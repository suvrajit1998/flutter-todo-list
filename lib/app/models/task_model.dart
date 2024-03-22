class TaskModel {
  String name;
  String description;
  String date;
  String admin;
  String client;
  String id;

  TaskModel({
    required this.admin,
    required this.client,
    required this.date,
    required this.description,
    required this.name,
    required this.id,
  });

  factory TaskModel.formMap(Map<String, dynamic> map) {
    return TaskModel(
      admin: map['admin'],
      client: map['client'],
      date: map['date'],
      description: map['description'],
      name: map['name'],
      id: map['id'] ?? '',
    );
  }
}
