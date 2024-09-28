import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/biometric_auth.dart';
import 'finger_auth.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onNumberTapped;

  NumberPad({Key? key, required this.onNumberTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < 9) {
          // Numbers 1 to 9
          return NumberButton(
            label: "${index + 1}",
            onTap: () => onNumberTapped("${index + 1}"),
          );
        } else if (index == 11) {
          // Del button
          return NumberButton(
            label: "Del",
            onTap: () => onNumberTapped("Del"),
            icon: Icons.delete,
          );
        } else if (index == 10) {
          // 0 button
          return NumberButton(
            label: "0",
            onTap: () => onNumberTapped("0"),
          );
        } else {
          // Fingerprint icon as the 12th button
          return FingerprintAuth(
            onAuthenticate: () => BiometricAuth.authenticateWithBiometrics(context), // استدعاء الدالة هنا
          );
        }
      },
    );
  }
}

// Individual Number Button Widget
class NumberButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon; // Optional icon parameter

  const NumberButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon, // Initialize optional icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) // Show icon if it's provided
                Icon(
                  icon,
                  size: 30, // Set the icon size
                  color: Colors.white,
                ),
              label == "Del"
                  ? Container()
                  : Text(
                label,
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
