import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/intresting_page.dart/intresting_page.dart';
import 'package:cyber_hulk/view/news_screen/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: ColorConstant.pantonemessage,
        actions: const [
          Text(
            "Version 1.0.0",
            style: TextStyle(color: ColorConstant.mainblack),
          )
        ],
      ),
      body: Column(children: [
        Stack(children: [
          Container(
            width: double.infinity,
            height: screenHeight * .25,
            decoration: BoxDecoration(
              color: ColorConstant.pantonemessage,
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(70),
              //     bottomRight: Radius.circular(70))
              borderRadius: BorderRadius.only(
                  //  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Center(
                child: Text(widget.question,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.light
                              ? ColorConstant.mainblack
                              : ColorConstant.mainwhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => NewsScreen()));
              //     },
              //     icon: Image.asset(
              //       "assets/images/CyberHULK Logo final.png",
              //       fit: BoxFit.cover,
              //       height: 60,
              //     )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InterestingPage()));
                },
                child: Container(
                  // height: screenHeight * 0.05,
                  // width: screenWidth * 0.1,
                  constraints: BoxConstraints(
                      minHeight: screenHeight * .07,
                      minWidth: screenWidth * .15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      //  color: ColorConstant.mainwhite,
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/Location Pin Cartoon StyleHULK (1).png",
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => NewsScreen()));
              //     },
              //     child: Image.asset(
              //       "assets/images/unnamed.webp",
              //       // height: screenHeight * .1,
              //     )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_out),
                    onPressed: () {
                      setState(() {
                        if (_fontSize > 12) {
                          _fontSize -= 2; // Decrease font size
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_in),
                    onPressed: () {
                      setState(() {
                        if (_fontSize < 30) {
                          _fontSize += 2; // Increase font size
                        }
                      });
                    },
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => InterestingPage()));
              //     },
              //     icon: Icon(Icons.home)),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.lightGreen[500])),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.newspaper,
                        color: ColorConstant.mainwhite,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "News",
                        style: TextStyle(color: ColorConstant.mainwhite),
                      )
                    ],
                  ))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: screenHeight * .7,
                  width: screenWidth * .95,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Text(
                        textAlign: TextAlign.justify,
                        widget.answers,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: _fontSize,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? ColorConstant.mainwhite
                                : ColorConstant.mainblack,
                          ),
                        )),
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstant.mainwhite,
                      borderRadius: BorderRadius.circular(60)),
                ),
              ),
            ],
          ),
        ]),
      ]),
    );
  }
}
