import 'package:flutter/material.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:mobile_3_uas_kelompok_10/global/common/toast.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    try {
      if (emailController.text.isEmpty) {
        showToast('Please enter your email.');
        return;
      }
      await FirebaseAuthService().sendPasswordResetEmail(emailController.text);
      showToast('Password reset email sent. Please check your inbox.');
      Navigator.pop(context); 
    } catch (e) {
      showToast('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bacground44.jpeg', 
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: const Color.fromARGB(255, 27, 31, 63).withOpacity(0.2), // Overlay
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildEmailField(),
                    const SizedBox(height: 30),
                    _buildResetButton(),
                    const SizedBox(height: 20),
                    _buildBackToLoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 87, 86, 86).withOpacity(0.7),
        prefixIcon: const Icon(Icons.email, color: Colors.white70),
        hintText: "Enter your email",
        hintStyle: const TextStyle(color: Color.fromARGB(179, 248, 245, 245)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: resetPassword,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 184, 11, 169),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        "Send Reset Email",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        "Back to Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
