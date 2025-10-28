import 'package:flutter/material.dart';
import 'book_card.dart';

class NewlyPostedSection extends StatelessWidget {
  const NewlyPostedSection({super.key});

  final List<Map<String, String>> books = const [
    {'image': '', 'title': '[Zhihu] Phú Trọng...', 'subtitle': 'Phú Trọng Tr...'},
    {'image': '', 'title': 'Vợ Tối', 'subtitle': 'Vợ Tối'},
    {'image': '', 'title': 'Kể Chuyện', 'subtitle': 'Ma Trọng...'},
    {'image': '', 'title': 'Anh Tối', 'subtitle': 'Thanh Doi...'},
    {'image': '', 'title': 'Extra Book', 'subtitle': 'Extra Subtitle...'},
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
              'Mới đăng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Xem thêm ',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
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
