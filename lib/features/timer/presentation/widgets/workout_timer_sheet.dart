import 'dart:async';

import 'package:droplet_flutter/shared/theme/app_colors.dart';
import 'package:droplet_flutter/shared/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Bottom sheet where the user sets a countdown for their next workout session.
class WorkoutTimerSheet extends StatefulWidget {
  const WorkoutTimerSheet({super.key});

  @override
  State<WorkoutTimerSheet> createState() => _WorkoutTimerSheetState();
}

class _WorkoutTimerSheetState extends State<WorkoutTimerSheet> {
  static const _presets = <int>[10, 20, 30, 45, 60];
  static const _minMinutes = 5;
  static const _maxMinutes = 120;

  Timer? _ticker;
  int _minutes = 30;
  int _remaining = 30 * 60;
  bool _running = false;

  bool get _completed => _remaining == 0;
  bool get _inSetup => !_running && _remaining == _minutes * 60;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _setMinutes(int m) {
    final clamped = m.clamp(_minMinutes, _maxMinutes);
    setState(() {
      _minutes = clamped;
      _remaining = clamped * 60;
    });
  }

  void _start() {
    setState(() => _running = true);
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining > 0) {
        setState(() => _remaining--);
      }
      if (_remaining == 0) {
        _ticker?.cancel();
        setState(() => _running = false);
      }
    });
  }

  void _pause() {
    _ticker?.cancel();
    setState(() => _running = false);
  }

  void _reset() {
    _ticker?.cancel();
    setState(() {
      _running = false;
      _remaining = _minutes * 60;
    });
  }

  String get _timeLabel {
    final m = (_remaining ~/ 60).toString().padLeft(2, '0');
    final s = (_remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String get _statusText => _completed
      ? 'COMPLETE'
      : (_running ? 'FOCUS' : (_inSetup ? 'READY' : 'PAUSED'));

  IconData get _statusIcon =>
      _completed || _running ? LucideIcons.flame : LucideIcons.timer;

  Color get _statusColor =>
      _running || _completed ? AppColors.accentLime : AppColors.textSecondary;

  String get _hintText =>
      _completed ? 'GOOD JOB!' : (_inSetup ? 'SET DURATION' : 'TIME LEFT');

  @override
  Widget build(BuildContext context) {
    final total = _minutes * 60;
    final progress = total == 0 ? 0.0 : _remaining / total;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _dragHandle(),
            const SizedBox(height: 18),
            _header(),
            const SizedBox(height: 14),
            const Text(
              'Set a timer for your next workout session.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            _timerFace(progress),
            if (_inSetup) ...[
              const SizedBox(height: 20),
              _presetRow(),
              const SizedBox(height: 14),
              _stepper(),
              const SizedBox(height: 20),
              _actionButton(
                icon: LucideIcons.play,
                label: 'Start timer',
                onTap: _start,
                filled: true,
              ),
            ] else ...[
              const SizedBox(height: 20),
              _controls(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.divider,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            LucideIcons.timer,
            size: 20,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WORKOUT TIMER',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                letterSpacing: 2.2,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Next session',
              style: TextStyle(
                fontFamily: AppFont.spaceGrotesk,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.x,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _timerFace(double progress) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 190,
            height: 190,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              strokeCap: StrokeCap.round,
              backgroundColor: AppColors.primaryLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.accentLime),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_statusIcon, size: 14, color: _statusColor),
                  const SizedBox(width: 6),
                  Text(
                    _statusText,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      letterSpacing: 2.2,
                      color: _statusColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _timeLabel,
                style: const TextStyle(
                  fontFamily: AppFont.spaceGrotesk,
                  fontWeight: FontWeight.w700,
                  fontSize: 52,
                  height: 1,
                  letterSpacing: -2.6,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _hintText,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  letterSpacing: 2.2,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _presetRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [for (final m in _presets) _presetChip(m)],
    );
  }

  Widget _presetChip(int m) {
    final selected = m == _minutes;
    return GestureDetector(
      onTap: () => _setMinutes(m),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$m',
          style: TextStyle(
            fontFamily: AppFont.spaceGrotesk,
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: selected ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _stepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stepButton(LucideIcons.minus, () => _setMinutes(_minutes - 5)),
        SizedBox(
          width: 110,
          child: Center(
            child: Text(
              '$_minutes MIN',
              style: const TextStyle(
                fontFamily: AppFont.spaceGrotesk,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
        _stepButton(LucideIcons.plus, () => _setMinutes(_minutes + 5)),
      ],
    );
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _controls() {
    if (_completed) {
      return _actionButton(
        icon: LucideIcons.rotateCcw,
        label: 'Start over',
        onTap: _reset,
        filled: true,
      );
    }
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: LucideIcons.rotateCcw,
            label: 'Reset',
            onTap: _reset,
            filled: false,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            icon: _running ? LucideIcons.pause : LucideIcons.play,
            label: _running ? 'Pause' : 'Resume',
            onTap: _running ? _pause : _start,
            filled: true,
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return Material(
      color: filled ? AppColors.accentLime : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: filled
            ? BorderSide.none
            : const BorderSide(color: AppColors.textPrimary, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
