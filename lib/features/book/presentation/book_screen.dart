import 'package:booking_reserv/core/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Data model for a booking
class Booking {
  final String id;
  final String establishmentName;
  final String imageUrl;
  final DateTime bookingDate;
  final bool isActive;

  Booking({
    required this.id,
    required this.establishmentName,
    required this.imageUrl,
    required this.bookingDate,
    required this.isActive,
  });
}

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});
  static const String routeName = '/book';

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  // Sample list of bookings (replace with actual data source)
  final List<Booking> bookings = [
    Booking(
      id: '1',
      establishmentName: 'Cafe Serenity',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      bookingDate: DateTime.now().add(const Duration(days: 1)),
      isActive: true,
    ),
    Booking(
      id: '2',
      establishmentName: 'Bistro Delight',
      imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828add9',
      bookingDate: DateTime.now().subtract(const Duration(days: 2)),
      isActive: false,
    ),
    Booking(
      id: '3',
      establishmentName: 'Pizzeria Amore',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      bookingDate: DateTime.now().add(const Duration(hours: 5)),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Бронь',
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'Нет бронирований',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return BookingCard(booking: booking);
              },
            ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    final formattedDate = dateFormat.format(booking.bookingDate);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Stack(
              children: [
                Image.network(
                  booking.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image,
                        size: 50, color: Colors.grey),
                  ),
                ),
                // Status overlay
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: booking.isActive ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      booking.isActive ? 'Активно' : 'Прошедшее',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.establishmentName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (booking.isActive)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Бронь ${booking.establishmentName} отменена')),
                          );
                        },
                        child: const Text(
                          'Отменить',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
