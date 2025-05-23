import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Optional: store globally if needed
final user = FirebaseAuth.instance.currentUser;
final uid = user?.uid;

Future<void> signInAnon() async {
  final userCredential = await FirebaseAuth.instance.signInAnonymously();
  final user = userCredential.user;
  print("Signed in with UID: ${user?.uid}");
}

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signInAnonymously();
  }

  void _continue() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      Navigator.pushNamed(context, '/chat', arguments: name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to your pretty RANDOM CHAT')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Please enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _continue,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
