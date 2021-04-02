import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:insta_code/services/provider.dart';

class Auth {
  final container = ProviderContainer();
  FirebaseAuth auth;

  Auth() {
    auth = container.read(authProvider);
  }

  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  // TODO: Hide secrets (maybe dart define?)
  // TODO: Maybe add some exception handling, like in other Auth methods
  Future<UserCredential> logInGitHub(
      BuildContext context, RemoteConfig remoteConfig) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: remoteConfig.getString("clientId").replaceAll(RegExp('"'), ""),
      clientSecret:
          remoteConfig.getString("clientSecret").replaceAll(RegExp('"'), ""),
      redirectUrl: "https://insta-code-dev.firebaseapp.com/__/auth/handler",
    );

    final result = await gitHubSignIn.signIn(context);

    final AuthCredential githubAuthCredential =
        GithubAuthProvider.credential(result.token);

    return auth.signInWithCredential(githubAuthCredential);
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
