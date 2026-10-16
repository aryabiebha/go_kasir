import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Clean high-contrast POS search bar with optional barcode scanner trigger.
class PosSearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onScanBarcodePressed;
  final bool autofocus;

  const PosSearchBar({
    super.key,
    this.hintText = 'Cari produk, nama, atau scan barcode...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onScanBarcodePressed,
    this.autofocus = false,
  });

  @override
  State<PosSearchBar> createState() => _PosSearchBarState();
}

class _PosSearchBarState extends State<PosSearchBar> {
  late final TextEditingController _controller;
  bool _isInternalController = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
      _isInternalController = true;
    } else {
      _controller = widget.controller!;
    }
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: AppRadius.borderSm,
        border: Border.all(color: AppColors.borderSubtle, width: 1.0),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Icon(Icons.search_rounded, color: AppColors.textMuted, size: 22.0),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: widget.autofocus,
              textInputAction: TextInputAction.search,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
          if (_hasText)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 20.0),
              tooltip: 'Hapus pencarian',
              color: AppColors.textMuted,
              onPressed: _clearSearch,
            ),
          if (widget.onScanBarcodePressed != null) ...[
            Container(
              height: 28.0,
              width: 1.0,
              color: AppColors.borderSubtle,
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded, size: 24.0),
              tooltip: 'Scan Barcode',
              color: AppColors.pineGreen,
              onPressed: widget.onScanBarcodePressed,
            ),
          ],
        ],
      ),
    );
  }
}
