import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String? videoPath;

  const VideoPage({super.key, required this.videoPath});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<Widget> buttons = const [
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(widget.videoPath!),
      ),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 9 / 16,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text(errorMessage));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _chewieController!.pause();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .6,
        child: Chewie(controller: _chewieController!),
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
                    await ImageGallerySaver.saveFile(widget.videoPath!)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('video Saved'),
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
