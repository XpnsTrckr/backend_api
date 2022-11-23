import 'package:test/test.dart';
import 'package:xpns_trckr_api/models/expense.dart';

void main() {
  group('Expense model', () {
    const id = 42;
    const userId = 84;
    const description = 'meaningful description';
    const value = 128.0;
    final time = DateTime.now();

    Expense create() => Expense(
          id: id,
          userId: userId,
          description: description,
          value: value,
          time: time,
        );

    Map<String, dynamic> json() => <String, dynamic>{
          'id': id,
          'userId': userId,
          'description': description,
          'value': value,
          'time': time.toIso8601String(),
        };

    group('constructor', () {
      test('creates correctly', () => expect(create, returnsNormally));
    });

    group('equality', () {
      test('compared by value', () => expect(create(), equals(create())));
      test('with correct props', () {
        expect(create().props, equals([id, userId, description, value, time]));
      });
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(create().copyWith(), equals(create()));
      });
      test('replaces every non-null parameter', () {
        expect(
          create().copyWith(
            id: 1,
            userId: 1,
            description: 'new',
            value: 1,
            time: time.add(const Duration(seconds: 2)),
          ),
          equals(
            Expense(
              id: 1,
              userId: 1,
              description: 'new',
              value: 1,
              time: time.add(const Duration(seconds: 2)),
            ),
          ),
        );
      });
    });

    group('fromJson', () {
      test('maps correctly', () {
        expect(Expense.fromJson(json()), equals(create()));
      });
    });

    group('toJson', () {
      test('maps correctly', () => expect(create().toJson(), json()));
    });
  });
}
