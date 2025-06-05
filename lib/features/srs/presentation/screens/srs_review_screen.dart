import 'package:flutter/material.dart';

class SrsReviewScreen extends StatefulWidget {
  const SrsReviewScreen({super.key});

  @override
  State<SrsReviewScreen> createState() => _SrsReviewScreenState();
}

class _SrsReviewScreenState extends State<SrsReviewScreen> {
  final List<Map<String, String>> _items = const [
    {'word': '学校', 'reading': 'がっこう', 'meaning': '学校'},
    {'word': '先生', 'reading': 'せんせい', 'meaning': '老师'},
    {'word': '友達', 'reading': 'ともだち', 'meaning': '朋友'},
  ];
  int _currentIndex = 0;
  bool _showMeaning = false;

  void _nextCard() {
    setState(() {
      _showMeaning = false;
      _currentIndex = (_currentIndex + 1) % _items.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = _items[_currentIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('SRS 复习')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => _showMeaning = !_showMeaning),
              child: Card(
                elevation: 8,
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: _showMeaning
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(item['reading']!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              const SizedBox(height: 12),
                              Text(item['meaning']!,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ],
                          )
                        : Text(item['word']!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonal(
                  onPressed: _nextCard,
                  child: const Text('陌生'),
                ),
                FilledButton.tonal(
                  onPressed: _nextCard,
                  child: const Text('模糊'),
                ),
                FilledButton.tonal(
                  onPressed: _nextCard,
                  child: const Text('掌握'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
