
import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'registro_evento.dart';
import 'registro_asiento.dart';
import 'registro_cliente.dart';
import 'registro_sesion.dart';


class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menú',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MenuScreen(),
      routes: {
        '/registro_evento': (context) => RegistroEventoScreen(),
        '/registro_asiento': (context) => RegistroAsientoScreen(),
        '/registro_cliente': (context) => RegistroClienteScreen(),
        '/registro_sesion': (context) => RegistroSesionScreen(),
      },
    );
  }
}
