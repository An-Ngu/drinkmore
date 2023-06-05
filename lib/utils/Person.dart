import 'dart:convert';

class Person{
  String name;
  bool isBeer;
  bool isSingle;
  bool isMan;

  Person(this.name, this.isBeer, this.isSingle, this.isMan);

  factory Person.fromJson(Map<String, dynamic> d) {
    return Person(
      d['name'],
      d['isBeer'],
      d['isSingle'],
      d['isMan'],

    );

  }  Map<String, dynamic> toJson() => {
    "name": name,
    "isBeer": isBeer,
    "isSingle": isSingle,
    "isMan": isMan,
  };
}