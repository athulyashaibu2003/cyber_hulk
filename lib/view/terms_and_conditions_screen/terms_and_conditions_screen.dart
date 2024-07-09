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
                const Text(
                  "CyberHulk - Terms and Conditions",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.mainblack),
                ),
                const Text(
                  """
           
                        1. Introduction
1.1. These Terms and Conditions ("Terms") govern your use of the CyberHulk bot ("CyberHulk")
provided by Avanzo Cyber Security Solutions Pvt. Ltd. . By accessing or using CyberHulk, you
agree to be bound by these Terms.
1.2. If you do not agree to these Terms, you may not access or use CyberHulk.

                      2. Description of CyberHulk
2.1. CyberHulk is a cybersecurity advising bot designed to provide users with information,
guidance, and recommendations on cybersecurity best practices, threat detection, incident
response, and risk management.

                      3. User Responsibilities
3.1. Users are solely responsible for their use of CyberHulk and for implementing any
recommendations or guidance provided by CyberHulk.
3.2. Users agree to use CyberHulk in compliance with all applicable laws, regulations, and
industry standards.
3.3. Users acknowledge that CyberHulk is an advisory tool and that the Provider does not
guarantee the accuracy, completeness, or effectiveness of its recommendations.

                      4. Limitations of Liability
4.1. The Provider shall not be liable for any direct, indirect, incidental, special, consequential, or
exemplary damages arising out of or in connection with the use of CyberHulk.
4.2. The Provider makes no representations or warranties of any kind, express or implied,
regarding the accuracy, reliability, suitability, or availability of CyberHulk.

                      5. Data Privacy
5.1. The Provider will collect, process, and store personal data in accordance with its Privacy
Policy.
5.2. Users acknowledge and consent to the collection and use of their data by CyberHulk for the
purpose of providing cybersecurity advisory services.

                      6. Intellectual Property
6.1. All intellectual property rights in CyberHulk and its content belong to the provider.
6.2. Users may not copy, reproduce, modify, or distribute CyberHulk or its content without the
Provider's prior written consent.

                      7. Amendments
7.1. The Provider reserves the right to amend these Terms at any time by posting the amended
Terms on the Provider's website or notifying Users through CyberHulk.
7.2. Users' continued use of CyberHulk after any such amendments will constitute acceptance
of the amended Terms.

                      8. Termination
8.1. The provider may terminate or suspend a user's access to CyberHulk at any time, without
prior notice or liability, for any reason whatsoever.
8.2. Upon termination, users must cease all use of CyberHulk and may be required to delete or
destroy any copies of CyberHulk in their possession.

                      9. Governing Law
9.1. These terms shall be governed by and construed in accordance with the laws of India.
9.2. Any disputes arising out of or in connection with these Terms shall be subject to the
exclusive jurisdiction of the courts of India.

                      10. Changes to Agreement
The provider reserves the right to modify or update this agreement at any time. The user's
continued use of the app after any such changes constitutes acceptance of the modified terms.

                      11. Entire Agreement
This agreement constitutes the entire agreement between the provider and user regarding the
use of the app and supersedes all prior agreements and understandings.

By using the CyberHulk, the user acknowledges that they have read, understood, and agreed to
be bound by the terms and conditions of this agreement. However, the App will not be
responsible for any direct or indirect damages caused without proper usage of the app.
      """,
                  style: TextStyle(
                      fontSize: 16,
                      // color: themeProvider.themeMode == ThemeMode.dark
                      //     ? ColorConstant.mainwhite
                      //     : ColorConstant.mainblack,
                      color: ColorConstant.mainblack),
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
