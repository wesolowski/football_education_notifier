import 'dart:convert';
import 'dart:io';

class InfoFile {
  final String filePath;

  InfoFile(this.filePath);

  List<String> getContent() {
    final file = File(filePath);

    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      final content = jsonDecode(jsonString).cast<String>();

      return content;
    }
    return [];
  }

  void setContent(List<String> content) {
    final file = File(filePath);

    final jsonString = jsonEncode(content);

    file.writeAsStringSync(jsonString);
  }
}
