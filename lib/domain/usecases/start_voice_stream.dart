import 'package:irene_assistant/domain/repositories/voice_repository.dart';

class StartVoiceStream {
  final VoiceRepository repository;

  StartVoiceStream(this.repository);

  Future<void> call() async {
    await repository.startRecording();
  }
}
