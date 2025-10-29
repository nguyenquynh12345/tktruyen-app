import 'package:flutter/material.dart';

class CompleteStoriesSection extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const CompleteStoriesSection({super.key, required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Truyện Full - Hoàn',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor.withOpacity(0.8),
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.book, size: 24, color: textColor),
                    const SizedBox(height: 8),
                    Text(
                      'Full - Mới Cập Nhật',
                      style: TextStyle(fontSize: 12, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor.withOpacity(0.8),
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.star, size: 24, color: textColor),
                    const SizedBox(height: 8),
                    Text(
                      'Full - Đánh Giá Cao',
                      style: TextStyle(fontSize: 12, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor.withOpacity(0.8),
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.heart_broken, size: 24, color: textColor),
                    const SizedBox(height: 8),
                    Text(
                      'Full - Yêu thích',
                      style: TextStyle(fontSize: 12, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor.withOpacity(0.8),
                  foregroundColor: textColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.more, size: 24, color: textColor),
                    const SizedBox(height: 8),
                    Text(
                      'Full - Xem nhiều',
                      style: TextStyle(fontSize: 12, color: textColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
