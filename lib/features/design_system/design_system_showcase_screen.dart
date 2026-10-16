import 'package:flutter/material.dart';
import '../../core/layout/adaptive_breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/pos_button.dart';
import '../../shared/widgets/pos_card.dart';
import '../../shared/widgets/pos_search_bar.dart';
import '../../shared/widgets/pos_status_badge.dart';
import '../../shared/widgets/pos_text_field.dart';
import '../../shared/widgets/rupiah_text.dart';

/// Interactive showcase screen for visual QA of design system tokens and POS widgets.
class DesignSystemShowcaseScreen extends StatefulWidget {
  const DesignSystemShowcaseScreen({super.key});

  @override
  State<DesignSystemShowcaseScreen> createState() => _DesignSystemShowcaseScreenState();
}

class _DesignSystemShowcaseScreenState extends State<DesignSystemShowcaseScreen> {
  bool _isLoadingButtons = false;

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.deepForest,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    final isTablet = context.isTablet;

    return Scaffold(
      backgroundColor: AppColors.surfaceBackground,
      appBar: AppBar(
        title: const Text('Design System & Adaptive QA'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: Chip(
              backgroundColor: AppColors.forestGreen,
              side: const BorderSide(color: AppColors.sageGreen),
              label: Text(
                '${width.toInt()}dp • ${isTablet ? "TABLET" : "PHONE"}',
                style: const TextStyle(
                  color: AppColors.mintCream,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // 1. Mandatory Brand Palette
          _buildSectionHeader('1. Green Forest Brand Palette (Mandatory 6 Colors)'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _buildColorChip('Deep Forest', '#051F20', AppColors.deepForest, AppColors.textOnDark),
              _buildColorChip('Forest Green', '#0B2B26', AppColors.forestGreen, AppColors.textOnDark),
              _buildColorChip('Pine Green', '#163832', AppColors.pineGreen, AppColors.textOnDark),
              _buildColorChip('Moss Green', '#235347', AppColors.mossGreen, AppColors.textOnDark),
              _buildColorChip('Sage Green', '#8EB69B', AppColors.sageGreen, AppColors.textPrimary),
              _buildColorChip('Mint Cream', '#DAF1DE', AppColors.mintCream, AppColors.textPrimary),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // 2. High-Contrast Store Surfaces & Semantic Status Colors
          _buildSectionHeader('2. Store Lighting Surfaces & Semantic Status'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _buildColorChip('Surface Canvas', '#F6FAF7', AppColors.surfaceBackground, AppColors.textPrimary, hasBorder: true),
              _buildColorChip('Card Surface', '#FFFFFF', AppColors.surfaceWhite, AppColors.textPrimary, hasBorder: true),
              _buildColorChip('Success / Lunas', '#15803D', AppColors.success, AppColors.textOnDark),
              _buildColorChip('Warning / Tempo', '#B45309', AppColors.warning, AppColors.textOnDark),
              _buildColorChip('Danger / Piutang', '#DC2626', AppColors.danger, AppColors.textOnDark),
              _buildColorChip('Info / System', '#1D4ED8', AppColors.info, AppColors.textOnDark),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // 3. Status Badges
          _buildSectionHeader('3. POS Semantic Badges'),
          const SizedBox(height: AppSpacing.sm),
          PosCard(
            child: Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                PosStatusBadge.lunas(),
                PosStatusBadge.kasbon(),
                PosStatusBadge.cicilan(),
                PosStatusBadge.stokAman(),
                PosStatusBadge.stokMenipis(),
                PosStatusBadge.stokHabis(),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 4. Financial Metric Cards
          _buildSectionHeader('4. POS Financial Metric Cards'),
          const SizedBox(height: AppSpacing.sm),
          isTablet
              ? Row(
                  children: [
                    Expanded(
                      child: PosMetricCard(
                        title: 'Omzet Hari Ini',
                        amount: 1450000,
                        icon: Icons.payments_rounded,
                        iconColor: AppColors.success,
                        iconBackgroundColor: AppColors.successBg,
                        subtitle: '38 Transaksi Berhasil',
                        badge: const PosStatusBadge.lunas(label: '+12%'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PosMetricCard(
                        title: 'Kas Masuk Tunai',
                        amount: 1200000,
                        icon: Icons.point_of_sale_rounded,
                        iconColor: AppColors.pineGreen,
                        iconBackgroundColor: AppColors.mintCream,
                        subtitle: 'Laci Kasir Aktif',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: PosMetricCard(
                        title: 'Total Piutang (Kasbon)',
                        amount: 250000,
                        icon: Icons.receipt_long_rounded,
                        iconColor: AppColors.danger,
                        iconBackgroundColor: AppColors.dangerBg,
                        subtitle: '4 Pelanggan Belum Lunas',
                        badge: const PosStatusBadge.kasbon(label: 'Jatuh Tempo'),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    PosMetricCard(
                      title: 'Omzet Hari Ini',
                      amount: 1450000,
                      icon: Icons.payments_rounded,
                      iconColor: AppColors.success,
                      iconBackgroundColor: AppColors.successBg,
                      subtitle: '38 Transaksi Berhasil',
                      badge: const PosStatusBadge.lunas(label: '+12%'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PosMetricCard(
                      title: 'Kas Masuk Tunai',
                      amount: 1200000,
                      icon: Icons.point_of_sale_rounded,
                      iconColor: AppColors.pineGreen,
                      iconBackgroundColor: AppColors.mintCream,
                      subtitle: 'Laci Kasir Aktif',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PosMetricCard(
                      title: 'Total Piutang (Kasbon)',
                      amount: 250000,
                      icon: Icons.receipt_long_rounded,
                      iconColor: AppColors.danger,
                      iconBackgroundColor: AppColors.dangerBg,
                      subtitle: '4 Pelanggan Belum Lunas',
                      badge: const PosStatusBadge.kasbon(label: 'Jatuh Tempo'),
                    ),
                  ],
                ),

          const SizedBox(height: AppSpacing.xl),

          // 5. RupiahText & Tabular Numerals Alignment QA
          _buildSectionHeader('5. Integer Rupiah & Tabular Numerals Alignment'),
          const SizedBox(height: AppSpacing.sm),
          PosCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verifikasi alignment vertikal digit Rupiah (FontFeature.tabularFigures):',
                  style: TextStyle(fontSize: 13.0, color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: AppRadius.borderSm,
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Column(
                    children: [
                      _buildReceiptRow('Beras Ramos 5kg (x1)', 68500),
                      _buildReceiptRow('Minyak Goreng 2L (x2)', 34000),
                      _buildReceiptRow('Gula Pasir 1kg (x1)', 17500),
                      _buildReceiptRow('Telur Ayam 1kg (x1)', 28000),
                      _buildReceiptRow('Mie Instan Goreng (x5)', 15000),
                      _buildReceiptRow('Diskon Promosi Member', -10000, isDiscount: true),
                      const Divider(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('TOTAL BELANJA', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0)),
                          RupiahText.large(amount: 153000, color: AppColors.pineGreen),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 6. Search Bar with Barcode Scanner Trigger
          _buildSectionHeader('6. POS Search & Barcode Trigger'),
          const SizedBox(height: AppSpacing.sm),
          PosSearchBar(
            hintText: 'Cari produk atau scan barcode fisik/kamera...',
            onScanBarcodePressed: () {
              _showFeedback('Barcode scanner callback triggered!');
            },
            onChanged: (query) {},
          ),

          const SizedBox(height: AppSpacing.lg),

          const PosTextField(
            label: 'Catatan Transaksi / Nama Pelanggan',
            hintText: 'Contoh: Bu Siti (Warung Sebelah)',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),

          const SizedBox(height: AppSpacing.xl),

          // 7. Interactive Buttons & Loading States
          _buildSectionHeader('7. POS Action Buttons (Touch Target >= 48dp)'),
          const SizedBox(height: AppSpacing.sm),
          PosCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Uji State Loading:', style: TextStyle(fontWeight: FontWeight.w600)),
                    Switch(
                      value: _isLoadingButtons,
                      activeThumbColor: AppColors.pineGreen,
                      onChanged: (val) {
                        setState(() {
                          _isLoadingButtons = val;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    PosButton.primary(
                      label: 'Bayar Tunai',
                      icon: Icons.payments_rounded,
                      isLoading: _isLoadingButtons,
                      onPressed: () => _showFeedback('Bayar Tunai ditekan'),
                    ),
                    PosButton.secondary(
                      label: 'Simpan Kasbon',
                      icon: Icons.account_balance_wallet_rounded,
                      isLoading: _isLoadingButtons,
                      onPressed: () => _showFeedback('Simpan Kasbon ditekan'),
                    ),
                    PosButton.tonal(
                      label: 'Cetak Struk',
                      icon: Icons.print_rounded,
                      isLoading: _isLoadingButtons,
                      onPressed: () => _showFeedback('Cetak Struk ditekan'),
                    ),
                    PosButton.danger(
                      label: 'Batalkan',
                      icon: Icons.delete_outline_rounded,
                      isLoading: _isLoadingButtons,
                      onPressed: () => _showFeedback('Batalkan ditekan'),
                    ),
                    PosButton.ghost(
                      label: 'Tahan Transaksi',
                      icon: Icons.pause_circle_outline_rounded,
                      isLoading: _isLoadingButtons,
                      onPressed: () => _showFeedback('Tahan Transaksi ditekan'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PosButton.primary(
                  label: 'Konfirmasi Transaksi Penuh (Full Width 48dp)',
                  icon: Icons.check_circle_outline_rounded,
                  fullWidth: true,
                  isLoading: _isLoadingButtons,
                  onPressed: () => _showFeedback('Full Width Confirmation pressed'),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTypography.headlineSmall.copyWith(
        color: AppColors.deepForest,
      ),
    );
  }

  Widget _buildColorChip(
    String name,
    String hex,
    Color color,
    Color textColor, {
    bool hasBorder = false,
  }) {
    return Container(
      width: 150.0,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.borderSm,
        border: hasBorder ? Border.all(color: AppColors.borderSubtle, width: 1.0) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            hex,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: textColor.withValues(alpha: 0.85),
              fontFeatures: AppTypography.tabularFigures,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String item, int price, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontSize: 13.0,
                color: isDiscount ? AppColors.danger : AppColors.textPrimary,
                fontWeight: isDiscount ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          RupiahText.small(
            amount: price,
            color: isDiscount ? AppColors.danger : AppColors.deepForest,
          ),
        ],
      ),
    );
  }
}
