import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'authentication_client.dart';
import 'models/authentication_user.dart';

class FirebaseAuthenticationClient implements AuthenticationClient {
  FirebaseAuthenticationClient({
    // TODO: required TokenStorage tokenStorage,
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) :
        // TODO: _tokenStorage = tokenStorage,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance {
    user.listen(_onUserChanged);
  }

  // TODO: final TokenStorage _tokenStorage;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
          LogInWithEmailAndPasswordFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
          SignUpWithEmailAndPasswordFailure(error), stackTrace);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  Future<void> _onUserChanged(AuthenticationUser user) async {
    // TODO: extra save token
    // await _tokenStorage.saveToken(user.id);
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
    required String appPackageName,
  }) async {
    try {
      final redirectUrl = Uri.https(
        const String.fromEnvironment('FLAVOR_DEEP_LINK_DOMAIN'),
        const String.fromEnvironment('FLAVOR_DEEP_LINK_PATH'),
        <String, String>{'email': email},
      );

      final actionCodeSettings = firebase_auth.ActionCodeSettings(
        url: redirectUrl.toString(),
        handleCodeInApp: true,
        iOSBundleId: appPackageName,
        androidPackageName: appPackageName,
        androidInstallApp: true,
      );

      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
        // actionCodeSettings: actionCodeSettings,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
          SendPasswordResetEmailFailure(error), stackTrace);
    }
  }
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}
