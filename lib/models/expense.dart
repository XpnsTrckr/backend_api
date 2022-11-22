import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'expense.g.dart';

/// A single expense item.
///
/// Contains a [value] and a [time], in addition to [id] and [userId], detailing
/// further this [Expense] item.
///
/// [Expense]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized usign [toJson] and [fromJson]
/// respectively.
@immutable
@JsonSerializable()
class Expense extends Equatable {
  /// Creates a new [Expense].
  const Expense({
    required this.id,
    required this.userId,
    required this.description,
    required this.value,
    required this.time,
  });

  /// The unique identifier of the expense.
  ///
  /// Cannot be empty.
  final int id;

  /// The user whose this expense belongs to.
  ///
  /// Cannot be empty.
  final int userId;

  /// Briefly description about what were expended.
  final String description;

  /// How much the user expend with this expense.
  final double value;

  /// When the user created this expense.
  final DateTime time;

  /// Returns a copy of this expense with the given values updated.
  Expense copyWith({
    int? id,
    int? userId,
    String? description,
    double? value,
    DateTime? time,
  }) =>
      Expense(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        description: description ?? this.description,
        value: value ?? this.value,
        time: time ?? this.time,
      );

  /// Deserializes the given `Map<String, dynamic>` into a [Expense].
  static Expense fromJson(Map<String, dynamic> json) => _$ExpenseFromJson(json);

  /// Converts this [Expense] into a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  @override
  List<Object?> get props => [id, userId, description, value, time];
}
