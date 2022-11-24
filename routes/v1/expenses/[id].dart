import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

FutureOr<Response> onRequest(RequestContext context, String query) async {
  final id = int.tryParse(query);

  if (id == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Query ID must be an integer',
    );
  }

  final dataSource = context.read<ExpensesDataSource>();
  final expense = await dataSource.read(id);

  if (expense == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return Response.json(body: expense);
    case HttpMethod.put:
      return _put(context, id);
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _put(RequestContext context, int id) async {
  final dataSource = context.read<ExpensesDataSource>();
  final json = await context.request.json() as Map<String, dynamic>;
  final expense = Expense.fromJson(json);

  final updated = await dataSource.update(id, expense);

  return Response.json(body: updated);
}

Future<Response> _delete(RequestContext context, int id) async {
  final dataSource = context.read<ExpensesDataSource>();

  await dataSource.delete(id);

  return Response(statusCode: HttpStatus.noContent);
}
