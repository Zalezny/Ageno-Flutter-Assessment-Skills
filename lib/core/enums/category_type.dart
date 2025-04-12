import 'package:freezed_annotation/freezed_annotation.dart';

enum CategoryType {
  @JsonValue('HEADPHONES')
  headphones('Słuchawki'),

  @JsonValue('SPEAKERS')
  speakers('Głośniki'),

  @JsonValue('ALL')
  all('Wszystkie');

  final String label;
  const CategoryType(this.label);

  static CategoryType? fromString(String? value) {
    if (value == null) return null;

    return CategoryType.values.firstWhere((type) => type.label == value, orElse: () => CategoryType.all);
  }
}