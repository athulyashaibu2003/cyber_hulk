// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:cyber_hulk/utilis/container_text.dart';
import 'package:flutter/material.dart';

class DDOSAttacktext extends StatefulWidget {
  const DDOSAttacktext({super.key});

  @override
  State<DDOSAttacktext> createState() => _DDOSAttacktextState();
}

class _DDOSAttacktextState extends State<DDOSAttacktext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText.ddosAttackInfo[index]
                              ["question"]
                          .toString()),
                      subtitle: Text(ContainerText.ddosAttackInfo[index]
                              ["answer"]
                          .toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.ddosAttackInfo.length),
          )
        ],
      ),
    );
  }
}
