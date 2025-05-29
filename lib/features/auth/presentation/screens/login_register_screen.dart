import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录 / 注册')), // 暂时保留 AppBar
      body: Center(
        child: SingleChildScrollView(
          // 添加 SingleChildScrollView 以防止溢出
          child: Padding(
            padding: const EdgeInsets.all(24.0), // 调整 Padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '日语大师',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  icon: const Icon(Icons.g_mobiledata_outlined), // Google 图标
                  label: const Text('使用 Google 登录'),
                  onPressed: () => GoRouter.of(context).go('/'),
                ),
                const SizedBox(height: 12.0), // 调整间距
                ElevatedButton.icon(
                  icon: const Icon(Icons.apple), // Apple 图标
                  label: const Text('使用 Apple 登录'),
                  onPressed: () => GoRouter.of(context).go('/'),
                ),
                const SizedBox(height: 24.0), // 调整间距
                Text(
                  '或使用邮箱注册/登录',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16.0),
                const TextField(
                  decoration: InputDecoration(
                    hintText: '请输入邮箱',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16.0), // 调整间距
                const TextField(
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => GoRouter.of(context).go('/'),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('登录', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0), // 调整间距
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("还没有账户？"),
                    TextButton(
                      onPressed:
                          () => GoRouter.of(context).go('/'), // 实际应导航到注册页或切换模式
                      child: const Text('立即注册'),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  onPressed: () => GoRouter.of(context).go('/'),
                  child: const Text('随便看看'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
