import 'package:booking_reserv/core/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define a list of establishments with their names and icons
  final List<Map<String, dynamic>> establishments = [
    {'name': 'Компьютерные клубы', 'icon': Icons.computer},
    {'name': 'Бани и сауны', 'icon': Icons.hot_tub},
    {'name': 'Автосервисы', 'icon': Icons.car_repair},
    {'name': 'Парикмахерские', 'icon': Icons.cut},
    {'name': 'Спортивные залы', 'icon': Icons.fitness_center},
    {'name': 'Рестораны', 'icon': Icons.restaurant},
    {'name': 'Караоке-клубы', 'icon': Icons.mic},
    {'name': 'Квест-комнаты', 'icon': Icons.lock},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Главная'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1, // Makes grid items square
          ),
          itemCount: establishments.length, // Set the number of items
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
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
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    establishments[index]['icon'],
                    size: 24, // Increased icon size for better visibility
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    establishments[index]['name'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 2, // Allow text to wrap if needed
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}