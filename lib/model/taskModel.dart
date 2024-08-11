class TaskModel {
  String id;
  String title;
  String description;
  int date;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
    title: json['title'],
    description: json['description'],
    date: json['date'],
    userId: json['userID'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "userID": userId,
      "id": id,
    };
  }
}
