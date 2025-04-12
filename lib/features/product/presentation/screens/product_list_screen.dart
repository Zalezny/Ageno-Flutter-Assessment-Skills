import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/category_type.dart';
import '../../../../gen/assets.gen.dart';
import '../../../cart/presentation/widgets/cart_button.dart';
import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import '../widgets/sliver_category_bar_delegate.dart';

final selectedCategoryProvider = StateProvider<CategoryType?>((ref) => null);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  return productsAsync.when(
    data: (products) {
      if (selectedCategory == null || selectedCategory == CategoryType.all) {
        return products;
      } else {
        return products.where((product) => product.category == selectedCategory).toList();
      }
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

bool isTablet(BuildContext context) {
  final data = MediaQuery.of(context);
  final shortestSide = data.size.shortestSide;
  return shortestSide >= 600;
}

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  bool _showTrolley = false;
  double _imageHeight = 0;
  final double _collapsedOffset = 50;
  final double _categoryBarHeight = 50;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final bool isCollapsed = _scrollController.offset > _imageHeight - _collapsedOffset;
      final bool showTrolley = _scrollController.offset > _imageHeight + _categoryBarHeight + _collapsedOffset;
      if (isCollapsed != _isCollapsed) {
        setState(() {
          _isCollapsed = isCollapsed;
        });
      }
      if (showTrolley != _showTrolley) {
        setState(() {
          _showTrolley = showTrolley;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _imageHeight = MediaQuery.of(context).size.height * 0.25;

    final asyncProducts = ref.watch(productsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: asyncProducts.when(
        data: (products) => _buildProductList(context, products),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Wystąpił błąd: $error')),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, List<Product> products) {
    if (products.isEmpty) {
      return const Center(child: Text('Brak produktów do wyświetlenia'));
    }

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final filteredProducts = ref.watch(filteredProductsProvider);
    final crossAxisSpacing = isLandscape ? 20 : 10;
    final mainAxisSpacing = isLandscape ? 20 : 10;

    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: _imageHeight,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 1,
            snap: false,
            stretch: true,
            toolbarHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Elektronika",
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: _isCollapsed ? Colors.black : Colors.white),
                      ),
                    ),
                    if (_showTrolley) CartButton(),
                  ],
                ),
              ),
              background: Stack(
                children: [
                  Positioned.fill(child: Image.asset(Assets.images.electronicPicture.path, fit: BoxFit.cover)),
                  Positioned.fill(child: Container(color: Colors.black.withAlpha(85))),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(pinned: false, delegate: SliverCategoryBarDelegate(height: _categoryBarHeight, products: products)),
        ];
      },
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Liczba produktów: ${filteredProducts.length}"), CartButton()],
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLandscape ? 4 : 2,
                childAspectRatio: isLandscape && !isTablet(context) ? 0.35 : 0.4,
                crossAxisSpacing: crossAxisSpacing.toDouble(),
                mainAxisSpacing: mainAxisSpacing.toDouble(),
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductItem(product: filteredProducts[index]);
              }, childCount: filteredProducts.length),
            ),
          ),
        ],
      ),
    );
  }
}
