import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress("Yeni proje oluşturuluyor");

  try {
    await _createFlutterApp(context);
    progress.complete("Proje oluşturuldu!");
  } catch (e) {
    progress.fail("Proje oluşturulurken sorun oluştu 'flutter create' : $e");
  }
}

Future<void> _createFlutterApp(HookContext context) async {
  String projectName = context.vars["project_name"];
  projectName = projectName.snakeCase;
  final description = context.vars["description"] as String;
  final organization = context.vars["organization"] as String;
  final platforms = context.vars["platforms"] as String;

  final args = [
    "create",
    projectName,
    "--description",
    description,
    "--org",
    organization
  ];

  if (platforms != "all")
    args.addAll(["--platforms", platforms.replaceAll(" ", "")]);

  final result = await Process.run("flutter", args, runInShell: true);
  if (result.exitCode != 0) throw result.stderr;
}
