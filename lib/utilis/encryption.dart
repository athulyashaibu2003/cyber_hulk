// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cyber_hulk/utilis/container_text.dart';

class Encryptiontext extends StatefulWidget {
  const Encryptiontext({super.key});

  @override
  State<Encryptiontext> createState() => _EncryptiontextState();
}

class _EncryptiontextState extends State<Encryptiontext> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      title: Text(ContainerText
                          .encryptionCyberSecurityInfo[index]["question"]
                          .toString()),
                      subtitle: Text(ContainerText
                          .encryptionCyberSecurityInfo[index]["answer"]
                          .toString()),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: ContainerText.encryptionCyberSecurityInfo.length),
          )
        ],
      ),
    );
  }
}
