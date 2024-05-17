import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter += 1;

    var response = await get(
        Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'));

    var imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lets see some images!'),
        ),
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
