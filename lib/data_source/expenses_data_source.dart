import 'package:xpns_trckr_api/models/expense.dart';

/// An interface for an expenses data source.
/// An expenses data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class ExpensesDataSource {
  /// Create and return the newly created [Expense].
  Future<void> create(Expense expense);

  /// Return all [Expense]s.
  Future<List<Expense>> readAll();

  /// Return a [Expense] with the provided [id] if one exists.
  Future<Expense?> read(int id);

  /// Update the [Expense] with the provided [id] to match [expense] and
  /// return the updated todo.
  Future<void> update(int id, Expense expense);

  /// Delete the [Expense] with the provided [id] if one exists.
  Future<void> delete(int id);
}
