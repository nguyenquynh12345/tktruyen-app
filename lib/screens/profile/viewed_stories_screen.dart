import 'package:flutter/material.dart';
import 'package:heheheh/models/story.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'package:heheheh/viewed_stories_notifier.dart';

class ViewedStoriesScreen extends StatefulWidget {
  const ViewedStoriesScreen({super.key});

  @override
  State<ViewedStoriesScreen> createState() => _ViewedStoriesScreenState();
}

class _ViewedStoriesScreenState extends State<ViewedStoriesScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure viewed stories are loaded when the screen is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewedStoriesNotifier>(context, listen: false).loadViewedStories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, ViewedStoriesNotifier>(
      builder: (context, themeNotifier, viewedStoriesNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;

        final List<Story> stories = viewedStoriesNotifier.viewedStories;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text('Truyện đã xem', style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.delete_forever, color: textColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: backgroundColor,
                        title: Text('Xóa lịch sử?', style: TextStyle(color: textColor)),
                        content: Text('Bạn có chắc chắn muốn xóa tất cả truyện đã xem không?', style: TextStyle(color: textColor)),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Hủy', style: TextStyle(color: textColor)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Xóa', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              viewedStoriesNotifier.clearViewedStories();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: stories.isEmpty
              ? Center(child: Text('Bạn chưa xem truyện nào.', style: TextStyle(color: textColor)))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, '/story_detail', arguments: {'storyId': story.id});
                        // No need to refresh here, as addViewedStory in StoryDetailScreen will handle it
                      },
                      child: Card(
                        color: backgroundColor,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  story.image,
                                  width: 80,
                                  height: 120, // Aspect ratio 9:16
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 80,
                                    height: 120,
                                    color: Colors.grey,
                                    child: Icon(Icons.broken_image, color: textColor.withOpacity(0.7)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      story.storyName,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      story.author,
                                      style: TextStyle(
                                        color: textColor.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      story.description,
                                      style: TextStyle(
                                        color: textColor.withOpacity(0.6),
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
