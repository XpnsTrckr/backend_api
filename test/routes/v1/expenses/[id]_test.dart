import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:expense/expense.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../../routes/v1/expenses/[id].dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockExpensesRepository extends Mock implements ExpenseRepository {}

void main() {
  late RequestContext context;
  late Request request;
  late ExpenseRepository repository;

  const query = '42';
  const id = 42;
  final expense = Expense(
    id: id,
    userId: 84,
    description: 'meaningful description',
    value: 128,
    time: DateTime.now(),
  );

  setUpAll(() => registerFallbackValue(expense));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    repository = _MockExpensesRepository();

    when(() => context.read<ExpenseRepository>()).thenReturn(repository);
    when(() => context.request).thenReturn(request);
  });

  group('responds with a 405', () {
    setUp(() {
      when(() => repository.read(any())).thenAnswer((_) async => expense);
    });

    test('when method is HEAD', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.head);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is OPTIONS', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.options);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PATCH', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.patch);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is POST', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.post);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });

  group('responds with a 400', () {
    test('when query is not a valid id', () async {
      // Arrange
      const invalid = 'not a valid query';
      when(() => request.method).thenReturn(HttpMethod.get);

      // Act
      final response = await route.onRequest(context, invalid);

      // Assert
      expect(response.statusCode, equals(HttpStatus.badRequest));

      verifyNever(() => repository.read(any()));
    });
  });

  group('responds with a 404', () {
    test('when no expense is found', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => repository.read(any())).thenAnswer((_) async => null);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.notFound));

      verify(() => repository.read(any(that: equals(id)))).called(1);
    });
  });

  group('GET /expenses/[id]', () {
    test('responds with 200 when expense is found', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => repository.read(any())).thenAnswer((_) async => expense);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(expense.toJson())));

      verify(() => repository.read(any(that: equals(id)))).called(1);
    });
  });

  group('PUT /expenses/[id]', () {
    test('responds with 200 and updates the expense', () async {
      // Arrange
      final updated = expense.copyWith(description: 'Updated!');

      when(() => request.method).thenReturn(HttpMethod.put);
      when(() => request.json()).thenAnswer((_) async => updated.toJson());

      when(() => repository.read(any())).thenAnswer((_) async => expense);
      when(() => repository.update(any(), any()))
          .thenAnswer((_) async => updated);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(updated.toJson())));

      verify(() => repository.read(any(that: equals(id)))).called(1);
      verify(
        () => repository.update(
          any(that: equals(id)),
          any(that: equals(updated)),
        ),
      ).called(1);
    });
  });

  group('DELETE /expenses/[id]', () {
    test('responds with 204 and deletes the expense', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.delete);
      when(() => repository.read(any())).thenAnswer((_) async => expense);
      when(() => repository.delete(any())).thenAnswer((_) async {});

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.noContent));
      expect(response.body(), completion(isEmpty));

      verify(() => repository.read(any(that: equals(id)))).called(1);
      verify(() => repository.delete(any(that: equals(id)))).called(1);
    });
  });
}
