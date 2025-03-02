import 'dart:async';
import 'package:flutter/material.dart';

class TrafficLightPage extends StatefulWidget {
  const TrafficLightPage({super.key});

  @override
  State<TrafficLightPage> createState() => _TrafficLightPageState();
}

class _TrafficLightPageState extends State<TrafficLightPage> {
  int _currentLight = 0; // 0 = แดง, 1 = เหลือง, 2 = เขียว
  bool _isAutoMode = false; // โหมดอัตโนมัติ
  Timer? _timer;
  int _countdown = 10; // เวลาถอยหลังก่อนเปลี่ยนไฟ

  void _changeLight() {
    setState(() {
      _currentLight = (_currentLight + 1) % 3;
      _resetCountdown(); // รีเซ็ตตัวเลขถอยหลังเมื่อเปลี่ยนไฟ
    });
  }

  void _toggleAutoMode() {
    setState(() {
      _isAutoMode = !_isAutoMode;

      if (_isAutoMode) {
        _startAutoMode();
      } else {
        _timer?.cancel();
        _resetCountdown();
      }
    });
  }

  void _startAutoMode() {
    _timer?.cancel();
    _countdown = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        _changeLight();
        _countdown = 10;
      }
    });
  }

  void _resetCountdown() {
    _countdown = 10;
  }

  double _getOpacity(int lightIndex) {
    return _currentLight == lightIndex ? 1.0 : 0.3;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Traffic Light Animation',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal, // ปรับสีของ AppBar ให้ดูสะดุดตา
        elevation: 5,
      ),
      body: Container(
        color: Colors.teal[50], // ปรับสีพื้นหลังให้ดูสบายตา
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // เลื่อนเนื้อหาขึ้น
            children: [
              // ไฟจราจร
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLight(Colors.red, _getOpacity(0), _isAutoMode && _currentLight == 0 ? _countdown : null),
                    _buildLight(Colors.yellow, _getOpacity(1), _isAutoMode && _currentLight == 1 ? _countdown : null),
                    _buildLight(Colors.lightGreen, _getOpacity(2), _isAutoMode && _currentLight == 2 ? _countdown : null),
                  ],
                ),
              ),
              const SizedBox(height: 10), // เพิ่มช่องว่างระหว่างไฟและปุ่ม
              ElevatedButton(
                onPressed: _changeLight,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.teal, // สีปุ่มให้เข้ากับธีม
                ),
                child: const Text(
                  'เปลี่ยนไฟ',
                  style: TextStyle(
                    color: Colors.white, // สีข้อความให้ชัดเจน
                    fontSize: 20, // ขนาดตัวอักษรใหญ่ขึ้น
                    fontWeight: FontWeight.bold, // ทำให้ข้อความหนา
                  ),
                ),
              ),
              const SizedBox(height: 10), // เพิ่มช่องว่างระหว่างปุ่มและสวิตช์
              SwitchListTile(
                title: const Text(
                  'โหมดอัตโนมัติ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // ขยายขนาดตัวอักษร
                ),
                value: _isAutoMode,
                onChanged: (value) => _toggleAutoMode(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLight(Color color, double opacity, int? countdown) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: countdown != null
            ? Center(
                child: Text(
                  '$countdown',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
