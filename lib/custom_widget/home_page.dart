import 'package:flutter/material.dart';
import 'profile_card.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme; //เพิ่มตัวแปรฟังก์ชันเปลี่ยนโหมด
  final ThemeMode themeMode; //เพิ่มตัวแปรรับค่าโหมดปัจจุบัน

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widget'),
        actions: [ //เพิ่มปุ่มสลับโหมด
          IconButton(
            icon: Icon(themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme, //กดแล้วเปลี่ยนโหมด
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ProfileCard(
            name: 'Ruthaichanok Reungthanoo',
            position: 'Student',
            email: 'reungthanoo_r@silpakorn.edu',
            phoneNumber: '0987654321',
            imageUrl: 'assets/images/nong.jpg',
          ),
        ),
      ),
    );
  }
}
