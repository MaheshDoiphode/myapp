import 'package:mongo_dart/mongo_dart.dart';
import 'package:myapp/features/revision_tracker/models/revision_topic.dart';

class MongoDBService {
  // Replace with your MongoDB connection string
  final _connectionString =
      'mongodb+srv://admin:1234@flutter-revision.vpnokco.mongodb.net/?retryWrites=true&w=majority&appName=flutter-revision';

  Future<Db> _getConnection() async {
    final db = await Db.create(_connectionString);
    await db.open();
    return db;
  }

  Future<bool> userExists(String username) async {
    final db = await _getConnection();
    final usersCollection = db.collection('users');
    final user = await usersCollection.findOne(where.eq('username', username));
    await db.close();
    return user != null;
  }

  Future<void> createUser(String username) async {
    final db = await _getConnection();
    final usersCollection = db.collection('users');

    // Fetch the default template
    final defaultTemplate = await getDefaultTemplate();

    if (defaultTemplate != null) {
      // Create a new user document based on the default template
      // Remove the _id field from the template
      defaultTemplate.remove('_id');

      // Set the username as the _id
      defaultTemplate['_id'] = username;

      // Set the username field
      defaultTemplate['username'] = username;

      // Insert the new user document
      await usersCollection.insert(defaultTemplate);
    } else {
      // Handle the case where the default template is not found
      print('Error: Default template not found!');
      // You might want to throw an exception or handle this error differently
    }

    await db.close();
  }

  Future<void> addRevisionTopic(RevisionTopic revisionTopic) async {
    final db = await _getConnection();
    final revisionTopicsCollection = db.collection('revisionTopics');
    await revisionTopicsCollection.insert(revisionTopic.toMap());
    await db.close();
  }

  Future<Map<String, dynamic>?> getDefaultTemplate() async {
    final db = await _getConnection();
    final usersCollection = db.collection('users');
    final template =
        await usersCollection.findOne(where.eq('_id', 'default_template'));
    await db.close();
    return template;
  }
}
