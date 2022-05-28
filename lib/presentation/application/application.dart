import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen/home_screen.dart';
import 'theme.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
