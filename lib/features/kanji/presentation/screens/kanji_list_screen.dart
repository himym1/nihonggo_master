import 'package:flutter/material.dart';

class KanjiListScreen extends StatelessWidget {
  const KanjiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 占位符数据
    final List<Map<String, String>> kanjiList = [
      {'kanji': '学', 'reading': 'がく / まな-ぶ', 'meaning': '学习, 学问'},
      {'kanji': '生', 'reading': 'せい / い-きる', 'meaning': '生命, 出生'},
      {'kanji': '先', 'reading': 'せん / さき', 'meaning': '先前, 老师'},
      {'kanji': '日', 'reading': 'にち, じつ / ひ, -か', 'meaning': '太阳, 日子'},
      {'kanji': '本', 'reading': 'ほん / もと', 'meaning': '书本, 根本'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('汉字学习')),
      body: ListView.builder(
        itemCount: kanjiList.length,
        itemBuilder: (context, index) {
          final item = kanjiList[index];
          return ListTile(
            title: Text(item['kanji']!, style: const TextStyle(fontSize: 24)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(item['reading']!), Text(item['meaning']!)],
            ),
            onTap: () {
              // 未来可导航到汉字详情或启动特定汉字的练习
            },
          );
        },
      ),
    );
  }
}
