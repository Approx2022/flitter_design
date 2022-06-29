import 'dart:convert';

class Book_model {
  late int id;
  late String name;

  Book_model({int? id, required this.name}) {
    this.id = id ?? 0;
  }

  Book_model.fromJson(Map<String, dynamic> json) {
    id = json['book_id'];
    name = json['book_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['book_name'] = name;
    return data;
  }
}
