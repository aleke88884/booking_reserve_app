import 'package:booking_reserv/core/widgets/custom_app_bar_widget.dart';
import 'package:booking_reserv/features/reservation/presentation/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// Модель для места бронирования
class Establishment {
  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final String address;

  Establishment({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.address,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Список мест для бронирования (пример данных)
  final List<Establishment> establishments = [
    Establishment(
      id: '1',
      name: 'Баня на Озере',
      imageUrl: 'https://images.unsplash.com/photo-1519040067592-89cc3b706997',
      type: 'Баня',
      address: 'ул. Озерная, 12',
    ),
    Establishment(
      id: '2',
      name: 'Сауна Релакс',
      imageUrl: 'https://images.unsplash.com/photo-1576864032034-79dc6f80e6e7',
      type: 'Сауна',
      address: 'ул. Лесная, 45',
    ),
    Establishment(
      id: '3',
      name: 'Русская Баня',
      imageUrl: 'https://images.unsplash.com/photo-1601924333309-83e3038a316c',
      type: 'Баня',
      address: 'ул. Центральная, 8',
    ),
    Establishment(
      id: '4',
      name: 'Спа-Сауна Люкс',
      imageUrl: 'https://images.unsplash.com/photo-1595484027760-0e7e8e2d4d62',
      type: 'Сауна',
      address: 'ул. Спа, 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Места для бронирования'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Изменено для учета изображения
          ),
          itemCount: establishments.length,
          itemBuilder: (context, index) {
            final establishment = establishments[index];
            return GestureDetector(
              onTap: () {
                context.push(ReservationScreen.routeName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Изображение места
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        establishment.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 120,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 200,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    // Контент
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            establishment.name,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            establishment.type,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            establishment.address,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[500],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
