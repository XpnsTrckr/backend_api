import 'package:expense/expense.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:test/test.dart';

class _ExpensesDataSource implements ExpensesDataSource {
  @override
  Future<Expense> create(Expense expense) => throw UnimplementedError();

  @override
  Future<void> delete(int id) => throw UnimplementedError();

  @override
  Future<Expense?> read(int id) => throw UnimplementedError();

  @override
  Future<List<Expense>> readAll() => throw UnimplementedError();

  @override
  Future<Expense> update(int id, Expense expense) => throw UnimplementedError();
}

void main() {
  group('ExpensesDataSource', () {
    test('can be implemented', () => expect(_ExpensesDataSource(), isNotNull));
  });
}
