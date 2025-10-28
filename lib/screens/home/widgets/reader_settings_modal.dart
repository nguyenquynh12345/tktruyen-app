import 'package:flutter/material.dart';

void showReaderSettingsModal({
  required BuildContext context,
  required double initialFontSize,
  required Color initialBackgroundColor,
  required Color initialTextColor,
  required List<Map<String, dynamic>> colorThemes,
  required Function(double) onFontSizeChanged,
  required Function(Color, Color) onColorChanged,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              color: initialBackgroundColor,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Font Size', style: TextStyle(color: initialTextColor, fontWeight: FontWeight.bold)),
                  Slider(
                    value: initialFontSize,
                    min: 12.0,
                    max: 24.0,
                    divisions: 6,
                    label: initialFontSize.round().toString(),
                    onChanged: (double value) {
                      onFontSizeChanged(value);
                      modalSetState(() {}); // Update modal UI
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Color Theme', style: TextStyle(color: initialTextColor, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: colorThemes.map((theme) {
                      return ChoiceChip(
                        label: Text(theme['name']!),
                        selected: initialBackgroundColor == theme['background'],
                        onSelected: (bool selected) {
                          if (selected) {
                            onColorChanged(theme['background']!, theme['text']!);
                            modalSetState(() {}); // Update modal UI
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
