import 'package:flutter/material.dart';
import 'package:heheheh/screens/home/discovery.dart';
import 'package:heheheh/screens/home/tag.dart';
import 'section_tabs.dart';
import 'newly_posted_section.dart';
import 'latest_updated_section.dart';
import 'complete_stories_section.dart';

class HomeScreenBody extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const HomeScreenBody({super.key, required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                    color: backgroundColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TKTRUYEN',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search, color: textColor),
                            ),
                          ],
                        ),
                        SectionTabs(backgroundColor: backgroundColor, textColor: textColor),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        NewlyPostedSection(backgroundColor: backgroundColor, textColor: textColor),
                        const SizedBox(height: 24),
                        LatestUpdatedSection(backgroundColor: backgroundColor, textColor: textColor),
                        const SizedBox(height: 24),
                        CompleteStoriesSection(backgroundColor: backgroundColor, textColor: textColor),
                        const SizedBox(height: 24),
                        Discovery(backgroundColor: backgroundColor, textColor: textColor),
                        const SizedBox(height: 24),
                        Tags(backgroundColor: backgroundColor, textColor: textColor)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
