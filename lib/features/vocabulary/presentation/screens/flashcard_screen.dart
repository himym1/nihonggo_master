import 'package:flutter/material.dart';

// Defines the structure for a flashcard item.
class FlashcardItem {
  final String word;
  final String reading;
  final String meaning;

  FlashcardItem({
    required this.word,
    required this.reading,
    required this.meaning,
  });
}

class FlashcardScreen extends StatefulWidget {
  final String categoryId;

  const FlashcardScreen({super.key, required this.categoryId});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

// Sample flashcard data for different categories.
// This would typically come from a database or a service in a real application.
final Map<String, List<FlashcardItem>> _sampleFlashcardData = {
  'N5': [
    FlashcardItem(word: '学校', reading: 'がっこう', meaning: '学校'),
    FlashcardItem(word: '先生', reading: 'せんせい', meaning: '老师'),
    FlashcardItem(word: '友達', reading: 'ともだち', meaning: '朋友'),
  ],
  'N4': [
    FlashcardItem(word: '部屋', reading: 'へや', meaning: '房间'),
    FlashcardItem(word: '電車', reading: 'でんしゃ', meaning: '电车'),
  ],
  'Verbs': [
    FlashcardItem(word: '行く', reading: 'いく', meaning: '去'),
    FlashcardItem(word: '来る', reading: 'くる', meaning: '来'),
    FlashcardItem(word: '帰る', reading: 'かえる', meaning: '回去'),
  ],
  'Default': [
    FlashcardItem(word: 'こんにちは', reading: 'Konnichiwa', meaning: '你好'),
    FlashcardItem(word: 'ありがとう', reading: 'Arigatou', meaning: '谢谢'),
  ],
};

class _FlashcardScreenState extends State<FlashcardScreen> {
  late List<FlashcardItem> _flashcards;
  int _currentIndex = 0;
  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    List<FlashcardItem>? categoryFlashcards =
        _sampleFlashcardData[widget.categoryId];
    if (categoryFlashcards != null && categoryFlashcards.isNotEmpty) {
      _flashcards = categoryFlashcards;
    } else {
      // Fallback to default list if category is not found or empty
      _flashcards = _sampleFlashcardData['Default']!;
    }
    _currentIndex = 0; // Reset index
    _isFrontVisible = true; // Reset visibility
  }

  void _flipCard() {
    setState(() {
      _isFrontVisible = !_isFrontVisible;
    });
  }

  void _handleSrsButtonPressed() {
    setState(() {
      _isFrontVisible = true;
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('闪卡学习: ${widget.categoryId}'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: Text('没有可学习的卡片。')),
      );
    }

    final currentCard = _flashcards[_currentIndex];

    Widget frontWidget = SizedBox(
      key: ValueKey<String>(currentCard.word + 'front'),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentCard.word,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    Widget backWidget = SizedBox(
      key: ValueKey<String>(currentCard.word + 'back'),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentCard.reading,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            currentCard.meaning,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: _isFrontVisible ? frontWidget : backWidget,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilledButton.tonal(
                        onPressed: _handleSrsButtonPressed,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: const Text('陌生'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilledButton.tonal(
                        onPressed: _handleSrsButtonPressed,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: const Text('模糊'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilledButton.tonal(
                        onPressed: _handleSrsButtonPressed,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: const Text('掌握'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
