import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';

import '../models/worker.dart';

class WorkerSearchDelegate extends SearchDelegate {
  String? get searchWorker => "Buscar trabajador";

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
    if (query.isEmpty) return _noWorker();
    ProviderTfg provider = Provider.of(context, listen: false);
    return FutureBuilder(
      future: provider.searchWorkers(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _workerList(snapshot.data!, context, provider);
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Ha ocurrido un error."));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _noWorker() => Container(
        child: const Center(
          child: Icon(
            Icons.work,
            size: 100,
            color: Colors.black26,
          ),
        ),
      );

  Widget _workerList(
      List<Worker> list, BuildContext context, ProviderTfg provider) {
    if (list.isEmpty) {
      return Center(
          child: Container(
        child: Text("No se encontraron trabajadores."),
      ));
    }
    return ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(
              height: 2,
              thickness: 2,
            ),
        itemBuilder: (context, index) =>
            _elementoLista(list[index], context, provider));
  }

  Widget _elementoLista(Worker w, BuildContext context, ProviderTfg provider) =>
      ListTile(
        onTap: () {
          FocusScope.of(context).unfocus();
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.pushNamed(context, "Worker", arguments: w);
            },
          );
        },
        tileColor: Colors.blueAccent,
        title: Text("${w.lastName}, ${w.firsName}"),
        leading: ClipOval(
          child: FadeInImage(
            fadeOutDuration: const Duration(seconds: 1),
            fadeInDuration: const Duration(seconds: 2),
            placeholder: const AssetImage("assets/images/loading.gif"),
            image: NetworkImage("http://${provider.ip}${w.imagePath}"),
          ),
        ),
      );
}
