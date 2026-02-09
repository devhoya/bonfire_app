import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';
import '../bloc/session_state.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/timer_display.dart';
import '../widgets/xp_progress_bar.dart';
import '../widgets/focus_mode_button.dart';
import '../widgets/upgrade_button.dart';
import 'firewood_memory_burner_screen.dart';
import 'stove_upgrade_store_screen.dart';

class MainFireplaceScreen extends StatefulWidget {
  const MainFireplaceScreen({super.key});

  @override
  State<MainFireplaceScreen> createState() => _MainFireplaceScreenState();
}

class _MainFireplaceScreenState extends State<MainFireplaceScreen> {
  late final VideoPlayerController _videoController;
  int _logCount = 0;
  bool _showLogToast = false;
  Timer? _logToastTimer;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://cdn.coverr.co/videos/coverr-burning-fireplace-1579/1080p.mp4',
      ),
    )..initialize().then((_) {
        if (!mounted) return;
        _videoController
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _logToastTimer?.cancel();
    _videoController.dispose();
    super.dispose();
  }

  void _addLog() {
    setState(() {
      _logCount = (_logCount + 1).clamp(0, 5);
      _showLogToast = true;
    });

    _logToastTimer?.cancel();
    _logToastTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => _showLogToast = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is SessionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SessionError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is SessionRunning || state is SessionPaused) {
            final session = state is SessionRunning
                ? (state as SessionRunning).session
                : (state as SessionPaused).session;

            final level = state is SessionRunning
                ? (state as SessionRunning).level
                : (state as SessionPaused).level;

            return Stack(
              children: [
                Positioned.fill(
                  child: Stack(
                    children: [
                      if (_videoController.value.isInitialized)
                        Positioned.fill(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                        )
                      else
                        Container(color: AppTheme.backgroundDark),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.backgroundDark.withOpacity(0.4),
                              Colors.transparent,
                              AppTheme.backgroundDark,
                            ],
                            stops: const [0.0, 0.3, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (_logCount > 0)
                  Positioned(
                    bottom: 210,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _showLogToast ? 1 : 0,
                        child: GlassContainer(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            child: Text('장작 +1', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  ),

                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'LEVEL ${level.currentLevel}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GlassContainer(
                              isCircular: true,
                              child: IconButton(
                                icon: const Icon(Icons.settings),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const FirewoodMemoryBurnerScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      TimerDisplay(
                        minutes: session.remainingTime.inMinutes,
                        seconds: session.remainingTime.inSeconds % 60,
                      ),
                      const SizedBox(height: 18),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _logCount == 0 ? 0.55 : 1,
                        child: Text(
                          '🪵' * _logCount,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: FocusModeButton(
                                    isActive: session.isFocusMode,
                                    onPressed: () {
                                      context.read<SessionBloc>().add(ToggleFocusModeEvent());
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                FilledButton.icon(
                                  onPressed: _addLog,
                                  icon: const Icon(Icons.forest),
                                  label: const Text('장작 넣기'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            XPProgressBar(
                              currentXP: level.currentXP,
                              requiredXP: level.requiredXP,
                              nextLevel: level.currentLevel + 1,
                              xpPerMinute: level.xpPerMinute,
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.centerRight,
                              child: UpgradeButton(
                                onPressed: () {
                                  context.read<SessionBloc>().add(UpgradeStoveEvent());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const StoveUpgradeStoreScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.75 - (_logCount * 0.08).clamp(0, 0.35)),
                          blurRadius: 150,
                          spreadRadius: -40,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
