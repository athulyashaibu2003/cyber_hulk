import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/login_screen/login_screen.dart';
import 'package:cyber_hulk/view/terms_and_conditions_screen/terms_for_read.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class AboutCyberHulkScreen extends StatefulWidget {
  const AboutCyberHulkScreen({super.key});

  @override
  State<AboutCyberHulkScreen> createState() => _AboutCyberHulkScreenState();
}

class _AboutCyberHulkScreenState extends State<AboutCyberHulkScreen>
    with SingleTickerProviderStateMixin {
  late Box box1;
  late AnimationController _controller;
  late Animation<int> _typewriterAnimation;

  final String _text1 =
      "     CyberHulk is a free informative APP developed by Avanzo Cyber Security Solutions, its prime motive is to spread knowledge and aware the peoples about the usage and functionalities of cyber security. In today’s modern world, the usage of cyber space is indefinable, so the hidden pitfalls are enormous. To help the people who in need the support can use our CyberHulk as much as they need. Its user-friendly appearance is easy to understand and provides meaningful answers in a simplified manner. ";
  final String _text2 =
      "              The limitation is your thought, any questions related to the cyber world can be accessed through CyberHulk. Primarily CyberHulk ideas limited under Indian Jurisdiction but on coming updates you can change your region and access full support related to that region. CyberHulk will be an informative buddy so you will not be unaware about our cyber laws. However, the APP will not be responsible for any direct or indirect damages caused without proper usage of the APP CyberHulk is not just an informative App also a final solution, our app can be used to contact cyber security support and you can communicate with professionals and find solution without any sweat.  In the future the support provided by CyberHulk will be limitless, our chat buddy will be your friend who in need. We assure you our CyberHulk will be the only solution for your cyber related problems and in the future a well known and educated generation will be born and recreate the world. ";
  Color textColor = ColorConstant.mainblack;
  void colorFunction() {
    if (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.light) {
      textColor = ColorConstant.mainblack;
    } else {
      textColor = ColorConstant.mainwhite;
    }
  }

  @override
  void initState() {
    super.initState();
    createOpenBox();
    // Typewriter effect initialization
    _controller = AnimationController(
      duration: const Duration(seconds: 50),
      vsync: this,
    );
    _typewriterAnimation = StepTween(
      begin: 0,
      end: _text1.length + _text2.length,
    ).animate(_controller);

    _controller.forward();
  }

  void createOpenBox() async {
    box1 = await Hive.openBox('logindata');
  }

  Future<void> logout() async {
    await box1.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: [
            Center(
              child: Container(
                height: size.height * 0.25,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/CH green final.png",
                        ),
                        fit: BoxFit.fitWidth)),
                // child: Image.asset(
                //     // themeProvider.themeMode == ThemeMode.dark
                //     //     ? "assets/images/CyberHULK Logo final-07.png"
                //     //     : "assets/images/CyberHULK Logo final-06.png",
                //     "assets/images/Artboard 3_PURPLE.png",
                //     fit: BoxFit.fitHeight,
                //     height: 150),
              ),
            ),

            // SizedBox(height: 10),
            AnimatedBuilder(
              animation: _typewriterAnimation,
              builder: (context, child) {
                String textToShow =
                    (_typewriterAnimation.value <= _text1.length)
                        ? _text1.substring(0, _typewriterAnimation.value)
                        : _text1 +
                            _text2.substring(
                                0, _typewriterAnimation.value - _text1.length);
                return Text(
                  textToShow,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? textColor = ColorConstant.mainwhite
                          : textColor = ColorConstant.mainblack,
                      fontSize: 16.0),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Termsforread()));
              },
              child: Text(
                "Terms and conditions",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ColorConstant.darkpurple),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            OutlinedButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(color: ColorConstant.darkpurple),
                ),
              ),
              onPressed: logout,
              child: Text(
                "Logout",
                style: TextStyle(color: ColorConstant.darkpurple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
