// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: json['id'] as String,
  name: json['name'] as String,
  imageUrl: json['imageUrl'] as String,
  price: (json['price'] as num).toDouble(),
  stock: (json['stock'] as num).toInt(),
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'price': instance.price,
  'stock': instance.stock,
};
