import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final dataSource = context.read<ExpensesDataSource>();
  final expenses = await dataSource.readAll();
  return Response.json(body: expenses);
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<ExpensesDataSource>();
  final json = await context.request.json() as Map<String, dynamic>;
  final expense = Expense.fromJson(json);

  await dataSource.create(expense);

  return Response.json(
    statusCode: HttpStatus.created,
    body: expense.toJson(),
  );
}
