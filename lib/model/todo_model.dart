class TodoModel {
  final String id;
  final String title;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  factory TodoModel.fromDocument(Map<String, dynamic> doc) {
    return TodoModel(
      id: doc['id'],
      title: doc['title'],
      isCompleted: doc['isCompleted'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
