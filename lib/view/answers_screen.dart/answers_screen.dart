import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Answersscreen extends StatefulWidget {
  const Answersscreen(
      {super.key, required this.answers, required this.question});
  final String answers;
  final String question;
  @override
  State<Answersscreen> createState() => _AnswersscreenState();
}

class _AnswersscreenState extends State<Answersscreen> {
  double _fontSize = 16.0; // Default font size

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.pantonemessage,
        actions: [
          Text(
            "Version 1.0.0",
            style: TextStyle(color: ColorConstant.mainblack),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                        child: Text(
                      widget.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.light
                              ? ColorConstant.mainblack
                              : ColorConstant.mainwhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.pantonemessage,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70))),
                ),
                Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.zoom_out),
                          onPressed: () {
                            setState(() {
                              if (_fontSize > 12)
                                _fontSize -= 2; // Decrease font size
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.zoom_in),
                          onPressed: () {
                            setState(() {
                              if (_fontSize < 30)
                                _fontSize += 2; // Increase font size
                            });
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        textAlign: TextAlign.justify,
                        widget.answers,
                        style: TextStyle(
                          fontSize: _fontSize,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? ColorConstant.mainwhite
                              : ColorConstant.mainblack,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
