import 'package:rnd_num/rnd_num.dart';
import 'dart:io';

main(List<String> arguments) {
  Map<String, String> envVars = Platform.environment;
  var domain = envVars['rnd_domain'] == null
      ? InternetAddress.loopbackIPv4
      : envVars['rnd_domain'];
  var port = envVars['rnd_port'] == null ? 3000 : envVars['rnd_port'];
  var certPath = envVars['rnd_cert'] == null ? "" : envVars['rnd_cert'];
  var certKeyPath =
      envVars['rnd_cert_key'] == null ? 3000 : envVars['rnd_cert_key'];

  print(envVars);

  bool secureServer = false;
  for (String arg in arguments) {
    if (arg == "secure" || arg == "-s") {
      print("No Secure server implemented!");
      exit(0);
    }
  }

  if (!secureServer) {
    httpServer(domain, port);
  } else {
    httpsServer(domain, certPath, certKeyPath);
  }
}

void httpsServer(String domain, String certPath, String certKeyPath) async {
  SecurityContext serverContext = new SecurityContext()
    ..useCertificateChain(certPath)
    ..usePrivateKey(certKeyPath);

  var server =
      await HttpServer.bindSecure(domain, 433, serverContext, backlog: 5);

  listenRequest(server);
}

void httpServer(dynamic domain, dynamic port) async {
  var server = await HttpServer.bind(domain, 3000);
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
