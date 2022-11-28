import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:expense/expense.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../routes/v1/expenses/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  late RequestContext context;
  late Request request;
  late ExpenseRepository repository;

  final expense = Expense(
    id: 42,
    userId: 84,
    description: 'meaningful description',
    value: 128,
    time: DateTime.now(),
  );

  setUpAll(() => registerFallbackValue(expense));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    repository = _MockExpenseRepository();

    when(() => context.read<ExpenseRepository>()).thenReturn(repository);
    when(() => context.request).thenReturn(request);
  });

  group('responds with a 405', () {
    test('when method is DELETE', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.delete);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is HEAD', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.head);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is OPTIONS', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.options);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PATCH', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.patch);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PUT', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.put);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });

  group('GET /expenses', () {
    test('responds with a 200 and an empty list', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => repository.readAll()).thenAnswer((_) async => []);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(isEmpty));

      verify(() => repository.readAll()).called(1);
    });

    test('responds with a 200 and a populated list', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => repository.readAll()).thenAnswer((_) async => [expense]);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals([expense.toJson()])));

      verify(() => repository.readAll()).called(1);
    });
  });

  group('POST /expenses', () {
    test('responds with a 201 and the newly created Expense', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.json()).thenAnswer((_) async => expense.toJson());
      when(() => repository.create(any())).thenAnswer((_) async => expense);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.created));
      expect(response.json(), completion(equals(expense.toJson())));

      verify(() => repository.create(any())).called(1);
    });
  });
}
