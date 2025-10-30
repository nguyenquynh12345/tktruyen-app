import 'package:flutter/material.dart';
import 'package:heheheh/models/story.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'package:heheheh/favorite_notifier.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initial load of favorites when the screen is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteNotifier>(context, listen: false).refreshFavorites();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, FavoriteNotifier>(
      builder: (context, themeNotifier, favoriteNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;

        final List<Story> stories = favoriteNotifier.favoriteStories;
        final bool isLoading = favoriteNotifier.isLoading;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text('Tủ sách', style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            elevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: favoriteNotifier.refreshFavorites,
            color: textColor, // Use text color for refresh indicator
            backgroundColor: backgroundColor,
            child: isLoading && stories.isEmpty
                ? Center(child: CircularProgressIndicator(color: textColor))
                : stories.isEmpty
                    ? Center(child: Text('Tủ sách của bạn trống.', style: TextStyle(color: textColor)))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: stories.length,
                        itemBuilder: (context, index) {
                          final story = stories[index];
                          return GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(context, '/story_detail', arguments: {'storyId': story.id});
                              // Refresh favorites when returning from detail screen
                              favoriteNotifier.refreshFavorites();
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
                                        height: 120, // Aspect ratio 9:16 (80 * 16/9 = 142.2, so 120 is close enough for a list item)
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
          ),
        );
      },
    );
  }
}
