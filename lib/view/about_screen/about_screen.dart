import 'package:cyber_hulk/view/about_avanzo_screen/about_avanzo_screen.dart';
import 'package:cyber_hulk/view/about_cyberhulk_screen/about_cyberhulk_screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(children: [
        AboutCyberHulkScreen(),
        AboutAvanzoScreen(),
      ]),
    );
  }
}
