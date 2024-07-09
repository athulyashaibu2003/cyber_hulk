import 'package:cyber_hulk/view/about_avanzo_screen/about_avanzo_screen.dart';
import 'package:cyber_hulk/view/about_cyberhulk_screen/about_cyberhulk_screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "About",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // backgroundColor: ColorConstant.mainwhite,
          toolbarHeight: 68,
          actions: const [
            // const Text(
            //   "Version 1.0.0",
            //   style: TextStyle(color: ColorConstant.mainblack),
            // ),
            // ThemeSwitch(),
            SizedBox(
              width: 15,
            )
          ],
          bottom: const TabBar(
            dividerHeight: 0,
            tabs: [
              Tab(
                child: Text("Cyberhulk"),
              ),
              Tab(
                child: Text("Author"),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          AboutCyberHulkScreen(),
          AboutAvanzoScreen(),
        ]),
      ),
    );
  }
}
