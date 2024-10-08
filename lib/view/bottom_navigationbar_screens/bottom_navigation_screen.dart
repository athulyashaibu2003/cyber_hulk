import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/utilis/theme_swich/theme_switch.dart';
import 'package:cyber_hulk/view/about_screen/about_screen.dart';
import 'package:cyber_hulk/view/dashborad_screen/dashboard_screen.dart';
import 'package:cyber_hulk/view/intresting_page.dart/intresting_page.dart';
import 'package:cyber_hulk/view/news_screen/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int indexnum = 0;

  List screens = [
    const InterestingPage(),
    const DashboardScreen(),
    const NewsScreen(),
    // const AboutCyberHulkScreen(),
    const AboutScreen(),
  ];

  final Uri _url =
      Uri.parse('https://cybot.avanzosolutions.in/cybot/newsimagedisplay.php');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false)
        .toggleTheme(ThemeMode.system == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colorconstant.mainwhite,
      appBar: indexnum == 3
          ? null
          : AppBar(
              backgroundColor: ColorConstant.pantonemessage,
              toolbarHeight: 68,
              actions: const [
                Text(
                  "Version 1.0.0",
                  style: TextStyle(color: ColorConstant.mainblack),
                ),
                ThemeSwitch(),
                SizedBox(
                  width: 15,
                )
              ],
            ),
      body:
          // indexnum == 2 ? Container() :
          screens[indexnum],
      // bottomNavigationBar: BottomNavigationBar(
      // onTap: (value) {
      //   // if (value == 2) {
      //   //   _launchUrl();
      //   // } else {
      //   setState(() {
      //     indexnum = value;
      //   });
      //   // }
      // },
      // currentIndex: indexnum,
      //   unselectedItemColor: Colorconstant.mainwhite,
      //   selectedItemColor: Colorconstant.pantonemessage,
      //   backgroundColor: Colorconstant.mainblack,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //           size: 20,
      //         ),
      //         label: "Home"),
      //     const BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.search,
      //           size: 20,
      //         ),
      //         label: "Ask Question"),
      //     // -----------------------------------------------------
      //     // const BottomNavigationBarItem(
      //     //     icon: ImageIcon(
      //     //       const AssetImage(
      //     //         "assets/images/Animation - 1717225115801 (1).gif",
      //     //       ),
      //     //       size: 40,
      //     //     ),
      //     //     label: "News"),
      //     // ---------------------
      //     const BottomNavigationBarItem(
      //         icon:
      // ImageIcon(
      //           AssetImage(
      //             "assets/images/CyberHULK Logo final small.png",
      //           ),
      //           size: 20,
      //         ),
      //         label: "Cyberhulk"),
      //     const BottomNavigationBarItem(
      //         icon:
      // ImageIcon(
      //           AssetImage(
      //             "assets/images/avzlogo.png",
      //           ),
      //           size: 20,
      //         ),
      //         label: "Avanzo"),
      //   ],
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => NewsScreen(),
      //         ));
      //   },
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   mini: true,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) {
          // if (value == 2) {
          //   _launchUrl();
          // } else {
          setState(() {
            indexnum = value;
          });
          // }
        },
        letIndexChange: (index) => true,
        index: indexnum,
        backgroundColor: Colors.transparent,
        color: ColorConstant.pantonemessage,
        items: const <Widget>[
          ImageIcon(
            AssetImage(
              "assets/images/CyberHULK Logo final small.png",
            ),
            size: 30,
          ),
          Icon(
            Icons.search,
            size: 30,
          ),
          Icon(Icons.newspaper_sharp),
          ImageIcon(
            AssetImage(
              "assets/images/avzlogo copy.png",
            ),
            size: 40,
          ),
        ],
      ),
    );
  }
}
