import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/models/project.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';

class DatosProyecto extends StatelessWidget {
  const DatosProyecto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Project p = ModalRoute.of(context)!.settings.arguments as Project;

    ProviderTfg provider = Provider.of(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('${p.name}'),
        ),
        body: elementoLista(p, provider, context));
  }

  Widget elementoLista(Project p, ProviderTfg provider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset:const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Título:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "${p.name}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Presupuesto:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "${p.budget?.toStringAsFixed(2)}€",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Descripción:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                "${p.description}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Inicio: ${p.startDate} \nFin: ${p.endDate}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
