import 'package:carousel_slider_plus/carousel_slider_plus.dart';
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
  // carousel.CarouselController buttonCarouselController =
  //    carousel.CarouselController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  dynamic res = "";
  String answers = "";

  // double _fontSize = 16.0; // Default font size

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
            askquestioncontroller.text = "$_text?";
            askquestioncontroller.selection = TextSelection.fromPosition(
                TextPosition(offset: askquestioncontroller.text.length));
            _isListening = false;
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
            const SizedBox(height: 30),
            Image.asset("assets/images/CH green final.png",
                fit: BoxFit.fitHeight, height: 150),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    autofocus: false,

                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                        onPressed: _listen,
                      ),
                      border: const OutlineInputBorder(),
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
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(ColorConstant.darkpurple),
                minimumSize: WidgetStateProperty.all(const Size(300, 70)),
              ),
              onPressed: () async {
                String response = await askquestion();
                answers = response;
                String question = askquestioncontroller.text;
                // log("this will be printed on ui $answers");
                print("respose===== $answers");
                setState(() {});
                answers != "WRONG CREDENTIALS "
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Answersscreen(
                              answers: answers, question: question),
                        ))
                    : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.purple,
                        content: Text("There is no answer")));
                FocusScope.of(context).unfocus();
                askquestioncontroller.clear();
              },
              child: const Text(
                "Ask",
                style: TextStyle(
                  fontSize: 25,
                  color: ColorConstant.mainwhite,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
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
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/bulb-removebg-preview.png"))),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            CarouselSlider(
              //   carouselController: buttonCarouselController,
              options: CarouselOptions(
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  height: 200,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.ease,
                  autoPlay: true,
                  enlargeCenterPage: true),
              items: List.generate(
                Cybertipsclass.cybertips.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      TipsBottomSheet(context, index);
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * .5,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          color: ColorConstant.pantonemessage,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            textAlign: TextAlign.center,
                            Cybertipsclass.cybertips[index]["title"],
                            style: const TextStyle(
                                color: ColorConstant.mainblack,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              textAlign: TextAlign.justify,
                              Cybertipsclass.cybertips[index]["subtitle"],
                              style: const TextStyle(
                                  color: ColorConstant.mainblack,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
                    style: const TextStyle(fontSize: 30, color: Colors.purple),
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
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          )
        ],
      );
    },
  );
}
