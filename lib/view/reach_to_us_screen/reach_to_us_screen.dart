import 'package:cyber_hulk/view/reach_to_us_screen/widget/contactsdetailsdialog.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(
        text: 'Welcome to Avanzo chat! How can I help you today?',
        isUser: false),
  ];

  final Map<String, String> _qaPairs = {
    'who are you': 'I\'m a friendly chatbot!',
    'hi': 'Hello!',
    'hello': 'Hi!',
    'something else':
        'Please contact our support for further assistance: 7356 1111 28',
    'i love u': "love u too"
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
  bool isResponse = false;
  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.insert(0, Message(text: text, isUser: true));
      _controller.clear();
    });

    // Simulate bot response
    Future.delayed(Duration(milliseconds: 800), () {
      String botResponse = _qaPairs[text.toLowerCase()] ?? 'false';

      botResponse == 'false' ? isResponse = false : isResponse = true;

      if (text.toLowerCase() == 'contact details' || isResponse == false) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ContactDetailsDialog();
          },
        );
      } else {
        setState(() {
          _messages.insert(0, Message(text: botResponse, isUser: false));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Chat with Avanzo'),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: _messages[index].isUser
                            ? Colors.blue[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        _messages[index].text,
                        style: TextStyle(fontSize: 16),
                      ),
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
                      label: Text(option),
                      onPressed: () => _sendMessage(option),
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

  Message({required this.text, required this.isUser});
}
