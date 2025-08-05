import 'dart:convert';
import 'dart:typed_data';

import 'package:irene_assistant/data/data_sources/voice_remote_datasource.dart';
import 'package:irene_assistant/domain/entities/voice_result.dart';
import 'package:irene_assistant/domain/repositories/voice_repository.dart';
import 'package:record/record.dart';

class VoiceRepositoryImpl implements VoiceRepository {
  final VoiceRemoteDataSource remote;

  VoiceRepositoryImpl(this.remote);

  final AudioRecorder _recorder = AudioRecorder();
  Stream<Uint8List>? _streamSub;

  @override
  Future<void> startRecording(Function(VoiceResult result) onResult) async {
    if (!await _recorder.hasPermission()) {
      throw Exception("В доступе к микрофону отказано");
    }

    remote.connect().listen((event) {
      final json = jsonDecode(event);
      //print("remote-connect-$json");
      final result = VoiceResult(
        text: json['text'] ?? '',
        wavBase64: json['wav_base64'],
      );
      onResult(result);
    });

    final stream = await _recorder.startStream(
      RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 48000),
    );

    _streamSub = stream;
    _streamSub!.listen((data) {
      //print("микрофон-stream-$data");
      remote.send(data);
    });
  }

  @override
  Future<void> stopRecording() async {
    await _recorder.stop();
    await _recorder.dispose();
    remote.disconnect();
  }
}
