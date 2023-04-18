import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';
import 'package:veguma_special/models/wheels.dart';
import 'package:cross_file/cross_file.dart';

class CreatePdf with ChangeNotifier {
  Future<void> createPdfOnPressed(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/OpenSans.ttf");
    final ttf = pw.Font.ttf(font);
    List<dynamic> tires = [];
    tires = Provider.of<Wheels>(context, listen: false).tires;

    pw.Column pdfColumn(String cellValue) {
      return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(2.0),
              child: pw.Text(cellValue,
                  style: pw.TextStyle(fontSize: 6, font: ttf)),
            )
          ]);
    }

    pw.Center headerRow(String headerCellValue) {
      return pw.Center(
          child: pw.Text(headerCellValue, style: pw.TextStyle(fontSize: 6, font: ttf)));
    }

    pdf.addPage(
      pw.MultiPage(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Table(border: pw.TableBorder.all(), children: [
                pw.TableRow(children: [
                  headerRow('№'),
                  headerRow(tr('tireSize')),
                  headerRow('Клиент'),
                  headerRow('Бренд'),
                  headerRow('Протектор'),
                  headerRow('Замена'),
                  headerRow('Из брака'),
                  headerRow('Склад'),
                  headerRow('Заплатки'),
                  headerRow('Прослойка'),
                  headerRow('Дата протектора'),
                  headerRow('Смесь'),
                  headerRow('Твердость'),
                ]),
                for (var i = 0; i < tires.length; i++)
                  pw.TableRow(children: [
                    pdfColumn((tires[i].number + 1).toString()),
                    pdfColumn(tires[i].tireSize),
                    pdfColumn(tires[i].client),
                    pdfColumn(tires[i].tireBrand),
                    pdfColumn('${tires[i].treadType} ${tires[i].treadWidth}'),
                    pdfColumn(
                        '${tires[i].newTreadType} ${tires[i].newTreadWidth}'),
                    pdfColumn(tires[i].treadDefect.toString()),
                    pdfColumn(tires[i].warehouse),
                    pdfColumn(tires[i].patchNumbers),
                    pdfColumn(tires[i].interlayer),
                    pdfColumn(tires[i].treadDate),
                    pdfColumn(tires[i].mixtureNumber),
                    pdfColumn(tires[i].hardness),
                  ])
              ])
            ];
          }),
    );
    Directory appDocDir =
        (await getExternalStorageDirectories(type: StorageDirectory.downloads))!
            .first;
    String appDocPath = appDocDir.path;
    print(appDocPath);
    final file = File("$appDocPath/tires.pdf");
    await file.writeAsBytes(await pdf.save());
    XFile xFile = XFile(file.path);
    Share.shareXFiles([xFile], text: 'Отчет');
  }
}
