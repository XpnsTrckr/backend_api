import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test('responds with a 200 and welcome message', () {
      // Arrange
      final context = _MockRequestContext();
      const welcome = '''
Welcome to Xpns Trckr API!
Please choose a version to work with.
''';

      // Act
      final response = route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.body(), completion(equals(welcome)));
    });
  });
}
