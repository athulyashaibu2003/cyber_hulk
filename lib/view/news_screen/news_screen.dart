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
  bool _emptyCheck = true;
  bool _isLoading = true;
  NewsModel newsModel = NewsModel();

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Future<void> newsDetails() async {
    String url = "https://cybot.avanzosolutions.in/cybot/newsdisplay.php";
    var res = await http.get(Uri.parse(url));
    var json = jsonDecode(res.body) as Map<String, dynamic>;
    newsModel = NewsModel.fromJson(json);
    _emptyCheck = newsModel.list?.length == 0;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> callInit() async {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("News Updates for Today"),
        backgroundColor: ColorConstant.pantonemessage,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _emptyCheck
              ? Center(child: Text("No Updates"))
              : RefreshIndicator(
                  onRefresh: newsDetails,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: ListView.separated(
                      itemCount: newsModel.list?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: _toggleExpanded,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newsModel.list?[index].cont ?? "",
                                    maxLines: _isExpanded ? null : 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      "https://cybot.avanzosolutions.in/cybot/newsimage/${newsModel.list?[index].filename}",
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: Text('Image not available'));
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text.rich(
                                    TextSpan(
                                      text: "Read more",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorConstant.darkpurple,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 14),
                    ),
                  ),
                ),
    );
  }
}
