// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app_task/UI_pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SinupPage extends StatefulWidget {
  const SinupPage({super.key});

  @override
  State<SinupPage> createState() => _SinupPageState();
}

class _SinupPageState extends State<SinupPage> {
  final emailController = TextEditingController();
  final passworController = TextEditingController();
  Future<void> saverdetils(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1731596691311-5955c052b66e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 66),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.lime,
                          Colors.green,
                          Colors.teal
                        ],
                      ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Text(
                        "Welcome! Sign Up Below",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: Text('Enter Email'),

                      // fillColor: Colors.white,
                      // filled: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passworController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      label: Text('Enter password'),
                      // fillColor: Colors.white,
                      // filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      fixedSize: const Size(410, 53),
                    ),
                    onPressed: () async {
                      print("Sign Up button tapped");
                      final email = emailController.text.trim();
                      final password = passworController.text.trim();

                      print("DEBUG Email: $email");
                      print("DEBUG Password: $password");

                      if (email.isNotEmpty && password.isNotEmpty) {
                        await saverdetils(email, password);
                        emailController.clear();
                        passworController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("User Registered Successfully",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom: 30, left: 16, right: 16),
                            duration: Duration(seconds: 4),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please enter email & password",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom: 30, left: 16, right: 16),
                            duration: Duration(seconds: 4),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text("Log In",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
