import 'package:dart_frog/dart_frog.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:in_memory_expense_repository/in_memory_expense_repository.dart';

final _repository = InMemoryExpensesRepository();

/// Middleware used for version 1.
Handler middleware(Handler handler) =>
    handler.use(provider<ExpenseRepository>((_) => _repository));
