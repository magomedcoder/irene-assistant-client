import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:irene_assistant/presentation/cubit/settings_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadAddress();
    _controller = TextEditingController();
  }

  void _launchGitHub() async {
    const url = 'https://github.com/magomedcoder/irene-assistant-client';
    final uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть GitHub')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is SettingsSaved) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Адрес сохранён')));
          }
        },
        builder: (context, state) {
          if (state is SettingsLoaded || state is SettingsSaved) {
            final address =
                (state is SettingsLoaded)
                    ? state.address
                    : (state as SettingsSaved).address;

            _controller.value = TextEditingValue(
              text: address,
              selection: TextSelection.collapsed(offset: address.length),
            );

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Сервер голосового помощника',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'ws://127.0.0.1:5003',
                    ),
                    onChanged: context.read<SettingsCubit>().updateAddress,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          () => context.read<SettingsCubit>().saveAddress(),
                      child: const Text('Сохранить'),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton.icon(
                      onPressed: _launchGitHub,
                      icon: const Icon(Icons.code),
                      label: const Text("Исходный код на GitHub"),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
