import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';

import '../models/project.dart';

class ProjectSearchDelegate extends SearchDelegate {
  String? get searchProject => "Buscar trabajador";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();

        Future.delayed(const Duration(seconds: 1), () {
          close(context, null);
        });
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: buildSuggestions(context));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _noProject();
    ProviderTfg provider = Provider.of(context, listen: false);
    return FutureBuilder(
      future: provider.searchProjects(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _projectList(snapshot.data!, context, provider);
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Ha ocurrido un error."));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _noProject() => Container(
        child: const Center(
          child: Icon(
            Icons.work,
            size: 100,
            color: Colors.black26,
          ),
        ),
      );

  Widget _projectList(
      List<Project> list, BuildContext context, ProviderTfg provider) {
    if (list.isEmpty) {
      return Center(
          child: Container(
        child: const Text("No se encontraron proyectos."),
      ));
    }
    return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(
              height: 2,
              thickness: 2,
            ),
        itemBuilder: (context, index) =>
            _elementoLista(list[index], context, provider, index));
  }

  Widget _elementoLista(
          Project p, BuildContext context, ProviderTfg provider, int i) =>
      ListTile(
        onTap: () {
          FocusScope.of(context).unfocus();
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.pushNamed(context, "Project", arguments: p);
            },
          );
        },
        tileColor: i % 2 == 0 ? Colors.blueAccent : Colors.greenAccent,
        title: Text("${p.name}"),
        subtitle: Text("${p.budget}"),
      );
}
