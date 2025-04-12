// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:uuid/uuid.dart' as _i706;

import '../../features/product/data/repositories/product_repository_impl.dart'
    as _i1040;
import '../../features/product/domain/repositories/product_repository.dart'
    as _i39;
import '../../features/product/domain/usecases/get_product_by_id.dart' as _i894;
import '../../features/product/domain/usecases/get_products.dart' as _i279;
import 'modules/uuid_module.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final uuidModule = _$UuidModule();
    gh.lazySingleton<_i706.Uuid>(() => uuidModule.uuid);
    gh.lazySingleton<_i39.ProductRepository>(
      () => _i1040.ProductRepositoryImpl(uuid: gh<_i706.Uuid>()),
    );
    gh.factory<_i279.GetProducts>(
      () => _i279.GetProducts(gh<_i39.ProductRepository>()),
    );
    gh.factory<_i894.GetProductById>(
      () => _i894.GetProductById(gh<_i39.ProductRepository>()),
    );
    return this;
  }
}

class _$UuidModule extends _i913.UuidModule {}
