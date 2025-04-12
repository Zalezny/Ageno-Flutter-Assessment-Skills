import 'package:ageno_flutter_assessment_skills/features/cart/presentation/widgets/cart_promo_code_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../domain/entities/cart_item.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_items_list.dart';
import '../widgets/cart_total_section.dart';
import '../widgets/clear_cart_button.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCartItems = ref.watch(cartProvider).items;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      resizeToAvoidBottomInset: !isLandscape,
      appBar: AppBar(
        title: Text(LocaleKeys.cart.tr()),
        centerTitle: true,
        actions: [CartClearButton()],
      ),
      body: _buildCartContent(context, asyncCartItems, isLandscape),
    );
  }

  Widget _buildCartContent(
    BuildContext context,
    AsyncValue<List<CartItem>> asyncCartItems,
    bool isLandscape,
  ) {
    return asyncCartItems.when(
      data: (cartItems) {
        print('cartItems: $cartItems');
        if (cartItems.isEmpty) {
          return Center(child: Text(LocaleKeys.emptyCart.tr()));
        }

        return isLandscape
            ? _buildLandscapeLayout(cartItems)
            : _buildPortraitLayout(cartItems);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(child: Text(LocaleKeys.cartLoadError.tr())),
    );
  }

  Widget _buildLandscapeLayout(List<CartItem> cartItems) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 3, child: CartItemsList(cartItems: cartItems)),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const CartPromoCodeSection(),
              const Expanded(child: CartTotalSection(useCenter: true)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(List<CartItem> cartItems) {
    return Column(
      children: [
        Expanded(child: CartItemsList(cartItems: cartItems)),
        const CartPromoCodeSection(),
        const CartTotalSection(),
      ],
    );
  }
}
