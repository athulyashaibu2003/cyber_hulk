// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:cyber_hulk/utilis/container_text.dart';
import 'package:flutter/material.dart';

class CyberSecuritytext extends StatefulWidget {
  const CyberSecuritytext({super.key});

  @override
  State<CyberSecuritytext> createState() => _CyberSecuritytextState();
}

class _CyberSecuritytextState extends State<CyberSecuritytext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText.cybersecurityInfo[index]
                              ["question"]
                          .toString()),
                      subtitle: Text(ContainerText.cybersecurityInfo[index]
                              ["answer"]
                          .toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.cybersecurityInfo.length),
          )
        ],
      ),
    );
  }
}
