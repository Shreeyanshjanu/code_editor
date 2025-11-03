import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(120.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Lottie.asset(
                                    'assets/animations/welcome.json',
                                    width: 400,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),

                                  Text(
                                    'Today is a new day. It\'s your day. You shape it.\nSign in to start managing your projects.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 30),
                            Center(
                              child: Container(
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Example@email.com',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Password Field
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'At least 8 characters',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // Sign In Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF1a3a3a),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text('Or'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    // Social Login Buttons
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/logos/google.png',
                                              width: 24,
                                              height: 24,
                                            ),
                                            SizedBox(width: 12),
                                            Text('Sign in with Google'),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20),
                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Don\'t you have an account? ',
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(
                                              text: 'Sign up',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Right side - Image
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/login_image.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
