import 'dart:ui';

class Category {
  int? id;
  String name;
  String? iconPath;
  String color;
  int userId;

  Category({this.id, required this.name, this.iconPath, required this.color,required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
      'color': color,
      'user_id':userId
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconPath: map['iconPath'],
      color: map['color'],
      userId: map['user_id'],
    );
  }
}
