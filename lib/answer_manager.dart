import 'dart:developer';
import 'dart:io';

enum Answer { yes, no, unknown }

class AnswerManager {
  final questionTrailing = 'Only respond with: (y/n)';

  Answer askQuestionAndGetResponse(String question, [bool? exitOnNo]) {
    print('$question $questionTrailing');
    final String? answer = stdin.readLineSync();

    if (answer == 'y') {
      return Answer.yes;
    } else if (answer == 'n') {
      if (exitOnNo != null && exitOnNo) {
        print('Okay... Bye!');
        exit(0);
      }
      return Answer.no;
    } else {
      askQuestionAndGetResponse(question);
      return Answer.unknown;
    }
  }

  String getResponse(String question) {
    while (true) {
      print(question);
      final String? answer = stdin.readLineSync();
      if (answer != null && answer.isNotEmpty) {
        return answer;
      }
    }
  }

  void handleResponse(Answer response) {
    switch (response) {
      case Answer.yes:
        print('Yes!');
        break;
      case Answer.no:
        print('No!');
        break;
      case Answer.unknown:
        print('Unknown!');
        break;
    }
  }

  bool validatePath(String? path, [String? response]) {
    print('path given is $path');
    if (path == null || path.isEmpty || !path.contains('/')) {
      if (response != null) {
        print(response);
      }
      print('The given path is invalid!');
      return false;
    }
    return true;
  }
}
