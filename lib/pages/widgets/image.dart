import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_save_whatsapp/pages/widgets/image_page.dart';
import 'package:status_save_whatsapp/provider/get_statuses_provider.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusesProvider>(
        builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatuses('jpg');
            Future.delayed(const Duration(microseconds: 1), () {
              _isFetched = true;
            });
          }

          return file.isWhatsappAvailable == false
              ? const Center(
                  child: Text('Whatsapp not available'),
                )
              : file.getImages.isEmpty
                  ? const Center(
                      child: Text('No image available'),
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
                        children: List.generate(file.getImages.length, (index) {
                          final data = file.getImages[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ImagePage(
                                    imagePath: data.path,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  image: FileImage(File(data.path)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
        },
      ),
    );
  }
}
