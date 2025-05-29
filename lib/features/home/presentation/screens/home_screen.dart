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
                        // TODO: Navigate to SRS review
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
                        // TODO: Navigate to detailed stats
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
            childAspectRatio: 2.8, // 调整宽高比以适应内容
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

      // 将 navigationShell 传递给 DashboardContentPage，如果它需要的话
      // 或者确保 DashboardContentPage 可以通过其他方式访问到 navigationShell
      // 在这个例子中，FeatureCard 的 onTap 中直接使用了 context 获取 GoRouter 实例，
      // 对于 goBranch，我们需要确保它能被正确调用。
      // 一种方式是将 navigationShell 传递给 DashboardContentPage，再传递给 FeatureCard
      // 或者在 DashboardContentPage 中定义 FeatureCard 时，直接使用 HomeScreen 的 navigationShell
      // 为了简单起见，我们修改 FeatureCard 的 onTap 逻辑，使其能够处理 goBranch
      // 但更优的做法可能是将 navigationShell 传递下去。
      // 当前的修改是将 navigationShell 传递给 FeatureCard，并在AI导师卡片处使用。
      // 注意：DashboardContentPage 本身并不直接使用 navigationShell，而是其子Widget FeatureCard 可能需要
      // 因此，我们将 navigationShell 传递给 DashboardContentPage，再由它传递给 FeatureCard
      // 或者，更直接地，在 DashboardContentPage 构建 FeatureCard 时，直接使用 HomeScreen 的 navigationShell
      // 这里我们选择后者，在 DashboardContentPage 的 build 方法中，为 AI 导师的 FeatureCard 的 onTap 直接使用 HomeScreen 的 navigationShell
      // 更新：已将 navigationShell 传递给 FeatureCard，并在AI导师卡片处使用。
      // 再次更新：为了让 DashboardContentPage 能够访问 navigationShell 以便传递给 FeatureCard，
      // HomeScreen 需要将 navigationShell 传递给 DashboardContentPage。
      // 然而，DashboardContentPage 是一个 StatelessWidget，通常不直接依赖于 HomeScreen 的实例变量。
      // 最好的做法是，当 DashboardContentPage 在 HomeScreen 中被实例化时，
      // 如果 DashboardContentPage 内部的某个子 Widget (如 FeatureCard) 需要 navigationShell，
      // 那么 navigationShell 应该作为参数传递给 DashboardContentPage，然后由 DashboardContentPage 再传递给那个子 Widget。
      // 或者，如果 FeatureCard 的 onTap 总是由 HomeScreen 的上下文调用，
      // 那么在 HomeScreen 中创建 FeatureCard 实例时，可以直接将 HomeScreen 的 navigationShell 传递给 FeatureCard。

      // 鉴于 DashboardContentPage 是一个独立的 Widget，并且其内部的 FeatureCard 需要 navigationShell，
      // 我们应该将 navigationShell 传递给 DashboardContentPage。
      // 但由于 DashboardContentPage 是在路由中定义的，直接传递 navigationShell 可能不直观。
      // 一个折衷方案是，在 DashboardContentPage 中，对于需要 goBranch 的情况，
      // 我们假设它能通过某种方式获取到正确的 navigationShell。
      // 在当前结构中，DashboardContentPage 是 HomeScreen 的一部分（通过 navigationShell.CurrentView）。
      // 因此，在 DashboardContentPage 的 build 方法中，可以直接引用 HomeScreen 的 navigationShell。
      // 这需要 DashboardContentPage 能够访问 HomeScreen 的 navigationShell。
      // 最简单的方式是，当我们在 HomeScreen 中构建 DashboardContentPage 时（如果它是直接构建的话），传递 navigationShell。
      // 但这里 DashboardContentPage 是通过 StatefulNavigationShell 的机制加载的。

      // 解决方案：在 DashboardContentPage 的 build 方法中，为 AI 导师的 FeatureCard 的 onTap，
      // 我们需要一种方式来调用 navigationShell.goBranch(2)。
      // 由于 DashboardContentPage 是由 StatefulNavigationShell 管理的，
      // 它本身并不直接持有 navigationShell 实例。
      // HomeScreen 持有 navigationShell。
      // 因此，当 FeatureCard 的 onTap 需要调用 goBranch 时，它需要访问 HomeScreen 的 navigationShell。
      // 这可以通过回调或者直接在 HomeScreen 中处理点击事件来实现。

      // 修正后的逻辑：
      // 1. FeatureCard 的 onTap 仍然是 VoidCallback。
      // 2. 在 DashboardContentPage 中，为 "AI语言导师" 的 FeatureCard 的 onTap，
      //    我们将使用 GoRouter.of(context).go('/aitutor-shell'); (假设我们为AI导师的根页面设置了这样的路由)
      //    或者，如果必须使用 goBranch，我们需要确保 DashboardContentPage 能访问到 navigationShell。
      //    最直接的方式是，HomeScreen 在构建其 body (即 navigationShell) 时，
      //    如果当前的 child 是 DashboardContentPage，并且 DashboardContentPage 需要 navigationShell，
      //    那么应该将 navigationShell 传递给它。
      //    但由于 DashboardContentPage 是通过路由构建的，这种传递不直接。

      // 最终决定：为了保持 DashboardContentPage 的独立性，并且符合 go_router 的使用习惯，
      // 对于需要 goBranch 的情况，我们将依赖于 HomeScreen 传递 navigationShell。
      // 这意味着 DashboardContentPage 需要一个 navigationShell 参数。
      // 然而，在 AppRouter 中，DashboardContentPage 是作为 Widget Function() 构建的，
      // 不能直接传递 HomeScreen 的 navigationShell。

      // 再次思考：
      // `navigationShell.goBranch(2)` 是在 `HomeScreen` 的上下文中调用的。
      // `DashboardContentPage` 是 `navigationShell` 的一个子页面。
      // 当 `FeatureCard` 在 `DashboardContentPage` 中被点击时，它的 `onTap` 被触发。
      // 如果 `onTap` 需要调用 `navigationShell.goBranch(2)`，那么 `DashboardContentPage` 必须能访问到 `navigationShell`。
      //
      // 方案A: 将 `navigationShell` 作为参数传递给 `DashboardContentPage`。
      //   - `AppRouter` 中构建 `DashboardContentPage` 时需要能提供 `navigationShell`。这比较困难。
      // 方案B: `FeatureCard` 的 `onTap` 对于 `goBranch` 的情况，通过 `context` 找到 `HomeScreenState` (如果 `HomeScreen` 是 `StatefulWidget`)
      //          或者通过 `Provider` 等状态管理工具获取 `navigationShell`。
      // 方案C: 在 `DashboardContentPage` 中，对于AI导师的卡片，其 `onTap` 直接调用 `GoRouter.of(context).go(AppRoutes.aiTutorTabRoute)`
      //          然后在 `AppRouter` 中，确保 `/ai-tutor-shell` (或类似的路径) 能够正确地触发 `navigationShell.goBranch(2)`。
      //          这似乎是最符合 `go_router` 设计的方式。
      //          但是，`goBranch` 是 `StatefulNavigationShell` 的方法，通常在持有 `StatefulNavigationShell` 的 Widget (即 `HomeScreen`) 中调用。
      //
      // 考虑到任务描述中明确指出 `onTap: () => GoRouter.of(context).goBranch(2)`，这暗示了 `goBranch` 可以通过 `GoRouter.of(context)` 访问。
      // 查阅 `go_router` 文档，`goBranch` 是 `StatefulNavigationShell` 的实例方法，而不是 `GoRouter` 的静态方法或扩展方法。
      // 所以 `GoRouter.of(context).goBranch(2)` 是不正确的。
      //
      // 正确的做法是，`DashboardContentPage` 需要能调用其父 `HomeScreen` 中的 `navigationShell.goBranch`。
      // 这可以通过将 `navigationShell` 传递给 `DashboardContentPage` 来实现。
      //
      // 在 `AppRouter` 中，`ShellRoute` 的 `builder` 函数接收 `child` (即 `navigationShell`)。
      // `HomeScreen` 就是这个 `builder` 返回的 Widget。
      // `DashboardContentPage` 是 `navigationShell` 的其中一个分支的页面。
      //
      // 为了让 `DashboardContentPage` 中的 `FeatureCard` 能够调用 `navigationShell.goBranch`，
      // `DashboardContentPage` 需要接收 `navigationShell`。
      //
      // 修改 `DashboardContentPage` 以接收 `navigationShell`:
      // ```dart
      // class DashboardContentPage extends StatelessWidget {
      //   final StatefulNavigationShell navigationShell; // 添加这个
      //   const DashboardContentPage({super.key, required this.navigationShell}); // 修改构造函数
      //
      //   // ... build method ...
      //   FeatureCard(
      //     title: 'AI语言导师',
      //     icon: Icons.mic_none,
      //     onTap: () => navigationShell.goBranch(2), // 现在可以使用了
      //   ),
      // }
      // ```
      //
      // 现在的问题是，`AppRouter` 如何将 `navigationShell` 传递给 `DashboardContentPage`？
      // `AppRouter` 中的 `routes` 列表定义了各个路径对应的 Widget。
      // ```dart
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) => const NoTransitionPage(
      //     child: DashboardContentPage(navigationShell: ???), // 这里需要 navigationShell
      //   ),
      // ),
      // ```
      // 这是不行的，因为 `DashboardContentPage` 是 `StatefulNavigationShell` 的子路由，
      // 它是由 `StatefulNavigationShell` 内部管理的。
      //
      // 任务描述中的 `onTap: () => GoRouter.of(context).goBranch(2)` 可能是笔误。
      // 应该是 `onTap: () => navigationShell.goBranch(2)`，并且 `DashboardContentPage` 需要能访问 `navigationShell`。
      //
      // 最简单的处理方式，是假设 `DashboardContentPage` 总是作为 `HomeScreen` 的一部分被渲染，
      // 并且 `HomeScreen` 会将 `navigationShell` 传递给它。
      //
      // 让我们回到 `FeatureCard` 的定义，它有一个可选的 `navigationShell` 参数。
      // 在 `DashboardContentPage` 的 `build` 方法中，当创建 "AI语言导师" 的 `FeatureCard` 时，
      // 我们需要提供 `navigationShell`。
      //
      // `DashboardContentPage` 本身如何获取 `navigationShell`？
      // 如果 `DashboardContentPage` 是 `HomeScreen` 的直接子 Widget，`HomeScreen` 可以传递它。
      // 但它是通过 `StatefulNavigationShell` 路由机制加载的。
      //
      // 考虑 `StatefulNavigationShell` 的工作方式：
      // `HomeScreen` 的 `body` 是 `navigationShell`。
      // `navigationShell` 会根据当前激活的分支渲染对应的 Widget。
      // 如果 `DashboardContentPage` 是第一个分支的根 Widget，那么当第一个分支激活时，
      // `navigationShell` 会构建 `DashboardContentPage`。
      //
      // 关键点：`StatefulNavigationShell` 本身就是一个 Widget。
      // `HomeScreen` 的 `build` 方法中：`body: navigationShell,`
      //
      // 如果 `DashboardContentPage` 需要 `navigationShell`，那么 `StatefulNavigationShell` 在构建其子页面时，
      // 必须有办法将自身 (或其控制器) 传递给子页面。
      //
      // 查阅 `StatefulNavigationShell` 的用法，它通常不直接将自身传递给子路由。
      // 子路由通过 `GoRouter.of(context)` 进行导航。
      //
      // 再次审视任务要求：`onTap: () => GoRouter.of(context).goBranch(2)`
      // 这强烈暗示 `goBranch` 是 `GoRouter` 的一个扩展方法，或者 `context` 中有某种方式可以访问到它。
      // 经过确认，`StatefulNavigationShell` 自身并不将其 `goBranch` 方法暴露给 `GoRouter.of(context)`。
      //
      // 那么，最可能的意图是：
      // `DashboardContentPage` 能够访问到 `HomeScreen` 的 `navigationShell` 实例。
      // 这通常通过依赖注入 (如 Provider) 或将 `navigationShell` 作为参数传递来实现。
      //
      // 鉴于 `DashboardContentPage` 是在 `AppRouter` 中定义的，并且是 `ShellRoute` 的一部分，
      // 它不能直接访问 `HomeScreen` 的实例变量。
      //
      // 结论：任务描述中的 `GoRouter.of(context).goBranch(2)` 存在歧义或不准确。
      // 正确的方式是调用 `navigationShell.goBranch(2)`。
      // 为了让 `DashboardContentPage` 能做到这一点，它需要 `navigationShell`。
      //
      // 解决方案：修改 `DashboardContentPage` 以接收 `navigationShell`。
      // 然后，在 `AppRouter` 中，当 `StatefulNavigationShell` 构建 `DashboardContentPage` 时，
      // 它需要将自身传递过去。
      //
      // `ShellRoute.builder` 或 `StatefulNavigationShell.builder` (如果使用 `StatefulShellRoute`)
      // 的 `navigationShell` 参数就是我们需要的。
      //
      // `StatefulShellRoute` 的 `builder` 函数签名是：
      // `Widget Function(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell)`
      // 这个 `navigationShell` 可以用来构建包含它的 `Scaffold` (如 `HomeScreen`)，
      // 并且这个 `navigationShell` 也可以被传递给由它管理的子页面。
      //
      // 但是，`DashboardContentPage` 是 `StatefulShellBranch` 的 `routes` 中的一个 `GoRoute`。
      // `GoRoute` 的 `builder` 或 `pageBuilder` 无法直接访问到外层 `StatefulShellRoute` 的 `navigationShell`。
      //
      // 这是一个常见的问题：如何在 `ShellRoute` 的子页面中调用 `navigationShell.goBranch`？
      // 1. 使用 `GlobalKey`：不推荐。
      // 2. 使用状态管理 (Provider)：`HomeScreen` 将 `navigationShell` 放入 Provider，`DashboardContentPage` 读取。
      // 3. 修改 `onTap` 的行为：不直接调用 `goBranch`，而是 `GoRouter.of(context).go('/path-that-triggers-branch-change')`，
      //    但这通常用于不同的导航场景。
      //
      // 鉴于任务的直接性，最符合原始意图（即使表达上可能有误）的是让 `DashboardContentPage` 能调用 `navigationShell.goBranch`。
      //
      // 让我们假设 `DashboardContentPage` 可以通过某种方式获得 `navigationShell`。
      // 在 `FeatureCard` 的 `onTap` 中，如果需要 `navigationShell`，它应该由 `DashboardContentPage` 提供。
      //
      // 为了简化，我将遵循任务描述中提供的 `onTap` 签名，并假设在 `DashboardContentPage` 的上下文中，
      // `navigationShell.goBranch(2)` 是可以被调用的。
      // 这意味着 `DashboardContentPage` 需要一个 `navigationShell` 成员。
      //
      // 在 `AppRouter` 中，`HomeScreen` 接收 `navigationShell`。
      // `DashboardContentPage` 是 `navigationShell` 的一个子页面。
      //
      // 如果 `DashboardContentPage` 是 `HomeScreen` 的一部分，那么 `HomeScreen` 可以将 `navigationShell` 传递给它。
      //
      // 考虑到 `DashboardContentPage` 是一个独立的 Widget，并且在 `AppRouter` 中被引用，
      // 它不能直接依赖 `HomeScreen` 的实例。
      //
      // 最终方案：
      // 1. `DashboardContentPage` 接收一个 `StatefulNavigationShell` 参数。
      // 2. 在 `AppRouter` 中，当 `StatefulNavigationShell` 的分支构建 `DashboardContentPage` 时，
      //    需要有一种机制来传递这个 `navigationShell`。
      //    这通常是通过 `StatefulShellRoute.builder` 来实现的，该 builder 创建了包含 `StatefulNavigationShell` 的父 Widget (如 `HomeScreen`)，
      //    并且这个父 Widget 负责将 `StatefulNavigationShell` 传递给其当前的子页面。
      //    这超出了直接修改 `DashboardContentPage` 的范围，可能需要修改 `AppRouter` 和 `HomeScreen` 的结构。
      //
      // 为了在当前步骤中前进，我将假设 `DashboardContentPage` 能够通过 `context` 间接访问到 `navigationShell`，
      // 或者任务描述中的 `GoRouter.of(context).goBranch(2)` 是一种简化的写法，
      // 实际项目中会通过 Provider 或其他方式解决。
      //
      // 我将按照任务描述中给出的 `onTap` 实现，即 `onTap: () => navigationShell.goBranch(2)`，
      // 并将 `navigationShell` 作为 `DashboardContentPage` 的一个必需参数。
      // 这将导致 `AppRouter` 中的实例化需要调整。
      //
      // 鉴于我只能修改 `home_screen.dart` 和 `widget_test.dart`，我不能修改 `AppRouter`。
      // 因此，我不能给 `DashboardContentPage` 添加 `navigationShell` 参数，除非它已经是这样设计的。
      //
      // 从原始代码看，`DashboardContentPage` 没有 `navigationShell` 参数。
      // `HomeScreen` 有 `navigationShell`。
      //
      // 那么，`FeatureCard` 的 `onTap` 中调用 `navigationShell.goBranch(2)` 必须依赖于
      // `DashboardContentPage` 的 `build` 方法能够访问到 `HomeScreen` 的 `navigationShell`。
      //
      // 这可以通过 `context.findAncestorWidgetOfExactType<HomeScreen>()?.navigationShell` 实现，但这不优雅。
      //
      // 更好的方式是，如果 `FeatureCard` 的 `onTap` 需要执行 `goBranch`，
      // 那么 `onTap` 应该是一个接受 `StatefulNavigationShell` 的回调，
      // 或者 `DashboardContentPage` 提供一个方法来执行这个操作。
      //
      // 让我们遵循任务描述中 `FeatureCard` 的 `onTap: () => GoRouter.of(context).goBranch(2)` 的字面意思，
      // 并假设这是有效的，或者在测试中我们会发现问题。
      // 但如前所述，`GoRouter.of(context)` 没有 `goBranch`。
      //
      // 我将采用以下方式：
      // `FeatureCard` 的 `onTap` 是 `VoidCallback`。
      // 在 `DashboardContentPage` 中，对于AI导师的卡片：
      // `onTap: () { StatefulNavigationShell.of(context).goBranch(2); }`
      // `StatefulNavigationShell.of(context)` 是获取 `StatefulNavigationShellState` 的正确方式。
      //
      // 这样，`DashboardContentPage` 和 `FeatureCard` 的签名不需要改变。

      // 重新检查 `StatefulNavigationShell.of(context)`:
      // `StatefulNavigationShell.of(context)` 返回 `StatefulNavigationShellState`。
      // `StatefulNavigationShellState` 有 `goBranch` 方法。这是可行的。
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
