// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nihongo_master/app/app.dart';
import 'package:nihongo_master/features/auth/presentation/screens/login_register_screen.dart';
import 'package:nihongo_master/features/home/presentation/screens/home_screen.dart'; // Imports HomeScreen and DashboardContentPage
import 'package:nihongo_master/features/user_profile/presentation/screens/user_profile_screen.dart';
import 'package:nihongo_master/features/vocabulary/presentation/screens/vocabulary_category_screen.dart';
import 'package:nihongo_master/features/vocabulary/presentation/screens/vocabulary_list_screen.dart';
import 'package:nihongo_master/features/vocabulary/presentation/screens/flashcard_screen.dart';
import 'package:nihongo_master/features/kanji/presentation/screens/kanji_list_screen.dart';
import 'package:nihongo_master/features/ai_tutor/presentation/screens/ai_tutor_screen.dart';
import 'package:nihongo_master/features/grammar/presentation/screens/grammar_course_list_screen.dart';

void main() {
  // Helper function to navigate to HomeScreen after login/guest access
  Future<void> navigateToHome(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle(const Duration(seconds: 3)); // Splash
    expect(find.byType(LoginRegisterScreen), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, '随便看看'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget); // Shell is HomeScreen
  }

  testWidgets(
    'App shows splash screen and then navigates to login/register screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byIcon(Icons.language), findsOneWidget);
      expect(find.text('はじめまして、世界！'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(LoginRegisterScreen), findsOneWidget);
      expect(find.text('登录 / 注册'), findsOneWidget);
    },
  );

  testWidgets('LoginRegisterScreen UI elements are present', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byType(LoginRegisterScreen), findsOneWidget);
    expect(find.text('日语大师'), findsOneWidget);
    expect(
      find.widgetWithText(ElevatedButton, '使用 Google 登录'),
      findsOneWidget,
    ); // ElevatedButton.icon contains this text
    expect(
      find.widgetWithText(ElevatedButton, '使用 Apple 登录'),
      findsOneWidget,
    ); // ElevatedButton.icon contains this text
    expect(find.text('或使用邮箱注册/登录'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.hintText == '请输入邮箱',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField && widget.decoration?.hintText == '请输入密码',
      ),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, '登录'), findsOneWidget);
    expect(
      find.widgetWithText(TextButton, '立即注册'),
      findsOneWidget,
    ); // Text is now split
    expect(find.widgetWithText(TextButton, '随便看看'), findsOneWidget);
  });

  testWidgets(
    'LoginRegisterScreen navigation buttons work and navigate to home (DashboardContentPage)',
    (WidgetTester tester) async {
      Future<void> testNavigationButton(
        String buttonText, {
        bool isElevated = false, // Original ElevatedButton or new FilledButton
        bool isIconElevated = false, // For ElevatedButton.icon
      }) async {
        await tester.pumpWidget(const ProviderScope(child: App()));
        await tester.pumpAndSettle(const Duration(seconds: 3)); // Splash
        expect(find.byType(LoginRegisterScreen), findsOneWidget);

        if (isIconElevated) {
          // For ElevatedButton.icon, the text is in a child Text widget
          await tester.tap(find.widgetWithText(ElevatedButton, buttonText));
        } else if (isElevated) {
          // For FilledButton (new '登录' button) or old ElevatedButton
          await tester.tap(
            find.ancestor(
              of: find.text(buttonText),
              matching: find.byWidgetPredicate(
                (widget) => widget is FilledButton || widget is ElevatedButton,
              ),
            ),
          );
        } else {
          await tester.tap(find.widgetWithText(TextButton, buttonText));
        }
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget); // Shell
        expect(
          find.byType(DashboardContentPage),
          findsOneWidget,
        ); // Initial content
        expect(
          find.widgetWithText(AppBar, '日语大师'),
          findsOneWidget,
        ); // AppBar title

        // Verify Welcome Message
        expect(find.text('こんにちは, 学习者!'), findsOneWidget);

        // Verify "今日任务" Card
        expect(find.widgetWithText(Card, '今日任务'), findsOneWidget);
        expect(find.text('今日需复习: 10 词 / 5 汉字'), findsOneWidget);
        expect(
          find.widgetWithText(FilledButton, '开始学习'),
          findsOneWidget,
        ); // Updated button

        // Verify "学习统计" Card
        expect(find.widgetWithText(Card, '学习统计'), findsOneWidget);
        expect(find.text('本周学习时长: 3 小时 25 分钟'), findsOneWidget);
        expect(find.text('累计掌握词汇: 150 个'), findsOneWidget);
        expect(find.widgetWithText(TextButton, '查看详情'), findsOneWidget);

        // Verify "核心功能" Section Title
        expect(find.text('核心功能'), findsOneWidget);

        // Verify FeatureCards (by title, assuming FeatureCard is a custom widget that contains these texts)
        // To be more precise, we should find FeatureCard and then text within it.
        // For now, let's assume the text is unique enough or directly findable.
        // Or find by Icon and then the text.
        expect(find.widgetWithText(FeatureCard, '词汇学习'), findsOneWidget);
        expect(find.widgetWithText(FeatureCard, '汉字学习'), findsOneWidget);
        expect(find.widgetWithText(FeatureCard, 'AI语言导师'), findsOneWidget);
        expect(find.widgetWithText(FeatureCard, '语法详解'), findsOneWidget);
      }

      await testNavigationButton('随便看看');
      // For other login buttons, they would also lead to DashboardContentPage initially
      // We assume login is successful for this test's purpose
      await testNavigationButton('登录', isElevated: true); // Now a FilledButton
      await testNavigationButton(
        '使用 Google 登录',
        isIconElevated: true,
      ); // Now ElevatedButton.icon
      await testNavigationButton(
        '使用 Apple 登录',
        isIconElevated: true,
      ); // Now ElevatedButton.icon
      await testNavigationButton('立即注册'); // TextButton with "立即注册"
    },
  );

  testWidgets(
    'HomeScreen bottom navigation bar switches between tabs correctly',
    (WidgetTester tester) async {
      await navigateToHome(tester);

      // 1. Verify initial tab is "首页" (DashboardContentPage)
      expect(find.byType(DashboardContentPage), findsOneWidget);
      expect(find.byType(VocabularyCategoryScreen), findsNothing);
      expect(find.byType(AiTutorScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);

      // Verify BottomNavigationBar is present
      final bnbFinder = find.byType(BottomNavigationBar);
      expect(bnbFinder, findsOneWidget);

      // 2. Tap "学习" tab
      await tester.tap(
        find.descendant(of: bnbFinder, matching: find.text('学习')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsNothing);
      expect(find.byType(VocabularyCategoryScreen), findsOneWidget);
      expect(
        find.text('选择词汇单元'),
        findsOneWidget,
      ); // Title of VocabCategoryScreen
      expect(find.byType(AiTutorScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);

      // 3. Tap "AI导师" tab
      await tester.tap(
        find.descendant(of: bnbFinder, matching: find.text('AI导师')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsNothing);
      expect(find.byType(VocabularyCategoryScreen), findsNothing);
      expect(find.byType(AiTutorScreen), findsOneWidget);
      expect(
        find.text('AI 语言导师 - 樱花老师'),
        findsOneWidget,
      ); // Title of AiTutorScreen
      expect(find.byType(UserProfileScreen), findsNothing);

      // 4. Tap "我的" tab
      await tester.tap(
        find.descendant(of: bnbFinder, matching: find.text('我的')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsNothing);
      expect(find.byType(VocabularyCategoryScreen), findsNothing);
      expect(find.byType(AiTutorScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsOneWidget);
      expect(find.text('用户中心'), findsOneWidget); // Title of UserProfileScreen

      // 5. Tap "首页" tab again
      await tester.tap(
        find.descendant(of: bnbFinder, matching: find.text('首页')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsOneWidget);
      expect(
        find.text('こんにちは, 学习者!'),
        findsOneWidget,
      ); // Welcome message still there
      expect(find.widgetWithText(Card, '今日任务'), findsOneWidget); // Check a card
      expect(find.byType(VocabularyCategoryScreen), findsNothing);
      expect(find.byType(AiTutorScreen), findsNothing);
      expect(find.byType(UserProfileScreen), findsNothing);
    },
  );

  testWidgets(
    'Navigate from DashboardContentPage to VocabularyCategoryScreen (via button) and verify UI',
    (WidgetTester tester) async {
      await navigateToHome(tester);
      expect(find.byType(DashboardContentPage), findsOneWidget);

      // Verify '词汇学习' FeatureCard is present on DashboardContentPage
      final vocabFeatureCardFinder = find.widgetWithText(FeatureCard, '词汇学习');
      expect(vocabFeatureCardFinder, findsOneWidget);

      // Tap the '词汇学习' FeatureCard
      // This should navigate to '/vocabulary-categories', which is the '学习' tab's root.
      await tester.tap(vocabFeatureCardFinder);
      await tester.pumpAndSettle();

      // Verify navigation to VocabularyCategoryScreen (as the '学习' tab)
      expect(find.byType(VocabularyCategoryScreen), findsOneWidget);
      expect(find.text('选择词汇单元'), findsOneWidget);
      expect(
        find.byType(DashboardContentPage),
        findsNothing,
      ); // Dashboard should be gone

      // Verify at least one category card is present
      expect(find.widgetWithText(Card, 'JLPT N5 基础词汇'), findsOneWidget);
    },
  );

  testWidgets(
    'VocabularyListScreen shows correct words and AppBar title (navigated from "学习" tab)',
    (WidgetTester tester) async {
      await navigateToHome(tester);

      // Go to "学习" tab
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('学习'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(VocabularyCategoryScreen), findsOneWidget);

      // Test for category 'N5'
      await tester.tap(find.widgetWithText(Card, 'JLPT N5 基础词汇'));
      await tester.pumpAndSettle();
      expect(find.byType(VocabularyListScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, '词汇单元: N5'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, '开始闪卡学习'),
        findsOneWidget,
      ); // Changed to FilledButton
      expect(find.widgetWithText(ListTile, '私'), findsOneWidget);

      await tester.pageBack(); // Back to VocabCategoryScreen
      await tester.pumpAndSettle();
      expect(find.byType(VocabularyCategoryScreen), findsOneWidget);

      // Test for category 'Verbs'
      await tester.tap(find.widgetWithText(Card, '常用动词'));
      await tester.pumpAndSettle();
      expect(find.byType(VocabularyListScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, '词汇单元: Verbs'), findsOneWidget);
      expect(find.widgetWithText(ListTile, '食べる'), findsOneWidget);
    },
  );

  testWidgets('FlashcardScreen shows correct data (navigated from "学习" tab)', (
    WidgetTester tester,
  ) async {
    await navigateToHome(tester);
    await tester.tap(
      find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('学习'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(Card, 'JLPT N5 基础词汇'));
    await tester.pumpAndSettle();
    expect(find.byType(VocabularyListScreen), findsOneWidget);

    // Tap "开始闪卡学习"
    await tester.tap(
      find.widgetWithText(FilledButton, '开始闪卡学习'),
    ); // Changed to FilledButton
    await tester.pumpAndSettle();

    expect(find.byType(FlashcardScreen), findsOneWidget);
    // AppBar title is removed for immersion, check for AppBar presence and back button
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify initial front card content (word)
    // Sample data for N5: FlashcardItem(word: '学校', reading: 'がっこう', meaning: '学校'),
    expect(find.text('学校'), findsOneWidget);
    expect(
      find.text('がっこう'),
      findsNothing,
    ); // Reading should not be visible initially

    // Tap the card to flip it
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 550),
    ); // Wait for AnimatedSwitcher

    // Verify back card content (reading and meaning)
    expect(
      find.text('学校'),
      findsNothing,
    ); // Word should not be visible after flip
    expect(find.text('がっこう'), findsOneWidget); // Reading should be visible
    // The meaning for '学校' is also '学校'. We find the specific Text widget.
    final meaningFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data == '学校' &&
          widget.style?.fontSize ==
              Theme.of(
                tester.element(find.byType(FlashcardScreen)),
              ).textTheme.titleLarge?.fontSize,
    );
    expect(meaningFinder, findsOneWidget);

    // Verify SRS buttons are present (they are FilledButton.tonal, check by text)
    expect(find.widgetWithText(FilledButton, '陌生'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '模糊'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '掌握'), findsOneWidget);

    // Tap an SRS button to go to the next card
    await tester.tap(find.widgetWithText(FilledButton, '掌握'));
    await tester.pumpAndSettle(
      const Duration(milliseconds: 550),
    ); // Wait for AnimatedSwitcher if card changes

    // Assuming next N5 card is '先生' from _sampleFlashcardData
    expect(find.text('先生'), findsOneWidget); // New front card
    expect(find.text('学校'), findsNothing); // Old card front gone
    expect(find.text('がっこう'), findsNothing); // Old card back (reading) gone
  });

  testWidgets(
    'Navigate from DashboardContentPage to KanjiListScreen (push) and verify UI',
    (WidgetTester tester) async {
      await navigateToHome(tester);
      expect(find.byType(DashboardContentPage), findsOneWidget);

      // Find and tap the "汉字学习" FeatureCard
      final kanjiFeatureCardFinder = find.widgetWithText(FeatureCard, '汉字学习');
      expect(kanjiFeatureCardFinder, findsOneWidget);
      await tester.tap(kanjiFeatureCardFinder);
      await tester.pumpAndSettle();

      expect(find.byType(KanjiListScreen), findsOneWidget); // Pushed on top
      expect(
        find.byType(DashboardContentPage),
        findsNothing,
      ); // DashboardContentPage is now covered
      expect(find.byType(HomeScreen), findsOneWidget); // Shell is still there
      expect(find.widgetWithText(AppBar, '汉字学习'), findsOneWidget);
      expect(find.text('学'), findsOneWidget);

      // Go back to DashboardContentPage (which is under the shell)
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsOneWidget);
      expect(find.byType(KanjiListScreen), findsNothing);
    },
  );

  testWidgets(
    'Navigate from DashboardContentPage to AiTutorScreen (tab switch) and verify UI',
    (WidgetTester tester) async {
      await navigateToHome(tester);
      expect(find.byType(DashboardContentPage), findsOneWidget);

      // Find and tap the "AI语言导师" FeatureCard on DashboardContentPage
      final aiTutorFeatureCardFinder = find.widgetWithText(
        FeatureCard,
        'AI语言导师',
      );
      expect(aiTutorFeatureCardFinder, findsOneWidget);
      await tester.tap(aiTutorFeatureCardFinder);
      await tester.pumpAndSettle();

      // Verify navigation to AiTutorScreen (as the 'AI导师' tab)
      expect(find.byType(AiTutorScreen), findsOneWidget);
      expect(find.byType(DashboardContentPage), findsNothing);
      expect(find.widgetWithText(AppBar, 'AI 语言导师 - 樱花老师'), findsOneWidget);
      expect(find.text('こんにちは！我是樱花老师，有什么可以帮助你的吗？'), findsOneWidget);
    },
  );

  testWidgets(
    'Navigate from DashboardContentPage to GrammarCourseListScreen (push) and verify UI',
    (WidgetTester tester) async {
      await navigateToHome(tester);
      expect(find.byType(DashboardContentPage), findsOneWidget);

      // Find and tap the "语法详解" FeatureCard
      final grammarFeatureCardFinder = find.widgetWithText(FeatureCard, '语法详解');
      expect(grammarFeatureCardFinder, findsOneWidget);
      await tester.tap(grammarFeatureCardFinder);
      await tester.pumpAndSettle();

      expect(
        find.byType(GrammarCourseListScreen),
        findsOneWidget,
      ); // Pushed on top
      expect(
        find.byType(DashboardContentPage),
        findsNothing,
      ); // DashboardContentPage is now covered
      expect(find.byType(HomeScreen), findsOneWidget); // Shell is still there
      expect(find.widgetWithText(AppBar, '语法课程'), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'JLPT N5 语法'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(DashboardContentPage), findsOneWidget);
      expect(find.byType(GrammarCourseListScreen), findsNothing);
    },
  );

  testWidgets(
    'UserProfileScreen navigation via BottomNav, UI elements, and logout',
    (WidgetTester tester) async {
      await navigateToHome(tester);

      // Tap the '我的' tab in BottomNavigationBar
      await tester.tap(
        find.descendant(
          of: find.byType(BottomNavigationBar),
          matching: find.text('我的'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileScreen), findsOneWidget);
      expect(find.widgetWithText(AppBar, '用户中心'), findsOneWidget);
      expect(find.text('[用户昵称]'), findsOneWidget);
      expect(find.widgetWithText(ListTile, '账户设置'), findsOneWidget);
      expect(find.widgetWithText(ListTile, '退出登录'), findsOneWidget);

      // Tap '退出登录'
      await tester.tap(find.widgetWithText(ListTile, '退出登录'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginRegisterScreen), findsOneWidget);
      expect(find.text('登录 / 注册'), findsOneWidget);
    },
  );
}
