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
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pink, Colors.green],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 150.0));
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
      decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: NetworkImage(
          //         "https://img.freepik.com/premium-vector/cyber-security-digital-background_734894-18.jpg"),
          //     fit: BoxFit.cover)
          // color: ColorConstant.mainwhite,
          ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                  radius: MediaQuery.sizeOf(context).width * .1,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/avzlogo.png")),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(       
              //       width: 5,
              //     ),
              //     CircleAvatar(
              //         radius: size.width * .1,
              //         backgroundColor: Colors.white,
              //         backgroundImage: AssetImage("assets/images/avzlogo.png")),
              //   ],
              // ),

              Text("Avanzo",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
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
                        textStyle: TextStyle(
                            // color: ColorConstant.mainblack,
                            height: 1.6,
                            fontSize: 17))),
              ),
              SizedBox(
                height: 25,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         sendMailto();
              //       },
              //       child: Container(
              //         height: 30,
              //         width: 30,
              //         decoration: BoxDecoration(
              //           image: DecorationImage(
              //             image: AssetImage("assets/images/gmail (1).png"),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     InkWell(
              //       onTap: () {
              //         _launchInBrowser(Uri.parse("https://avanzo.in/"));
              //       },
              //       child: Container(
              //         height: 30,
              //         width: 30,
              //         child: Image.asset(
              //           "assets/images/web.png",
              //           scale: .7,
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     InkWell(
              //       onTap: () {
              //         _makePhoneCall("+91 7356 1111 28");
              //       },
              //       child: Container(
              //         height: 30,
              //         width: 30,
              //         decoration: BoxDecoration(
              //           image: DecorationImage(
              //             image: AssetImage("assets/images/telephone.png"),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // Text(
              //   "Version 1.0.0",
              //   style:
              //       TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              // ),

              // -----------------------------------------------------
              // AnimatedContainer(duration: Duration(seconds: 5

              // ),
              // curve: Curves.decelerate,
              // child: Text(""),)
              // ---------------------------------------------------
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  child: Text(
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

      // ==================================================================

      // ================================================
//Center(child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//   Container(
//     // height: 470,
//     width: 340,

//   child: Column(crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         height: 80,width: 55,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/avzlogo.png"))),),

//      Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Text(
//                 _text1,
//                 textAlign: TextAlign.justify,
//                 style: TextStyle(
//                   color: Colorconstant.mainblack,
//                   // color: themeProvider.themeMode == ThemeMode.light
//                   //     ? Colorconstant.mainblack
//                   //     : Colorconstant.mainwhite,
//                   fontSize: 18.0,
//                 ),
//               ),
//      ),
//     ],
//   ),
//   decoration: BoxDecoration(color: Color.fromARGB(255, 233, 207, 236),borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),),
//   SizedBox(height: 10,),
//   Container(height: 100,width: 340,

//   decoration: BoxDecoration(color: Color.fromARGB(255, 225, 186, 231),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),

//   // color: Color.fromARGB(255, 225, 186, 231),
//  child:  Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   sendMailto();
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/gmail (1).png"),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   _launchInBrowser(Uri.parse("https://avanzo.in/"));
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   child: Image.asset(
//                     "assets/images/web.png",
//                     scale: .7,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   _makePhoneCall("+91 7356 1111 28");
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/telephone.png"),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),),

// ],),),

//       body: Column(
//         children: [
//           SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/images/avzlogo.png",
//                // color: Colorconstant.darkpurple,
//                 // color: themeProvider.themeMode == ThemeMode.light
//                 //     ? Colorconstant.mainblack
//                 //     : Colorconstant.mainwhite,
//                 height: 120,
//               ),
//               SizedBox(height: 10),
//               Center(
//                 child: Text(
//                   "Avanzo",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
//             child: Text(
//               _text1,
//               textAlign: TextAlign.justify,
//               style: TextStyle(
//                 color: themeProvider.themeMode == ThemeMode.light
//                     ? Colorconstant.mainblack
//                     : Colorconstant.mainwhite,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//           Text("Connect with us through",style:  TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.bold,
//     foreground: Paint()..shader = linearGradient),
// ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   sendMailto();
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/gmail (1).png"),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   _launchInBrowser(Uri.parse("https://avanzo.in/"));
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   child: Image.asset(
//                     "assets/images/web.png",
//                     scale: .7,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   _makePhoneCall("+91 7356 1111 28");
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/telephone.png"),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),