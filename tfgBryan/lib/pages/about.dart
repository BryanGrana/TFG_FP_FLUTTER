import 'package:flutter/material.dart';
import 'package:tfgbryan/widgets/navigation_widget.dart';

import '../widgets/bullet_point.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationWidget(),
      appBar: AppBar(
        title: const Text('Acerca de WorkFlow Hub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'WorkFlow Hub',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                'WorkFlow Hub es una aplicación diseñada para gestionar y muestrear información relacionada con trabajadores y proyectos. '
                'Proporciona una plataforma eficiente y centralizada para realizar un seguimiento de las tareas, responsabilidades y el progreso de cada proyecto, '
                'así como la asignación y gestión de los trabajadores involucrados.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Funcionalidades principales:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              const BulletPoint(
                  text:
                      'Visualización de la lista de trabajadores y sus detalles.'),
              const BulletPoint(
                  text: 'Asignación de trabajadores a proyectos específicos.'),
              const BulletPoint(
                  text: 'Seguimiento del progreso de cada proyecto.'),
              const BulletPoint(
                  text: 'Muestreo de información detallada de cada proyecto.'),
              const SizedBox(height: 16.0),
              Text(
                'Nuestra misión',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Text(
                'En WorkFlow Hub, nuestra misión es simplificar la gestión de proyectos y trabajadores mediante una interfaz intuitiva y herramientas poderosas. '
                'Nos esforzamos por proporcionar una experiencia de usuario excepcional que permita a las organizaciones mejorar su eficiencia y productividad.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Contacto',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Si tienes alguna pregunta o necesitas más información, no dudes en contactarnos a través de nuestro soporte técnico o visita nuestro sitio web.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
