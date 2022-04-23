import 'package:chores/models/status.dart';

class Chore{
  late int? choreId;
  late String choreName;
  late Status status;
  late DateTime? dateTime;

  Chore(this.choreName, this.status, this.dateTime);

  Chore.fromJson(Map<String, dynamic> json){
    choreId = json['choreId'];
    choreName = json['choreName'];
    status = json['status'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() => {
    'choreName': choreName,
    'status': status,
    'dateTime': dateTime
  };

}