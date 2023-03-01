import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventModel {
  final int? id;
  final String? date;
  final TimeOfDay? alarmTime;
  final String? displayName;
  final String? car;
  final String? contactInfo;
  final String? location;
  final String? description;

  EventModel({
    this.id,
    this.date,
    this.alarmTime,
    this.displayName,
    this.car,
    this.contactInfo,
    this.location,
    this.description,
  });

  EventModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        date = res['date'],
        alarmTime = (res['alarm'] != null)
            ? TimeOfDay(
                hour: int.parse(res['alarm'].split(':')[0]),
                minute: int.parse(res['alarm'].split(':')[1]))
            : null,
        displayName = res['displayName'],
        car = res['car'],
        contactInfo = res['contactInfo'],
        location = res['location'],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "date": date,
      "alarmTime": "${alarmTime!.hour}:${alarmTime!.minute}",
      "displayName": displayName,
      "car": car,
      "contactInfo": contactInfo,
      "location": location,
      "description": description
    };
  }
}
