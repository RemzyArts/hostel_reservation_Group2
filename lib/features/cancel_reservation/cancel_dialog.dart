import 'package:flutter/material.dart';

class CancelReservationDialog extends StatelessWidget {
  final VoidCallback onConfirmCancel;

  const CancelReservationDialog({
    super.key,
    required this.onConfirmCancel,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );

    final primaryTextStyle = const TextStyle(fontSize: 16);
    final noteStyle = TextStyle(
      fontSize: 14,
      color: Colors.green.shade700,
      fontWeight: FontWeight.w600,
    );

    return AlertDialog(
      title: Text('Cancel Reservation?', style: titleStyle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to cancel this reservation?',
              style: primaryTextStyle,
            ),
            const SizedBox(height: 12),
            Text(
              'This action cannot be undone.',
              style: noteStyle,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirmCancel();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Yes, Cancel Reservation',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}