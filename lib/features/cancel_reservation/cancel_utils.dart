/// Utility functions for reservation cancellation logic
class CancelUtils {
  /// The cancellation window: 3 days from booking
  static const Duration cancellationWindow = Duration(days: 3);

  /// Calculates the deadline for cancelling a reservation
  /// Returns 3 days after the booking was made
  static DateTime cancelDeadline(DateTime bookedAt) {
    return bookedAt.add(cancellationWindow);
  }

  /// Checks if a reservation can still be cancelled
  /// Returns true if the booking is within the cancellation window
  static bool canCancel(DateTime bookedAt) {
    final deadline = cancelDeadline(bookedAt);
    return DateTime.now().isBefore(deadline);
  }

  /// Formats a duration into an abbreviated countdown string
  /// Example: "2D 3H 5M 30S" or "45M 30S"
  static String formatDuration(Duration duration) {
    if (duration.isNegative || duration.inSeconds <= 0) {
      return '0S';
    }

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    List<String> parts = [];

    if (days > 0) {
      parts.add('${days}D');
    }

    if (hours > 0) {
      parts.add('${hours}H');
    }

    if (minutes > 0) {
      parts.add('${minutes}M');
    }

    if (seconds > 0) {
      parts.add('${seconds}S');
    }

    return parts.join(':');
  }

  /// Converts a Firestore timestamp to a DateTime
  /// (Ready for integration with actual Firestore timestamps)
  static DateTime firestoreTimestampToDateTime(dynamic timestamp) {
    if (timestamp is DateTime) {
      return timestamp;
    }
    // For actual Firestore integration, handle Timestamp type here
    // return (timestamp as Timestamp).toDate();
    return DateTime.now();
  }

  /// Checks how many days are remaining until cancellation deadline
  static int daysRemaining(DateTime bookedAt) {
    final deadline = cancelDeadline(bookedAt);
    final now = DateTime.now();
    final diff = deadline.difference(now);
    return diff.inDays;
  }

  /// Checks if cancellation deadline is today
  static bool deadlineIsToday(DateTime bookedAt) {
    final deadline = cancelDeadline(bookedAt);
    final now = DateTime.now();
    return deadline.year == now.year &&
        deadline.month == now.month &&
        deadline.day == now.day;
  }

  /// Returns a user-friendly message about cancellation eligibility
  static String getCancellationMessage(DateTime bookedAt) {
    if (!canCancel(bookedAt)) {
      return 'Cancellation window has expired';
    }

    final daysLeft = daysRemaining(bookedAt);
    if (daysLeft == 0) {
      return 'Cancel today to avoid charges';
    } else if (daysLeft == 1) {
      return '1 day left to cancel';
    } else {
      return '$daysLeft days left to cancel';
    }
  }
}
