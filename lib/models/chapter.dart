class Chapter {
  final int id;
  final int chapterNumber;
  final String title;
  final String content;
  final int totalChapters;

  Chapter({
    required this.id,
    required this.chapterNumber,
    required this.title,
    required this.content,
    required this.totalChapters,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      chapterNumber: json['chapterNumber'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      totalChapters: json['totalChapters'] ?? 0,
    );
  }
}
