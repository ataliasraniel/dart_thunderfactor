import 'dart:developer';
import 'dart:io';

import 'package:dart_thunderfactor/answer_manager.dart';

final AnswerManager answerManager = AnswerManager();
final Directory current = Directory.current;
final String path = current.path;
String pathToFiles = '$path\\';

final Directory files = Directory(pathToFiles);
final List<FileSystemEntity> filesInDirectory = files.listSync(recursive: true, followLinks: true);
void startThunderFactor() {
  print('ThunderFactor is starting...');
  print('Please, provide the path to the files: ');
  String selectedPath = '';
  selectedPath = stdin.readLineSync()!;
  while (!answerManager.validatePath(selectedPath, 'Please, provide the path to the files: ')) {
    selectedPath = stdin.readLineSync()!;
  }
  pathToFiles += selectedPath;

  print('Path to files is $pathToFiles');
  print('filesInDirectory: ${filesInDirectory.length}');

  print('Which factor do you want to use?');
  print('1. Rename files'
      '\n2. Rename folders'
      '\n3. Rename Objects');
  final String? answer = stdin.readLineSync();
  switch (answer) {
    case '1':
      renameFiles();
      break;
    case '2':
      // renameFolders();
      break;
    case '3':
      renameObjects();
      break;
    default:
      print('Unknown option!');
      break;
  }
}

void renameObjects() async {
  print('This module will rename all names ocurrences in the files.');
  print('Please provide a "from" string: ');
  final String from = stdin.readLineSync()!;
  print('Please provide a "to" string: ');
  final String to = stdin.readLineSync()!;
  print('Okay... Let\'s continue!');
  print('Renaming all ocurrencies from $from to $to');
  if (answerManager.askQuestionAndGetResponse('Do you want to continue?', true) == Answer.yes) {
    for (FileSystemEntity file in filesInDirectory) {
      try {
        if (file.path.contains('.dart')) {
          log('File is ${file.path}');
          File currentFile = File(file.path);
          final fileTextContent = await currentFile.readAsString();
          final renamedFileTextContent = fileTextContent.replaceAll(from, to);
          await currentFile.writeAsString(renamedFileTextContent);
          print('Alright file ${file.path} content $from was replaced by $to');
        }
      } catch (e) {
        log('Error! File is ${file.path}');
      }
    }
    print('Done! All file name Ocurrencies are changed to $to! 👍');
    print('Press any key to exit...');
    stdin.readLineSync();
    exit(0);
  }
}

void renameFiles() {
  if (answerManager.askQuestionAndGetResponse('Do you want to continue?') == Answer.yes) {
    print('Please provide a "from" string: ');
    final String from = stdin.readLineSync()!;
    print('Please provide a "to" string: ');
    final String to = stdin.readLineSync()!;
    print('Okay... Let\'s continue!');
    print('Renaming files from $from to $to');
    if (answerManager.askQuestionAndGetResponse('Do you want to continue?') == Answer.yes) {
      print('Okay... Renaming files!');
      for (FileSystemEntity file in filesInDirectory) {
        try {
          if (file.path.contains(from)) {
            log('File is ${file.path}');
            final String currentFileName = file.path;
            final renamedFileName = currentFileName.replaceAll(from, to);
            log('Renamed file is $renamedFileName');
            file.renameSync(renamedFileName);
          }
        } catch (e) {
          log('Error! File is ${file.path}');
        }
      }
      print('Done! All files renamed to $to! 🥳');
      print('Press any key to exit...');
      stdin.readLineSync();
      exit(0);
    } else {
      print('Okay... Bye!');
      exit(0);
    }
  } else {
    print('Okay... Bye!');
    exit(0);
  }
}
