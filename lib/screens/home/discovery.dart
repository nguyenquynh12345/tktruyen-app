import 'package:flutter/material.dart';
import 'package:heheheh/screens/wiget_component/discovery_dutton.dart';

class Discovery extends StatelessWidget {
  const Discovery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hãy thử khám phá',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DiscoveryButton(
                label: 'Bộ lọc truyện nâng cao',
                onPressed: () {},
                icon: Icons.filter_list,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DiscoveryButton(
                label: 'Đánh giá của bạn đọc',
                onPressed: () {},
                icon: Icons.feedback
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DiscoveryButton(
                  label: 'Bộ sưu tập hay mới chia sẻ',
                  onPressed: () {},
                  icon: Icons.share
              ),
            ),
          ],
        ),
      ],
    );
  }
}
