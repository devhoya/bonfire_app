import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';
import '../bloc/session_state.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/timer_display.dart';
import '../widgets/xp_progress_bar.dart';
import '../widgets/focus_mode_button.dart';
import '../widgets/upgrade_button.dart';

class MainFireplaceScreen extends StatelessWidget {
  const MainFireplaceScreen({super.key});

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
                // Background Image
                Positioned.fill(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuD5JA6JLA8dL9U_yRbR8hwqENqWToqFkHx3wmJqD7RIXAEJxqCki4tOmsR4YyPXpnEjZN-dHvzAZFvod_kTvNRhrqXguedAHtH8gEM3Kf09BoGl8SmVOqaQzAVay0Yd6o_mFeuFwjSkfFYnx0bxl_Fl8p-SmUtUYcgaip9ufgHqyMWlx5Da7bkmvsPa_Tgvj3Bf80y64e0BfFkqXUDZCYegDQWyAEXTfSRkkoLJaVNmFn_3-7gLbTMsYPBUcRG9GAIh2AYV2sXby5cG',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient overlays
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

                // Content
                SafeArea(
                  child: Column(
                    children: [
                      // Top Navigation
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
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
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Timer Display
                      TimerDisplay(
                        minutes: session.remainingTime.inMinutes,
                        seconds: session.remainingTime.inSeconds % 60,
                      ),

                      const Spacer(),

                      // Bottom UI
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Focus Mode Button
                            FocusModeButton(
                              isActive: session.isFocusMode,
                              onPressed: () {
                                context.read<SessionBloc>().add(
                                      ToggleFocusModeEvent(),
                                    );
                              },
                            ),

                            const SizedBox(height: 24),

                            // XP Progress Bar
                            XPProgressBar(
                              currentXP: level.currentXP,
                              requiredXP: level.requiredXP,
                              nextLevel: level.currentLevel + 1,
                              xpPerMinute: level.xpPerMinute,
                            ),

                            const SizedBox(height: 24),

                            // Upgrade Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: UpgradeButton(
                                onPressed: () {
                                  context.read<SessionBloc>().add(
                                        UpgradeStoveEvent(),
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

                // Vignette effect
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
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
