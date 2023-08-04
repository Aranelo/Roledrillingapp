import 'package:flutter/material.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:roledrilling_app/helpers/pdf_helper.dart';

class ReportSelectionScreen extends StatefulWidget {
  final List<Reporte> reportes;
  final List<Reporte> selectedReports;
  final Function(List<Reporte> selectedReports, PlatformFile? file) onSendReports;

  const ReportSelectionScreen({
    required this.reportes,
    required this.selectedReports,
    required this.onSendReports,
  });

  @override
  _ReportSelectionScreenState createState() => _ReportSelectionScreenState();
}

class _ReportSelectionScreenState extends State<ReportSelectionScreen> {
  PlatformFile? _selectedFile;

  String _getBody() {
    final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return 'Adjunto reporte de perforación con fecha de: $currentDate';
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Reportes'),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSendReports(widget.selectedReports, _selectedFile);
              Navigator.pop(context);
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.reportes.length,
        itemBuilder: (context, index) {
          final reporte = widget.reportes[index];
          final isSelected = widget.selectedReports.contains(reporte);

          return ListTile(
            leading: IconButton(
              icon: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    widget.selectedReports.remove(reporte);
                  } else {
                    widget.selectedReports.add(reporte);
                  }
                });
              },
            ),
            title: Text('Reporte de perforación'),
            subtitle: Text('Fecha: ${reporte.fecha}'),
            onTap: () {
              setState(() {
                if (isSelected) {
                  widget.selectedReports.remove(reporte);
                } else {
                  widget.selectedReports.add(reporte);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        tooltip: 'Adjuntar Archivo',
        child: Icon(Icons.attach_file),
      ),
    );
  }
}
