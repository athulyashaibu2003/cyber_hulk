import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsDialog extends StatelessWidget {
  const ContactDetailsDialog({super.key});

  Future<void> sendMailto({String email = "avanzonet@gmail.com"}) async {
    final Uri parsedMailto = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (!await launchUrl(parsedMailto, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $parsedMailto";
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw "Could not make phone call to $phoneNumber";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Contact Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text("Contact Details", style: TextStyle(color: Colors.black)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  sendMailto();
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/022/484/516/original/google-mail-gmail-icon-logo-symbol-free-png.png"),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  _launchInBrowser(Uri.parse("https://avanzo.in/"));
                },
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.network(
                    "https://cdn-icons-png.freepik.com/256/1006/1006771.png?semt=ais_hybrid",
                    scale: .7,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  _makePhoneCall("+91 7356 1111 28");
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqvIH0qQEwp_XV51RMqRW30rtrLvU0EI9wTg&s"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
