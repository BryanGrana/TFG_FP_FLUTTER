import 'dart:convert';

import 'package:tfgbryan/models/worker.dart';

class WorkerResponse {
  List<Worker> workers = [];

  WorkerResponse({required this.workers});

  factory WorkerResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> lista = json["list"];


    List<Worker> e = [];

    for (var element in lista) {
      Worker w = Worker(
        id: element["ID"],
        imagePath: element["ImagePath"],
        firsName: element["FirstName"],
        lastName: element["LastName"],
        email: element["Email"],
        dateOfBirth: element["DateOfBirth"],
        phone: element["Phone"],
        address: element["Address"],
      );
      e.add(w);
    }
    return WorkerResponse(
      workers: e,
    );
  }

  factory WorkerResponse.fromRawJson(String s) =>
      WorkerResponse.fromJson(json.decode(s));
}
