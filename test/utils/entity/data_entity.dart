class DataEntity {
  int id;
  String userName;
  int age;

  DataEntity(this.id, this.userName, this.age);

  static DataEntity fromJson(Map<String, dynamic> json) =>
      DataEntity(json['id'], json['userName'], json['age']);
}
