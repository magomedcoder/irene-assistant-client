import 'dart:typed_data';

import 'package:irene_assistant/data/data_sources/voice_remote_datasource.dart';
import 'package:irene_assistant/domain/repositories/voice_repository.dart';
import 'package:record/record.dart';

class VoiceRepositoryImpl implements VoiceRepository {
  final VoiceRemoteDataSource remote;
  VoiceRepositoryImpl(this.remote);

  final AudioRecorder _recorder = AudioRecorder();
  Stream<Uint8List>? _streamSub;

  @override
  Future<void> startRecording() async {
    if (!await _recorder.hasPermission()) {
      throw Exception("В доступе к микрофону отказано");
    }

    remote.connect().listen((event) {
      print("remote-connect-$event");
    });

    final stream = await _recorder.startStream(RecordConfig(encoder: AudioEncoder.pcm16bits));

    _streamSub = stream;
    _streamSub!.listen((data) {
      //print("микрофон-stream-$data");
      remote.send(data);
    });
  }
}
