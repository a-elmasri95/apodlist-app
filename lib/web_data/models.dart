class MemeModel {
  final String name;
  final String url;
  final String date;

  const MemeModel({required this.name, required this.url, required this.date});

  factory MemeModel.fromJson(Map<String, dynamic> json) {
    return MemeModel(
      name: json['title'],
      date: json['date'],
      url: json['url'],
    );
  }
}
