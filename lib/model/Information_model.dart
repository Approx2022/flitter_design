import 'package:flutter/material.dart';

class Information_model {
  late int id, book_id;
  late double cash;
  late String  category, mode;
  late DateTime date;
  late TimeOfDay time;
  late bool isCash_In = true;

  Information_model(
      {int? id,
      required this.book_id,
      required this.cash,
      required this.isCash_In,
      required this.date,
      required this.category,
      required this.mode}) {
    this.id = id ?? 0;
  }

  /* Information_model({int? id, required this.day,required this.date,required this.category,required this.case_in,required this.case_out}) {
    this.id = id ?? 0;
  }*/

  Information_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    book_id = json['book_id'];
    cash = json['cash'];
    isCash_In = json['isCash_In'] == 1;
    date = DateTime.tryParse(json['date'])!;
    category = json['category'];
    category = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['date'] = date;
    data['category'] = category;
    data['book_id'] = book_id;
    data['cash'] = cash;
    data['isCash_In'] = isCash_In;
    data['mode'] = mode;
    return data;
  }
}
