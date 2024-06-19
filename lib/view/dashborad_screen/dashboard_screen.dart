// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cyber_hulk/controller/suggestion_list/suggestion_list.dart';
// import 'package:cyber_hulk/main.dart';
// import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'dart:developer';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   TextEditingController askquestioncontroller = TextEditingController();
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = '';
//   dynamic res = "";
//   String answers = "";
//   double _fontSize = 16.0; // Default font size

//   Future<String> askquestion() async {
//     String uri = "https://cybot.avanzosolutions.in/cybot/";
//     try {
//       res = await http.post(Uri.parse(uri), body: {
//         "askquestioncontroller": askquestioncontroller.text,
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//     String data = res.body;
//     return data;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) => setState(() {
//             askquestioncontroller.text = val.recognizedWords;
//             _text = val.recognizedWords;
//             askquestioncontroller.text = _text;
//             askquestioncontroller.selection = TextSelection.fromPosition(
//                 TextPosition(offset: askquestioncontroller.text.length));
//           }),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   @override
//   void dispose() {
//     askquestioncontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 30),
//             Image.asset(
// themeProvider.themeMode == ThemeMode.dark
//     ? "assets/images/CyberHULK Logo final-07.png"
//     : "assets/images/CyberHULK Logo final-06.png",
//                 "assets/images/CH green final.png",
//                 fit: BoxFit.fitHeight,
//                 height: 150),
//             // Center(
//             //   child: Text(
//             //     "CYBERHULK",
//             //     style: TextStyle(
//             //       color: Colorconstant.darkpurple,
//             //       fontSize: 35,
//             //       fontWeight: FontWeight.w900,
//             //     ),
//             //   ),
//             // ),
//             // SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//               child: TypeAheadField(
//                 builder: (context, controller, focusNode) => TextField(
//                   controller: askquestioncontroller,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                       icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                       onPressed: _listen,
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 suggestionsCallback: (pattern) async {
//                   return Suggestions.suggestionlist
//                       .where((item) =>
//                           item.toLowerCase().startsWith(pattern.toLowerCase()))
//                       .toList();
//                 },
//                 itemBuilder: (context, suggestion) {
//                   return ListTile(title: Text(suggestion));
//                 },
//                 onSelected: (suggestion) {
//                   askquestioncontroller.text = suggestion;
//                 },
//               ),
//             ),
//             SizedBox(height: 15),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor:
//                     WidgetStateProperty.all(ColorConstant.darkpurple),
//                 minimumSize: WidgetStateProperty.all(Size(300, 70)),
//               ),
//               onPressed: () async {
//                 String response = await askquestion();
//                 answers = response;
//                 log("this will be printed on ui $answers");
//                 setState(() {});
//                 askquestioncontroller.clear();
//               },
//               child: Text(
//                 "Ask",
//                 style: TextStyle(
//                   fontSize: 25,
//                   color: ColorConstant.mainwhite,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.zoom_out),
//                         onPressed: () {
//                           setState(() {
//                             if (_fontSize > 12)
//                               _fontSize -= 2; // Decrease font size
//                           });
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.zoom_in),
//                         onPressed: () {
//                           setState(() {
//                             if (_fontSize < 30)
//                               _fontSize += 2; // Increase font size
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   Text(
//                     answers,
//                     style: TextStyle(fontSize: _fontSize),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30),
//               child: Text(
//                 "Cyber Tips",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: NetworkImage(
//                           "https://static.vecteezy.com/system/resources/previews/017/458/891/non_2x/light-bulb-with-shining-light-cartoon-style-flat-style-hand-drawn-style-doodle-style-symbol-of-creativity-innovation-inspiration-invention-and-ideas-illustration-vector.jpg"))),
//             ),

//             SizedBox(
//               height: 200,
//               width: 350,
//               child: CarouselSlider(
//                   options: CarouselOptions(
//                       autoPlayAnimationDuration: Duration(seconds: 1),
//                       height: 200,
//                       viewportFraction: 1,
//                       autoPlayCurve: Curves.ease,
//                       autoPlay: true,
//                       enlargeCenterPage: true),
//                   items: [
//                     Image.network(
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRonKuTxQGNoBhBXAoW0csPNQJjc5DiJPsTpA&s",
//                       fit: BoxFit.cover,
//                       width: 1500,
//                     ),
//                     Image.network(
//                       "https://img.freepik.com/free-photo/standard-quality-control-collage-concept_23-2149595831.jpg?t=st=1717760603~exp=1717764203~hmac=776ba6cec13b69c5cb3b2adde57d9ee92e10acb7fe499e0f1a0d9c6447b717f4&w=740",
//                       fit: BoxFit.cover,
//                       width: 1500,
//                     ),
//                     Image.network(
//                       "https://img.freepik.com/free-photo/website-hosting-concept-with-circuits_23-2149406782.jpg?t=st=1717760733~exp=1717764333~hmac=7576ac09f2c2db7d0109f3aefc32763a5253a9ab7d2f0f65aa16a8f21eaca8ca&w=826",
//                       fit: BoxFit.cover,
//                       width: 1500,
//                     ),
//                   ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyber_hulk/controller/suggestion_list/suggestion_list.dart';
import 'package:cyber_hulk/database/database.dart';
import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/answers_screen.dart/answers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:developer';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController askquestioncontroller = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  dynamic res = "";
  String answers = "";
  double _fontSize = 16.0; // Default font size

  Future<String> askquestion() async {
    String uri = "https://cybot.avanzosolutions.in/cybot/search_text.php";
    try {
      res = await http.post(Uri.parse(uri), body: {
        "askquestioncontroller": askquestioncontroller.text,
      });
    } catch (e) {
      log(e.toString());
    }
    String data = res.body;
    return data;
  }

  Future<String> searchSuggestion({required String searchField}) async {
    String uri = "https://cybot.avanzosolutions.in/cybot/search_text1.php";
    try {
      res = await http.post(Uri.parse(uri), body: {
        "askquestioncontroller": searchField,
      });
    } catch (e) {
      log(e.toString());
    }
    String data = res.body;
    return data;
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            askquestioncontroller.text = val.recognizedWords;
            _text = val.recognizedWords;
            askquestioncontroller.text = _text;
            askquestioncontroller.selection = TextSelection.fromPosition(
                TextPosition(offset: askquestioncontroller.text.length));
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void dispose() {
    askquestioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Image.asset("assets/images/CH green final.png",
                fit: BoxFit.fitHeight, height: 150),
            // Center(
            //   child: Text(
            //     "CYBERHULK",
            //     style: TextStyle(
            //       color: Colorconstant.darkpurple,
            //       fontSize: 35,
            //       fontWeight: FontWeight.w900,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              // child: TypeAheadField(
              //   suggestionsCallback: (pattern) async {
              //     return Suggestions.suggestionlist
              //         .where((item) =>
              //             item.toLowerCase().startsWith(pattern.toLowerCase()))
              //         .toList();
              //   },
              //   builder: (context, controller, focusNode) {
              //     return TextField(
              //       style: TextStyle(
              //           color: themeProvider.themeMode == ThemeMode.dark
              //               ? ColorConstant.mainwhite
              //               : ColorConstant.mainblack),
              //       controller: askquestioncontroller,
              //       focusNode: focusNode,
              //       autofocus: true,
              //       decoration: InputDecoration(
              //         suffixIcon: IconButton(
              //           icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              //           onPressed: _listen,
              //         ),
              //         border: OutlineInputBorder(),
              //       ),
              //     );
              //   },
              //   itemBuilder: (context, suggestion) {
              //     return ListTile(
              //         title: Text(
              //       suggestion,
              //       style: TextStyle(
              //           color: themeProvider.themeMode == ThemeMode.dark
              //               ? ColorConstant.mainwhite
              //               : ColorConstant.mainblack),
              //     ));
              //   },
              //   onSelected: (suggestion) {
              // askquestioncontroller.clear();
              // askquestioncontroller.text = suggestion;
              //     // setState(() {});
              //   },

              //   // textFieldConfiguration: TextFieldConfiguration(
              //   //   controller: askquestioncontroller,
              //   //   decoration: InputDecoration(
              //   //     suffixIcon: IconButton(
              //   //       icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              //   //       onPressed: _listen,
              //   //     ),
              //   //     border: OutlineInputBorder(),
              //   //   ),
              //   // ),
              // ),
              child: TypeAheadField(
                controller: askquestioncontroller,
                suggestionsCallback: (pattern) async {
                  print('Pattern: $pattern');

                  final filteredSuggestions = Suggestions.suggestionlist
                      .where((item) =>
                          item.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();

                  print('Filtered Suggestions: $filteredSuggestions');

                  return filteredSuggestions;
                },
                builder: (context, askquestioncontroller, focusNode) {
                  return TextField(
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? ColorConstant.mainwhite
                          : ColorConstant.mainblack,
                    ),
                    controller:
                        askquestioncontroller, // Use the provided controller
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                        onPressed: _listen,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => searchSuggestion(
                        searchField: askquestioncontroller.text),
                  );
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(
                      suggestion,
                      style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? ColorConstant.mainwhite
                            : ColorConstant.mainblack,
                      ),
                    ),
                  );
                },
                onSelected: (suggestion) {
                  // Clear the controller and set the selected suggestion
                  askquestioncontroller.clear();
                  askquestioncontroller.text = suggestion;
                  // setState(() {});
                },
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(ColorConstant.darkpurple),
                minimumSize: WidgetStateProperty.all(Size(300, 70)),
              ),
              onPressed: () async {
                String response = await askquestion();
                answers = response;
                String question = askquestioncontroller.text;
                log("this will be printed on ui $answers");
                setState(() {});
                askquestioncontroller.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Answersscreen(answers: answers, question: question),
                    ));
              },
              child: Text(
                "Ask",
                style: TextStyle(
                  fontSize: 25,
                  color: ColorConstant.mainwhite,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            // SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Column(
            //     children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.zoom_out),
            //       onPressed: () {
            //         setState(() {
            //           if (_fontSize > 12)
            //             _fontSize -= 2; // Decrease font size
            //         });
            //       },
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.zoom_in),
            //       onPressed: () {
            //         setState(() {
            //           if (_fontSize < 30)
            //             _fontSize += 2; // Increase font size
            //         });
            //       },
            //     ),
            //   ],
            // ),
            // Text(
            //   answers,
            //   style: TextStyle(fontSize: _fontSize),
            // ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Quick Tips",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? ColorConstant.mainwhite
                            : ColorConstant.mainblack),
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/bulb-removebg-preview.png"))),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),

            CarouselSlider(
                options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    height: 200,
                    viewportFraction: 1,
                    autoPlayCurve: Curves.ease,
                    autoPlay: true,
                    enlargeCenterPage: true),
                items: List.generate(
                  Cybertipsclass.cybertips.length,
                  (index) {
                    return Container(
                      height: MediaQuery.sizeOf(context).height * .5,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          color: ColorConstant.pantonemessage,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text(
                            textAlign: TextAlign.center,
                            Cybertipsclass.cybertips[index]["title"],
                            style: TextStyle(
                                color: ColorConstant.mainblack,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              textAlign: TextAlign.justify,
                              Cybertipsclass.cybertips[index]["subtitle"],
                              style: TextStyle(
                                  color: ColorConstant.mainblack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  TipsBottomSheet(context, index);
                                },
                                child: Text(
                                  "Know more",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.01,
                                // height: 15,
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          )
                        ],
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> TipsBottomSheet(BuildContext context, int index) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 1,
              itemBuilder: (context, check) {
                // int questionLength =
                //     BottomSheetContainer.info[0][check].length;
                return ListTile(
                  title: Text(
                    // textAlign: TextAlign.justify,
                    Cybertipsclass.cybertips[index]['title'],
                    style: TextStyle(fontSize: 30, color: Colors.purple),
                  ),
                  subtitle: Text(
                    textAlign: TextAlign.justify,
                    Cybertipsclass.cybertips[index]['description'],
                    style: TextStyle(
                        color: Provider.of<ThemeProvider>(context).themeMode ==
                                ThemeMode.dark
                            ? ColorConstant.mainwhite
                            : ColorConstant.mainblack,
                        fontSize: 17),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
            ),
          )
        ],
      );
    },
  );
}
