import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(
        text:
            'Welcome to Avanzo chat! How can I help you today? If you have many queries, you can message us on WhatsApp by clicking the link below:',
        isUser: false,
        timestamp: DateTime.now()),
  ];

  final Map<String, String> _qaPairs = {
    'what is avanzo?':
        'We are in a rapid digital transformation phase where everyone – ‘Grocer to Tailor to Hair stylist to MSMEs’ and Corporates – All shifting to the Digital platform. Every business now is going to be governed by Data. Hence, in this “Data Driven Economy”, “Data Security” is of paramount importance to any organization irrespective of its size.',
    'who is the founder of avanzo?':
        'Avanzo was founded by Pattathil Dhanya Menon and the cofounders were late Venugopal Menon and late Santhosh VK in 2010.',
    'is avanzo a cyber security company?':
        'Avanzo is a cybersecurity company based in Thrissur, Kerala. It works on the platforms of cybersecurity audit, vulnerability assessment, and penetration testing.',
    'when did avanzo establish?': '2010',
    'where is avanzo located?': 'Thrissur, Kerala',
    'is avanzo customer friendly?':
        'Yes, Avanzo is customer friendly and our focus is on delivering our best in the interest of our clients.',
    'how can you contact avanzo?':
        'Email: avanzonet@gmail.com\nWebsite: https://avanzo.in\nPhone: +91 7356 1111 28',
    'how many staff are in avanzo?':
        'We have a good team size and we are growing every day.',
    'is avanzo a legal company?':
        'It\'s a techno-legal company. We provide legal consultation in cyberspace.',
    'does avanzo have any vacancy?': 'Please send your CV to jobs@avanzo.in.',
    'is it safe to consult avanzo?': 'Very safe.',
    'is avanzo a government authorised company?':
        'We are a private limited company with 15 years of experience.',
    'is the avanzo meeting confidential?': 'Yes.',
    'why avanzo?':
        'At Avanzo, we understand that the rapid evolution of technology brings with it a myriad of challenges and concerns. That’s why we’ve established a dedicated helpline to assist individuals facing cyber-related issues.',
  };

  final List<String> _options = [
    'what is avanzo?',
    'Who is the founder of avanzo?',
    'Is avanzo a cyber security company?',
    'When did Avanzo establish?',
    'Where is avanzo located?',
    'Is avanzo customer friendly?',
    'How can you contact avanzo?',
    'How many staff are in avanzo?',
    'Is avanzo a legal company?',
    'Does avanzo have any vacancy?',
    'Is it safe to consult avanzo?',
    'Is Avanzo a government authorised company?',
    'Is the avanzo meeting confidential?',
    'Why avanzo?',
  ];

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        Message(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _controller.clear();
    });

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 800), () {
      String botResponse = _qaPairs[text.toLowerCase()] ??
          'Please contact our support for further assistance: 7356 1111 28';

      setState(() {
        _messages.insert(
          0,
          Message(
            text: botResponse,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  // Future<void> _launchWhatsApp() async {
  //   final Uri url = Uri.parse('https://wa.link/siezai');
  //   print('Trying to launch: $url');
  //   if (await canLaunchUrl(url)) {
  //     print('Can launch $url');
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     print('Cannot launch $url');
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _launchWhatsApp(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      // browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[50],
        title: Text('Chat with AVANZO',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _messages.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: _messages[index].isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: _messages[index].isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _messages[index].isUser
                                ? Colors.purple[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              Text(_messages[index].text,
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )),
                              // If this is the welcome message, add the link button
                              if (_messages[index].text.contains('WhatsApp'))
                                TextButton(
                                  onPressed: () => _launchWhatsApp(
                                      Uri.parse('https://wa.link/6zeah7')),
                                  child: const Text(
                                    'Click here to message on WhatsApp',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('hh:mm a')
                              .format(_messages[index].timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Write a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.black,
                      iconSize: 25,
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .25,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      children: _options.map((option) {
                        return ActionChip(
                          label: Text(
                            option,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                          onPressed: () {
                            _sendMessage(option);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
