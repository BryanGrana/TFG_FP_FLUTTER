import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/models/project_worker.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';

import '../models/worker.dart';

class DatosTrabajador extends StatelessWidget {
  const DatosTrabajador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Worker w = ModalRoute.of(context)!.settings.arguments as Worker;
    ProviderTfg provider = Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('${w.firsName} ${w.lastName}'),
        ),
        body: orientacion(w, context, provider));
  }

  Widget orientacion(Worker w, BuildContext context, ProviderTfg provider) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Container(
            alignment: Alignment.center,
            child: proyectosPortrait(w, context, provider),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: proyectosLandscape(w, context, provider),
          );
        }
      },
    );
  }

  Widget proyectosPortrait(
      Worker w, BuildContext context, ProviderTfg provider) {
    return Column(
      children: [
        datosTrabajador(w, context, provider),
        const Text(
          "Proyectos:",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: 'Roboto',
            letterSpacing: 1.2,
            fontStyle: FontStyle.italic,
          ),
        ),
        listaProyectos(w, context, provider, 0.5),
      ],
    );
  }

  Widget proyectosLandscape(
      Worker w, BuildContext context, ProviderTfg provider) {
    return Row(
      children: [
        Expanded(
          child: datosTrabajador(w, context, provider),
        ),
        Expanded(
          child: listaProyectos2(w, context, provider, 1, 0.5),
        ),
      ],
    );
  }

  Widget listaProyectos2(Worker w, BuildContext context, ProviderTfg provider,
      double height, double width) {
    return FutureBuilder(
      future: provider.projectWorkerList(w.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Hay un error");
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final lista = snapshot.data as List<ProjectWorker>;

        //print("${lista[0]} BBBBBBBBBBBBBBBBBBBBB");
        //print(lista[1]);

        if (lista.isEmpty) {
          return const Center(
            child: Text("Sin proyectos"),
          );
        }
        MediaQueryData mqd = MediaQuery.of(context);

        return Consumer<ProviderTfg>(
            builder: (context, value, child) => SizedBox(
                  height: mqd.size.height * height,
                  child: listaElementos(lista, context, provider),
                ));
      },
    );
  }

  Widget listaProyectos(
      Worker w, BuildContext context, ProviderTfg provider, double height) {
    return FutureBuilder(
      future: provider.projectWorkerList(w.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Hay un error");
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final lista = snapshot.data as List<ProjectWorker>;

        if (lista.isEmpty) {
          return const Center(
            child: Text("Sin proyectos"),
          );
        }
        MediaQueryData mqd = MediaQuery.of(context);

        return Consumer<ProviderTfg>(
            builder: (context, value, child) => SizedBox(
                  height: mqd.size.height * height,
                  child: listaElementos(lista, context, provider),
                ));
      },
    );
  }

  Widget listaElementos(
      List<ProjectWorker> lista, BuildContext context, ProviderTfg provider) {
    ScrollController sc = ScrollController();
    return ListView.builder(
      controller: sc,
      itemBuilder: (context, index) =>
          elementoLista(lista[index], context, provider, index),
      itemCount: lista.length,
    );
  }

  Widget elementoLista(
      ProjectWorker pw, BuildContext context, ProviderTfg provider, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textWithStyle("Nombre", FontWeight.bold),
            _textWithStyle("${pw.p.name}", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("Fecha de asignación", FontWeight.bold),
            _textWithStyle("${pw.assignmentDate}", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("Fecha de inicio", FontWeight.bold),
            _textWithStyle("${pw.p.startDate}", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("Puesto", FontWeight.bold),
            _textWithStyle("${pw.role}", FontWeight.normal),
            const SizedBox(height: 15),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textWithStyle("Presupuesto", FontWeight.bold),
            _textWithStyle("${pw.p.budget}€", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("Horas mensuales", FontWeight.bold),
            _textWithStyle("${pw.assignedHoursPerWeek}", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("Fecha de fin", FontWeight.bold),
            _textWithStyle("${pw.p.endDate}", FontWeight.normal),
            const SizedBox(height: 15),
            _textWithStyle("", FontWeight.normal), // Espacio vacío
            _textWithStyle("", FontWeight.normal), // Espacio vacío
            const SizedBox(height: 15),
          ],
        ),
      ],
    );
  }

  Widget _textWithStyle(String text, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget datosTrabajador(Worker w, BuildContext context, ProviderTfg provider) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          child: FadeInImage(
            fadeOutDuration: const Duration(seconds: 1),
            fadeInDuration: const Duration(seconds: 2),
            placeholder: const AssetImage("assets/images/loading.gif"),
            image: NetworkImage("http://${provider.ip}${w.imagePath}"),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nombre",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "${w.lastName}, ${w.firsName}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            const Text(
              "Dirección",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "${w.address}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              "Fecha de nacimiento",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "${w.dateOfBirth}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const Text(
              "Teléfono",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "${w.phone}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
