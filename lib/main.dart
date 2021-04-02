import 'dart:isolate';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_code/screens/auth/auth_screen.dart';
import 'package:insta_code/services/auth.dart';
import 'package:insta_code/services/provider.dart';
import 'package:insta_code/widgets/navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: App()));
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig _remoteConfig = await RemoteConfig.instance;
  await _remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeoutMillis: const Duration(seconds: 10).inMilliseconds,
    minimumFetchIntervalMillis: const Duration(hours: 1).inMilliseconds,
  ));

  await _remoteConfig.fetch(expiration: const Duration(hours: 5));
  await _remoteConfig.activateFetched();

  return _remoteConfig;
}

class App extends HookWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final _remoteConfig = useProvider(remoteConfigProvider);
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: Future.wait([_initialization, setupRemoteConfig()]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            //initFirebase(); // TODO: Remove when in production

            return Root(
              remoteConfig: snapshot.data[1] as RemoteConfig,
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete

          return const Scaffold(
            body: Center(
              child: Text("Loading ..."),
            ),
          );
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  final RemoteConfig remoteConfig;

  const Root({Key key, this.remoteConfig}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().user, // Auth stream
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            // Login Screen
            return AuthScreen(
              remoteConfig: widget.remoteConfig,
            );
          } else {
            // Home Screen
            return Navigation();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Loading ..."),
            ),
          );
        }
      },
    );
  }
}
