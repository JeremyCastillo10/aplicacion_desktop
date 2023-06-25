import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Registro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Registro de Evento'),
              onTap: () {
                Navigator.pushNamed(context, '/registro_evento');
              },
            ),
            ListTile(
              leading: Icon(Icons.airline_seat_recline_normal),
              title: Text('Registro de Asiento'),
              onTap: () {
                Navigator.pushNamed(context, '/registro_asiento');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Registro de Cliente'),
              onTap: () {
                Navigator.pushNamed(context, '/registro_cliente');
              },
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: Text('Registro de Sección'),
              onTap: () {
                Navigator.pushNamed(context, '/registro_sesion');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Icon(
          Icons.receipt,
          size: 100,
          color: Colors.blue,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
