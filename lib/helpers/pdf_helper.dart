import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:roledrilling_app/models/reporte_model.dart';
import 'package:roledrilling_app/helpers/file_save_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfHelper {
  static Future<void> showPDF(List<Reporte> reportes) async {
    final pdf = await generateReportPDF(reportes);
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
static Future<pw.Document> generateReportPDF(List<Reporte> reportes) async {
    final pdf = pw.Document();
    for (final reporte in reportes) {
      pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Center(child: pw.Text('REPORTE DE PERFORACIÓN ROLE DRILLING', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('PROYECTO:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.Text('MAQUINA:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.Text('PERFORISTA:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(reporte.proyecto ?? '', style: pw.TextStyle(fontSize: 7)),
                pw.Text(reporte.maquina ?? '', style: pw.TextStyle(fontSize: 7)),
                pw.Text(reporte.perforista ?? '', style: pw.TextStyle(fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('FECHA:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.Text('TURNO:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.Text('AYUDANTE:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(reporte.fecha ?? '', style: pw.TextStyle(fontSize: 7)),
                pw.Text(reporte.turno ?? '', style: pw.TextStyle(fontSize: 7)),
                pw.Text(reporte.ayudante1 ?? '', style: pw.TextStyle(fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('POZO:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.Text('AYUDANTE:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(reporte.pozo ?? '', style: pw.TextStyle(fontSize: 7)),
                pw.Text(reporte.ayudante2 ?? '', style: pw.TextStyle(fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('SUPERVISOR:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(reporte.supervisor ?? '', style: pw.TextStyle(fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('SUPERVISOR DE SEGURIDAD:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(reporte.supervisorSeguridad ?? '', style: pw.TextStyle(fontSize: 7)),
              ],
            ),
          ],
        ),
      ));
    }
    return pdf;
  }

  

  static Future<void> sendPDF(List<Reporte> reportes, String? filePath) async {
    final pdf = await generateReportPDF(reportes);

    final Uint8List pdfBytes = await pdf.save();
    final String pdfFileName = "reportes.pdf";
    final pdfPath = await FileSaveHelper.saveFile(pdfBytes, pdfFileName);

    try {
      await launch(
        'mailto:?subject=Reportes%20de%20Perforación&body=Adjunto%20se%20encuentran%20los%20reportes%20de%20perforación%20en%20formato%20PDF.&attachment=$pdfPath',
      );
    } catch (e) {
      print('No se pudo abrir la aplicación de correo.');
    }
  }
}