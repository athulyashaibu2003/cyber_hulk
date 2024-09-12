import 'package:cyber_hulk/view/reach_to_us_screen/reach_to_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAvanzoScreen extends StatefulWidget {
  const AboutAvanzoScreen({super.key});

  @override
  State<AboutAvanzoScreen> createState() => _AboutAvanzoScreenState();
}

class _AboutAvanzoScreenState extends State<AboutAvanzoScreen> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.pink, Colors.green],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 150.0));
  final String _text1 =
      "In today’s digital data driven economy, when brands are moulded with process automation, ‘Data protection’ is of paramount importance. Avanzo now offers consultancy in Formulating security policies for corporates, Intellectual property rights (IPR) in cyberspace, Cyber forensics, Cyber Legal Audit & IS Audit for organisations and Security Audit as per ISO standards. Cyber investigation for governments and Case presentation in front of adjudication officers (India, Arbitration).";

  Future<void> sendMailto({
    String email = "avanzonet@gmail.com",
  }) async {
    final Uri parsedMailto = Uri.parse("mailto:<$email>?");
    if (!await launchUrl(
      parsedMailto,
      mode: LaunchMode.externalApplication,
    )) {
      throw "error";
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width * .1,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      const AssetImage("assets/images/avzlogo.png")),
              Text("Avanzo",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          // color: ColorConstant.mainblack,
                          height: 2,
                          fontSize: 35,
                          fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    "This App is Developed by Avanzo Cyber Secuirty Solutions, In today’s digital data driven economy, when brands are moulded with process automation, ‘Data protection’ is of paramount importance. Avanzo now offers consultancy in Formulating security policies for corporates, Intellectual property rights ( IPR) in cyberspace, Cyber forensics, Cyber Legal Audit & IS Audit for organisations and Security Audit as per ISO standards. Cyber investigation for governments and Case presentation in front of adjudication officers (India, Arbitration).",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            // color: ColorConstant.mainblack,
                            height: 1.6,
                            fontSize: 17))),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ChatScreen()));
                  },
                  child: const Text(
                    "Reach us",
                    style: TextStyle(
                        fontSize: 20, decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
