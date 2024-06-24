import 'dart:convert';

class Project {
  int? id;
  String? name;
  String? description;
  double? budget;
  String? startDate;
  String? endDate;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.budget,
    required this.startDate,
    required this.endDate,
  });

  Project.Vacio();

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['ID'] ?? '',
        name: json['Name'] ?? '',
        description: json['Description'] ?? '',
        budget: double.tryParse(json['Budget'].toString()) ?? 0.0,
        startDate: json['StartDate'] ?? '',
        endDate: json['EndDate'] ?? '',
      );

  factory Project.fromRawJson(String s) => Project.fromJson(json.decode(s));

  @override
  String toString() {
    return 'Project{id: $id, name: $name, description: $description, budget: $budget, startDate: $startDate, endDate: $endDate}';
  }
}
