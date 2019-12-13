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
  } else {}
}

void httpsServer() async {
  SecurityContext serverContext = new SecurityContext()
    ..useCertificateChain('path/to/my_cert.pem')
    ..usePrivateKey('path/to/my_key.pem');

  var server = await HttpServer.bindSecure('example.com', 433, serverContext,
      backlog: 5);

  listenRequest(server);
}

void httpServer() async {
  var server = await HttpServer.bind("rndnum.talviruusu.com", 80);
  listenRequest(server);
  print('Listening localhos:${server.port}');
}

void listenRequest(HttpServer server) async {
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
