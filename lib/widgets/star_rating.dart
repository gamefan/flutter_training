import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 提供星級評分的狀態
final ratingProvider = StateProvider<int>((ref) => 0);

/// 星星按鈕
class Star extends StatelessWidget {
  final bool filled;
  final VoidCallback onPressed;

  const Star({super.key, required this.filled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        size: 50,
        Icons.star, // 滿星
        color: filled ? Colors.amber : Colors.grey[200], // 變更顏色：未選擇時為灰色
      ),
      onPressed: onPressed,
    );
  }
}

/// 星級評分 Widget（使用 Riverpod）
class StarRating extends ConsumerWidget {
  final void Function(int) onRatingChanged;

  const StarRating({super.key, required this.onRatingChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(ratingProvider); // 讀取當前評分

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; ++i)
          Star(
            filled: i < rating,
            onPressed: () {
              ref.read(ratingProvider.notifier).state = i + 1; // 更新評分
              onRatingChanged(i + 1); // 觸發事件
            },
          ),
      ],
    );
  }
}
