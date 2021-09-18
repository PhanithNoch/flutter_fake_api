class PostModel {
  int? id;
  String? title;
  String? body;
  String? imageUrl;
  String? author;

  PostModel(
      {this.id,
      required this.title,
      required this.body,
      required this.imageUrl,
      required this.author});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    imageUrl = json['image_url'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image_url'] = this.imageUrl;
    data['author'] = this.author;
    return data;
  }
}
