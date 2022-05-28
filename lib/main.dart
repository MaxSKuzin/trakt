import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection.dart';
import 'presentation/application/application.dart';

Future<void> main() async {
  await dotenv.load();
  await configureDependencies();
  
  runApp(const Application());
}
