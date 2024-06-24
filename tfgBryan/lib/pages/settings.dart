import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfgbryan/providers/provider_tfg.dart';
import 'package:tfgbryan/widgets/navigation_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String ip = "";

  @override
  Widget build(BuildContext context) {
    ProviderTfg provider = Provider.of(context, listen: false);
    return Scaffold(
      drawer:const NavigationWidget(),
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                _ipServer(provider),
                _buttonAceptar(provider),
              ],
            ),
          )),
    );
  }

  Widget _ipServer(ProviderTfg provider) {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: "",
      maxLines: 1,
      maxLength: 15,
      onChanged: (value) {
        setState(() {
          print(ip);
          ip = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'La dirección IP no puede estar vacía';
        }

        final ipRegExp = RegExp(
            r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');

        if (!ipRegExp.hasMatch(value)) {
          return 'Ingrese una dirección IP válida';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "192.168.1.135",
        labelText: "Dirección IP del servidor",
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        prefixIcon: const Icon(Icons.computer),
        filled: true,
        fillColor: Colors.grey[200],
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Widget _buttonAceptar(ProviderTfg provider) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          provider.ip = ip;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conexión exitosa.'),
              duration: Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, "Welcome");
          });
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      child: const Text(
        "Conexión",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
