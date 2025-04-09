import 'package:flutter/material.dart';
import '../controllers/quiz_manager.dart';
import 'result_screen.dart';
import 'dart:async';


class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizManager _quizManager;
  int _remainingTime = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _quizManager = QuizManager(onQuizEnd: _navigateToResult);
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = 10;
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        _handleAnswer(-1);
      }
    });
  }

  void _handleAnswer(int selectedIndex) {
    bool isCorrect = selectedIndex == _quizManager.questions[_quizManager.currentQuestionIndex].correctAnswerIndex;
    _quizManager.updateScore(isCorrect);

    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _quizManager.nextQuestion(isCorrect);
          _startTimer();
        });
      }
    });
  }

  void _navigateToResult() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(score: _quizManager.score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF414A4C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScoreIndicator(correctAnswers: _quizManager.correctAnswers, wrongAnswers: _quizManager.wrongAnswers),
              SizedBox(height: 20),
              Text(
                '⏳ Waktu tersisa: $_remainingTime detik',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  _quizManager.questions[_quizManager.currentQuestionIndex].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
                Column(
                children: List.generate(
                  _quizManager.questions[_quizManager.currentQuestionIndex].options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF0FFF0),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _handleAnswer(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 60), 
                          alignment: Alignment.center,
                          child: Text(
                            _quizManager.questions[_quizManager.currentQuestionIndex].options[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF414A4C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class ScoreIndicator extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;

  ScoreIndicator({required this.correctAnswers, required this.wrongAnswers});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 30),
        SizedBox(width: 5),
        Text('$correctAnswers', style: TextStyle(fontSize: 20, color: Colors.white)),
        SizedBox(width: 20),
        Icon(Icons.cancel, color: Colors.red, size: 30),
        SizedBox(width: 5),
        Text('$wrongAnswers', style: TextStyle(fontSize: 20, color: Colors.white)),
      ],
    );
  }
}
