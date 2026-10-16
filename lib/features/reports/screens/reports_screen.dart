import 'package:flutter/material.dart';
import '../../../core/layout/adaptive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pos_card.dart';
import '../../../shared/widgets/pos_status_badge.dart';
import '../../../shared/widgets/rupiah_text.dart';

/// Reports & Transaction History screen placeholder for Phase 01.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;

    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Metric Cards
          if (isTablet)
            Row(
              children: [
                Expanded(
                  child: PosMetricCard(
                    title: 'Omzet Hari Ini',
                    amount: 1450000,
                    icon: Icons.monetization_on_outlined,
                    iconColor: AppColors.success,
                    subtitle: '38 Transaksi',
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PosMetricCard(
                    title: 'Laba Bersih Estimasi',
                    amount: 320000,
                    icon: Icons.trending_up_rounded,
                    iconColor: AppColors.pineGreen,
                    subtitle: 'Margin ~22%',
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: PosMetricCard(
                    title: 'Total Piutang Belum Bayar',
                    amount: 250000,
                    icon: Icons.assignment_late_outlined,
                    iconColor: AppColors.danger,
                    subtitle: '4 Pelanggan',
                  ),
                ),
              ],
            )
          else ...[
            PosMetricCard(
              title: 'Omzet Hari Ini',
              amount: 1450000,
              icon: Icons.monetization_on_outlined,
              iconColor: AppColors.success,
              subtitle: '38 Transaksi',
            ),
            const SizedBox(height: AppSpacing.md),
            PosMetricCard(
              title: 'Laba Bersih Estimasi',
              amount: 320000,
              icon: Icons.trending_up_rounded,
              iconColor: AppColors.pineGreen,
              subtitle: 'Margin ~22%',
            ),
            const SizedBox(height: AppSpacing.md),
            PosMetricCard(
              title: 'Total Piutang Belum Bayar',
              amount: 250000,
              icon: Icons.assignment_late_outlined,
              iconColor: AppColors.danger,
              subtitle: '4 Pelanggan',
            ),
          ],

          const SizedBox(height: AppSpacing.xl),
          const Text(
            'Transaksi Terakhir Hari Ini',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: AppColors.deepForest),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTransactionRow('TRX-20261016-0038', '12:40 WIB • Tunai', 85000, PosStatusType.lunas),
          const SizedBox(height: AppSpacing.sm),
          _buildTransactionRow('TRX-20261016-0037', '12:15 WIB • Kasbon (Bu Siti)', 42500, PosStatusType.kasbon),
          const SizedBox(height: AppSpacing.sm),
          _buildTransactionRow('TRX-20261016-0036', '11:50 WIB • Tunai', 115000, PosStatusType.lunas),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String id, String subtitle, int total, PosStatusType status) {
    return PosCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.0),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12.0, color: AppColors.textMuted),
              ),
            ],
          ),
          Row(
            children: [
              PosStatusBadge.fromType(status),
              const SizedBox(width: AppSpacing.md),
              RupiahText.medium(amount: total, color: AppColors.deepForest),
            ],
          ),
        ],
      ),
    );
  }
}
