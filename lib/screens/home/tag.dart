import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const Tags({super.key, required this.backgroundColor, required this.textColor});

  final List<String> _labels = const [
    'TKTruyen',
    'Tiên hiệp',
    'Ngôn tình',
    'Hài hước',
    'Hài hước',
    'Hài hước',
    'Hài hước',
    'Hài hước',
    'Hài hước',
    'Hài hước',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < _labels.length; i += 2) {
      final first = _labels[i];
      final second = i + 1 < _labels.length ? _labels[i + 1] : null;

      rows.add(
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor.withOpacity(0.8),
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Text(first, style: TextStyle(color: textColor)),
              ),
            ),
            if ( second != null)...[
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor.withOpacity(0.8),
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(second, style: TextStyle(color: textColor)),
                ),
              ),
          ],
          ],
        ),
      );
      rows.add(const SizedBox(height: 8));
    }
    return Column(
      children: rows,
    );
  }
}
