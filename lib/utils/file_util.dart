import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static Future<String> _getShoppingNotesDirPath() async {
    final Directory appDocsDir = await getApplicationDocumentsDirectory();
    final String shoppingNotesDirPath = join(appDocsDir.path, 'shoppingnotes');

    Directory shoppingNotesDir = Directory(shoppingNotesDirPath);

    if (!shoppingNotesDir.existsSync()) {
      shoppingNotesDir.createSync();
    }

    return shoppingNotesDirPath;
  }

  static Future<String> readNote() async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    final shoppingNotePath = join(shoppingNotesDirPath, "notes.txt");
    final notesFile = File(shoppingNotePath);

    final contents = await notesFile.readAsString();

    return contents;
  }

  static Future<void> writeNote(String fileContent) async {
    final shoppingNotesDirPath = await _getShoppingNotesDirPath();

    final shoppingNotePath = join(shoppingNotesDirPath, "notes.txt");
    final notesFile = File(shoppingNotePath);

    await notesFile.writeAsString(fileContent);
  }
}
