import 'package:flutter/material.dart';
import 'book_card.dart';

class LatestUpdatedSection extends StatelessWidget {
  const LatestUpdatedSection({super.key});

  final List<Map<String, String>> books = const [
    {'image': '', 'title': 'Sở Xá Hồi', 'subtitle': 'Sở Xa Hồi Xuyên Th...'},
    {'image': '', 'title': 'Bán Vợ Tù', 'subtitle': 'Bán Vợ Tù Theo...'},
    {'image': '', 'title': 'Anh Tối', 'subtitle': 'Thanh Đợi...'},
    {'image': '', 'title': 'Xuyên Nhân', 'subtitle': 'Xuyên Nhân Hạ...'},
    {'image': '', 'title': 'Extra Book 2', 'subtitle': 'Extra Subtitle 2...'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Mới cập nhật nhất',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Xem thêm',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: BookCard(
                  imagePath: books[index]['image'] ?? '',
                  title: books[index]['title'] ?? '',
                  subtitle: books[index]['subtitle'] ?? '',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
