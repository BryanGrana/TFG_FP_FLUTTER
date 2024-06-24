import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/models/worker.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';
import 'package:tfgbryan/widgets/navigation_widget.dart';

import '../search/worker_search_delegate.dart';

class ListTrabajadores extends StatelessWidget {
  const ListTrabajadores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderTfg provider = Provider.of(context, listen: false);

    return Scaffold(
      drawer: const NavigationWidget(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: WorkerSearchDelegate()),
              icon: const Icon(Icons.search_outlined)),
        ],
        title: const Text('Trabajadores'),
      ),
      body: listTrabajadores(provider),
    );
  }

  Widget listTrabajadores(ProviderTfg provider) {
    return FutureBuilder(
      future: provider.workersList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
              "Compruebe la conexión o la dirección IP establecida.");
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final lista = snapshot.data as List<Worker>;

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
      List<Worker> lista, ProviderTfg value, BuildContext context) {
    ScrollController sc = ScrollController();
    return ListView.builder(
      controller: sc,
      itemBuilder: (context, index) =>
          elementoLista(lista[index], value, context, index),
      itemCount: lista.length,
      padding: const EdgeInsets.all(2),
    );
  }

  Widget elementoLista(
      Worker w, ProviderTfg provider, BuildContext context, int i) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "Worker", arguments: w);
      },
      tileColor: i % 2 == 0 ? Colors.blueAccent : Colors.greenAccent,
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
}
