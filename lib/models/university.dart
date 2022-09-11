import 'package:json_annotation/json_annotation.dart';

part 'university.g.dart';

@JsonSerializable()
class University {
  University({
    this.domains,
    this.alphaTwoCode,
    this.country,
    this.webPages,
    this.name,
  });

  factory University.fromJson(Map<String, dynamic> json) =>
      _$UniversityFromJson(json);

  List<String>? domains;
  String? alphaTwoCode;
  String? country;
  List<String>? webPages;
  String? name;
  bool inFav = false;

  Map<String, dynamic> toJson() => _$UniversityToJson(this);
}
