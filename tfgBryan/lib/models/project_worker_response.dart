import 'dart:convert';

import 'package:tfgbryan/models/project_worker.dart';

class ProjectWorkerResponse {
  List<ProjectWorker> lista = [];

  ProjectWorkerResponse({required this.lista});

  factory ProjectWorkerResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> lista = json["list"];

    List<ProjectWorker> e = [];

    for (var element in lista) {
      ProjectWorker p = ProjectWorker(
        workerId: element['WorkerId'] ?? '',
        projectId: element['ProjectId'] ?? '',
        role: element['Role'] ?? '',
        assignedHoursPerWeek: element['AssignedHoursPerWeek'] ?? '',
        assignmentDate: element['AssignmentDate'] ?? '',
      );
      e.add(p);
    }

    return ProjectWorkerResponse(lista: e);
  }

  factory ProjectWorkerResponse.fromRawJson(String s) =>
      ProjectWorkerResponse.fromJson(json.decode(s));
}
