import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  // These parameters allow this button to talk to your teammates' code
  final bool enabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const CancelButton({
    super.key,
    required this.enabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Fixed width ensures the button doesn't jump around when text changes
      width: 100, 
      height: 38,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Requirement: Disables visually when time is over
          backgroundColor: enabled ? Colors.white : Colors.grey.shade300,
          foregroundColor: Colors.red,
          elevation: enabled ? 2 : 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Requirement: Checks if cancel is allowed 
        // Logic: if 'enabled' is false from the parent, the button becomes unclickable
        onPressed: enabled && !isLoading ? onPressed : null,
        child: isLoading
            ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.red,
                ),
              )
            : const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}