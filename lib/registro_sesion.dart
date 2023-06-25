import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroSesionScreen extends StatefulWidget {
  @override
  _RegistroSesionScreenState createState() => _RegistroSesionScreenState();
}

class _RegistroSesionScreenState extends State<RegistroSesionScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _capacidadController = TextEditingController();


  Future<void> _submitForm() async {
    final String nombre = _nombreController.text.trim();
    int capacidad = int.parse(_capacidadController.text.trim());




    if (nombre.isEmpty ||
        capacidad.toString().isEmpty) {
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

    final url = Uri.parse('https://eventoapiweb.azurewebsites.net/api/Seccion');

    final Map<String, dynamic> requestData = {
      'nombre': nombre,
      'Capacidad': capacidad,
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
    _capacidadController.dispose();
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
              decoration: InputDecoration(labelText: 'Nombre Seccion'),
            ),
            TextField(
              controller: _capacidadController,
              decoration: InputDecoration(labelText: 'Capacidad'),
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


