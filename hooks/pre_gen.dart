import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress("Running 'flutter create'");

  try {
    await _createFlutterApp(context);
    progress.complete("Flutter App created!");
  } catch (e) {
    progress.fail("Something went wrong while running 'flutter create' : $e");
  }
}

Future<ProcessResult> _createFlutterApp(HookContext context) async {
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

  if (platforms != "all") args.addAll(["--platforms=", platforms]);

  return Process.run("C:/flutter/bin/flutter.bat", args);
}
