import 'package:flutter/material.dart';

class SectionTabs extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const SectionTabs({super.key, required this.backgroundColor, required this.textColor});

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
                backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : textColor.withOpacity(0.5),
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
