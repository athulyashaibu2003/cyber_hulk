// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:cyber_hulk/utilis/container_text.dart';
import 'package:flutter/material.dart';

class Databreach extends StatefulWidget {
  const Databreach({super.key});

  @override
  State<Databreach> createState() => _DatabreachState();
}

class _DatabreachState extends State<Databreach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText.dataBreachInfo[index]
                              ["question"]
                          .toString()),
                      subtitle: Text(ContainerText.dataBreachInfo[index]
                              ["answer"]
                          .toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.dataBreachInfo.length),
          )
        ],
      ),
    );
  }
}
