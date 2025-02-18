import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaiwanTime extends StatelessWidget {
  DateTime _time;
  bool _showFuzzy;
  TextStyle? _style;

  TaiwanTime({
    super.key,
    required DateTime time,
    bool showFuzzy = false,
    TextStyle? style,
  })  : _time = time,
        _showFuzzy = showFuzzy,
        _style = style;

  @override
  Widget build(BuildContext context) {
    // 格式化
    String taiwanTime = _formatTaiwanTime(_time);
    // 模糊時間
    String? fuzzyTime = _showFuzzy ? _getFuzzyTime(_time) : null;

    return Text(
      fuzzyTime != null ? "$taiwanTime ($fuzzyTime)" : taiwanTime,
      style: _style,
    );
  }

  /// **格式化為台灣時間**
  String _formatTaiwanTime(DateTime dateTime) {
    int rocYear = dateTime.year - 1911; // 民國年
    String period = _getPeriod(dateTime.hour);
    String formattedTime =
        "民國$rocYear年${dateTime.month}月${dateTime.day}日 $period${dateTime.hour % 12}:${dateTime.minute.toString().padLeft(2, '0')}分";
    return formattedTime;
  }

  /// **取得時段 (凌晨、早上、下午、晚上)**
  String _getPeriod(int hour) {
    if (hour >= 0 && hour < 6) return "凌晨";
    if (hour >= 6 && hour < 12) return "早上";
    if (hour >= 12 && hour < 18) return "下午";
    return "晚上";
  }

  /// **取得模糊時間顯示**
  String? _getFuzzyTime(DateTime targetTime) {
    DateTime now = DateTime.now();
    Duration diff = targetTime.difference(now);
    int minutes = diff.inMinutes;
    int hours = diff.inHours;
    int days = diff.inDays;

    // 時間差的絕對值，小於 X 內，判斷 時間差是負數(過去)，正數(未來)
    if (minutes.abs() < 5) return minutes < 0 ? "剛剛" : "即將發生";
    if (minutes.abs() < 60) return minutes < 0 ? "${-minutes} 分鐘前" : "${minutes} 分鐘後";
    if (hours.abs() < 24) return hours < 0 ? "${-hours} 小時前" : "${hours} 小時後";
    if (days.abs() < 7) return days < 0 ? "${-days} 天前" : "${days} 天後";

    return null; // 超過 1 週則不顯示模糊時間
  }
}
