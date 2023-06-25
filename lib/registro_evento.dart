import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroEventoScreen extends StatefulWidget {
  @override
  _RegistroEventoScreenState createState() => _RegistroEventoScreenState();
}

class _RegistroEventoScreenState extends State<RegistroEventoScreen> {
  final TextEditingController _nombreEventoController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  Future<void> _submitForm() async {
    final String nombreEvento = _nombreEventoController.text.trim();
    final String ubicacion = _ubicacionController.text.trim();
    final String imagenUrl = _imagenUrlController.text.trim();
    final String categoria = _categoriaController.text.trim();
    final String descripcion = _descripcionController.text.trim();
    final String fecha = _fechaController.text.trim();

    if (nombreEvento.isEmpty ||
        ubicacion.isEmpty ||
        imagenUrl.isEmpty ||
        categoria.isEmpty ||
        descripcion.isEmpty ||
        fecha.isEmpty) {
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

    final url = Uri.parse('https://eventoapiweb.azurewebsites.net/api/Evento');

    final Map<String, dynamic> requestData = {
      'nombreEvento': nombreEvento,
      'ubicacion': ubicacion,
      'imagenUrl': imagenUrl,
      'categoria': categoria,
      'descripcion': descripcion,
      'fecha': fecha,
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
    _nombreEventoController.dispose();
    _ubicacionController.dispose();
    _imagenUrlController.dispose();
    _categoriaController.dispose();
    _descripcionController.dispose();
    _fechaController.dispose();
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
              controller: _nombreEventoController,
              decoration: InputDecoration(labelText: 'Nombre del Evento'),
            ),
            TextField(
              controller: _ubicacionController,
              decoration: InputDecoration(labelText: 'Ubicación'),
            ),
            TextField(
              controller: _imagenUrlController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(labelText: 'Fecha'),
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
