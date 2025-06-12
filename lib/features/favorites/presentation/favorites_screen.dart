import 'package:booking_reserv/core/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Sample data model for an establishment
class Establishment {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Establishment({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  static const String routeName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Sample list of favorite establishments (replace with actual data source)
  final List<Establishment> favoriteEstablishments = [
    Establishment(
      id: '1',
      name: 'Cafe Serenity',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      description: 'Cozy cafe with great coffee',
    ),
    Establishment(
      id: '2',
      name: 'Bistro Delight',
      imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828add9',
      description: 'Modern bistro with exquisite dishes',
    ),
    Establishment(
      id: '3',
      name: 'Pizzeria Amore',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      description: 'Authentic Italian pizza',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Избранное',
      ),
      body: favoriteEstablishments.isEmpty
          ? Center(
              child: Text(
                'Нет избранных заведений',
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: favoriteEstablishments.length,
              itemBuilder: (context, index) {
                final establishment = favoriteEstablishments[index];
                return FavoriteCard(establishment: establishment);
              },
            ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Establishment establishment;

  const FavoriteCard({super.key, required this.establishment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              establishment.imageUrl,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180.h,
                color: Colors.grey[300],
                child:
                    Icon(Icons.broken_image, size: 50.sp, color: Colors.grey),
              ),
            ),
          ),
          // Content section
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  establishment.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  establishment.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon:
                          Icon(Icons.favorite, color: Colors.red, size: 24.sp),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${establishment.name} удалено из избранного')),
                        );
                      },
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
