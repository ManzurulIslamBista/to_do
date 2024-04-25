class UserTodoRecord {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String priority;
  final int categoryId;
  final int userId;

  UserTodoRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.priority,
    required this.categoryId,
    required this.userId,
  });

  factory UserTodoRecord.fromMap(Map<String, dynamic> map) {
    return UserTodoRecord(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      priority: map['priority'],
      categoryId: map['categoryId'],
      userId: map['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'priority': priority,
      'categoryId': categoryId,
      'user_id': userId,
    };
  }
}
