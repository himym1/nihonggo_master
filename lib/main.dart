// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart'; // 确保路径正确

void main() {
  runApp(const ProviderScope(child: App()));
}
