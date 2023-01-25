import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_save_whatsapp/pages/widgets/image.dart';
import 'package:status_save_whatsapp/pages/widgets/video.dart';

import '../provider/bottom_nav_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [
    ImageWidget(),
    VideoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Status Saver')),
          body: pages[controller.currentPage],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              controller.changePage(value);
            },
            currentIndex: controller.currentPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: 'Image',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Video',
              ),
            ],
          ),
        );
      },
    );
  }
}
