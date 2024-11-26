import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // 배경색 설정
          gradient: LinearGradient(
            colors: [Color(0xFF87CEFA), Color(0xFFB0E0E6)], // 밝은 블루 그라데이션
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              // 로고
              Image.asset(
                'assets/images/logo.png',
                width: 500,
                height: 500,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              // 서비스 설명 텍스트
              Text(
                '간단하고 빠른 회원가입과 로그인을 통해\n다양한 혜택을 누리세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),

              // 회원가입 및 로그인 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.blue[400],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.blue[600],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 일러스트 공간 (이미지 추가 가능)
              // Expanded(
              //   child: Container(
              //     margin: const EdgeInsets.only(top: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.grey[200],
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: const Center(
              //       child: Text(
              //         '여기에 서비스 관련 일러스트가 들어갈 수 있습니다.',
              //         style: TextStyle(fontSize: 14, color: Colors.grey),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ),
              // ),

              // Footer
              const SizedBox(height: 20),
              Text(
                '© 2024 모두누리 - 개인정보처리방침 | 이용약관',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
