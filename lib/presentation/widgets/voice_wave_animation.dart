import 'dart:math';

import 'package:flutter/material.dart';

class VoiceWaveAnimation extends StatefulWidget {
  final bool isActive;

  const VoiceWaveAnimation({super.key, required this.isActive});

  @override
  State<VoiceWaveAnimation> createState() => _VoiceWaveAnimationState();
}

class _VoiceWaveAnimationState extends State<VoiceWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int barCount = 9;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _barHeight(int index, double animationValue) {
    final sinValue = sin(animationValue * 2 * pi + index);
    return 10 + (sinValue + 1) * 20;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return const SizedBox(height: 60);

    return SizedBox(
      height: 60,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(barCount, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 8,
                height: _barHeight(index, _controller.value),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
