import 'package:flutter/material.dart';

/// 星星按鈕
class Star extends StatelessWidget {
  final bool filled;
  final Function() onPressed;

  const Star({super.key, required this.filled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        filled ? Icons.star : Icons.star_border, // 滿星 / 空星
        color: Colors.amber,
      ),
      onPressed: onPressed,
    );
  }
}

/// 星級評分 Widget
class StarRating extends StatefulWidget {
  final int rating;
  final void Function(int) onRatingChanged;

  const StarRating({super.key, required this.rating, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _currentRating = 0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating; // 初始化評分
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; ++i)
          Star(
            filled: i < _currentRating,
            onPressed: () {
              setState(() {
                _currentRating = i + 1; // 更新評分
              });
              widget.onRatingChanged(_currentRating); // 觸發事件
            },
          )
      ],
    );
  }
}
