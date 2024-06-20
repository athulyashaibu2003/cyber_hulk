import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(
        text: 'Welcome to Avanzo chat! How can I help you today?',
        isUser: false,
        timestamp: DateTime.now()),
  ];

  final Map<String, String> _qaPairs = {
    'who are you?': 'I\'m a friendly chatbot!',
    'hi': 'Hello!',
    'hello': 'Hi!',
    'something else':
        'Please contact our support for further assistance: 7356 1111 28',
    'i love u': 'love u more.....'
  };

  final List<String> _options = [
    'contact details',
    'Who are you?',
    'Hi',
    'Hello',
    'Something else',
    'i love u',
    'Alo',
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
    Future.delayed(Duration(milliseconds: 800), () {
      String botResponse = _qaPairs[text.toLowerCase()] ??
          'Please contact our support for further assistance: 7356 1111 28';

      if (text.toLowerCase() == 'contact details') {
        setState(() {
          _messages.insert(
            0,
            Message(
                text:
                    'Email: avanzonet@gmail.com\nWebsite: https://avanzo.in\nPhone: +91 7356 1111 28',
                isUser: false,
                timestamp: DateTime.now()),
          );
        });
      } else {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[50],
        title: Text('Chat with AVANZO',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(_messages[index].text,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),
                        SizedBox(height: 5),
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
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Colors.black,
                      iconSize: 25,
                      icon: Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: _options.map((option) {
                    return ActionChip(
                      label: Text(
                        option,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      onPressed: () {
                        _sendMessage(option);
                      },
                    );
                  }).toList(),
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
