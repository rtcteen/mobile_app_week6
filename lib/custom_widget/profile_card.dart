import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.position,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark; //ตรวจสอบโหมด

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: isDarkMode ? Colors.grey[800] : Color.fromARGB(255, 255, 255, 207), //เปลี่ยนสี Card ตามโหมด
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(position, style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey)), //เปลี่ยนสีข้อความ
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 16, color: isDarkMode ? Colors.tealAccent : Colors.blue), //เปลี่ยนสีไอคอน
                const SizedBox(width: 4),
                Text(email, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)), //เปลี่ยนสีข้อความ
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 16, color: isDarkMode ? Colors.greenAccent : Colors.green), //เปลี่ยนสีไอคอน
                const SizedBox(width: 4),
                Text(phoneNumber, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)), //เปลี่ยนสีข้อความ
              ],
            ),
          ],
        ),
      ),
    );
  }
}
