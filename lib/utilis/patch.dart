// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cyber_hulk/utilis/container_text.dart';

class Patchtext extends StatefulWidget {
  const Patchtext({super.key});

  @override
  State<Patchtext> createState() => _PatchtextState();
}

class _PatchtextState extends State<Patchtext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText.patchInfo[index]["question"]
                          .toString()),
                      subtitle: Text(
                          ContainerText.patchInfo[index]["answer"].toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.patchInfo.length),
          )
        ],
      ),
    );
  }
}
