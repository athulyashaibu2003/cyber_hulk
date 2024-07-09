import 'package:cyber_hulk/utilis/dummy_db.dart/dummy_db.dart';
import 'package:cyber_hulk/utilis/theme_swich/theme_switch.dart';
import 'package:cyber_hulk/view/intresting_page.dart/widget/container_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          backgroundColor: const Color.fromARGB(255, 201, 115, 216),
          // floating: true,
          pinned: true,
          actions: [
            ThemeSwitch(),
            const SizedBox(width: 10),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: const Text(
              'Interesting Facts',
              style: TextStyle(color: Colors.white),
            ),
            background: Image.network(
              'https://media.licdn.com/dms/image/D5612AQH1ysKwdVnA8w/article-cover_image-shrink_600_2000/0/1690159564074?e=2147483647&v=beta&t=dHRP30xoLr_ZRWFu7w-AhKJf0viBejPcb5xrdtylfPE', // this image will replace the AppBar when scrolled
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(30),
          sliver: SliverGrid.builder(
            itemCount: BottomSheetContainer.info.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // FactsBottomSheet(context, index);
              },
              child: ContainerWidget(
                image: BottomSheetContainer.info[index]['details'][0]['img'],
                insidetext: BottomSheetContainer.info[index]['details'][0]
                    ['name'],
                index: index,
                width: MediaQuery.sizeOf(context).width * .22,
              ),
            ),
          ),
        )
      ],
    )
        // ClipPath(
        //   clipper: CustomClipPath(),
        //   child: Container(
        //     color: Colors.red,
        //     child: const Center(
        //       child: Text(
        //         'Bezier Curve',
        //         style: TextStyle(
        //           fontSize: 34,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     height: 400,
        //   ),
        // ),
        );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();
    // path.moveTo(0, 100);
    path.lineTo(0, height);
    path.quadraticBezierTo(100, 900, width, 0);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
