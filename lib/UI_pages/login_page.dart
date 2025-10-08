import 'package:flutter/material.dart';
import 'package:note_app_task/UI_pages/add_note_Screen.dart';
import 'package:note_app_task/UI_pages/sinup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hux/hux.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // ✅ form key

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  Future<bool> checkLogin(String email, String password) async {
    emailcontroller.clear();
    passwordcontroller.clear();
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');
    return email == savedEmail && password == savedPassword;
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
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
        actions: [
          IconButton(
              onPressed: () async {
                await logout(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 30, left: 16, right: 16),
                    duration: Duration(seconds: 4),
                  ),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SinupPage()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 66),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.purple, Colors.blue, Colors.greenAccent],
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      "Hello Again!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: emailcontroller,
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
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    label: Text('Enter password'),
                    // fillColor: Colors.white,
                    //filled: true,
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
                    bool success = await checkLogin(
                      emailcontroller.text,
                      passwordcontroller.text,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login successful'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin:
                              EdgeInsets.only(bottom: 30, left: 16, right: 16),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Invalid credentials",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin:
                              EdgeInsets.only(bottom: 30, left: 16, right: 16),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "LogIn",
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
                      "I have no account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SinupPage()));
                      },
                      child:
                          Text("Sing Up", style: TextStyle(color: Colors.blue)),
                      //),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SinupPage()));
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
