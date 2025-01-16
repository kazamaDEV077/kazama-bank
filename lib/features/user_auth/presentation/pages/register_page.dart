import 'package:flutter/material.dart';
import 'package:mobile_3_uas_kelompok_10/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:mobile_3_uas_kelompok_10/global/common/toast.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool _isPasswordVisible = false;

  void register(BuildContext context) async {
    try {
      var user = await FirebaseAuthService().registerWithEmail(
          emailController.text, passwordController.text, nameController.text);
          // tambahkan perinta untuk mengirim data ke firestore
      if (user != null) {
        showToast("Registration successful");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } catch (e) {
      showToast('Registration failed: $e');
    }
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Adding transparency to the box
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(66, 12, 12, 12),
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(prefixIcon, color: Colors.white),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: const Color.fromARGB(255, 209, 202, 202).withOpacity(0.4), // More transparency on the input background
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bacground44.jpeg', 
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 165, 163, 163),
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 3,
                            color: Color.fromARGB(135, 27, 27, 27),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Input Name
                    buildInputField(
                      controller: nameController,
                      hintText: "Name",
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    // Input Email
                    buildInputField(
                      controller: emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 20),
                    // Input Password with Toggle Visibility
                    buildInputField(
                      controller: passwordController,
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromARGB(255, 253, 247, 247),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => register(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 201, 36, 165),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Back to Login
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Log in",
                        style: TextStyle(
                          color: Color.fromARGB(179, 245, 239, 239),
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
