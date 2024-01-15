// screens/article_list.dart
import 'package:paperweft/common/widget/button_default.dart';
import 'package:paperweft/common/widget/header_default.dart';
import 'package:paperweft/core/localization/language_string.dart';
import 'package:paperweft/core/style/app_color.dart';
import 'package:paperweft/core/style/app_size.dart';
import 'package:paperweft/core/style/app_typography.dart';
import 'package:paperweft/module/house/data/model/article_model.dart';
import 'package:paperweft/module/house/data/model/database_helper.dart';
import 'package:paperweft/module/house/screen/edit_article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HouseScreen extends StatefulWidget {
  @override
  _ArticleListScreenState createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<HouseScreen> {
  late Future<List<Article>> articles;

  bool isdark = true;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<void> refreshList() async {
    setState(() {
      articles = DatabaseHelper.instance.getArticles();
    });
  }

  String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'good morning.';
    } else if (hour >= 12 && hour < 17) {
      return 'good afternoon.';
    } else {
      return 'good evening.';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    DateTime now = new DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM').format(now);
    AppSize().init(context);
    String greeting = getGreeting();
    return Scaffold(
      backgroundColor: isdark == true ? Colors.black : Colors.white,
      // appBar: HeaderDefault(
      //   backgroundColor: isdark == true ? Colors.black87 : Colors.white,
      //   title: "good morning.",
      //   titleStyle: GoogleFonts.lato(),
      //   //  TextStyle(color: isdark == true ? Colors.white : Colors.black, fontFamily: ),

      //   leading: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                controller: scrollController,
                itemCount: (snapshot.data as List<Article>).length,
                itemBuilder: (context, index) {
                  Article article = snapshot.data![index];
                  return Column(children: [
                    index == 0
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                greeting.toString(),
                                style: GoogleFonts.lato(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: isdark == true
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                formattedDate.toString(),
                                style: GoogleFonts.lato(
                                    color: isdark == true
                                        ? Colors.white
                                        : Colors.black),
                              )
                            ],
                          )
                        : Container(),

                    // index == 0 ? search() : Container(),
                    section(article)
                  ]);
                },
              );
            }
          },
        ),
      ),
      // bottomNavigationBar: Container(
      //   child: ButtonDefault(
      //     height: 50.0,
      //     width: AppSize.screenWidth * 0.8,
      //     margin: EdgeInsets.all(10.0),
      //     borderRadius: 50.0,
      //     textStyle: TextStyle(fontSize: 18.0),
      //     title: 'Start a New Journal',
      //     iconColor: Colors.black,
      //     titleColor: Colors.black,
      //     backgroundColor: Colors.grey.shade200,
      //     borderRadiusColor: Colors.black,
      //     onTap: () {
      //       Get.to(EditArticleScreen());
      //       // Implement onTap logic here
      //     },
      //   ),
      // ),
    );
  }

  Widget section(Article article) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // SvgPicture.asset(image),
                Icon(
                  Icons.radio_button_checked,
                  color: isdark == true ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: AppSize.screenWidth * 0.7,
                    child: Text(
                      article.title,
                      style: AppTypography.body2(
                        color: isdark == true ? Colors.white : Colors.black,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: isdark == true ? Colors.white : Colors.black87,
                          width: 4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(article.content.toString(),
                  //     style: AppTypography.body2()),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(EditArticleScreen(
                          article: article,
                        ));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            width: AppSize.screenWidth * 0.8,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isdark == true
                                  ? Colors.black87
                                  : Colors.white,
                              border: Border.all(
                                  color: isdark == true
                                      ? Colors.white
                                      : Colors.black),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.content.toString(),
                                    style: AppTypography.body1(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                                Text(article.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.headline4(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                                Text(article.content.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppTypography.body2(
                                        color: isdark == true
                                            ? Colors.white
                                            : Colors.black)),
                              ],
                            ),
                          )))
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [],
        )
      ],
    );
  }

  Widget search() {
    TextEditingController searchController = TextEditingController();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      color: AppColors.greywhite,
      child: Row(children: [
        // SvgPicture.asset(AppAssets.search),
        const SizedBox(
          width: 19,
        ),
        Expanded(
            flex: 1,
            child: TextField(
              controller: searchController,
              // onChanged: (value) => c.filterDataList(value),
              onEditingComplete: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: "",
              ),
            ))
      ]),
    );
  }
}
