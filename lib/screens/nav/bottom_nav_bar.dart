import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    this.initialIndex = 1, // Default to Khám Phá (index 1)
    this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  final List<IconData> _icons = [
    Icons.grid_view_outlined,
    Icons.explore_outlined,
    Icons.search_outlined,
    Icons.download_outlined,
    Icons.more_horiz_outlined,
  ];

  final List<String> _labels = [
    'Tag',
    'Khám Phá',
    'Tìm Truyện',
    'Offline',
    'Menu',
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: Colors.grey[800]!,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _icons[index],
                      size: 24,
                      color: isSelected ? Colors.blue : Colors.grey[400],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey[400],
                        fontSize: 10,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}