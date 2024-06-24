import 'package:flutter/material.dart';
import 'package:tfgbryan/widgets/navigation_widget.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: const NavigationWidget(),
        appBar: AppBar(
          title: const Text('Inicio'),
        ),
        body: orientacion());
  }

  Widget orientacion() {
    return OrientationBuilder(
      builder: (context, orientation) {
        var isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;
        if (orientation == Orientation.portrait) {
          return Container(
            alignment: Alignment.center,
            child: welcomePortrait(),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: welcomeLandscape(),
          );
        }
      },
    );
  }

  Widget welcomePortrait() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imagen(),
        texto(),
      ],
    );
  }

  Widget welcomeLandscape() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        imagen(),
        const SizedBox(
          width: 50,
        ),
        texto(),
      ],
    );
  }

  Widget imagen() {
    return Image.asset("assets/images/logo.png", scale: 0.8);
  }

  Widget texto() {
    return const Text("Bienvenido a WorkFlowHub",
        style: TextStyle(color: Colors.white, fontSize: 30));
  }
}
