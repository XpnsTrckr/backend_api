// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_base.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  /// The unique identifier of the expense.
  int get id => throw _privateConstructorUsedError;

  /// The user whose this expense belongs to.
  int get userId => throw _privateConstructorUsedError;

  /// Briefly description about what were expended.
  String get description => throw _privateConstructorUsedError;

  /// How much the user expend with this expense.
  double get value => throw _privateConstructorUsedError;

  /// When the user created this expense.
  DateTime get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {int id, int userId, String description, double value, DateTime time});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? description = null,
    Object? value = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpenseCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$_ExpenseCopyWith(
          _$_Expense value, $Res Function(_$_Expense) then) =
      __$$_ExpenseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, int userId, String description, double value, DateTime time});
}

/// @nodoc
class __$$_ExpenseCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$_Expense>
    implements _$$_ExpenseCopyWith<$Res> {
  __$$_ExpenseCopyWithImpl(_$_Expense _value, $Res Function(_$_Expense) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? description = null,
    Object? value = null,
    Object? time = null,
  }) {
    return _then(_$_Expense(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Expense implements _Expense {
  const _$_Expense(
      {required this.id,
      required this.userId,
      required this.description,
      required this.value,
      required this.time});

  factory _$_Expense.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseFromJson(json);

  /// The unique identifier of the expense.
  @override
  final int id;

  /// The user whose this expense belongs to.
  @override
  final int userId;

  /// Briefly description about what were expended.
  @override
  final String description;

  /// How much the user expend with this expense.
  @override
  final double value;

  /// When the user created this expense.
  @override
  final DateTime time;

  @override
  String toString() {
    return 'Expense(id: $id, userId: $userId, description: $description, value: $value, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Expense &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, description, value, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpenseCopyWith<_$_Expense> get copyWith =>
      __$$_ExpenseCopyWithImpl<_$_Expense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseToJson(
      this,
    );
  }
}

abstract class _Expense implements Expense {
  const factory _Expense(
      {required final int id,
      required final int userId,
      required final String description,
      required final double value,
      required final DateTime time}) = _$_Expense;

  factory _Expense.fromJson(Map<String, dynamic> json) = _$_Expense.fromJson;

  @override

  /// The unique identifier of the expense.
  int get id;
  @override

  /// The user whose this expense belongs to.
  int get userId;
  @override

  /// Briefly description about what were expended.
  String get description;
  @override

  /// How much the user expend with this expense.
  double get value;
  @override

  /// When the user created this expense.
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseCopyWith<_$_Expense> get copyWith =>
      throw _privateConstructorUsedError;
}
