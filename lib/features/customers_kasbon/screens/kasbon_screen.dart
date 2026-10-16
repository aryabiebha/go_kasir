import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pos_button.dart';
import '../../../shared/widgets/pos_card.dart';
import '../../../shared/widgets/pos_search_bar.dart';
import '../../../shared/widgets/pos_status_badge.dart';
import '../../../shared/widgets/rupiah_text.dart';

/// Kasbon / Customer Credit & Receivable Ledger screen placeholder for Phase 01.
class KasbonScreen extends StatelessWidget {
  const KasbonScreen({super.key});

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
                    hintText: 'Cari nama pelanggan kasbon...',
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                PosButton.primary(
                  label: 'Catat Kasbon Baru',
                  icon: Icons.person_add_alt_1_rounded,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: ListView(
                children: [
                  _buildCustomerTile('Bu Siti (RT 03)', '0812-3456-7890', 125000, 'Jatuh Tempo: 3 Hari Lagi', PosStatusType.kasbon),
                  const SizedBox(height: AppSpacing.sm),
                  _buildCustomerTile('Pak Joko (Bengkel)', '0813-9876-5432', 80000, 'Cicilan ke-2 dari 3', PosStatusType.cicilan),
                  const SizedBox(height: AppSpacing.sm),
                  _buildCustomerTile('Mbak Maya', '0857-1122-3344', 0, 'Lunas Kemarin', PosStatusType.lunas),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerTile(String name, String phone, int debtAmount, String note, PosStatusType status) {
    return PosCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.0,
            backgroundColor: AppColors.surfaceContainer,
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.deepForest),
            ),
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
                  '$phone • $note',
                  style: const TextStyle(fontSize: 12.0, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          PosStatusBadge.fromType(status),
          const SizedBox(width: AppSpacing.lg),
          RupiahText.medium(
            amount: debtAmount,
            color: debtAmount > 0 ? AppColors.danger : AppColors.success,
          ),
        ],
      ),
    );
  }
}
