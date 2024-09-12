import 'package:cyber_hulk/main.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:cyber_hulk/view/dashborad_screen/dashboard_screen.dart';
import 'package:cyber_hulk/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.phnumber,
      required this.mailid,
      required this.username,
      required this.password});
  final String firstName;
  final String lastName;
  final String phnumber;
  final String mailid;
  final String username;
  final String password;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    Future<void> insertrecord() async {
      if (firstName != "" ||
          lastName != "" ||
          phnumber != "" ||
          mailid != "" ||
          username != "" ||
          password != "") {
        try {
          String uri =
              "https://cybot.avanzosolutions.in/cybot/insert_record.php";
          var res = await http.post(Uri.parse(uri), body: {
            "firstnamecontroller": firstName,
            "lastnamecontroller": lastName,
            "phnumbercontroller": phnumber,
            "mailidcontroller": mailid,
            "usernamecontroller": username,
            "passwordcontroller": password,
          });
          var response = "success";
          var resp = "WRONG CREDENTIALS";

          if (res.body == response) {
            print("Record inserted");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
                (route) => false);
          }
          if (res.body == resp) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("please fill all fields");
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Terms and Conditions"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "CyberHulk - Terms and Conditions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? ColorConstant.mainwhite
                        : ColorConstant.mainblack,
                  ),
                ),
                Text(
                  """
           
1. Acceptance of Terms

By downloading, installing, or using the App, User agrees to be bound by the terms and conditions of this Agreement. If User does not agree with these terms, User should not use the App.

2. App Description

The Cyber Hulk is designed to provide automated cyber security assistance, and security best practice recommendations.

3. User Responsibilities

User agrees to the following:

Use the App in compliance with all applicable laws and regulations.
Safeguard access credentials and not share them with unauthorized individuals.
Promptly report any suspected security incidents or vulnerabilities discovered while using the App.
4. Provider Responsibilities

Provider agrees to the following:

Maintain the security and integrity of the App to the best of its ability.
Provide regular updates and enhancements to improve the functionality and security of the App.
Respond promptly to reported security incidents and vulnerabilities.
5. Data Protection and Privacy

Provider will collect and process User data in accordance with its Privacy Policy, which is incorporated into this Agreement by reference.

6. Intellectual Property

The App and all associated intellectual property rights belong to Provider. User may not copy, modify, or distribute the App without prior written consent from Provider.

7. Limitation of Liability

In no event shall Provider be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with the use of the App.

8. Termination

Provider reserves the right to suspend or terminate User's access to the App at any time for violations of this Agreement or for security reasons.

9. Governing Law

This Agreement shall be governed by and construed in accordance with the laws of [Jurisdiction]. Any disputes arising out of this Agreement shall be resolved in the courts of [Jurisdiction].

10. Changes to Agreement

Provider reserves the right to modify or update this Agreement at any time. User's continued use of the App after any such changes constitutes acceptance of the modified terms.


11. Entire Agreement

This Agreement constitutes the entire agreement between Provider and User regarding the use of the App and supersedes all prior agreements and understandings. This app is governed by Indian law, and its use is subject to the jurisdiction of Indian courts, regardless of where the app is accessed globally. The app complies with the Information Technology Act, 2000, and other applicable Indian laws.

By using the Cyber Hulk, User acknowledges that they have read, understood, and agree to be bound by the terms and conditions of this Agreement.

      """,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? ColorConstant.mainwhite
                        : ColorConstant.mainblack,
                    // color: ColorConstant.mainblack
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        insertrecord();
                        var box = await Hive.openBox('logindata');
                        box.put('termsAccepted', true);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text("Accept"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Terms and Conditions Declined",
                                style: TextStyle(
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? ColorConstant.mainwhite
                                          : ColorConstant.mainblack,
                                ),
                              ),
                              content: Text(
                                "You have declined the terms and conditions. You cannot use the app without accepting the terms and conditions.",
                                style: TextStyle(
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? ColorConstant.mainwhite
                                          : ColorConstant.mainblack,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Decline"),
                    ),
                  ],
                ),
              ]),
            )));
  }
}
