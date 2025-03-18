import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/widgets/buy_rating_item.dart';
import 'package:flutter_training/widgets/star_rating.dart';

/// 作業05的主要Layout
class Hw05MainLayout extends StatefulWidget {
  const Hw05MainLayout({Key? key}) : super(key: key);

  @override
  _Hw05MainLayoutState createState() => _Hw05MainLayoutState();
}

class _Hw05MainLayoutState extends State<Hw05MainLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white, // 設定整個 body 底色為白色
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {},
          ),
          title: Text(
            'Rate your order',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12), // 右側留點間距
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // 內距
                decoration: BoxDecoration(
                  color: Colors.grey[200], // 灰色背景
                  borderRadius: BorderRadius.circular(20), // 圓角
                ),
                child: Row(
                  children: [
                    Icon(Icons.help_outline, size: 18, color: Colors.black),
                    SizedBox(width: 4), // 圖示與文字間距
                    Text(
                      'Help',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 店名與資訊
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rate this store",
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "How did you like Mr.Wish鮮果茶玩家 淡水老街店?",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              /// 評分元件
              StarRating(
                onRatingChanged: (rating) {
                  // 這裡不需要特別處理，因為 ratingProvider 會自動更新 UI
                },
              ),
              SizedBox(height: 16),

              /// 輸入評價內容 (只有評分 >=3 顆星時顯示)
              Consumer(
                builder: (context, ref, child) {
                  final rating = ref.watch(ratingProvider);
                  return Visibility(
                    visible: rating >= 3, // 只有 好評 星時顯示
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Share what you loved about your order.",
                          hintStyle: TextStyle(fontSize: 24), // 設定字體大小為 16
                          border: InputBorder.none,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),

              /// 評分項目（商品清單）
              Text(
                "Rate items",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              /// 商品清單
              Expanded(
                child: ListView(
                  children: [
                    BuyRatingItem(foodId: "1"),
                    BuyRatingItem(foodId: "2"),
                    BuyRatingItem(foodId: "3"),
                    BuyRatingItem(foodId: "4"),
                    BuyRatingItem(foodId: "5"),
                    BuyRatingItem(foodId: "6"),
                    BuyRatingItem(foodId: "7"),
                    BuyRatingItem(foodId: "8"),
                    BuyRatingItem(foodId: "9"),
                    BuyRatingItem(foodId: "10"),
                    // SizedBox(height: 8),
                  ],
                ),
              ),

              SizedBox(height: 16),

              /// Submit 按鈕
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //  提交評價的邏輯
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
