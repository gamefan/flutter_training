import 'package:flutter/material.dart';
import 'package:flutter_training/widgets/hw_04/list_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          // AppBar 最上方
          appBar: AppBar(
            titleSpacing: 0,
            toolbarHeight: kToolbarHeight, // 設定固定高度
            backgroundColor: Colors.black,
            title: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {},
              iconSize: 46,
              color: Colors.blue,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {},
                iconSize: 32,
                color: Colors.blue,
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.more_horiz_outlined),
                onPressed: () {},
                iconSize: 32,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
            ],
          ),

          // 內容主體
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 讓內容靠左對齊
            children: [
              SizedBox(
                height: 250,
                child: ListView(
                  children: [
                    // 灰色的line
                    Container(
                      color: Colors.grey,
                      height: 1,
                      width: 80,
                    ),

                    // msg
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 20),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 讓內容靠左對齊
                          children: [
                            Row(
                              children: [
                                FlutterLogo(size: 26),
                                SizedBox(width: 10),
                                Text(
                                  'flutter',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'flutter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.link,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'flutter.div',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.star,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '169k ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'stars',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  FontAwesomeIcons.codeFork,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '28.1k ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'forks',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey, // 設定背景顏色
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.star,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        Text(
                                          ' Star',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey, // 設定背景顏色
                                    minimumSize: Size(40, 40),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.codeFork,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey, // 設定背景顏色

                                    minimumSize: Size(40, 40),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 下方列表項目
              Expanded(
                child: ListView(
                  children: [
                    ListItem(
                      leftIconColor: Colors.greenAccent,
                      leftIconData: Icons.radio_button_checked,
                      title: "Issues",
                      rightNumber: "13,154",
                      rightIconData: Icons.arrow_forward_ios,
                    ),
                    ListItem(
                      leftIconColor: Colors.blueAccent,
                      leftIconData: FontAwesomeIcons.codePullRequest,
                      leftIconSize: 18,
                      title: "Pull requests",
                      rightNumber: "219",
                      rightIconData: Icons.arrow_forward_ios,
                    ),
                    ListItem(
                      leftIconColor: Colors.orangeAccent,
                      leftIconData: Icons.play_circle_outline,
                      title: "Actions",
                      rightNumber: "",
                      rightIconData: Icons.arrow_forward_ios,
                    ),
                    ListItem(
                      leftIconColor: Colors.grey.shade500,
                      leftIconData: FontAwesomeIcons.tableList,
                      leftIconSize: 18,
                      title: "Projects",
                      rightNumber: "25",
                      rightIconData: Icons.arrow_forward_ios,
                    ),
                    ListItem(
                        leftIconColor: Colors.grey.shade800,
                        leftIconData: Icons.local_offer_outlined,
                        title: "Releases",
                        rightNumber: "7",
                        rightIconData: Icons.arrow_forward_ios,
                        otherWidget: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 20),
                          padding: EdgeInsets.all(10), // 內邊距
                          decoration: BoxDecoration(
                            color: Colors.grey[800], // 背景顏色（深灰色）
                            borderRadius: BorderRadius.circular(8), // 圓角 8px
                            border: Border.all(color: Colors.grey[700]!, width: 1), // 四邊加邊框，顏色為灰色 700
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // 讓文字靠左對齊
                            children: [
                              // 第一行標題
                              Text(
                                "Flutter 3.16 beta (October 11, 2023)", // 主標題
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis, // 超出時省略
                                ),
                              ),
                              SizedBox(height: 6), //  第一行與第二行的間距
                              // 第二行（時間 + 點號 + 綠色標籤）
                              Row(
                                mainAxisSize: MainAxisSize.min, //  讓 Row 只佔內容大小
                                children: [
                                  // 左側灰色文字（時間）
                                  Text(
                                    "A year ago · ",
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 18,
                                    ),
                                  ),
                                  // 右側綠色文字（標籤）
                                  Text(
                                    "Latest",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    ListItem(
                      leftIconColor: Colors.black45,
                      leftIconData: Icons.more_horiz_outlined,
                      title: "More",
                      rightNumber: "",
                      rightIconData: Icons.arrow_forward_ios,
                      rightIconRotation: 3.14 * 1.5, // 270度
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
