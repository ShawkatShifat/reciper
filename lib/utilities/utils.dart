import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reciper/models/recipe.dart';
import 'package:share_plus/share_plus.dart';

class Utils {
  static Future<void> userExport() async {
    Directory directory = await getTemporaryDirectory();
    String appDocumentsPath = directory.path;
    String filePath = '$appDocumentsPath/Reciper_Export.json';

    File file = File(filePath);

    // Simulate export data without database interaction
    String exportData = '{"recipes": []}'; // Replace with your export data
    await file.writeAsString(exportData);

    Share.shareXFiles([XFile(filePath)]);
  }

  static Future<int> userImport() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'Reciper export',
      extensions: <String>['json'],
    );
    final XFile? file =
    await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

    if (file != null) {
      // Simulate import data without database interaction
      String backupContent = await file.readAsString();
      // Process imported data as needed
    }

    return 1; // Return a success indicator (e.g., 1) after import
  }


  static Future<void> userPdfExport() async {
    Directory directory = await getTemporaryDirectory();
    String appDocumentsPath = directory.path;
    String filePath = '$appDocumentsPath/recipes.pdf';

    File file = File(filePath);

    final pdf = pw.Document();
    List<Recipe> recipes = [
      Recipe(id: 1, title: 'Steak', servings: '1', ingredients: 'Beef, Butter, Thyme, Ginger', steps: 'blah blah blah', source: 'N/A'),
      Recipe(id: 2, title: 'Pizza', ingredients: 'Beef, flour, sauce, cheese', steps: 'blah blah blah'),
    ]; // Sample recipes data, replace with your data

    for (var recipe in recipes) {
      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [
            pw.ListView(children: [
              pw.Text(recipe.title ?? "",
                  style: pw.TextStyle(
                      fontSize: 35, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 60),
              pw.Text("Ingredients : ",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(recipe.ingredients ?? "",
                  overflow: pw.TextOverflow.span),
              pw.SizedBox(height: 40),
              pw.Text("Instructions : ",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(recipe.steps ?? "", overflow: pw.TextOverflow.span),
            ])
          ]));
    }

    await file.writeAsBytes(await pdf.save());
    Share.shareXFiles([XFile(filePath)]);
  }
}