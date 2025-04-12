import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../providers/cart_provider.dart';

class CartPromoCodeSection extends ConsumerWidget {
  const CartPromoCodeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedPromoCode = ref.watch(cartProvider).appliedPromoCode;
    final isPromoCodeValid = ref.watch(cartProvider).isPromoCodeValid;
    final TextEditingController promoController = TextEditingController(
      text: appliedPromoCode,
    );
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: isLandscape ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (appliedPromoCode == null)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: promoController,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.enterPromoCode.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    if (promoController.text.isNotEmpty) {
                      ref
                          .read(cartProvider.notifier)
                          .applyPromoCode(promoController.text);
                    }
                  },
                  child: Text(LocaleKeys.apply.tr()),
                ),
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(
                    isPromoCodeValid ? Icons.check_circle : Icons.error,
                    color: isPromoCodeValid ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isPromoCodeValid
                          ? LocaleKeys.promoCodeApplied.tr(
                            args: [appliedPromoCode],
                          )
                          : LocaleKeys.promoCodeInvalid.tr(
                            args: [appliedPromoCode],
                          ),
                      style: TextStyle(
                        color: isPromoCodeValid ? Colors.green : Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).removePromoCode();
                    },
                    child: Text(LocaleKeys.remove.tr()),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
