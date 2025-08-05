import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irene_assistant/data/data_sources/voice_remote_datasource.dart';
import 'package:irene_assistant/data/repositories/settings_repository_impl.dart';
import 'package:irene_assistant/data/repositories/voice_repository_impl.dart';
import 'package:irene_assistant/domain/usecases/get_websocket_address.dart';
import 'package:irene_assistant/domain/usecases/save_websocket_address.dart';
import 'package:irene_assistant/domain/usecases/start_voice_stream.dart';
import 'package:irene_assistant/domain/usecases/stop_voice_stream.dart';
import 'package:irene_assistant/presentation/cubit/settings_cubit.dart';
import 'package:irene_assistant/presentation/screens/home_screen.dart';
import 'package:irene_assistant/presentation/screens/settings_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => SettingsCubit(
                getUseCase: GetWebSocketAddress(settingsRepository),
                saveUseCase: SaveWebSocketAddress(settingsRepository),
              )..loadAddress(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ирина',
        routes: {
          '/': (context) {
            final cubit = context.read<SettingsCubit>();
            final address =
                (cubit.state is SettingsLoaded)
                    ? (cubit.state as SettingsLoaded).address
                    : 'ws://127.0.0.1:5003';
            final dataSource = WebSocketVoiceRemoteDataSource(address);
            final repository = VoiceRepositoryImpl(dataSource);
            final startUseCase = StartVoiceStream(repository);
            final stopUseCase = StopVoiceStream(repository);
            return HomeScreen(startVoice: startUseCase, stopVoice: stopUseCase);
          },
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
