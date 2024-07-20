import 'package:cyber_hulk/utilis/color_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  newsDetails() async {
    String url = "";
    var res = await http.post(Uri.parse(url), body: {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .25,
                    color: ColorConstant.darkpurple,
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
