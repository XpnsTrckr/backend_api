import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

import '../../../../routes/v1/expenses/[id].dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockExpensesDataSource extends Mock implements ExpensesDataSource {}

void main() {
  late RequestContext context;
  late Request request;
  late ExpensesDataSource dataSource;

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
    dataSource = _MockExpensesDataSource();

    when(() => context.read<ExpensesDataSource>()).thenReturn(dataSource);
    when(() => context.request).thenReturn(request);
  });

  group('responds with a 405', () {
    setUp(() {
      when(() => dataSource.read(any())).thenAnswer((_) async => expense);
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
      when(() => request.method).thenReturn(HttpMethod.get);
      const invalid = 'not a valid query';

      // Act
      final response = await route.onRequest(context, invalid);

      // Assert
      expect(response.statusCode, equals(HttpStatus.badRequest));

      verifyNever(() => dataSource.read(any()));
    });
  });

  group('responds with a 404', () {
    test('when no expense is found', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => dataSource.read(any())).thenAnswer((_) async => null);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.notFound));
      verify(() => dataSource.read(any(that: equals(id)))).called(1);
    });
  });

  group('GET /expenses/[id]', () {
    test('responds with 200 when expense is found', () async {
      // Arrange
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => dataSource.read(any())).thenAnswer((_) async => expense);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(expense.toJson())));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
    });
  });

  group('PUT /expenses/[id]', () {
    test('responds with 200 and updates the expense', () async {
      // Arrange
      final updated = expense.copyWith(description: 'Updated!');

      when(() => request.method).thenReturn(HttpMethod.put);
      when(() => request.json()).thenAnswer((_) async => updated.toJson());

      when(() => dataSource.read(any())).thenAnswer((_) async => expense);
      when(() => dataSource.update(any(), any()))
          .thenAnswer((_) async => updated);

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(updated.toJson())));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
      verify(
        () => dataSource.update(
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
      when(() => dataSource.read(any())).thenAnswer((_) async => expense);
      when(() => dataSource.delete(any())).thenAnswer((_) async {});

      // Act
      final response = await route.onRequest(context, query);

      // Assert
      expect(response.statusCode, equals(HttpStatus.noContent));
      expect(response.body(), completion(isEmpty));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
      verify(() => dataSource.delete(any(that: equals(id)))).called(1);
    });
  });
}
