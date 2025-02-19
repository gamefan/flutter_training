import 'package:flutter/material.dart';
import 'widgets/star_rating.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StarRating(
                rating: _rating,
                onRatingChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                    print('評分事件觸發，評分為: $_rating');
                  });
                },
              ),
              const SizedBox(height: 20),
              Text("目前評分: $_rating", style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
