// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cyber_hulk/utilis/container_text.dart';

class Hackingtext extends StatefulWidget {
  const Hackingtext({super.key});

  @override
  State<Hackingtext> createState() => _HackingtextState();
}

class _HackingtextState extends State<Hackingtext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText.hackingInfo[index]["question"]
                          .toString()),
                      subtitle: Text(ContainerText.hackingInfo[index]["answer"]
                          .toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.hackingInfo.length),
          )
        ],
      ),
    );
  }
}
