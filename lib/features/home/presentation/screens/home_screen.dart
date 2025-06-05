import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 新的 Widget 用于承载原 HomeScreen 的 body 内容
class DashboardContentPage extends StatelessWidget {
  const DashboardContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // 确保内容可滚动
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'こんにちは, 学习者!', // 暂时使用硬编码的昵称
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('今日任务', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text('今日需复习: 10 词 / 5 汉字'), // 更新占位符
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.tonal(
                      onPressed: () {
                        GoRouter.of(context).push('/srs-review');
                      },
                      child: const Text('开始学习'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('学习统计', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text('本周学习时长: 3 小时 25 分钟'), // 更新占位符
                  const SizedBox(height: 8),
                  const Text('累计掌握词汇: 150 个'), // 更新占位符
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).push('/stats');
                      },
                      child: const Text('查看详情'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('核心功能', style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // 因为父级是SingleChildScrollView
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            // 调整宽高比以防止内部内容溢出
            childAspectRatio: 1.6,
            children: <Widget>[
              FeatureCard(
                title: '词汇学习',
                icon: Icons.spellcheck,
                onTap:
                    () => GoRouter.of(context).push('/vocabulary-categories'),
              ),
              FeatureCard(
                title: '汉字学习',
                icon: Icons.font_download_outlined,
                onTap: () => GoRouter.of(context).push('/kanji-list'),
              ),
              FeatureCard(
                title: 'AI语言导师',
                icon: Icons.mic_none,
                onTap: () {
                  // 使用 StatefulNavigationShell.of(context) 来获取 shell 并导航
                  // 这要求 DashboardContentPage 的 context 位于 StatefulNavigationShell Widget 的子树中
                  final navigationShellState = StatefulNavigationShell.of(
                    context,
                  );
                  navigationShellState.goBranch(2);
                },
              ),
              FeatureCard(
                title: '语法详解',
                icon: Icons.menu_book_outlined,
                onTap: () => GoRouter.of(context).push('/grammar-courses'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// 自定义的 FeatureCard Widget
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final StatefulNavigationShell? navigationShell; // 可选参数

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.navigationShell, // 初始化可选参数
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(4.0), // 调整卡片间距
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0), // 匹配Card的圆角
        child: Padding(
          padding: const EdgeInsets.all(12.0), // 调整内部填充
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ), // 调整图标大小
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall, // 调整文字样式
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日语大师')),

      body: navigationShell, // navigationShell 是 StatefulNavigationShell Widget
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '首页',
          ), // 使用 outlined icons
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: '学习'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), // AI导师图标保持
            label: 'AI导师',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), // 我的图标保持
            label: '我的',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        selectedItemColor:
            Theme.of(context).colorScheme.primary, // 使用 colorScheme
        unselectedItemColor: Colors.grey[600], // 调整未选中颜色
        onTap: (index) {
          // 确保 navigationShell 实例可用
          // final navigationShell = StatefulNavigationShell.of(context); // 这可能不正确，因为 HomeScreen 已经有 navigationShell
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        type: BottomNavigationBarType.fixed, // 保持 fixed 类型
        showUnselectedLabels: true, // 可以选择显示未选中的标签
      ),
    );
  }
}
