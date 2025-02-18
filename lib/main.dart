import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/taiwan_time.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final DateTime fixedTime = DateTime(2025, 2, 18, 12, 5); // 統一時間 2025/02/18 12:05

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // 1. 標準顯示時間（yyyy/MM/dd HH:mm）
            Text(
              "${fixedTime.year}/${fixedTime.month.toString().padLeft(2, '0')}/${fixedTime.day.toString().padLeft(2, '0')} "
              "${fixedTime.hour.toString().padLeft(2, '0')}:${fixedTime.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // 2. 沒有模糊時間的 TaiwanTime
            TaiwanTime(time: fixedTime),

            const SizedBox(height: 10),

            // 3. 有模糊時間的 TaiwanTime
            TaiwanTime(time: fixedTime, showFuzzy: true),

            const SizedBox(height: 10),
            // 4. 有模糊時間 + 自訂樣式 (文字大小 24，顏色深藍色)
            TaiwanTime(
              time: fixedTime,
              showFuzzy: true,
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ]),
        ),
      ),
    );
  }
}
