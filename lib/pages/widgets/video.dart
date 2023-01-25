import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_save_whatsapp/pages/widgets/vide_page.dart';
import 'package:status_save_whatsapp/utils/get_thumbnails.dart';

import '../../provider/get_statuses_provider.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusesProvider>(
        builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatuses('.mp4');
            Future.delayed(const Duration(microseconds: 1), () {
              _isFetched = true;
            });
          }

          return file.isWhatsappAvailable == false
              ? const Center(
                  child: Text('Whatsapp not available'),
                )
              : file.getVideos.isEmpty
                  ? const Center(
                      child: Text('No video available'),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        children: List.generate(
                          file.getVideos.length,
                          (index) {
                            final data = file.getVideos[index];
                            return FutureBuilder<String>(
                              future: getThumbnails(data.path),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => VideoPage(
                                                videoPath: data.path,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            image: DecorationImage(
                                              image: FileImage(
                                                File(snapshot.data!),
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              },
                            );
                          },
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
