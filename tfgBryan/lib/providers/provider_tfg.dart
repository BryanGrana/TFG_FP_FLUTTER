import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfgbryan/models/project.dart';
import 'package:tfgbryan/models/project_response.dart';
import 'package:tfgbryan/models/project_worker.dart';
import 'package:tfgbryan/models/project_worker_response.dart';
import 'package:tfgbryan/models/worker.dart';

import '../models/worker_response.dart';

class ProviderTfg with ChangeNotifier {
  String token = "tu_token_de_nocodb";

  String ip = "";

  //Workers
  List<Worker> workers = [];

  Future<List<Worker>> workersList() async {
    workers = [];
    String port = ":8080";

    String route = "$ip$port";

    var client = http.Client();
    var url = Uri.http(
      route,
      '/api/v1/db/data/v1/flutter/Workers',
    );
    var response = await client.get(
      url,
      headers: {
        "xc-Token": token,
      },
    );

    if (response.statusCode == 200) {
      final workerResponse = WorkerResponse.fromRawJson(response.body);
      workers.addAll(workerResponse.workers);
      return workers;
    }

    return workers;
  }

  Future<List<Worker>> searchWorkers(String startsWith) async {
    String port = ":8080";

    String route = "$ip$port";
    var client = http.Client();
    var url = Uri.http(
      route,
      '/api/v1/db/data/v1/flutter/Workers',
      {
        "where":
            "where(FirstName,like,$startsWith)~or(LastName,like,$startsWith)",
      },
    );
    var response = await client.get(
      url,
      headers: {
        "xc-Token": token,
      },
    );
    if (response.statusCode == 200) {
      final workerResponse = WorkerResponse.fromRawJson(response.body);
      return workerResponse.workers;
    }

    return [];
  }

  //ProjectWorker

  List<ProjectWorker> projectsWorker = [];

  Future<List<ProjectWorker>> projectWorkerList(int? idWorker) async {
    projectsWorker = [];
    String port = ":8080";

    String route = "$ip$port";

    var client = http.Client();
    var url = Uri.http(
      route,
      '/api/v1/db/data/v1/flutter/ProjectWorker',
      {
        "where": "where=(WorkerId,eq,$idWorker)",
      },
    );
    var response = await client.get(
      url,
      headers: {
        "xc-Token": token,
      },
    );

    if (response.statusCode == 200) {
      final projectWorkerResponse =
          ProjectWorkerResponse.fromRawJson(response.body);
      projectsWorker.addAll(projectWorkerResponse.lista);

      int i = 0;

      for (var element in projectsWorker) {
        url = Uri.http(
          route,
          '/api/v1/db/data/v1/flutter/Projects/views/Projects',
          {
            "where": "where=(ID,eq,${element.projectId})",
          },
        );
        var responseProject = await client.get(
          url,
          headers: {
            "xc-Token": token,
          },
        );

        List<Project> project = [];

        if (responseProject.statusCode == 200) {
          final projectResponse =
              ProjectResponse.fromRawJson(responseProject.body);
          //print("${projectResponse.projects[0]} AAAAAAAAAAAAAAAAAA");
          project.addAll(projectResponse.projects);
        }
        //print(project[0]);
        projectsWorker[i].p = project[0];
        i++;
      }
      return projectsWorker;
    }

    return projectsWorker;
  }

  //Projects

  Future<List<Project>> searchProjects(String startsWith) async {
    String port = ":8080";

    String route = "$ip$port";
    var client = http.Client();
    var url = Uri.http(route, '/api/v1/db/data/v1/flutter/Projects', {
      "where": "where=(Name,like,$startsWith)",
    });
    var response = await client.get(
      url,
      headers: {
        "xc-Token": token,
      },
    );

    if (response.statusCode == 200) {
      final projectResponse = ProjectResponse.fromRawJson(response.body);
      return projectResponse.projects;
    }

    return [];
  }

  List<Project> projects = [];

  Future<List<Project>> projectsList() async {
    projects = [];
    String port = ":8080";

    String route = "$ip$port";

    var client = http.Client();
    var url = Uri.http(
      route,
      '/api/v1/db/data/v1/flutter/Projects',
    );
    var response = await client.get(
      url,
      headers: {
        "xc-Token": token,
      },
    );

    if (response.statusCode == 200) {
      final projectResponse = ProjectResponse.fromRawJson(response.body);
      projects.addAll(projectResponse.projects);
      return projects;
    }

    return projects;
  }
}
