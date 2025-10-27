import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({super.key});

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
                  backgroundColor: Colors.grey[900],
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Text(first, style: const TextStyle(color: Colors.white)),
              ),
            ),
            if ( second != null)...[
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(second, style: const TextStyle(color: Colors.white)),
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
