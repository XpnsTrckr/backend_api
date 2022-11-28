import 'package:expense/expense.dart';

/// An interface for an expense repository.
/// An expense repository supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class ExpenseRepository {
  /// Create and return the newly created [Expense].
  Future<Expense> create(Expense expense);

  /// Return all [Expense]s.
  Future<List<Expense>> readAll();

  /// Return a [Expense] with the provided [id] if one exists.
  Future<Expense?> read(int id);

  /// Update the [Expense] with the provided [id] to match [expense] and
  /// return the updated todo.
  Future<Expense> update(int id, Expense expense);

  /// Delete the [Expense] with the provided [id] if one exists.
  Future<void> delete(int id);
}
