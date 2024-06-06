import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/phishing_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
  void _setTextFieldText(Widget targetscreen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => targetscreen));
  }

  Widget _buildClickableContainer(String text, Widget targetscreen) {
    return GestureDetector(
      onTap: () => _setTextFieldText(targetscreen),
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colorconstant.pantonebackground,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(
              shadows: [
                Shadow(color: Colorconstant.darkpurple, offset: Offset(.8, .8))
              ],
              // color: Colorconstant.pantonemessage,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List imageList = [
      "https://images.pexels.com/photos/6142129/pexels-photo-6142129.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/60504/security-protection-anti-virus-software-60504.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/5935787/pexels-photo-5935787.jpeg",
      "https://images.pexels.com/photos/5935787/pexels-photo-5935787.jpeg",
      "https://i.pinimg.com/564x/bf/f9/a5/bff9a5629be2631f6c5810ddb86e40bc.jpg",
    ];
    List<Map> homepageList = [
      {
        "title": "Phishing",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Cyber Security",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Malware",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Hacking",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Data Breach",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "DDoS Attack",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Firewall",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Patch",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "AI",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Encryption",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Security Incident",
        "itemimage":
            "https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Robotics",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
      {
        "title": "Ransomware",
        "itemimage":
            "https://images.pexels.com/photos/207580/pexels-photo-207580.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      },
    ];
    return Scaffold(
      backgroundColor: Colorconstant.mainwhite,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/Animation - 1717590925994.gif",
                height: 300,
                fit: BoxFit.contain,
              ),

              // Center(
              //   child: Container(
              //     height: 250,
              //     width: 250,
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: AssetImage(
              //                 "assets/images/Cyber attack-bro (1).png"))),
              //   ),
              // ),

              Wrap(
                children: [
                  _buildClickableContainer("Phishing", PhishingText()),
                  _buildClickableContainer(
                      "Cyber security", CyberSecuritytext()),
                  _buildClickableContainer("Malware", Malwaretext()),
                  _buildClickableContainer("Hacking", Hackingtext()),
                  _buildClickableContainer("Data breach", Databreach()),
                  _buildClickableContainer("DDoS attack", DDOSAttacktext()),
                  _buildClickableContainer("Firewall", FireWalltext()),
                  _buildClickableContainer("Patch", Patchtext()),
                  _buildClickableContainer("AI", AItext()),
                  _buildClickableContainer("Encryption", Encryptiontext()),
                  _buildClickableContainer(
                      "Security incident", Securityincidenttext()),
                  _buildClickableContainer("Robotics", Roboticstext()),
                  _buildClickableContainer("Ransomware", Ransomeware()),
                ],
              ),

              // grid
              // Expanded(
              //   child: GridView.builder(
              //     itemCount: 12, // Set your desired number of items
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2, // Adjust as per your needs
              //         crossAxisSpacing: 10.0,
              //         mainAxisSpacing: 10.0,
              //         mainAxisExtent: 200),
              //     itemBuilder: (BuildContext context, int index) {
              //       return InkWell(
              //         onTap: () {
              //           if (index == 0) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => PhishingText(),
              //               ),
              //             );
              //           } else if (index == 1) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => CyberSecuritytext(),
              //               ),
              //             );
              //           } else if (index == 2) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Malwaretext(),
              //               ),
              //             );
              //           } else if (index == 3) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Hackingtext(),
              //               ),
              //             );
              //           } else if (index == 4) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Databreach(),
              //               ),
              //             );
              //           } else if (index == 5) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => DDOSAttacktext(),
              //               ),
              //             );
              //           } else if (index == 6) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => FireWalltext(),
              //               ),
              //             );
              //           } else if (index == 7) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Patchtext(),
              //               ),
              //             );
              //           } else if (index == 8) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => AItext(),
              //               ),
              //             );
              //           } else if (index == 9) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Encryptiontext(),
              //               ),
              //             );
              //           } else if (index == 10) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Securityincidenttext(),
              //               ),
              //             );
              //           } else if (index == 11) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Roboticstext(),
              //               ),
              //             );
              //           } else if (index == 12) {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Ransomeware(),
              //               ),
              //             );
              //           }
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               // color: const Color.fromARGB(255, 73, 71, 71),
              //               // color: Colorconstant.pantonemessage,
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //               border:
              //                   Border.all(color: Colorconstant.pantonemessage)),
              //           child: LayoutBuilder(builder: (context, constraints) {
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Container(
              //                   height: constraints.maxHeight * .7,
              //                   width: constraints.maxWidth,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(20),
              //                         topRight: Radius.circular(20)),
              //                   ),
              //                   clipBehavior: Clip.antiAlias,
              //                   child: Image.network(
              //                     homepageList[index]["itemimage"],
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //                 SizedBox(height: 10),
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 5),
              //                   child: Text(
              //                     homepageList[index]["title"],
              //                     style: GoogleFonts.poppins(
              //                         textStyle: TextStyle(
              //                             color: Colors.black,
              //                             // fontWeight: FontWeight.bold,
              //                             fontSize: 17)),
              //                     // style: TextStyle(
              //                     //     color: Colors.black,
              //                     //     fontWeight: FontWeight.bold,
              //                     //     fontSize: 17),
              //                   ),
              //                 ),
              //               ],
              //             );
              //           }),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // grid end---------------------------------
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border.all(
              //           color: Colorconstant.pantonemessage, width: 2)),
              //   child: Wrap(
              //     runSpacing: 5,
              //     spacing: 8,
              //     children: [
              //       _buildClickableContainer("Phishing", PhishingText()),
              //       _buildClickableContainer(
              //           "Cyber security", CyberSecuritytext()),
              //       _buildClickableContainer("Malware", Malwaretext()),
              //       _buildClickableContainer("Hacking", Hackingtext()),
              //       _buildClickableContainer("Data breach", Databreach()),
              //       _buildClickableContainer("DDoS attack", DDOSAttacktext()),
              //       _buildClickableContainer("Firewall", FireWalltext()),
              //       _buildClickableContainer("Patch", Patchtext()),
              //       _buildClickableContainer("AI", AItext()),
              //       _buildClickableContainer("Encryption", Encryptiontext()),
              //       _buildClickableContainer(
              //           "Security incident", Securityincidenttext()),
              //       _buildClickableContainer("Robotics", Roboticstext()),
              //       _buildClickableContainer("Ransomware", Ransomeware())
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
