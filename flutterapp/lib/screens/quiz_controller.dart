import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'quiz.dart';
import 'package:flutter/material.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Lets animated our progress bar

  bool isNextButtonEnabled = false; // Initialize the button as disabled
  double _progress = 0.0; // Initialize progress to 0.0
  double get progress => _progress;
  int _totalQuestions = sample_data.length;
  int get totalQuestions => _totalQuestions;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Use CurvedAnimation with a custom curve

    _questionNumber = 1.obs;
    _pageController = PageController();
    super.onInit();
  }

  void incrementProgress() {
    _progress =
        (_questionNumber.value - 1) / _totalQuestions; // Calculate the progress
    update(); // Notify the UI that progress has changed
  }

  double calculateProgress() {
    if (_questionNumber.value == 1) {
      return 0.0;
    } else {
      return (_questionNumber.value - 1) / _totalQuestions;
    }
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    if (_isAnswered) return;
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    isNextButtonEnabled =
        true; // Ensure that it's set to true when an answer is selected

    update();
  }

  void resetState() {
    _isAnswered = false;
    _selectedAns = -1;
    isNextButtonEnabled = false; // Disable the button
    update();
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _selectedAns = -1; // Reset the selected answer
      isNextButtonEnabled = false; // Disable the button
      _pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
      );
    } else {
      // Use Navigator to navigate to the ScoreScreen
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  void resetQuiz() {
    _questionNumber.value = 1;
    _numOfCorrectAns = 0;
    isNextButtonEnabled = false;
    _isAnswered = false;
    update(); // Notify the UI that the state has changed
  }
}
