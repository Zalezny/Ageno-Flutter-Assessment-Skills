import 'package:ageno_flutter_assessment_skills/features/product/domain/entities/product.dart';
import 'package:ageno_flutter_assessment_skills/features/product/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/category_type.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {

  /// Mock data for products (borrowed from Amazon)
  final List<Product> _products = [
    Product(
      id: Uuid().v4(),
      name: 'Bezprzewodowe Apple AirPods Pro 2',
      price: 1299.99,
      imageUrl: 'https://m.media-amazon.com/images/I/51HCs2mVKsL._AC_SL1500_.jpg',
      description: 'Słuchawkami AirPods Pro dyryguje stworzony przez Apple czip H2.',
      brand: 'Apple',
      category: CategoryType.headphones,
    ),
    Product(
      id: Uuid().v4(),
      name: 'Bezprzewodowe słuchawki soundcore od Anker P20i',
      price: 89.99,
      imageUrl: 'https://m.media-amazon.com/images/I/51s68TPVLpL._AC_SL1500_.jpg',
      description: 'Potężny bas: całkowicie bezprzewodowe słuchawki douszne soundcore P20i',
      brand: 'Anker',
      category: CategoryType.headphones,
    ),
    Product(
      id: Uuid().v4(),
      name: 'Edifier S3000PRO Głośnik, Drewno, 2 Sztuki',
      price: 3004.23,
      imageUrl: 'https://m.media-amazon.com/images/I/51QLn7JMdNL._AC_UL480_FMwebp_QL65_.jpg',
      description: 'Aktywny głośnik z regulatorami głośności, basów i wysokich tonów',
      brand: 'Edifier',
      category: CategoryType.speakers,
    ),
    Product(
      id: Uuid().v4(),
      name: 'Bose 700 834402-2100 Głośnik',
      price: 2027.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71sJ7RC32TL._AC_SL1500_.jpg',
      description: 'Design i dźwięk głośników są dokładnie dopasowane',
      brand: 'Bose',
      category: CategoryType.speakers,
    ),
    Product(
      id: Uuid().v4(),
      name: 'ULTIMEA 5.1 Surround Sound System',
      price: 199.99,
      imageUrl: 'https://m.media-amazon.com/images/I/618lpetC-DL._AC_SL1500_.jpg',
      description: 'Wodoodporny głośnik przenośny z długim czasem pracy baterii',
      brand: 'ULTIMEA',
      category: CategoryType.speakers,
    ),
  ];

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
