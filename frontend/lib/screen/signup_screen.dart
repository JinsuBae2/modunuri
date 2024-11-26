import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _signup() async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': _usernameController.text,
        'password': _passwordController.text,
        'birthDate': _birthDateController.text,
        'phoneNumber': _phoneController.text,
        'email': _emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('회원가입 성공');
      Navigator.pushNamed(context, '/login');
    } else {
      print('회원가입 실패: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: '사용자 이름'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            TextField(
              controller: _birthDateController,
              decoration: const InputDecoration(labelText: '생년월일 (YYYY-MM-DD)'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  locale: const Locale('ko', 'KR'),
                );
                if (pickedDate != null) {
                  setState(() {
                    _birthDateController.text =
                        pickedDate.toLocal().toString().split(' ')[0];
                  });
                }
              },
            ),
            TextField(
              controller: _phoneController,
              decoration:
                  const InputDecoration(labelText: '전화번호 (010-XXXX-XXXX)'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signup,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
