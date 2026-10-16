import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/pos_card.dart';
import '../../design_system/design_system_showcase_screen.dart';

/// Settings screen with access to store setup and Design System Showcase.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Showcase Banner
          PosCard(
            backgroundColor: AppColors.mintCream,
            borderColor: AppColors.sageGreen,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DesignSystemShowcaseScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: const BoxDecoration(
                    color: AppColors.deepForest,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.palette_rounded, color: AppColors.mintCream, size: 24.0),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Design System & Adaptive QA',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepForest,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Lihat palette warna, tabular numerals, dan uji tombol POS',
                        style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: AppColors.deepForest),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
          const Text(
            'Konfigurasi Toko & Perangkat',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: AppColors.deepForest),
          ),
          const SizedBox(height: AppSpacing.md),

          _buildSettingItem(
            context,
            icon: Icons.storefront_rounded,
            title: 'Profil Toko',
            subtitle: 'Nama warung, alamat, nomor telepon struk',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingItem(
            context,
            icon: Icons.lock_outline_rounded,
            title: 'Keamanan PIN Kasir',
            subtitle: 'Kunci akses laporan, pembatalan struk, dan diskon',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingItem(
            context,
            icon: Icons.print_rounded,
            title: 'Printer Struk Bluetooth',
            subtitle: 'Atur printer thermal 58mm / 80mm',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSettingItem(
            context,
            icon: Icons.backup_rounded,
            title: 'Backup & Restore Database',
            subtitle: 'Simpan cadangan data lokal SQLite ke penyimpanan',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return PosCard(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: AppRadius.borderSm,
            ),
            child: Icon(icon, color: AppColors.pineGreen, size: 22.0),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12.0, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
