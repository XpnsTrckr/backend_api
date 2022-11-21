import 'package:dart_frog/dart_frog.dart';

/// Middleware used for all versions.
Handler middleware(Handler handler) => handler.use(requestLogger());
