import 'package:flutter/material.dart';
import 'package:heheheh/screens/home/discovery.dart';
import 'package:heheheh/screens/home/tag.dart';
import 'section_tabs.dart';
import 'newly_posted_section.dart';
import 'latest_updated_section.dart';
import 'complete_stories_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                    color: Colors.grey[900],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TKTRUYEN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search, color: Colors.white),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: SectionTabs(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        NewlyPostedSection(),
                        SizedBox(height: 24),
                        LatestUpdatedSection(),
                        SizedBox(height: 24),
                        CompleteStoriesSection(),
                        SizedBox(height: 24),
                        Discovery(),
                        SizedBox(height: 24),
                        Tags()
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
