import 'package:crud_api/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostService {
  Future<List<PostModel>?> getAllPost() async {
    var url = Uri.parse('http://localhost:3000/posts');
    try {
      var response = await http.get(url);
      List lstPosts = json.decode(response.body);
      print("lst post $lstPosts");
      List<PostModel> posts = [];
      lstPosts.forEach((post) {
        posts.add(PostModel.fromJson(post));
      });
      return posts;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future createPost(String title, String body, String imageUrl) async {
    var url = Uri.parse('http://localhost:3000/posts');
    try {
      Map map = {'body': body, 'title': title, 'image_url': imageUrl};
      print(json.encode(map));
      var header = {"Content-Type": "application/json"};
      var response =
          await http.post(url, body: json.encode(map), headers: header);
      if (response.statusCode == 200) {
        return "created succesfully";
      } else {
        return "unable to create data";
      }
    } catch (ex) {
      print("error :$ex");
    }
  }

  Future<String> deletePost(int id) async {
    var url = Uri.parse('http://localhost:3000/posts/$id');
    try {
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return "delete success";
      } else {
        return "delete fail";
      }
    } catch (ex) {
      print("error : $ex");
      return "${ex}";
    }
  }

  Future updatePost(int id, String title, String body, String imageUrl) async {
    var url = Uri.parse('http://localhost:3000/posts/$id');
    var header = {"Content-Type": "application/json"};
    Map map = {'body': body, 'title': title, 'image_url': imageUrl};

    try {
      var response = await http.put(url, body: map);
      if (response.statusCode == 200) {
        return "updated succesfully";
      } else {
        return "unable to update data";
      }
    } catch (ex) {
      print("error : $ex");
      return "${ex}";
    }
  }
}
