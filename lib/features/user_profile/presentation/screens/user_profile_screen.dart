import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用户中心')),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50), // Placeholder for avatar
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '[用户昵称]',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '已学习 X 天，掌握 Y 词汇', // Placeholder for learning stats
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('账户设置'),
            onTap: () {
              // Navigate to account settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('学习统计'),
            onTap: () {
              // Navigate to learning statistics
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('通知设置'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('关于我们'),
            onTap: () {
              // Navigate to about us page
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('退出登录', style: TextStyle(color: Colors.red)),
            onTap: () {
              GoRouter.of(context).go('/login');
            },
          ),
        ],
      ),
    );
  }
}
