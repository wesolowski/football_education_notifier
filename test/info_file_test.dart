import 'dart:convert';

import 'package:football_education_notifier/info_file.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('InfoFile', () {
    late String filePath;
    late File testFile;
    late InfoFile infoFile;

    setUp(() {
      filePath = 'test_data.json';
      testFile = File(filePath);
      infoFile = InfoFile(filePath);
    });

    tearDown(() {
      if (testFile.existsSync()) {
        testFile.deleteSync();
      }
    });

    test('getContent returns empty list for non-existent file', () {
      final content = infoFile.getContent();

      expect(content, isEmpty);
    });

    test('getContent returns content of existing file', () {
      final testData = ['one', 'two', 'three'];
      testFile.writeAsStringSync(jsonEncode(testData));

      final content = infoFile.getContent();

      expect(content, testData);
    });

    test('setContent writes content to file', () {

      final testData = ['one', 'two', 'three'];
      infoFile.setContent(testData);

      expect(testFile.existsSync(), isTrue);
      final content = testFile.readAsStringSync();
      expect(content, jsonEncode(testData));
    });

    test('setContent writes content to file when file exist', () {

      final testDataBefore = ['unit', 'test'];
      infoFile.setContent(testDataBefore);

      expect(infoFile.getContent(), testDataBefore);


      final testData = ['one', 'two', 'three'];
      infoFile.setContent(testData);

      expect(infoFile.getContent(), testData);
    });
  });
}
