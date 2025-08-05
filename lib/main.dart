import 'package:flutter/material.dart';
import 'package:irene_assistant/data/repositories/voice_repository_impl.dart';
import 'package:irene_assistant/domain/usecases/start_voice_stream.dart';
import 'package:irene_assistant/presentation/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = VoiceRepositoryImpl();
    final startUseCase = StartVoiceStream(repository);
    return MaterialApp(
      title: 'Ирина',
      home: HomeScreen(startVoice: startUseCase),
    );
  }
}
