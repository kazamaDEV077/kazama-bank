import 'package:flutter/material.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/home_klien_page.dart' as klien;
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/home_page_admin.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/presentation/pages/register_page.dart';
import 'package:mobile_3_uas_kelompok_10/global/common/toast.dart';
import 'reset_pasword_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void login() async {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showToast('Please enter email and password.');
        return;
      }

      var user = await FirebaseAuthService().loginWithEmail(email, password);
      if (user != null) {
        if (email == "admin@gmail.com") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        } else if (email == "klien@gmail.com") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const klien.HomeClientPage()),
          );
        } else {
          showToast('Access denied. Unauthorized email.');
        }
      } else {
        showToast('Login failed: Invalid user credentials.');
      }
    } catch (e) {
      showToast('Login failed: ${e.toString()}');
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
            color: const Color.fromARGB(255, 9, 9, 27).withOpacity(0.2),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    _buildTextField(emailController, "E-mail Address", Icons.email),
                    const SizedBox(height: 27),
                    _buildPasswordField(passwordController, "Password", Icons.lock),
                    const SizedBox(height: 27),
                    _buildSignInButton(),
                    const SizedBox(height: 10),
                    _buildFooterText(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText,
    IconData icon, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 87, 86, 86).withOpacity(0.7),
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(179, 248, 245, 245)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 87, 86, 86).withOpacity(0.7),
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(179, 248, 245, 245)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: login,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 184, 11, 169),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size(double.infinity, 10),
      ),
      child: const Text(
        "Log in",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
            );
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },
          child: const Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
