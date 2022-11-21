import 'package:dart_frog/dart_frog.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/data_source/in_memory_expenses_data_source.dart';

final _dataSource = InMemoryExpensesDataSource();

Handler middleware(Handler handler) => handler
    .use(requestLogger())
    .use(provider<ExpensesDataSource>((_) => _dataSource));
