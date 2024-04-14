
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'AuthController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthController _AuthController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: _AuthController.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: _AuthController.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () {
                    if (_AuthController.emailController.text.isNotEmpty &&
                        _AuthController.passwordController.text.isNotEmpty) {
                      _AuthController.createAccount();
                    } else {
                      Get.snackbar('Error', 'All fields are required');
                    }

                  },
                    child: const Text('Login'),),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(onPressed: () {


                      },
                        child: const Text('Sign Up'),),
                    ],
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
