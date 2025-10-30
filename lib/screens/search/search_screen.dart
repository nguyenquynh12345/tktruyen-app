import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Material for TextStyle

class SearchScreen extends StatelessWidget{
  final Color backgroundColor;
  final Color textColor;

  const SearchScreen({super.key, required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('test', style: TextStyle(color: textColor))
      ],
    );
  }

}