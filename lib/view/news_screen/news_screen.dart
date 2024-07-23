import 'dart:convert';

import 'package:cyber_hulk/model/news_model.dart';
import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  // my
  NewsModel newsModel = NewsModel();
  Future<void> newsDetails() async {
    String url = "https://cybot.avanzosolutions.in/cybot/newsdisplay.php";
    var res = await http.get(Uri.parse(url));
    var json = jsonDecode(res.body) as Map<String, dynamic>;
    newsModel = NewsModel.fromJson(json);
    print(json);
    setState(() {});
  }

  callInit() async {
    await newsDetails();
  }

  @override
  void initState() {
    super.initState();
    callInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: ListView.separated(
          itemCount: newsModel.list?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: newsModel.list?.length ?? 0,
                    //   itemBuilder: (context, index) {
                    //     return GestureDetector(
                    //       onTap: _toggleExpanded,
                    //       child: Text(
                    //         newsModel.list?[index].cont ?? "",
                    //         maxLines: _isExpanded ? null : 3,
                    //         overflow: _isExpanded
                    //             ? TextOverflow.visible
                    //             : TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //           fontSize: 28,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                    Text(
                      newsModel.list?[index].cont ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * .25,
                      color: ColorConstant.darkpurple,
                      child: Image.network(
                        "https://cybot.avanzosolutions.in/cybot/newsimage/${newsModel.list?[index].filename}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Read more......",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 14,
          ),
        ),
      ),
    );
  }
}
