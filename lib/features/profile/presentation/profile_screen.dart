import 'package:booking_reserv/core/constants/app_colors.dart';
import 'package:booking_reserv/core/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(
        title: 'Профиль',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white, // Желтый цвет
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Замените на реальное изображение
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Test Testovich',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.black),
                      onPressed: () {
                        // Действие для кнопки настроек
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Карточка с номером телефона
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.phone, color: AppColors.primary),
                        title: Text('Phone Number'),
                        subtitle: Text('+1 332 442 521'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Карточка с email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.email, color: AppColors.primary),
                        title: Text('Почта'),
                        subtitle: Text('ivanovich@gmail.com'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.location_city, color: AppColors.primary),
                        title: Text('Город'),
                        subtitle: Text('ivanovich@gmail.com'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
