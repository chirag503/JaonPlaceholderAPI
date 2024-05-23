import 'dart:convert';

List<AlbumListModel> albumListModelFromJson(String str) =>
    List<AlbumListModel>.from(
        json.decode(str).map((x) => AlbumListModel.fromJson(x)));

String albumListModelToJson(List<AlbumListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumListModel {
  final int? userId;
  final int? id;
  String? title;

  AlbumListModel({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumListModel.fromJson(Map<String, dynamic> json) => AlbumListModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
