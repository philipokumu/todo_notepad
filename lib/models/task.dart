class Task {
  final int id;
  final String title;
  final String description;
  final DateTime date;

  Task({this.id, this.title, this.description, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(['date']),
    );
  }
}
