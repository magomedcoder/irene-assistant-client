import 'package:flutter/material.dart';
import 'package:irene_assistant/domain/usecases/start_voice_stream.dart';
import 'package:irene_assistant/domain/usecases/stop_voice_stream.dart';
import 'package:irene_assistant/presentation/widgets/audio_player_widget.dart';
import 'package:irene_assistant/presentation/widgets/voice_wave_animation.dart';

class HomeScreen extends StatefulWidget {
  final StartVoiceStream startVoice;
  final StopVoiceStream stopVoice;

  const HomeScreen({
    super.key,
    required this.startVoice,
    required this.stopVoice,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRecording = false;
  String transcript = '';
  String? wavBase64;

  void _toggleRecording() async {
    if (isRecording) {
      await widget.stopVoice();
    } else {
      await widget.startVoice((result) {
        setState(() {
          //print("_toggleRecordingt-text-${result.text}-wavBase64-${result.wavBase64}");
          transcript = result.text;
          wavBase64 = result.wavBase64;
        });
      });
    }

    setState(() => isRecording = !isRecording);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ирина'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 32,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  if (transcript.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        transcript,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 32),
                  VoiceWaveAnimation(isActive: isRecording),
                ],
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _toggleRecording,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color:
                            isRecording ? Colors.redAccent : Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                isRecording
                                    ? Colors.redAccent.withOpacity(0.4)
                                    : Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isRecording ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isRecording ? "Говорите..." : "Нажмите, чтобы говорить",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            if (wavBase64 != null)
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: AudioPlayerWidget(base64Str: wavBase64!),
              ),
          ],
        ),
      ),
    );
  }
}
