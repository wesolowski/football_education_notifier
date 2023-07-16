import 'dart:convert';
import 'dart:io';

abstract class InfoFileInterface {
  List<String> getContent();
  void setContent(List<String> content);
}

class InfoFile implements InfoFileInterface {
  final String filePath;

  InfoFile(this.filePath);

  @override
  List<String> getContent() {
    final file = File(filePath);

    if (file.existsSync()) {
      final jsonString = file.readAsStringSync();
      final content = jsonDecode(jsonString).cast<String>();

      return content;
    }
    return [];
  }

  @override
  void setContent(List<String> content) {
    final file = File(filePath);

    final jsonString = jsonEncode(content);

    file.writeAsStringSync(jsonString);
  }
}
