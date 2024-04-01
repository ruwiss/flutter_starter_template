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
    "$projectName/test"
  ];

  final List<FileToCopy> filesToCopy = [
    FileToCopy(source: ".vscode", destination: "$projectName/"),
    FileToCopy(source: "environment", destination: "$projectName/"),
    FileToCopy(source: "lib", destination: "$projectName/"),
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
  await _runFlutterPubGet(context, projectName);
  await _runBuildRunnerScript(context, projectName);
}

Future<void> _copyFiles(HookContext context, String projectName,
    List<String> foldersToRemove, List<FileToCopy> filesToCopy) async {
  final copyFileProgress =
      context.logger.progress("Gerekli dosyalar kopyalanıyor");

  for (String folder in foldersToRemove) {
    final dir = Directory(folder);
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  }

  final List results = [];
  for (var fileMap in filesToCopy) {
    try {
      final String target = "${fileMap.destination}${fileMap.source}";
      if (fileMap.isFile) {
        results.add(File(fileMap.source).renameSync(target));
      } else {
        results.add(Directory(fileMap.source).renameSync(target));
      }

      copyFileProgress.update("${fileMap.source} taşındı");
    } catch (e) {
      copyFileProgress.fail(e.toString());
    } finally {
      if (filesToCopy.length == results.length) {
        copyFileProgress.complete("Dosyalar başarıyla kopyalandı!");
      }
    }
  }
}

Future<void> _runFlutterPubGet(HookContext context, String projectName) async {
  final flutterPubGetProgress =
      context.logger.progress("Flutter pub get: Proje hazırlanıyor");
  final result = await Process.run("flutter", ["pub", "get"],
      workingDirectory: projectName, runInShell: true);

  flutterPubGetProgress.update(result.stdout);
  flutterPubGetProgress.fail(result.stderr);

  _openCodeEditor(projectName);

  flutterPubGetProgress.complete("Proje açılıyor..");
}

Future<void> _runBuildRunnerScript(
    HookContext context, String projectName) async {
  final buildRunnerProgress =
      context.logger.progress("Build Runner: Çalıştırılıyor");
  final result = await Process.run(
      "dart", ["run", "build_runner", "build", "--delete-conflicting-outputs"],
      workingDirectory: projectName, runInShell: true);

  buildRunnerProgress.update(result.stdout);
  buildRunnerProgress.fail(result.stderr);

  buildRunnerProgress.complete("Build Runner: işlem bitti");
  exit(0);
}

void _openCodeEditor(String projectName) {
  Process.run("code", ["."], workingDirectory: projectName, runInShell: true);
}
