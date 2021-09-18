import 'package:crud_api/models/post_model.dart';
import 'package:crud_api/services/post_service.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final int? id;
  final String? title;
  final String? body;
  final String? image_url;

  CreatePostScreen({this.id, this.title, this.body, this.image_url});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  final PostService postService = PostService();

  @override
  void initState() {
    if (widget.id != null) {
      titleController.text = widget.title!;
      bodyController.text = widget.body!;
      imageController.text = widget.image_url!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(hintText: "Body"),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(hintText: "Image Url "),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      final title = titleController.text;
                      final body = bodyController.text;
                      final imageUrl = imageController.text;
                      print(body);
                      if (widget.id != null) {
                        postService.updatePost(
                            widget.id!, title, body, imageUrl);
                      } else {
                        postService.createPost(title, body, imageUrl);
                      }
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
