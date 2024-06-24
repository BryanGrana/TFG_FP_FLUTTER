import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfgbryan/pages/welcome.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            drawerHeader(context),
            drawerItems(context),
            drawerFooter(context)
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  Widget drawerItems(BuildContext context) {
    return Column(
      children: [
        drawerHome(Icons.home_outlined, "Inicio", context),
        drawerWorkers(Icons.work_outline, "Trabajadores", context),
        drawerProjects(Icons.assignment, "Projects", context),
      ],
    );
  }

  Widget drawerHome(IconData icon, String text, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Welcome(),
        ));
      },
    );
  }

  Widget drawerWorkers(IconData icon, String text, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "WorkersList");
      },
    );
  }

  Widget drawerProjects(IconData icon, String text, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "ProjectsList");
      },
    );
  }

  Widget drawerFooter(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);

    return Column(
      children: [
        SizedBox(
          height: mqd.size.height * 0.55,
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Ajustes"),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "Settings");
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text("Acerca de"),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "About");
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text("Salir"),
          onTap: () {
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}
