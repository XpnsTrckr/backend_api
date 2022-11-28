import 'package:expense/expense.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:in_memory_expense_repository/in_memory_expense_repository.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryExpensesDataSource', () {
    late ExpenseRepository repository;
    const id = 42;
    final expense = Expense(
      id: id,
      userId: 84,
      description: 'meaningful description',
      value: 128,
      time: DateTime.now(),
    );

    setUp(() => repository = InMemoryExpensesRepository());

    group('create', () {
      test('returns the newly created expense', () async {
        // Act
        final created = await repository.create(expense);

        // Assert
        expect(created, isNot(same(expense)));
        expect(created, equals(expense));
      });
    });

    group('readAll', () {
      test('returns an empty list when there are no expenses', () {
        expect(repository.readAll(), completion(isEmpty));
      });

      test('returns a populated list when there are expenses', () async {
        // Act
        await repository.create(expense);

        // Assert
        expect(repository.readAll(), completion(equals([expense])));
      });
    });

    group('read', () {
      test('return null when expense does not exist', () {
        expect(repository.read(id), completion(isNull));
      });

      test('returns a expense when it exists', () async {
        // Act
        await repository.create(expense);

        // Assert
        expect(repository.read(id), completion(equals(expense)));
      });
    });

    group('update', () {
      test('returns the updated expense when it does exist', () async {
        // Arrange
        final newExpense = expense.copyWith(description: 'Updated!');

        // Act
        final created = await repository.create(expense);
        final updated = await repository.update(id, newExpense);

        // Assert
        expect(repository.readAll(), completion(equals([updated])));
        expect(updated, equals(newExpense));
        expect(updated, isNot(equals(created)));
      });
    });

    group('delete', () {
      test('removes the expense when it does exist', () async {
        // Act
        await repository.create(expense);
        await repository.delete(id);

        // Assert
        expect(repository.readAll(), completion(isEmpty));
      });
    });
  });
}
