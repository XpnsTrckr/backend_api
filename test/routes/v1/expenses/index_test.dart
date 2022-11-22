import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

import '../../../../routes/v1/expenses/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockExpensesDataSource extends Mock implements ExpensesDataSource {}

void main() {
  late RequestContext context;
  late Request request;
  late ExpensesDataSource dataSource;

  const id = 42;
  const userId = 84;
  const description = 'test description';
  const value = 128.0;
  final time = DateTime.now();

  final expense = Expense(
    id: id,
    userId: userId,
    description: description,
    value: value,
    time: time,
  );

  setUpAll(() => registerFallbackValue(expense));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    dataSource = _MockExpensesDataSource();

    when(() => context.read<ExpensesDataSource>()).thenReturn(dataSource);
    when(() => context.request).thenReturn(request);
  });

  group('responds with a 405', () {
    test('when method is DELETE', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.delete);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });

    test('when method is HEAD', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.head);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });

    test('when method is OPTIONS', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.options);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });

    test('when method is PATCH', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.patch);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });

    test('when method is PUT', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.put);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });
  });

  group('GET /expenses', () {
    test('responds with a 200 and an empty list', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => dataSource.readAll()).thenAnswer((_) async => []);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.ok);
      expect(response.json(), completion(isEmpty));

      verify(() => dataSource.readAll()).called(1);
    });

    test('responds with a 200 and a populated list', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => dataSource.readAll()).thenAnswer((_) async => [expense]);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.ok);
      expect(response.json(), completion(equals([expense.toJson()])));

      verify(() => dataSource.readAll()).called(1);
    });
  });

  group('POST /expenses', () {
    test('responds with a 201 and the newly created Expense', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.json()).thenAnswer((_) async => expense.toJson());
      when(() => dataSource.create(any())).thenAnswer((_) async => expense);

      // Act
      final response = await route.onRequest(context);

      // Assert
      expect(response.statusCode, HttpStatus.created);
      expect(response.json(), completion(equals(expense.toJson())));
      verify(() => dataSource.create(any())).called(1);
    });
  });
}
