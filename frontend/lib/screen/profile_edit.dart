import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phoneNumber') ?? '';
      _birthDateController.text = prefs.getString('birthDate') ?? '';
    });
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance(); // 로컬 저장소에서 토큰 가져오기
    final token = prefs.getString('jwtToken') ?? ''; // 토큰 가져오기

    final response = await http.put(
      Uri.parse('http://localhost:8080/api/auth/update-profile'), // API URL
      headers: {
        'Content-Type': 'application/json', // JSON 요청
        'Authorization': 'Bearer $token', // 토큰 추가
      },
      body: json.encode({
        'username': _usernameController.text, // 사용자가 입력한 데이터
        'email': _emailController.text,
        'phoneNumber': _phoneController.text,
        'birthDate': _birthDateController.text,
      }),
    );

    if (response.statusCode == 200) {
      final updatedUser = json.decode(response.body);

      // 성공적으로 업데이트되었을 때 SharedPreferences 업데이트
      await prefs.setString('username', updatedUser['username']);
      await prefs.setString('email', updatedUser['email']);
      await prefs.setString('phoneNumber', updatedUser['phoneNumber']);
      await prefs.setString('birthDate', updatedUser['birthDate']);

      print('프로필 업데이트 성공');
      Navigator.pop(context); // 이전 화면으로 돌아가기
    } else {
      print('프로필 업데이트 실패: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: '사용자 이름'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: '전화번호'),
            ),
            TextField(
              controller: _birthDateController,
              decoration: const InputDecoration(labelText: '생년월일'),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode()); // 키보드 닫기
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  locale: const Locale('ko', 'KR'), // 한국어 달력
                );
                if (pickedDate != null) {
                  setState(() {
                    _birthDateController.text =
                        pickedDate.toString().split(' ')[0]; // yyyy-MM-dd 형식
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('프로필 저장'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/change-password');
              },
              child: const Text('비밀번호 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
