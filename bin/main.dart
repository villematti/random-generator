import 'package:rnd_num/rnd_num.dart';
import 'dart:io';
import 'dart:convert';

main(List<String> arguments) async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('Listening localhos:${server.port}');

  await for (HttpRequest request in server) {
    if (request.method == 'POST') {
      if (request.uri.queryParameters['length'] != null) {
        var num = int.parse(request.uri.queryParameters['length']);
        var rndNum = randomBytes(num);

        request.response
          ..write(rndNum)
          ..close();
      } else {
        request.response
          ..write("Incorrect params! Length must be assigned!")
          ..close();
      }
    } else {
      request.response
        ..write('Unsupportted method! Please use post!')
        ..close();
    }
  }
}
