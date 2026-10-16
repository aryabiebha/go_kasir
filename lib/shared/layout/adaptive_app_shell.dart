import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/layout/adaptive_breakpoints.dart';
import '../../core/theme/app_colors.dart';
import '../../features/customers_kasbon/screens/kasbon_screen.dart';
import '../../features/design_system/design_system_showcase_screen.dart';
import '../../features/pos/screens/pos_screen.dart';
import '../../features/products/screens/products_screen.dart';
import '../../features/reports/screens/reports_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

/// Riverpod Notifier managing the active navigation index.
class ActiveNavIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}

/// Provider exposing the active navigation index.
final activeNavIndexProvider = NotifierProvider<ActiveNavIndexNotifier, int>(
  ActiveNavIndexNotifier.new,
);

/// Adaptive application shell switching between Phone bottom NavigationBar and Tablet NavigationRail.
class AdaptiveAppShell extends ConsumerWidget {
  const AdaptiveAppShell({super.key});

  static const List<_NavDestinationItem> _destinations = [
    _NavDestinationItem(
      label: 'Kasir',
      icon: Icons.point_of_sale_outlined,
      selectedIcon: Icons.point_of_sale_rounded,
    ),
    _NavDestinationItem(
      label: 'Produk & Stok',
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2_rounded,
    ),
    _NavDestinationItem(
      label: 'Kasbon',
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet_rounded,
    ),
    _NavDestinationItem(
      label: 'Laporan',
      icon: Icons.assessment_outlined,
      selectedIcon: Icons.assessment_rounded,
    ),
    _NavDestinationItem(
      label: 'Pengaturan',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
    ),
  ];

  static const List<Widget> _screens = [
    PosScreen(),
    ProductsScreen(),
    KasbonScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(activeNavIndexProvider);
    final isTablet = context.isTablet;

    if (isTablet) {
      return Scaffold(
        body: Row(
          children: [
            // Tablet Navigation Rail (Deep Forest / Forest Green Theme)
            Container(
              decoration: const BoxDecoration(
                color: AppColors.deepForest,
                border: Border(
                  right: BorderSide(color: AppColors.forestGreen, width: 1.0),
                ),
              ),
              child: NavigationRail(
                selectedIndex: activeIndex,
                onDestinationSelected: (index) {
                  ref.read(activeNavIndexProvider.notifier).setIndex(index);
                },
                backgroundColor: Colors.transparent,
                labelType: NavigationRailLabelType.all,
                indicatorColor: AppColors.mintCream,
                selectedIconTheme: const IconThemeData(
                  color: AppColors.deepForest,
                  size: 26.0,
                ),
                unselectedIconTheme: const IconThemeData(
                  color: AppColors.sageGreen,
                  size: 24.0,
                ),
                selectedLabelTextStyle: const TextStyle(
                  color: AppColors.mintCream,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                ),
                unselectedLabelTextStyle: const TextStyle(
                  color: AppColors.sageGreen,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: AppColors.pineGreen,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: AppColors.sageGreen, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.store_rounded,
                          color: AppColors.mintCream,
                          size: 28.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'GoKasir',
                        style: TextStyle(
                          color: AppColors.mintCream,
                          fontWeight: FontWeight.w800,
                          fontSize: 13.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: IconButton(
                        icon: const Icon(Icons.palette_rounded),
                        tooltip: 'Design System & Adaptive QA',
                        color: AppColors.sageGreen,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DesignSystemShowcaseScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                destinations: _destinations.map((d) {
                  return NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  );
                }).toList(),
              ),
            ),

            // Active Tablet Screen Area
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(_destinations[activeIndex].label),
                  backgroundColor: AppColors.deepForest,
                  foregroundColor: AppColors.textOnDark,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.palette_outlined),
                      tooltip: 'Design System Preview',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DesignSystemShowcaseScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                body: IndexedStack(
                  index: activeIndex,
                  children: _screens,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Phone Experience
    return Scaffold(
      appBar: AppBar(
        title: Text(_destinations[activeIndex].label),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Design System Preview',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DesignSystemShowcaseScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: activeIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: activeIndex,
        onDestinationSelected: (index) {
          ref.read(activeNavIndexProvider.notifier).setIndex(index);
        },
        destinations: _destinations.map((d) {
          return NavigationDestination(
            icon: Icon(d.icon),
            selectedIcon: Icon(d.selectedIcon),
            label: d.label,
          );
        }).toList(),
      ),
    );
  }
}

class _NavDestinationItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const _NavDestinationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
