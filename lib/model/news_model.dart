// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    List<ListElement>? list;

    NewsModel({
        this.list,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    };
}

class ListElement {
    String? filename;
    String? cont;

    ListElement({
        this.filename,
        this.cont,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        filename: json["filename"],
        cont: json["cont"],
    );

    Map<String, dynamic> toJson() => {
        "filename": filename,
        "cont": cont,
    };
}
