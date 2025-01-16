import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<User?> registerWithEmail(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String role = email == "admin@gmail.com" ? "Admin" : "Client";
      await _firestore.collection("users").doc(userCredential.user?.uid).set({
        "email": email,
        "name": name,
        "Admin": role,
      });

      return userCredential.user;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        return userDoc.get("role");
      }
      return null; 
    } catch (e) {
      throw Exception("Error fetching user role: $e");
    }
  }
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }

  sendPasswordResetEmail(String text) {}
}
