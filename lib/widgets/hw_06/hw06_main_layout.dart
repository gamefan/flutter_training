import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../taiwan_time.dart';

/// Todo 資料模型
class TodoItem {
  final String title;
  bool isDone;
  int sortIndex = 0;
  DateTime? scheduledTime;

  TodoItem({
    required this.title,
    this.isDone = false,
    this.sortIndex = 0,
    this.scheduledTime,
  });

  /// 將物件轉為 Map
  Map<String, dynamic> toJson() => {
        'title': title,
        'isDone': isDone,
        'sortIndex': sortIndex,
        'scheduledTime': scheduledTime?.toIso8601String(),
      };

  /// 從 Map 建立物件
  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        title: json['title'],
        isDone: json['isDone'],
        sortIndex: json['sortIndex'],
        scheduledTime: json['scheduledTime'] != null ? DateTime.parse(json['scheduledTime']) : null,
      );
}

/// 作業06的主要Layout
class Hw06MainLayout extends StatefulWidget {
  const Hw06MainLayout({Key? key}) : super(key: key);

  @override
  _Hw06MainLayoutState createState() => _Hw06MainLayoutState();
}

class _Hw06MainLayoutState extends State<Hw06MainLayout> {
  List<TodoItem> _todoList = [];

  bool _showCompleted = true; // 是否顯示已完成項目
  final TextEditingController _textController = TextEditingController();

  @override

  /// 初始化狀態
  void initState() {
    super.initState();
    // 讀取待辦事項列表
    _loadTodoList();
  }

  @override
  Widget build(BuildContext context) {
    // 排序：有 scheduledTime > 沒有，然後照 sortIndex
    final displayList = _todoList.toList()..sort((a, b) => a.sortIndex.compareTo(b.sortIndex));

    return Scaffold(
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
                        _saveTodoList(); // 儲存到 SharedPreferences
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

            /// 清單
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;

                    final item = _todoList.removeAt(oldIndex);
                    _todoList.insert(newIndex, item);

                    for (int i = 0; i < _todoList.length; i++) {
                      _todoList[i].sortIndex = i;
                    }
                  });
                  _saveTodoList(); // 儲存到 SharedPreferences
                },
                children: [
                  for (int i = 0; i < displayList.length; i++)
                    if (_showCompleted || !displayList[i].isDone) _buildTodoItem(displayList[i], i),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 建立待辦項目元件
  Widget _buildTodoItem(TodoItem item, int index) {
    return ReorderableDelayedDragStartListener(
      key: ValueKey(item),
      index: index,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: Checkbox(
            value: item.isDone,
            onChanged: (value) {
              setState(() => item.isDone = value ?? false);
              _saveTodoList(); // 儲存到 SharedPreferences
            },
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 18,
              decoration: item.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: item.scheduledTime != null
              ? GestureDetector(
                  onTap: () => _pickDateTime(item),
                  child: TaiwanTime(
                    time: item.scheduledTime!,
                    showFuzzy: true,
                    style: const TextStyle(color: Colors.grey),
                  ),
                )
              : GestureDetector(
                  onTap: () => _pickDateTime(item),
                  child: const Text(
                    '尚未指定時間（點我設定）',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() => _todoList.remove(item));
              _saveTodoList(); // 儲存到 SharedPreferences
            },
          ),
        ),
      ),
    );
  }

  /// 彈出時間選擇器
  Future<void> _pickDateTime(TodoItem item) async {
    DateTime now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: item.scheduledTime ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: item.scheduledTime != null ? TimeOfDay.fromDateTime(item.scheduledTime!) : TimeOfDay.now(),
    );

    if (time == null) return;

    final newDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() => item.scheduledTime = newDateTime);
    _saveTodoList(); // 儲存到 SharedPreferences
  }

  /// 讀取待辦事項列表
  Future<void> _loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('todo_list');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      setState(() {
        _todoList = jsonList.map((e) => TodoItem.fromJson(e)).toList();
      });
    }
  }

  /// 儲存待辦事項列表到 SharedPreferences
  Future<void> _saveTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonList = json.encode(_todoList.map((e) => e.toJson()).toList());
    await prefs.setString('todo_list', jsonList);
  }
}
