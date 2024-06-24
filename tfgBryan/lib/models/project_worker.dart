import 'dart:convert';

import 'package:tfgbryan/models/project.dart';

class ProjectWorker {
  int? workerId;
  int? projectId;
  String? role;
  int? assignedHoursPerWeek;
  String? assignmentDate;
  Project p = Project.Vacio();

  ProjectWorker({
    required this.workerId,
    required this.projectId,
    required this.role,
    required this.assignedHoursPerWeek,
    required this.assignmentDate,
  });

  factory ProjectWorker.fromJson(Map<String, dynamic> json) => ProjectWorker(
        workerId: json['WorkerId'] ?? '',
        projectId: json['ProjectId'] ?? '',
        role: json['Role'] ?? '',
        assignedHoursPerWeek: json['AssignedHoursPerWeek'] ?? '',
        assignmentDate: json['AssignmentDate'] ?? '',
      );

  factory ProjectWorker.fromRawJson(String s) =>
      ProjectWorker.fromJson(json.decode(s));

  @override
  String toString() {
    return 'ProjectWorker{workerId: $workerId, projectId: $projectId, role: $role, assignedHoursPerWeek: $assignedHoursPerWeek, assignmentDate: $assignmentDate, p: $p}';
  }
}
