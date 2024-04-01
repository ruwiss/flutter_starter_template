import 'dart:io';
import 'package:mason/mason.dart';

class FileToCopy {
  final String source;
  final String destination;
  final bool isFile;
  FileToCopy(
      {required this.source, required this.destination, this.isFile = false});
}

Future<void> run(HookContext context) async {
  String projectName = context.vars["project_name"];
  projectName = projectName.snakeCase;

  final List<String> foldersToRemove = [
    "$projectName/lib/",
    "$projectName/test/widget_test.dart",
    "$projectName/pubspec.yaml",
    "$projectName/analysis_options.yaml",
    "$projectName/.gitignore",
  ];

  final List<FileToCopy> filesToCopy = [
    FileToCopy(source: ".vscode", destination: "$projectName/"),
    FileToCopy(source: "environment", destination: "$projectName/"),
    FileToCopy(source: "lib", destination: "$projectName/"),
    FileToCopy(source: "scripts", destination: "$projectName/"),
    FileToCopy(
        source: "pubspec.yaml", isFile: true, destination: "$projectName/"),
    FileToCopy(
        source: "analysis_options.yaml",
        isFile: true,
        destination: "$projectName/"),
    FileToCopy(source: "l10n.yaml", isFile: true, destination: "$projectName/"),
    FileToCopy(
        source: ".gitignore", isFile: true, destination: "$projectName/"),
    FileToCopy(source: "assets", destination: "$projectName/"),
  ];

  await _copyFiles(context, projectName, foldersToRemove, filesToCopy);
}

Future<void> _copyFiles(HookContext context, String projectName,
    List<String> foldersToRemove, List<FileToCopy> filesToCopy) async {
  final copyFileProgress = context.logger.progress("Copying required files");

  for (String folder in foldersToRemove) {
    final dir = Directory(folder);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  }

  final List results = [];
  for (var fileMap in filesToCopy) {
    try {
      final String target = "${fileMap.destination}/${fileMap.source}";
      if (fileMap.isFile) {
        results.add(File(fileMap.source).renameSync(target));
      } else {
        results.add(Directory(fileMap.source).renameSync(target));
      }

      copyFileProgress.update("${fileMap.source} moved");
    } catch (e) {
      copyFileProgress.fail(e.toString());
    } finally {
      if (filesToCopy.length == results.length) {
        copyFileProgress.complete(
            "Files copied successfully! Please run /scripts commands");
        exit(0);
      }
    }
  }
}
