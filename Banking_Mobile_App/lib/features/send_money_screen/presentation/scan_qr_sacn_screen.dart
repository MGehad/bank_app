import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';

import 'package:bank_app/core/styles/colors.dart';

import '../../../generated/l10n.dart';

// QR Scan Screen
class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool isFlashOn = false;
  bool hasScanned = false; // Flag to prevent multiple pops

  // Initialize the controller once

  @override
  void initState() {
    super.initState();
  }

  PreferredSizeWidget appBarBuilder(
      BuildContext context, MobileScannerController controller) {
    return AppBar(
      leading: IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.transparent),
        ),
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.white,
      title: Text(S.of(context).QRScanner),
      actions: [
        IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.white),
          ),
          icon: controller.torchEnabled
              ? const Icon(Icons.flashlight_off_rounded)
              : const Icon(Icons.flashlight_on_rounded),
          onPressed: controller.toggleTorch,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      extendBodyBehindAppBar: true,
      hideSheetDragHandler: true,
      hideSheetTitle: true,
      successColor: Colors.green,
      errorColor: Colors.red,
      onDispose: () {
        // Reset the flag when the scanner is disposed
        hasScanned = false;
      },
      hideGalleryButton: false,
      // Enable the gallery button
      onDetect: (BarcodeCapture capture) {
        // Get the scanned barcode value
        final String? scannedValue = capture.barcodes.first.rawValue;

        if (scannedValue != null && !hasScanned) {
          hasScanned = true; // Set the flag to prevent multiple pops
          // Return the scanned value and pop the screen
          Navigator.pop(context, scannedValue);
        }
      },
      validator: (value) {
        if (value.barcodes.isEmpty) {
          return false;
        }
        if (!(value.barcodes.first.rawValue?.contains('flutter.dev') ??
            false)) {
          return false;
        }
        return true;
      },
    );
  }
}
