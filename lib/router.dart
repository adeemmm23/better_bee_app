import 'package:better_buzz/features/auth/register.dart';
import 'package:better_buzz/features/location/location.dart';
import 'package:better_buzz/features/settings/profile.dart';
import 'package:better_buzz/features/settings/support.dart';
import 'package:better_buzz/features/temperature/temperature.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/hives/hive1.dart';
import 'features/auth/auth.dart';
import 'features/auth/login.dart';
import 'features/home/home.dart';
import 'features/humidity/humidity.dart';
import 'features/noise/noise.dart';
import 'features/settings/support_article.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
      initialLocation: initialLocation(),
      debugLogDiagnostics: true,
      errorBuilder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text('404'),
          ),
        );
      },
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Home(),
              );
            })),
        GoRoute(
          path: '/hive1',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Hive1(),
            );
          }),
        ),
        GoRoute(
          path: '/noise',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Noise(),
            );
          }),
        ),
        GoRoute(
          path: '/temperature',
          pageBuilder: ((context, state) {
            return const MaterialPage(
              child: Temperature(),
            );
          }),
        ),
        GoRoute(
            path: '/humidity',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Humidity(),
              );
            })),
        GoRoute(
            path: '/location',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Location(),
              );
            })),
        GoRoute(
            path: '/support',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Support(),
              );
            }),
            routes: [
              GoRoute(
                path: 'article',
                pageBuilder: ((context, state) {
                  final articleNameQuery = state.queryParameters['articleName'];
                  final articleContentQuery =
                      state.queryParameters['articleContent'];
                  final articleName = articleNameQuery.toString();
                  final articleContent = articleContentQuery.toString();
                  return MaterialPage(
                    child: SupportArticle(
                        articleName: articleName,
                        articleContent: articleContent),
                  );
                }),
              ),
            ]),
        GoRoute(
            path: '/auth',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Auth(),
              );
            }),
            routes: [
              GoRoute(
                  path: 'login',
                  pageBuilder: ((context, state) {
                    return const MaterialPage(
                      child: Login(),
                    );
                  })),
              GoRoute(
                  path: 'register',
                  pageBuilder: ((context, state) {
                    return const MaterialPage(
                      child: Register(),
                    );
                  })),
            ]),
        GoRoute(
            path: '/settings',
            pageBuilder: ((context, state) {
              return const MaterialPage(
                child: Settings(),
              );
            })),
      ]);
}

// initial location
String initialLocation() {
  if (FirebaseAuth.instance.currentUser != null) {
    return '/';
  } else {
    return '/auth';
  }
}
