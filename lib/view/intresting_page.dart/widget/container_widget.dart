//import 'package:cyber_hulk/core/constants/database/dumm_db.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget(
      {super.key,
      required this.index,
      this.image,
      this.insidetext,
      this.width});
  final image;
  final insidetext;
  final int index;
  final width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 201, 115, 216),
          // borderRadius: BorderRadius.circular(15)
          ),
      child: LayoutBuilder(
          builder: (context, constraints) => index % 2 == 0 || index == 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.fill),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        height: constraints.maxHeight * .71,
                        width: constraints.maxWidth),
                    Spacer(),
                    Container(
                        child: Center(
                          child: Text(
                            insidetext,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 201, 115, 216),
                            borderRadius: BorderRadius.circular(10)),
                        height: constraints.maxHeight * .26,
                        width: constraints.maxWidth)
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        child: Center(
                          child: Text(
                            insidetext,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 201, 115, 216),
                            borderRadius: BorderRadius.circular(10)),
                        height: constraints.maxHeight * .26,         
                        width: constraints.maxWidth),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.fill),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        height: constraints.maxHeight * .71,
                        width: constraints.maxWidth),
                  ],
                )),
    );
  }
}
