class RevisionTopic {
  final String subject;
  final String book;
  final String chapter;
  final String topic;
  final String subtopic;
  final DateTime dateAdded;
  final List<Revision> revisions;

  RevisionTopic({
    required this.subject,
    required this.book,
    required this.chapter,
    required this.topic,
    required this.subtopic,
    required this.dateAdded,
    required this.revisions,
  });

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'book': book,
      'chapter': chapter,
      'topic': topic,
      'subtopic': subtopic,
      'dateAdded': dateAdded.toIso8601String(),
      'revisions': revisions.map((revision) => revision.toMap()).toList(),
    };
  }

  factory RevisionTopic.fromMap(Map<String, dynamic> map) {
    return RevisionTopic(
      subject: map['subject'] as String,
      book: map['book'] as String,
      chapter: map['chapter'] as String,
      topic: map['topic'] as String,
      subtopic: map['subtopic'] as String,
      dateAdded: DateTime.parse(map['dateAdded'] as String),
      revisions: (map['revisions'] as List)
          .map((revision) => Revision.fromMap(revision as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Revision {
  final DateTime date;
  final String status; // e.g., 'pending', 'completed'

  Revision({
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory Revision.fromMap(Map<String, dynamic> map) {
    return Revision(
      date: DateTime.parse(map['date'] as String),
      status: map['status'] as String,
    );
  }
}
