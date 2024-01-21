import 'dart:io';

void main() async {
  final file = File('./material_icons.dart');
  final lines = await file.readAsLines();

  final regex = RegExp(r"static const IconData (\w+) = (IconData\(.+\));");

  final List<({String name, dynamic iconData})> icons = [];

  for (var line in lines) {
    final match = regex.firstMatch(line);
    if (match != null) {
      final name = match.group(1) ?? '';
      final icon = match.group(2) ?? '';
      icons.add((name: "'${name.replaceAll('_', ' ')}'", iconData: icon));
    }
  }

  final outputFile = File('icons.dart');
  await outputFile.writeAsString(
    'const List<({String name, IconData iconData})> icons = $icons;',
  );
}
