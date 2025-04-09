import '../models/questions.dart';

class QuizManager {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  final Function onQuizEnd;

  QuizManager({required this.onQuizEnd});

  List<Question> _questions = [
Question(
      questionText: "Apa singkatan dari D4 Manajemen Informatika?",
      options: ["MI", "D4MI", "TI"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Dalam linked list, setiap elemen disebut sebagai?",
      options: ["Row", "Column", " Node"],
      correctAnswerIndex: 2,
    ),
     Question(
      questionText: "Apa yang dimaksud dengan Big-O Notation dalam analisis algoritma?",
      options: ["Metode untuk mengurutkan data dalam array", "Notasi yang digunakan untuk menggambarkan kompleksitas waktu atau ruang dari suatu algoritma", "Teknik optimasi dalam pemrograman fungsional"],
      correctAnswerIndex: 1,
    ),
     Question(
      questionText: "Manakah dari pernyataan berikut yang merupakan konsep utama dalam OOP?",
      options: ["Encapsulation, Inheritance, Polymorphism", "Recursion, Looping, Compilation", "Syntax, Semantics, Debugging"],
      correctAnswerIndex: 0,
    ),
     Question(
      questionText: "Apa yang terjadi jika sebuah subclass memiliki metode yang sama dengan superclass, tetapi dengan implementasi yang berbeda?",
      options: ["Polymorphism", "Encapsulation", "Aggregation"],
      correctAnswerIndex: 0,
    ),
     Question(
      questionText: "Apa fungsi dari HTML dalam pembuatan website?",
      options: ["Mengatur tampilan dan desain halaman", "Menyusun struktur dan isi dari sebuah halaman web", "Menjalankan fungsi-fungsi logika di server"],
      correctAnswerIndex: 1,
    ),
     Question(
      questionText: "Manakah perintah SQL yang digunakan untuk mengambil semua data dari tabel 'mahasiswa'?",
      options: ["GET ALL FROM mahasiswa;", "FETCH mahasiswa;","SELECT * FROM mahasiswa;"],
      correctAnswerIndex: 2,
    ),
     Question(
      questionText: "Apa yang dimaksud dengan jaringan komputer?",
      options: ["Koneksi antara dua atau lebih komputer yang memungkinkan berbagi data dan sumber daya", "Perangkat keras yang digunakan untuk menyimpan file", "Program yang digunakan untuk mengedit dokumen"],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText: "Manakah contoh dari sistem manajemen database (DBMS)?",
      options: ["Windows dan Linux", "MySQL dan PostgreSQL", "Flutter"],
      correctAnswerIndex: 1,
    ),
     Question(
      questionText: "Manakah struktur data yang bekerja berdasarkan prinsip Last In, First Out (LIFO)?",
      options: ["Stack", "Queue", "Linked List"],
      correctAnswerIndex: 0,
    ),
  ];

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;

  void updateScore(bool isCorrect) {
    if (isCorrect) {
      _score += 10;
      _correctAnswers++;
    } else {
      _wrongAnswers++;
    }
  }

  void nextQuestion(bool isCorrect) {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      onQuizEnd();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
  }
}