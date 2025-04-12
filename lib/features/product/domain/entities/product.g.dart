// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  description: json['description'] as String?,
  brand: json['brand'] as String?,
  category: $enumDecodeNullable(_$CategoryTypeEnumMap, json['category']),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'description': instance.description,
  'brand': instance.brand,
  'category': _$CategoryTypeEnumMap[instance.category],
};

const _$CategoryTypeEnumMap = {
  CategoryType.headphones: 'HEADPHONES',
  CategoryType.speakers: 'SPEAKERS',
  CategoryType.all: 'ALL',
};
