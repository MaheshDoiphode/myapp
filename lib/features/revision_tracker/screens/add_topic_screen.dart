import 'package:flutter/material.dart';
import 'package:myapp/features/revision_tracker/models/revision_topic.dart';
import 'package:myapp/core/services/mongodb_service.dart';

class AddTopicScreen extends StatefulWidget {
  const AddTopicScreen({Key? key}) : super(key: key);

  @override
  State<AddTopicScreen> createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _bookController = TextEditingController();
  final _chapterController = TextEditingController();
  final _topicController = TextEditingController();
  final _subtopicController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _bookController.dispose();
    _chapterController.dispose();
    _topicController.dispose();
    _subtopicController.dispose();
    super.dispose();
  }

  Future<void> _addTopic() async {
    if (_formKey.currentState!.validate()) {
      final revisionTopic = RevisionTopic(
        subject: _subjectController.text,
        book: _bookController.text,
        chapter: _chapterController.text,
        topic: _topicController.text,
        subtopic: _subtopicController.text,
        dateAdded: DateTime.now(),
        revisions: _calculateRevisions(DateTime.now()),
      );

      final mongoDBService = MongoDBService();
      await mongoDBService.addRevisionTopic(revisionTopic);

      // Navigate back to the previous screen or show a success message
      Navigator.pop(context);
    }
  }

  List<Revision> _calculateRevisions(DateTime dateAdded) {
    final revisions = <Revision>[];
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 1)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 4)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 11)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 18)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 25)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 85)), status: 'pending'));
    revisions.add(Revision(
        date: dateAdded.add(const Duration(days: 265)), status: 'pending'));
    return revisions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookController,
                decoration: const InputDecoration(labelText: 'Book'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _chapterController,
                decoration: const InputDecoration(labelText: 'Chapter'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a chapter';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _topicController,
                decoration: const InputDecoration(labelText: 'Topic'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subtopicController,
                decoration: const InputDecoration(labelText: 'Subtopic'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subtopic';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addTopic,
                child: const Text('Add Topic'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
