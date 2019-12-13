import 'package:rnd_num/rnd_num.dart';
import 'dart:io';

main(List<String> arguments) {
  bool secureServer = false;
  for (String arg in arguments) {
    if (arg == "secure" || arg == "-s") {
      print("No Secure server implemented!");
      exit(0);
    }
  }

  if (!secureServer) {
    httpServer();
  }
}

void httpServer() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('Listening localhos:${server.port}');

  await for (HttpRequest request in server) {
    if (request.method == 'POST') {
      handlePost(request);
    } else {
      request.response
        ..write('Unsupportted method! Please use post!')
        ..close();
    }
  }
}

void handlePost(HttpRequest request) {
  if (request.uri.queryParameters['length'] != null) {
    var num = int.parse(request.uri.queryParameters['length']);
    var randomBytes = new RandomBytes(num);
    var rndNum = randomBytes.getBytes();

    request.response
      ..write(rndNum)
      ..close();
  } else {
    request.response
      ..write("Incorrect params! Length must be assigned!")
      ..close();
  }
}
