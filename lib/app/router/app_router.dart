// lib/app/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nihongo_master/features/auth/presentation/screens/splash_screen.dart';
import 'package:nihongo_master/features/auth/presentation/screens/login_register_screen.dart';
import 'package:nihongo_master/features/home/presentation/screens/home_screen.dart'; // Imports HomeScreen and DashboardContentPage
import 'package:nihongo_master/features/vocabulary/presentation/screens/vocabulary_category_screen.dart';
import 'package:nihongo_master/features/vocabulary/presentation/screens/vocabulary_list_screen.dart';
import 'package:nihongo_master/features/vocabulary/presentation/screens/flashcard_screen.dart';
import 'package:nihongo_master/features/ai_tutor/presentation/screens/ai_tutor_screen.dart';
import 'package:nihongo_master/features/kanji/presentation/screens/kanji_list_screen.dart';
import 'package:nihongo_master/features/grammar/presentation/screens/grammar_course_list_screen.dart';
import 'package:nihongo_master/features/user_profile/presentation/screens/user_profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder:
          (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder:
          (BuildContext context, GoRouterState state) =>
              const LoginRegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        // Branch 1: Home (Dashboard)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder:
                  (BuildContext context, GoRouterState state) =>
                      const DashboardContentPage(),
            ),
          ],
        ),
        // Branch 2: Learn (Vocabulary)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/vocabulary-categories',
              builder:
                  (BuildContext context, GoRouterState state) =>
                      const VocabularyCategoryScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: ':categoryId/list', // Relative path
                  builder: (BuildContext context, GoRouterState state) {
                    final categoryId = state.pathParameters['categoryId']!;
                    return VocabularyListScreen(categoryId: categoryId);
                  },
                ),
                GoRoute(
                  path: ':categoryId/flashcards', // Relative path
                  builder: (BuildContext context, GoRouterState state) {
                    final categoryId = state.pathParameters['categoryId']!;
                    return FlashcardScreen(categoryId: categoryId);
                  },
                ),
              ],
            ),
          ],
        ),
        // Branch 3: AI Tutor
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/ai-tutor',
              builder:
                  (BuildContext context, GoRouterState state) =>
                      const AiTutorScreen(),
            ),
          ],
        ),
        // Branch 4: Profile
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder:
                  (BuildContext context, GoRouterState state) =>
                      const UserProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    // Other top-level routes that are pushed on top of the shell
    GoRoute(
      path: '/kanji-list',
      builder:
          (BuildContext context, GoRouterState state) =>
              const KanjiListScreen(),
    ),
    GoRoute(
      path: GrammarCourseListScreen.routeName, // Usually '/grammar-courses'
      builder:
          (BuildContext context, GoRouterState state) =>
              const GrammarCourseListScreen(),
    ),
  ],
);
