import 'package:flutter/material.dart';
import 'package:irene_assistant/data/data_sources/voice_remote_datasource.dart';
import 'package:irene_assistant/data/repositories/voice_repository_impl.dart';
import 'package:irene_assistant/domain/usecases/start_voice_stream.dart';
import 'package:irene_assistant/domain/usecases/stop_voice_stream.dart';
import 'package:irene_assistant/presentation/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = WebSocketVoiceRemoteDataSource();
    final repository = VoiceRepositoryImpl(dataSource);
    final startUseCase = StartVoiceStream(repository);
    final stopUseCase = StopVoiceStream(repository);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ирина',
      home: HomeScreen(startVoice: startUseCase, stopVoice: stopUseCase),
    );
  }
}
