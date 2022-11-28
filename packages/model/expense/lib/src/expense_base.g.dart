// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Expense _$$_ExpenseFromJson(Map<String, dynamic> json) => _$_Expense(
      id: json['id'] as int,
      userId: json['userId'] as int,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'value': instance.value,
      'time': instance.time.toIso8601String(),
    };
