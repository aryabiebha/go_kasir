import 'package:flutter/material.dart';
import '../../../core/layout/adaptive_breakpoints.dart';
import '../../../core/layout/adaptive_split_view.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pos_button.dart';
import '../../../shared/widgets/pos_card.dart';
import '../../../shared/widgets/pos_search_bar.dart';
import '../../../shared/widgets/pos_status_badge.dart';
import '../../../shared/widgets/rupiah_text.dart';

/// POS Checkout Screen with Adaptive Phone and Tablet Split View.
class PosScreen extends StatefulWidget {
  const PosScreen({super.key});

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  // Sample catalog items for architectural demonstration
  final List<Map<String, dynamic>> _catalog = [
    {'name': 'Beras Ramos 5kg', 'price': 68500, 'stock': 24, 'barcode': '89912345601'},
    {'name': 'Minyak Goreng 2L', 'price': 34000, 'stock': 18, 'barcode': '89912345602'},
    {'name': 'Gula Pasir 1kg', 'price': 17500, 'stock': 40, 'barcode': '89912345603'},
    {'name': 'Telur Ayam 1kg', 'price': 28000, 'stock': 15, 'barcode': '89912345604'},
    {'name': 'Mie Instan Goreng', 'price': 3100, 'stock': 96, 'barcode': '89912345605'},
    {'name': 'Kopi Bubuk 165g', 'price': 14000, 'stock': 32, 'barcode': '89912345606'},
  ];

  // Demo active cart state
  final List<Map<String, dynamic>> _cart = [
    {'name': 'Beras Ramos 5kg', 'price': 68500, 'qty': 1},
    {'name': 'Minyak Goreng 2L', 'price': 34000, 'qty': 2},
    {'name': 'Gula Pasir 1kg', 'price': 17500, 'qty': 1},
  ];

  int get _cartTotal => _cart.fold(0, (sum, item) => sum + (item['price'] as int) * (item['qty'] as int));

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      final index = _cart.indexWhere((c) => c['name'] == item['name']);
      if (index >= 0) {
        _cart[index]['qty'] = (_cart[index]['qty'] as int) + 1;
      } else {
        _cart.add({'name': item['name'], 'price': item['price'], 'qty': 1});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveSplitView(
      primaryFlex: 6,
      secondaryFlex: 4,
      primary: _buildCatalogPane(),
      secondary: _buildCartPane(),
      phoneBuilder: (context, primary, secondary) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(child: primary),
                const SizedBox(height: 72.0), // Spacer for bottom bar
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildPhoneCartBar(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCatalogPane() {
    return Container(
      color: AppColors.surfaceBackground,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PosSearchBar(
            hintText: 'Cari produk (nama / scan barcode)...',
            onScanBarcodePressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanner Barcode siap dihubungkan (Phase 03)')),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isTablet ? 3 : 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: context.isTablet ? 1.05 : 0.85,
              ),
              itemCount: _catalog.length,
              itemBuilder: (context, index) {
                final item = _catalog[index];
                return PosCard(
                  onTap: () => _addToCart(item),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Stok: ${item['stock']}',
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RupiahText.medium(
                              amount: item['price'] as int,
                              color: AppColors.pineGreen,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Container(
                            padding: const EdgeInsets.all(AppSpacing.xs),
                            decoration: const BoxDecoration(
                              color: AppColors.mintCream,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, size: 18.0, color: AppColors.deepForest),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartPane() {
    return Container(
      color: AppColors.surfaceWhite,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Keranjang Belanja',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.deepForest),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              PosStatusBadge.lunas(label: '${_cart.length} Item'),
            ],
          ),
          const Divider(height: 24.0),
          Expanded(
            child: _cart.isEmpty
                ? const Center(
                    child: Text('Keranjang kosong', style: TextStyle(color: AppColors.textMuted)),
                  )
                : ListView.separated(
                    itemCount: _cart.length,
                    separatorBuilder: (context, index) => const Divider(height: 16.0),
                    itemBuilder: (context, index) {
                      final item = _cart[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  '${item['qty']} x',
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          RupiahText.small(
                            amount: (item['price'] as int) * (item['qty'] as int),
                            color: AppColors.deepForest,
                          ),
                        ],
                      );
                    },
                  ),
          ),
          const Divider(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TOTAL', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0)),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: RupiahText.large(amount: _cartTotal, color: AppColors.pineGreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: PosButton.secondary(
                  label: 'Kasbon',
                  icon: Icons.account_balance_wallet_rounded,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: PosButton.primary(
                  label: 'Bayar Tunai',
                  icon: Icons.payments_rounded,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneCartBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14051F20),
            offset: Offset(0, -2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_cart.length} Item di Keranjang',
                  style: const TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                RupiahText.medium(amount: _cartTotal, color: AppColors.pineGreen),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          PosButton.primary(
            label: 'Checkout',
            icon: Icons.shopping_cart_checkout_rounded,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Total Checkout: $_cartTotal')),
              );
            },
          ),
        ],
      ),
    );
  }
}
