import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: '''
Welcome to Xpns Trckr API!
Please choose a version to work with.
''',
  );
}
