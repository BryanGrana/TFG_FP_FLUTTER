import 'dart:convert';

import 'package:tfgbryan/models/project.dart';

class ProjectResponse {
  List<Project> projects = [];

  ProjectResponse({required this.projects});

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> lista = json["list"];

    List<Project> e = [];

    for (var element in lista) {
      Project p = Project(
        id: element['ID'] ?? '',
        name: element['Name'] ?? '',
        description: element['Description'] ?? '',
        budget: double.tryParse(element['Budget'].toString()) ?? 0.0,
        startDate: element['StartDate'] ?? '',
        endDate: element['EndDate'] ?? '',
      );
      e.add(p);
    }

    return ProjectResponse(
      projects: e,
    );
  }

  factory ProjectResponse.fromRawJson(String s) =>
      ProjectResponse.fromJson(json.decode(s));
}
