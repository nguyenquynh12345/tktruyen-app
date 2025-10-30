
class Story {
  final int id;
  final String storyName;
  final String author;
  final String sourceUrl;
  final String site;
  final String name;
  final String image;
  final bool active;
  final int? chapterFrom;
  final int? chapterTo;
  final String description;

  Story({
    required this.id,
    required this.storyName,
    required this.author,
    required this.sourceUrl,
    required this.site,
    required this.name,
    required this.image,
    required this.active,
    this.chapterFrom,
    this.chapterTo,
    required this.description,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      storyName: json['storyName'] ?? '',
      author: json['author'] ?? '',
      sourceUrl: json['sourceUrl'] ?? '',
      site: json['site'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      active: json['active'] ?? false,
      chapterFrom: json['chapterFrom'],
      chapterTo: json['chapterTo'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storyName': storyName,
      'author': author,
      'sourceUrl': sourceUrl,
      'site': site,
      'name': name,
      'image': image,
      'active': active,
      'chapterFrom': chapterFrom,
      'chapterTo': chapterTo,
      'description': description,
    };
  }
}
