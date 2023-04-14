import "package:json_annotation/json_annotation.dart";
part "contact_model.g.dart";

@JsonSerializable()

class Contact {
  final String name;
  final String phone_number;
  final String? id;

  Contact(this.name, this.phone_number, this.id);

  
  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

}