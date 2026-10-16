import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pos_button.dart';
import '../../../shared/widgets/pos_card.dart';
import '../../../shared/widgets/pos_search_bar.dart';
import '../../../shared/widgets/pos_status_badge.dart';
import '../../../shared/widgets/rupiah_text.dart';

/// Product Catalog & Stock Management screen placeholder for Phase 01.
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: PosSearchBar(
                    hintText: 'Cari katalog atau barcode produk...',
                    onScanBarcodePressed: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                PosButton.primary(
                  label: 'Tambah Produk',
                  icon: Icons.add_rounded,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView(
                children: [
                  _buildProductTile('Beras Ramos 5kg', '89912345601', 68500, 24, PosStatusType.stokAman),
                  const SizedBox(height: AppSpacing.sm),
                  _buildProductTile('Minyak Goreng 2L', '89912345602', 34000, 4, PosStatusType.stokMenipis),
                  const SizedBox(height: AppSpacing.sm),
                  _buildProductTile('Gula Pasir 1kg', '89912345603', 17500, 0, PosStatusType.stokHabis),
                  const SizedBox(height: AppSpacing.sm),
                  _buildProductTile('Telur Ayam 1kg', '89912345604', 28000, 15, PosStatusType.stokAman),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTile(String name, String barcode, int price, int stock, PosStatusType status) {
    return PosCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: AppRadius.borderSm,
            ),
            child: const Icon(Icons.inventory_2_outlined, color: AppColors.pineGreen),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Barcode: $barcode • Stok: $stock',
                  style: const TextStyle(fontSize: 12.0, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          PosStatusBadge.fromType(status),
          const SizedBox(width: AppSpacing.lg),
          RupiahText.medium(amount: price, color: AppColors.deepForest),
        ],
      ),
    );
  }
}
