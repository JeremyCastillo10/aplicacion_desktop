import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroClienteScreen extends StatefulWidget {
  @override
  _RegistroClienteScreenState createState() => _RegistroClienteScreenState();
}

class _RegistroClienteScreenState extends State<RegistroClienteScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  Future<void> _submitForm() async {
    final String nombre = _nombreController.text.trim();
    final String direccion= _direccionController.text.trim();
    final String telefono = _telefonoController.text.trim();


    if (nombre.isEmpty ||
        direccion.isEmpty ||
        telefono.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, complete todos los campos.'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final url = Uri.parse('https://apieventapp.azurewebsites.net/api/Cliente');

    final Map<String, dynamic> requestData = {
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

if (response.statusCode == 201) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Éxito'),
        content: Text('La solicitud POST se envió con éxito.'),
        actions: [
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
          ),
        ],
      );
    },
  );
} else {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('Hubo un error al enviar la solicitud POST.'),
        actions: [
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
          ),
        ],
      );
    },
  );
}

  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Evento')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(labelText: 'Direccion'),
            ),
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Telefono'),
            ),
  
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
