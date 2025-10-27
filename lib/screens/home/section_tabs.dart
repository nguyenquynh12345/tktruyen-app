import 'package:flutter/material.dart';

class SectionTabs extends StatelessWidget {
  const SectionTabs({super.key});

  final List<String> tabs = const [
    'Đang đọc',
    'Yêu thích',
    'Xem nhiều',
    'Thính Hàn',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == 0; // Default first tab selected
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.blue : Colors.transparent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : Colors.grey[700]!,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
