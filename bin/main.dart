// ignore_for_file: avoid_print

import 'dart:io';
import 'package:yaml/yaml.dart';

void main() async {
  String currentPath = Directory.current.path;

  File _yamlFile = File('$currentPath/pubspec.yaml');
  final String fileData = _yamlFile.readAsStringSync();

  final List<String> _fileExt = [
    ".png",
    ".jpg",
    ".jpeg",
    ".svg",
    ".webp",
    ".ttf",
    ".mp3",
    ".mp4",
    ".mov",
    ".avi",
    ".mkv",
    ".m4a",
    ".wav",
    ".wma",
    ".aac"
  ];
  var _yamlData = loadYaml(fileData);

  bool isAssetsAdded = _yamlData['flutter']['assets'] != null;
  bool isGeneratedPathAdded = _yamlData['generated_assets_path'] != null;
  if (!isAssetsAdded) {
    print("Please add assets in your pubspec.yaml");
    return;
  }

  if (!isGeneratedPathAdded) {
    print("Please add 'generated_assets_path' in your pubspec.yaml");
    return;
  }

  YamlList _assetPaths = _yamlData['flutter']['assets'];
  String _generatedAssetDirPath = _yamlData['generated_assets_path'];

  StringBuffer _code = StringBuffer();

  _code.writeln("class Assets {");

  for (var path in _assetPaths) {
    Directory _dir = Directory(path);
    _dir.listSync().forEach(
      (item) {
        print(item);
        String file = item.path.split('/').last;
        bool isFile = false;
        for (var ext in _fileExt) {
          isFile = file.endsWith(ext);
          if (isFile) break;
        }
        if (isFile) {
          String _fileName = file.split('.').first;
          int i = -1;
          String _varName = _fileName
              .split('_')
              .map((e) {
                var _firstChar = e.substring(0, 1);
                var _otherChar = e.substring(1);
                i++;

                return i == 0
                    ? _firstChar.toLowerCase() + _otherChar
                    : _firstChar.toUpperCase() + _otherChar;
              })
              .toList()
              .reduce((value, element) => "$value$element")
              .toString();

          if (int.tryParse(_fileName) == null) {
            _code.writeln("static String $_varName = \"$path$file\";");
          }
        }
      },
    );
  }

  _code.writeln("}");

  bool isExists = Directory(_generatedAssetDirPath).existsSync();
  if (!isExists) {
    await Directory(_generatedAssetDirPath).create();
  }

  File _file = File(_generatedAssetDirPath + 'app_assets.dart');
  _file.writeAsStringSync("$_code");
}
