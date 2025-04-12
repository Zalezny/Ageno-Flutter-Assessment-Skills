import 'package:injectable/injectable.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<Product?> call(String id) async {
    return await repository.getProductById(id);
  }
}
