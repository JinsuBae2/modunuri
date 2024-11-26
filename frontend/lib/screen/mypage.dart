import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  Future<Map<String, String>> _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username') ?? '사용자 이름 없음';
    String? email = prefs.getString('email') ?? '이메일 없음';
    return {'username': username, 'email': email};
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('사용자 정보를 불러오지 못했습니다.'));
          } else {
            final userInfo = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '안녕하세요, ${userInfo['username']}님!',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '이메일: ${userInfo['email']}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // 사용자 프로필 정보 수정 화면으로 이동
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    child: const Text('프로필 수정'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _logout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('로그아웃'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
