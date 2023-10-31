import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'package:get/get.dart';
import 'quiz_controller.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuestionController _questionController = Get.put(QuestionController());
  bool isNextButtonEnabled = false; // Initialize the button as disabled

  void enableNextButton() {
    setState(() {
      if (_questionController.selectedAns != -1) {
        isNextButtonEnabled = true;
        // Future.delayed(Duration(milliseconds: 2000), () {
        //   isNextButtonEnabled = false;// Notify the UI again
        // });
      } else {
        isNextButtonEnabled = false;
      }

      print("isNextButtonEnabled: $isNextButtonEnabled");
    });
  }

  void disableNextButtonWithDelay() {
    setState(() {
      isNextButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                () => CustomProgressBar(
                  progress: _questionController.calculateProgress(),
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Question ${_questionController.questionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: kSecondaryColor),
                    children: [
                      TextSpan(
                        text: "/${_questionController.questions.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(thickness: 1.0),
            SizedBox(height: kDefaultPadding),
            Container(
              height: MediaQuery.of(context).size.height - 260,
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _questionController.pageController,
                onPageChanged: _questionController.updateTheQnNum,
                itemCount: _questionController.questions.length,
                itemBuilder: (context, index) => QuestionCard(
                  question: _questionController.questions[index],
                  enableNextButton: enableNextButton,
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Center(
              child: Container(
                width: 340,
                height: 50,
                child: ElevatedButton(
                  onPressed: isNextButtonEnabled
                      ? () {
                          _questionController.nextQuestion();
                          _questionController.incrementProgress();
                          disableNextButtonWithDelay();
                        }
                      : null, // Set to null when the button should be disabled
                  child: Text("Next Question"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "Flutter is an open-source UI software development kit created by ______",
    "options": ['Apple', 'Google', 'Facebook', 'Microsoft'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "When google release Flutter.",
    "options": ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "A memory location that holds a single letter or number.",
    "options": ['Double', 'Int', 'Char', 'Word'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "What command do you use to output data to the screen?",
    "options": ['Cin', 'Count>>', 'Cout', 'Output>>'],
    "answer_index": 2,
  },
];

class Option extends StatelessWidget {
  const Option(
      {super.key,
      required this.text,
      required this.index,
      required this.press});

  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(),
      builder: (qnController) {
        Color getTheRightColor() {
          if (qnController.isAnswered) {
            if (index == qnController.correctAns) {
              return kGreenColor;
            } else if (index == qnController.selectedAns &&
                qnController.selectedAns != qnController.correctAns) {
              return kRedColor;
            }
          }
          return kGrayColor;
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. $text",
                  style: TextStyle(color: getTheRightColor(), fontSize: 16),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor() == kGrayColor
                        ? Colors.transparent
                        : getTheRightColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: getTheRightColor()),
                  ),
                  child: getTheRightColor() == kGrayColor
                      ? null
                      : Icon(getTheRightIcon(), size: 16),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  CustomProgressBar({super.key, required this.progress});
  QuestionController _questionController = Get.put(QuestionController());

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width *
                _questionController.calculateProgress(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.green
                ], // Customize your gradient colors
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${(_questionController.calculateProgress() * 100).toInt()}%"),
                  Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {super.key, required this.question, required this.enableNextButton});

  final Question question;
  final VoidCallback enableNextButton;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: kBlackColor),
            ),
            SizedBox(height: kDefaultPadding / 2),
            ...List.generate(
              question.options.length,
              (index) => Option(
                  index: index,
                  text: question.options[index],
                  press: () {
                    _controller.checkAns(question, index);
                    enableNextButton(); // Manually enable the button
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

void popMultiple(BuildContext context, int timesToPop) {
  for (int i = 0; i < timesToPop; i++) {
    Navigator.pop(context);
  }
}

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(height: 130),
              Container(
                width: 200, // Set the width as per your requirement
                height: 200, // Set the height as per your requirement
                child: Image.asset(
                  'images/trophy.png', // Replace with your image path
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: kSecondaryColor),
              ),
              SizedBox(height: 20),
              Text(
                "${(_qnController.numOfCorrectAns / _qnController.questions.length * 100).toInt()} Marks",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: kSecondaryColor),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _qnController.resetQuiz();
                  // Navigate back to CourseDetailScreen
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailScreen()));
                  // Navigator.pushNamed(context, '/courseDetail');
                  // Navigator.popUntil(context, ModalRoute.withName('/courseDetail'));
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CourseDetailScreen()),
                  //       (route) => false, // This predicate removes all previous routes
                  // );
                  popMultiple(context, 2); // Pops the stack twice
                },
                child: Text('Exit'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(tuLightBlue),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(200, 45)), // Set your desired color
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
