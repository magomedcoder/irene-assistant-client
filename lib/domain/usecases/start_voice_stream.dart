import 'package:irene_assistant/domain/entities/voice_result.dart';
import 'package:irene_assistant/domain/repositories/voice_repository.dart';

class StartVoiceStream {
  final VoiceRepository repository;

  StartVoiceStream(this.repository);

  Future<void> call(Function(VoiceResult) onResult) async {
    await repository.startRecording(onResult);
  }
}
