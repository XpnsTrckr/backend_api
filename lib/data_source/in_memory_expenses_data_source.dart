import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

/// An in-memory implementation of the [ExpensesDataSource] interface.
class InMemoryExpensesDataSource extends ExpensesDataSource {
  /// Map of ID -> Todo
  final _cache = <int, Expense>{};

  @override
  Future<Expense> create(Expense expense) async {
    final created = expense.copyWith();
    _cache[created.id] = created;
    return created;
  }

  @override
  Future<List<Expense>> readAll() async => _cache.values.toList();

  @override
  Future<Expense?> read(int id) async => _cache[id];

  @override
  Future<Expense> update(int id, Expense expense) async =>
      _cache.update(id, (value) => expense);

  @override
  Future<void> delete(int id) async => _cache.remove(id);
}
