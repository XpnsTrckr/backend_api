import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.freezed.dart';
part 'expense.g.dart';

/// A single expense item.
///
/// Contains a [value] and a [time], in addition to [id] and [userId], detailing
/// further this [Expense] item.
///
/// [Expense]s are immutable and can be copied using [copyWith], in addition to
/// being json de/serializable.
@freezed
class Expense with _$Expense {
  /// Creates a new [Expense].
  const factory Expense({
    /// The unique identifier of the expense.
    required int id,

    /// The user whose this expense belongs to.
    required int userId,

    /// Briefly description about what were expended.
    required String description,

    /// How much the user expend with this expense.
    required double value,

    /// When the user created this expense.
    required DateTime time,
  }) = _Expense;

  /// Deserializes the given `Map<String, dynamic>` into a [Expense].
  factory Expense.fromJson(Map<String, Object?> json) =>
      _$ExpenseFromJson(json);
}
