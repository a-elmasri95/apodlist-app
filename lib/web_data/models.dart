class Model {
  final int userId;
  final int id;
  final String title;

  const Model({required this.userId, required this.id, required this.title});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
