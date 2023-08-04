import 'package:flutter/material.dart';
import 'package:roledrilling_app/models/reporte_model.dart';

class DataEntryPerforado extends StatefulWidget {
  @override
  _DataEntryPerforadoState createState() => _DataEntryPerforadoState();
}

class _DataEntryPerforadoState extends State<DataEntryPerforado> {
  List<Perforacion> _perforaciones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso de Datos de Perforación'),
        actions: [
          IconButton(
            onPressed: () {
              // Guardar los datos ingresados y regresar a la pantalla anterior
              Navigator.pop(context, _perforaciones);
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Botón para agregar nueva perforación
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _perforaciones.add(Perforacion(tamano: '', desde: 0.0, totalPerforado: 0.0, hasta: 0.0));
                });
              },
              child: Text('Agregar Perforación'),
            ),
            SizedBox(height: 16),
            // Campos para ingresar los datos de perforación
            for (int i = 0; i < _perforaciones.length; i++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Tamaño'),
                        onChanged: (value) {
                          setState(() {
                            _perforaciones[i].tamano = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Desde'),
                        onChanged: (value) {
                          setState(() {
                            _perforaciones[i].desde = double.parse(value);
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Hasta'),
                        onChanged: (value) {
                          setState(() {
                            _perforaciones[i].hasta = double.parse(value);
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Total Perforado'),
                        onChanged: (value) {
                          setState(() {
                            _perforaciones[i].totalPerforado = double.parse(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
