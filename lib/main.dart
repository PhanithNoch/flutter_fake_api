import 'package:crud_api/models/post_model.dart';
import 'package:crud_api/screens/create_post.dart';
import 'package:crud_api/services/post_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostService postService = PostService();
  refreshData() async {
    postService.getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePostScreen(),
              ),
            ).then((value) {
              setState(() {
                refreshData();
              });
            });
          },
        ),
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: FutureBuilder<List<PostModel>?>(
          future: postService.getAllPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final data = snapshot.data![index];
                      print(data.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePostScreen(
                            id: data.id,
                            title: data.title,
                            body: data.body,
                            image_url: data.imageUrl,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                          title: Text(snapshot.data![index].title!),
                          subtitle: Text(snapshot.data![index].body!),
                          leading: Image.network(
                            snapshot.data![index].imageUrl!,
                            fit: BoxFit.cover,
                          ),
                          trailing: TextButton(
                              onPressed: () {
                                postService
                                    .deletePost(snapshot.data![index].id!);
                                setState(() {
                                  postService.getAllPost();
                                });
                              },
                              child: Text("Delete"))),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          },
        ));
  }
}
