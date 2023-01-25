import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImagePage extends StatefulWidget {
  final String? imagePath;

  const ImagePage({super.key, this.imagePath});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<Widget> buttons = const [
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(widget.imagePath!)),
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(buttons.length, (index) {
          return Container(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              heroTag: "$index",
              onPressed: () async {
                switch (index) {
                  case 0:
                    print('Download');
                    await ImageGallerySaver.saveFile(widget.imagePath!)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image Saved'),
                        ),
                      );
                    });
                    break;
                  case 1:
                    print('Print');
                    break;
                  case 2:
                    print('Share');
                    break;
                  default:
                }
              },
              child: buttons[index],
            ),
          );
        }),
      ),
    );
  }
}
