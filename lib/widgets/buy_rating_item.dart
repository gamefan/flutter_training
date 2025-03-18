import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 提供餐點評價的狀態
final ratingStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});

/// 讀取 JSON 並提供飲料資料
final foodDataProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final String jsonString = await rootBundle.loadString('assets/data/food_items.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
});

class BuyRatingItem extends ConsumerWidget {
  final String foodId;

  const BuyRatingItem({super.key, required this.foodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodDataAsync = ref.watch(foodDataProvider);
    final ratingState = ref.watch(ratingStateProvider);
    final selectedState = ratingState[foodId] ?? {'like': null, 'reasons': []};

    return foodDataAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text("載入錯誤: $err"),
      data: (foodData) {
        final foodItem = foodData.firstWhere(
          (item) => item["id"] == foodId,
          orElse: () => {"name": "未知品項", "image": "assets/images/food_1.png"},
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(foodItem["image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    foodItem["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    _buildLikeButton(ref, foodId, false, selectedState['like'] == false),
                    const SizedBox(width: 8),
                    _buildLikeButton(ref, foodId, true, selectedState['like'] == true),
                  ],
                ),
              ],
            ),
            if (selectedState['like'] == false) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildDislikeReasons(
                  ref,
                  foodId,
                  (selectedState['reasons'] as List?)?.map((e) => e.toString()).toList() ?? [],
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildLikeButton(WidgetRef ref, String foodId, bool isLike, bool isSelected) {
    return GestureDetector(
      onTap: () {
        ref.read(ratingStateProvider.notifier).state = {
          ...ref.read(ratingStateProvider),
          foodId: {'like': isLike, 'reasons': isLike ? [] : []},
        };
      },
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(
          isLike
              ? (isSelected ? Icons.thumb_up : Icons.thumb_up_outlined)
              : (isSelected ? Icons.thumb_down : Icons.thumb_down_outlined),
          color: isSelected ? Colors.white : Colors.black,
          size: isSelected ? 24 : 20,
        ),
      ),
    );
  }

  List<Widget> _buildDislikeReasons(WidgetRef ref, String foodId, List<String> selectedReasons) {
    final List<String> reasons = ["Too salty", "Too sweet", "Not fresh", "Bad texture", "Other"];

    return reasons.map((reason) {
      final bool isSelected = selectedReasons.contains(reason);
      return GestureDetector(
        onTap: () {
          final updatedReasons = List<String>.from(selectedReasons);
          if (isSelected) {
            updatedReasons.remove(reason);
          } else {
            updatedReasons.add(reason);
          }

          ref.read(ratingStateProvider.notifier).state = {
            ...ref.read(ratingStateProvider),
            foodId: {'like': false, 'reasons': updatedReasons},
          };
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            reason,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      );
    }).toList();
  }
}
