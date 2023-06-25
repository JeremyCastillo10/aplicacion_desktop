import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroAsientoScreen extends StatefulWidget {
  @override
  _RegistroAsientoScreenState createState() => _RegistroAsientoScreenState();
}

class _RegistroAsientoScreenState extends State<RegistroAsientoScreen> {
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _disponibilidadController = TextEditingController();
  String _seccionValue = 'VIP';

  final List<String> _seccionOptions = ['VIP', 'Preferencial', 'Estándar'];

  Future<void> _submitForm() async {
    final String numero = _numeroController.text.trim();
    final String disponibilidad = _disponibilidadController.text.trim();

    if (numero.isEmpty || disponibilidad.isEmpty || _seccionValue == null) {
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

    final url = Uri.parse('https://apieventapp.azurewebsites.net/api/Asiento');

    final Map<String, dynamic> requestData = {
      'numeroAsiento': numero,
      'seccion': _seccionValue,
      'disponibilidad': disponibilidad,
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
    _numeroController.dispose();
    _disponibilidadController.dispose();
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
              controller: _numeroController,
              decoration: InputDecoration(labelText: 'Numero Asiento'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Seccion'),
              value: _seccionValue,
              onChanged: (String? newValue) {
  setState(() {
  _seccionValue = newValue!;
});

},

              items: _seccionOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _disponibilidadController,
              decoration: InputDecoration(labelText: 'Disponibilidad'),
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
