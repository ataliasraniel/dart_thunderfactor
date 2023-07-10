import 'dart:io';

import 'package:dart_thunderfactor/dart_thunderfactor.dart' as dart_thunderfactor;

void main(List<String> arguments) {
  print('ThunderFactor is starting...');
  print('Do you want to continue? (y/n)');
  final String? answer = stdin.readLineSync();

  if (answer == 'y') {
    dart_thunderfactor.startThunderFactor();
  } else {
    print('Okay... Bye!');
  }
}
