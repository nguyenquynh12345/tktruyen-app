import 'package:flutter/material.dart';
import 'package:heheheh/api/api_service.dart';
import 'package:heheheh/screens/home/story_detail_screen.dart';
import 'book_card.dart';

class LatestUpdatedSection extends StatefulWidget {
  const LatestUpdatedSection({super.key});

  @override
  State<LatestUpdatedSection> createState() => _LatestUpdatedSectionState();
}

class _LatestUpdatedSectionState extends State<LatestUpdatedSection> {
  List<dynamic> _latestChapters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLatestChapters();
  }

  Future<void> _fetchLatestChapters() async {
    try {
      final data = await StoryService.getListNominatedStory();
      setState(() {
        _latestChapters = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Lỗi tải chương mới: $e');
      setState(() => _isLoading = false);
    }
  }

  void _goToStoryDetail(BuildContext context, int storyId, String storyTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StoryDetailScreen(
          storyId: storyId,
          storyTitle: storyTitle,
        ),
      ),
    );
  }

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

        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (_latestChapters.isEmpty)
          const Text('Không có dữ liệu', style: TextStyle(color: Colors.white))
        else
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _latestChapters.length,
              itemBuilder: (context, index) {
                final item = _latestChapters[index];

                final imageUrl = item['image'] ?? '';
                final title = item['name'] ?? 'Không tên';
                final storyId = int.tryParse(item['id'].toString()) ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => _goToStoryDetail(context, storyId, title),
                    child: BookCard(
                      imagePath: imageUrl,
                      title: title,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
