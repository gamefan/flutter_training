import 'package:flutter/material.dart';

/// Todo 資料模型
class TodoItem {
  final String title;
  bool isDone;
  int sortIndex = 0;

  TodoItem({required this.title, this.isDone = false, this.sortIndex = 0});
}

/// 作業06的主要Layout
class Hw06MainLayout extends StatefulWidget {
  const Hw06MainLayout({Key? key}) : super(key: key);

  @override
  _Hw06MainLayoutState createState() => _Hw06MainLayoutState();
}

class _Hw06MainLayoutState extends State<Hw06MainLayout> {
  List<TodoItem> _todoList = [
    TodoItem(title: "買牛奶", sortIndex: 0),
    TodoItem(title: "練 Flutter", sortIndex: 1),
    TodoItem(title: "散步 30 分鐘", sortIndex: 2),
  ];

  bool _showCompleted = true; // 是否顯示已完成項目
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('我的待辦事項'),
          actions: [
            Row(
              children: [
                const Text("顯示已完成"),
                Switch(
                  value: _showCompleted,
                  onChanged: (value) {
                    setState(() {
                      _showCompleted = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// 輸入框 + 加號按鈕
              Stack(
                children: [
                  // 輸入框本體
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "請輸入待辦事項...",
                      border: UnderlineInputBorder(), // 僅底線
                      contentPadding: EdgeInsets.only(right: 40), // 預留右邊空間放按鈕
                    ),
                  ),

                  // + 按鈕（浮在右下角）
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.black54,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(), // 移除預設最小尺寸
                      onPressed: () {
                        final text = _textController.text.trim();
                        if (text.isNotEmpty) {
                          setState(() {
                            _todoList.add(TodoItem(title: text));
                            _textController.clear();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// 待完成數量提示
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    '待完成: ${_todoList.where((item) => !item.isDone).length}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              /// 清單區塊
              Expanded(
                child: ReorderableListView(
                  buildDefaultDragHandles: false, // 使用自定拖曳觸發區
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      // 往後拖 移除舊位置的項目後，原本 newIndex 指向的項目就會往前移一格，
                      if (newIndex > oldIndex) newIndex -= 1;
                      final item = _todoList.removeAt(oldIndex);
                      _todoList.insert(newIndex, item);
                    });
                  },
                  children: [
                    for (int index = 0; index < _todoList.length; index++)
                      if (_showCompleted || !_todoList[index].isDone)
                        ReorderableDelayedDragStartListener(
                          key: ValueKey(_todoList[index]),
                          index: index,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _todoList[index].isDone,
                                  onChanged: (value) {
                                    setState(() {
                                      _todoList[index].isDone = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _todoList[index].isDone =
                                            !_todoList[index].isDone;
                                      });
                                    },
                                    child: Text(
                                      _todoList[index].title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: _todoList[index].isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.black54),
                                  onPressed: () {
                                    setState(() {
                                      _todoList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
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
