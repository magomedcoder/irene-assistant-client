import 'package:flutter/material.dart';
import 'package:irene_assistant/domain/usecases/start_voice_stream.dart';

class HomeScreen extends StatefulWidget {
  final StartVoiceStream startVoice;

  const HomeScreen({super.key, required this.startVoice});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _toggleRecording() async {
    await widget.startVoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ирина')),
      body: Column(
        children: [
          ElevatedButton(onPressed: _toggleRecording, child: Text("Микрофон")),
        ],
      ),
    );
  }
}
