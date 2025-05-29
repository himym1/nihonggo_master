import 'package:flutter/material.dart';

class GrammarCourseListScreen extends StatelessWidget {
  const GrammarCourseListScreen({super.key});

  static const String routeName = '/grammar-courses';

  @override
  Widget build(BuildContext context) {
    // 占位符数据
    final List<Map<String, String>> courseCategories = [
      {'title': 'JLPT N5 语法', 'description': '基础日语语法课程'},
      {'title': 'JLPT N4 语法', 'description': '进阶日语语法课程'},
      {'title': '常用句型', 'description': '日常会话高频句型'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('语法课程')),
      body: ListView.builder(
        itemCount: courseCategories.length,
        itemBuilder: (context, index) {
          final category = courseCategories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(category['title']!),
              subtitle: Text(category['description']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: 导航到具体语法点列表
                print('Tapped on ${category['title']}');
              },
            ),
          );
        },
      ),
    );
  }
}
