import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF414A4C), 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'img/ask.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  "Selamat Datang di Quissey",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF0FFF0),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  "Uji pengetahuanmu dengan menjawab berbagai pertanyaan seputar pengetahuan informatika!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF0FFF0).withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTapDown: (_) => _controller.forward(),
                  onTapUp: (_) {
                    _controller.reverse();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                  onTapCancel: () => _controller.reverse(),
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF0FFF0), 
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Color(0xFF414A4C), 
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "© 2025 Quissey Kelompok 1. All rights reserved.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF0FFF0).withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
