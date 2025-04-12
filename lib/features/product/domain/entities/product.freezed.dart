// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

 String get id; String get name; double get price; String get imageUrl; String? get description; String? get promoCode; double? get promoCodeDiscount; double? get discountPercentage; bool? get isNew; String? get brand; CategoryType? get category;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.promoCodeDiscount, promoCodeDiscount) || other.promoCodeDiscount == promoCodeDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,description,promoCode,promoCodeDiscount,discountPercentage,isNew,brand,category);

@override
String toString() {
  return 'Product(id: $id, name: $name, price: $price, imageUrl: $imageUrl, description: $description, promoCode: $promoCode, promoCodeDiscount: $promoCodeDiscount, discountPercentage: $discountPercentage, isNew: $isNew, brand: $brand, category: $category)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, double price, String imageUrl, String? description, String? promoCode, double? promoCodeDiscount, double? discountPercentage, bool? isNew, String? brand, CategoryType? category
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = null,Object? description = freezed,Object? promoCode = freezed,Object? promoCodeDiscount = freezed,Object? discountPercentage = freezed,Object? isNew = freezed,Object? brand = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,promoCodeDiscount: freezed == promoCodeDiscount ? _self.promoCodeDiscount : promoCodeDiscount // ignore: cast_nullable_to_non_nullable
as double?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,isNew: freezed == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryType?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Product implements Product {
  const _Product({required this.id, required this.name, required this.price, required this.imageUrl, this.description, this.promoCode, this.promoCodeDiscount, this.discountPercentage, this.isNew, this.brand, this.category});
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  String id;
@override final  String name;
@override final  double price;
@override final  String imageUrl;
@override final  String? description;
@override final  String? promoCode;
@override final  double? promoCodeDiscount;
@override final  double? discountPercentage;
@override final  bool? isNew;
@override final  String? brand;
@override final  CategoryType? category;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.promoCode, promoCode) || other.promoCode == promoCode)&&(identical(other.promoCodeDiscount, promoCodeDiscount) || other.promoCodeDiscount == promoCodeDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.isNew, isNew) || other.isNew == isNew)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,imageUrl,description,promoCode,promoCodeDiscount,discountPercentage,isNew,brand,category);

@override
String toString() {
  return 'Product(id: $id, name: $name, price: $price, imageUrl: $imageUrl, description: $description, promoCode: $promoCode, promoCodeDiscount: $promoCodeDiscount, discountPercentage: $discountPercentage, isNew: $isNew, brand: $brand, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double price, String imageUrl, String? description, String? promoCode, double? promoCodeDiscount, double? discountPercentage, bool? isNew, String? brand, CategoryType? category
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? imageUrl = null,Object? description = freezed,Object? promoCode = freezed,Object? promoCodeDiscount = freezed,Object? discountPercentage = freezed,Object? isNew = freezed,Object? brand = freezed,Object? category = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,promoCode: freezed == promoCode ? _self.promoCode : promoCode // ignore: cast_nullable_to_non_nullable
as String?,promoCodeDiscount: freezed == promoCodeDiscount ? _self.promoCodeDiscount : promoCodeDiscount // ignore: cast_nullable_to_non_nullable
as double?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,isNew: freezed == isNew ? _self.isNew : isNew // ignore: cast_nullable_to_non_nullable
as bool?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryType?,
  ));
}


}

// dart format on
