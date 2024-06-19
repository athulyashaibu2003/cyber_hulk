import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/phishing_text.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../utilis/AI.dart';
import '../../utilis/cyber_security_text.dart';
import '../../utilis/data_breach.dart';
import '../../utilis/ddos_attack.dart';
import '../../utilis/encryption.dart';
import '../../utilis/firewall.dart';
import '../../utilis/hacking_text.dart';
import '../../utilis/malware_text.dart';
import '../../utilis/patch.dart';
import '../../utilis/ransomware.dart';
import '../../utilis/robotics.dart';
import '../../utilis/security_incident.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool selected = false;
  toggleState() {
    setState(() {
      selected = !selected;
    });
  }

  void _navigateToTargetScreen(Widget targetScreen, String tag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TargetScreen(targetScreen: targetScreen, tag: tag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> cloudTexts = [
      'Phishing',
      'Cyber security',
      'Patch',
      'Ai',
      'Robotics',
      'Malware',
      // 'Hacking',
      // 'Data breach',
      // 'DDoS attack',
      // 'Firewall',
      // 'Encryption',
      // 'Security incident',
      // 'Ransomware'
    ];

    final List<Widget> targetScreens = [
      PhishingText(),
      CyberSecuritytext(),
      Patchtext(),
      AItext(),
      Roboticstext(),
      Malwaretext(),
      // Hackingtext(),
      // Databreach(),
      // DDOSAttacktext(),
      // FireWalltext(),
      // Encryptiontext(),
      // Securityincidenttext(),
      // Ransomeware()
    ];

    return Scaffold(
      backgroundColor: ColorConstant.mainwhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Interested Topics",
                style: TextStyle(
                    color: ColorConstant.mainblack,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                ),
                itemCount: cloudTexts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToTargetScreen(
                          targetScreens[index], cloudTexts[index]);
                      selectedIndex = index;
                      toggleState();
                    },
                    child: Hero(
                      tag: cloudTexts[index],
                      child: CloudTextWidget(
                        text: cloudTexts[index],
                        selected: selected,
                        index: selectedIndex,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  // Image.asset("assets/images/Animation - 1717674683787.gif"),
                  Text(
                    "Cyber Tips",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CloudTextWidget extends StatefulWidget {
  final String text;
  final int index;
  final bool selected;

  CloudTextWidget(
      {required this.text, required this.selected, required this.index});

  @override
  State<CloudTextWidget> createState() => _CloudTextWidgetState();
}

class _CloudTextWidgetState extends State<CloudTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.selected ? 150 : 75,
      width: widget.selected ? 150 : 75,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/violet cloud.png"),
      )),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.selected ? 18 : 14,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TargetScreen extends StatelessWidget {
  final Widget targetScreen;
  final String tag;

  TargetScreen({required this.targetScreen, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tag),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: targetScreen,
        ),
      ),
    );
  }
}
