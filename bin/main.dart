import 'package:rnd_num/rnd_num.dart';

main(List<String> arguments) {
  int num = 16;
  if (arguments.length > 0) {
    num = int.parse(arguments[0]);
  }
  print(randomBytes(num));
}
