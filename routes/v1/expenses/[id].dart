import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:xpns_trckr_api/data_source/expenses_data_source.dart';
import 'package:xpns_trckr_api/models/expense.dart';

FutureOr<Response> onRequest(RequestContext context, String query) async {
  final uid = int.tryParse(query);

  if (uid == null) {
    return Response(
      statusCode: HttpStatus.badRequest,
      body: 'Query ID must be an integer',
    );
  }

  final dataSource = context.read<ExpensesDataSource>();
  final expense = await dataSource.read(uid);

  if (expense == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return Response.json(body: expense);
    case HttpMethod.put:
      return _put(context, uid);
    case HttpMethod.delete:
      return _delete(context, uid);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _put(RequestContext context, int uid) async {
  final dataSource = context.read<ExpensesDataSource>();
  final json = context.request.json() as Map<String, dynamic>;
  final expense = Expense.fromJson(json);

  await dataSource.update(uid, expense);

  return Response.json(body: expense);
}

Future<Response> _delete(RequestContext context, int uid) async {
  final dataSource = context.read<ExpensesDataSource>();
  await dataSource.delete(uid);

  return Response(statusCode: HttpStatus.noContent);
}
