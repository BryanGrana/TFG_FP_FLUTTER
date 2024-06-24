import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/models/project.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';
import 'package:tfgbryan/search/project_search_delegate.dart';

import '../widgets/navigation_widget.dart';

class ListProyectos extends StatelessWidget {
  const ListProyectos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderTfg provider = Provider.of(context, listen: false);
    return Scaffold(
      drawer: const NavigationWidget(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: ProjectSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
        title: const Text('Proyectos'),
      ),
      body: listProyectos(provider),
    );
  }

  Widget listProyectos(ProviderTfg provider) {
    return FutureBuilder(
      future: provider.projectsList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Compruebe la conexión o la dirección IP establecida.");
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final lista = snapshot.data as List<Project>;

        if (lista.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        MediaQueryData mqd = MediaQuery.of(context);
        return Consumer<ProviderTfg>(
          builder: (context, value, child) => SizedBox(
            height: mqd.size.height * 0.8,
            child: listaElemetos(lista, value, context),
          ),
        );
      },
    );
  }

  Widget listaElemetos(
      List<Project> lista, ProviderTfg provider, BuildContext context) {
    ScrollController sc = ScrollController();
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(height: 3, color: Colors.black, thickness: 3),
      controller: sc,
      itemBuilder: (context, index) =>
          elementoLista(lista[index], context, provider, index),
      itemCount: lista.length,
      padding: const EdgeInsets.all(2),
    );
  }

  Widget elementoLista(
          Project p, BuildContext context, ProviderTfg provider, int i) =>
      ListTile(
        onTap: () {
          Navigator.pushNamed(context, "Project", arguments: p);
        },
        tileColor: i % 2 == 0 ? Colors.blueAccent : Colors.greenAccent,
        title: Text("${p.name}"),
        subtitle: Text("${p.budget}"),
      );
}
