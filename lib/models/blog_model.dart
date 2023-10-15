class Blog {
  String id;

  String imageUrl;

  String title;

  bool? isFav;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.isFav = false,
  });

  Blog copyWith({String? id, String? imageUrl, String? title, bool? isFav}) {
    return Blog(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      isFav: isFav ?? this.isFav,
    );
  }

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
      id: json["id"],
      imageUrl: json["image_url"],
      title: json["title"],
      isFav: false);

  Map<String, dynamic> toJson() =>
      {"id": id, "image_url": imageUrl, "title": title, "isFav": false};

  List<Object?> get props => [
        id,
        imageUrl,
        title,
        isFav,
      ];
}
