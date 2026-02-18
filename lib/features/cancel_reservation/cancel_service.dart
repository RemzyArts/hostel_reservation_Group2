<<<<<<< HEAD
class CancelService {
  // Simulates cancelling a reservation (your teammate will add real Firebase code)
  static Future<void> cancelReservation({required String bookingId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    print("Cancelled booking: $bookingId");
    // TODO: Add real Firebase/API cancellation logic here
=======
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Cancel reservation
  Future<String> cancelReservation({
    required String reservationId,
    required DateTime checkInDate,
    String? cancelReason,
  }) async {
    try {
      // Check if reservation can be cancelled
      bool allowed = _canCancel(checkInDate);

      if (!allowed) {
        return "Cancellation period expired";
      }

      // Update reservation in Firestore
      await _firestore
          .collection('reservations')
          .doc(reservationId)
          .update({
        'status': 'cancelled',
        'cancelledAt': Timestamp.now(),
        'cancelReason': cancelReason ?? "No reason provided",
      });

      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  /// Rule: cannot cancel after check-in date
  bool _canCancel(DateTime checkInDate) {
    DateTime now = DateTime.now();
    return now.isBefore(checkInDate);
>>>>>>> origin/feature/cancel_service
  }
}