import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/pages/about.dart';
import 'package:tfgbryan/pages/datos_proyecto.dart';
import 'package:tfgbryan/pages/list_proyectos.dart';
import 'package:tfgbryan/pages/list_trabajadores.dart';
import 'package:tfgbryan/pages/settings.dart';
import 'package:tfgbryan/pages/welcome.dart';
import 'package:tfgbryan/pages/datos_trabajador.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';

void main() {
  runApp(const MisProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workflow Hub',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent)),
      initialRoute: "Welcome",
      routes: {
        "Welcome": (context) => const Welcome(),
        "WorkersList": (context) => const ListTrabajadores(),
        "ProjectsList": (context) => const ListProyectos(),
        "Worker": (context) => const DatosTrabajador(),
        "Project": (context) => const DatosProyecto(),
        "Settings": (context) => const Settings(),
        "About": (context) => const About(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MisProviders extends StatelessWidget {
  const MisProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderTfg(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
