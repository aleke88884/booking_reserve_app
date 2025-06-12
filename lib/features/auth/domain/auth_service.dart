import 'dart:developer';

import 'package:booking_reserv/features/auth/data/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<User?> registerWithEmail({
    required String email,
    required String password,
    required AppUser userData,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        await fireStore
            .collection('users')
            .doc(user.uid)
            .set(userData.toJson());
      }
      return user;
    } catch (e) {
      log("Registration error: $e");
      return null;
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      log("Login error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get userChanges => _auth.authStateChanges();

  // Добавление записи настроения
  Future<void> addMoodEntry(String userId, int mood, DateTime date) async {
    try {
      await fireStore
          .collection('users')
          .doc(userId)
          .collection('moodEntries')
          .add({
        'mood': mood,
        'date': date,
      });
    } catch (e) {
      log("Error adding mood entry: $e");
    }
  }

  // Извлечение записей настроения
  Future<List<Map<String, dynamic>>> getMoodEntries(String userId) async {
    try {
      final querySnapshot = await fireStore
          .collection('users')
          .doc(userId)
          .collection('moodEntries')
          .orderBy('date')
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log("Error getting mood entries: $e");
      return [];
    }
  }
}
