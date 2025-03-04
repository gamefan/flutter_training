import 'package:flutter/material.dart';

/// List的Item Layout Widget
class ListItem extends StatelessWidget {
  final Color leftIconColor;
  final IconData leftIconData;
  final double? leftIconSize;
  final String title;
  final String rightNumber;
  final IconData? rightIconData;
  final double rightIconRotation; // 角度參數（弧度單位）
  // 角度	弧度（radians）
  // 90°	3.14 / 2
  // 180°	3.14
  // 270°	3.14 * 1.5
  // 360°	3.14 * 2
  final Widget? otherWidget;

  const ListItem({
    super.key,
    required this.leftIconColor,
    required this.leftIconData,
    this.leftIconSize,
    required this.title,
    required this.rightNumber,
    this.rightIconData,
    this.rightIconRotation = 0, // 預設不旋轉
    this.otherWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900], // 只設定背景色，不加底線
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          // 左側 ICON（用 Padding，確保對齊，不受底線影響）
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: leftIconColor, // 背景顏色
                borderRadius: BorderRadius.circular(8), // 方形圓角 8
              ),
              child: Icon(
                leftIconData,
                color: Colors.white,
                size: leftIconSize != null ? leftIconSize! : 24,
              ),
            ),
          ),

          // 右側內容（包含底線）
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0), // 內邊距
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[800]!)), // 這裡加底線
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 第一行title + rightNumber + rightIcon：固定高度，對齊左側 Icon
                  SizedBox(
                    height: 46,
                    child: Row(
                      children: [
                        // 標題
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            overflow: TextOverflow.ellipsis, // 避免超出
                          ),
                        ),

                        // 右側數字
                        Text(
                          rightNumber,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        SizedBox(width: 8), // 間距

                        // 右側圖示（如果存在）
                        if (rightIconData != null)
                          Transform.rotate(
                            angle: rightIconRotation,
                            child: Icon(
                              rightIconData,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),

                  // 第二行（如果有 otherWidget 則顯示）
                  if (otherWidget != null) ...[
                    SizedBox(height: 4), // 與第一行間距
                    otherWidget!,
                    SizedBox(height: 4), // 與底線間距
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
