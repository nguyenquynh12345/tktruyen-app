import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const BookCard({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 4; // 4.5 card trên 1 màn hình

    final defaultImageUrl =
        'https://kingtoys.com.vn/wp-content/uploads/2025/04/king-Toys-CosmicCreations-CC9132-Thach-Hao-9.jpg';
    final effectiveImagePath = imagePath.isNotEmpty ? imagePath : defaultImageUrl;

    return SizedBox(
      width: cardWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: cardWidth*1.2, // tỉ lệ ảnh khoảng 1.2 của width
              decoration: BoxDecoration(
                color: Colors.grey[800],
                image: DecorationImage(
                  image: NetworkImage(effectiveImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Tiêu đề
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
