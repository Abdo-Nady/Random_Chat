import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  String? name; // Local state variable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (name == null) {
      name = ModalRoute.of(context)?.settings.arguments as String?;
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty && name != null) {
      setState(() {
        _messages.add("${name!}: $text");
      });
      _messageController.clear();
    }
  }

  void _skip() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Skipped current user')),
    );
  }

  void _stop() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Search stopped')),
    );
  }

  void _report() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User reported')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Chatting as $name')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _skip, child: Text("Skip")),
                ElevatedButton(onPressed: _stop, child: Text("Stop")),
                ElevatedButton(
                  onPressed: _report,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text("Report"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
