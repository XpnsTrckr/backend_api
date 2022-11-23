import 'package:test/test.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/data_source/in_memory_expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

void main() {
  group('InMemoryExpensesDataSource', () {
    late ExpensesDataSource dataSource;
    const id = 42;
    final expense = Expense(
      id: id,
      userId: 84,
      description: 'meaningful description',
      value: 128,
      time: DateTime.now(),
    );

    setUp(() => dataSource = InMemoryExpensesDataSource());

    group('create', () {
      test('returns the newly created expense', () async {
        // Act
        final created = await dataSource.create(expense);

        // Assert
        expect(created, isNot(same(expense)));
        expect(created, equals(expense));
      });
    });

    group('readAll', () {
      test('returns an empty list when there are no expenses', () {
        expect(dataSource.readAll(), completion(isEmpty));
      });

      test('returns a populated list when there are expenses', () async {
        // Act
        await dataSource.create(expense);

        // Assert
        expect(dataSource.readAll(), completion(equals([expense])));
      });
    });

    group('read', () {
      test('return null when expense does not exist', () {
        expect(dataSource.read(id), completion(isNull));
      });

      test('returns a expense when it exists', () async {
        // Act
        await dataSource.create(expense);

        // Assert
        expect(dataSource.read(id), completion(equals(expense)));
      });
    });

    group('update', () {
      test('returns the updated expense when it does exist', () async {
        // Arrange
        final newExpense = expense.copyWith(description: 'Updated!');

        // Act
        final created = await dataSource.create(expense);
        final updated = await dataSource.update(id, newExpense);

        // Assert
        expect(dataSource.readAll(), completion(equals([updated])));
        expect(updated, equals(newExpense));
        expect(updated, isNot(equals(created)));
      });
    });

    group('delete', () {
      test('removes the expense when it does exist', () async {
        // Act
        await dataSource.create(expense);
        await dataSource.delete(id);

        // Assert
        expect(dataSource.readAll(), completion(isEmpty));
      });
    });
  });
}
