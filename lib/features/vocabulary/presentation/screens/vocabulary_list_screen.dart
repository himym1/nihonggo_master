import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 定义词汇项数据结构
class VocabListItem {
  final String word;
  final String reading;
  final String meaning;

  VocabListItem({
    required this.word,
    required this.reading,
    required this.meaning,
  });
}

// 定义示例词汇数据
final Map<String, List<VocabListItem>> _sampleCategoryWords = {
  'N5': [
    VocabListItem(word: '私', reading: 'わたし', meaning: '我'),
    VocabListItem(word: '学生', reading: 'がくせい', meaning: '学生'),
    VocabListItem(word: '日本', reading: 'にほん', meaning: '日本'),
  ],
  'N4': [
    VocabListItem(word: '家族', reading: 'かぞく', meaning: '家庭'),
    VocabListItem(word: '映画', reading: 'えいが', meaning: '电影'),
  ],
  'Verbs': [
    VocabListItem(word: '食べる', reading: 'たべる', meaning: '吃'),
    VocabListItem(word: '飲む', reading: 'のむ', meaning: '喝'),
    VocabListItem(word: '見る', reading: 'みる', meaning: '看'),
  ],
};

class VocabularyListScreen extends StatelessWidget {
  final String categoryId;

  const VocabularyListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    // 根据 categoryId 获取对应的词汇列表
    final List<VocabListItem> vocabularyItems =
        _sampleCategoryWords[categoryId] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('词汇单元: $categoryId'), // AppBar 标题显示 categoryId
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              // Changed to FilledButton
              onPressed: () {
                GoRouter.of(
                  context,
                ).push('/vocabulary-categories/$categoryId/flashcards');
              },
              child: const Text('开始闪卡学习'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            if (vocabularyItems.isEmpty &&
                !_sampleCategoryWords.containsKey(categoryId))
              const Center(child: Text('未找到该分类下的词汇。'))
            else if (vocabularyItems.isEmpty &&
                _sampleCategoryWords.containsKey(categoryId))
              Center(child: Text('$categoryId 分类下暂无词汇。'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: vocabularyItems.length,
                  itemBuilder: (context, index) {
                    final item = vocabularyItems[index];
                    return Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Text(
                              item.word,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.reading,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  item.meaning,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (index < vocabularyItems.length - 1)
                          const Divider(height: 1, indent: 16, endIndent: 16),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
