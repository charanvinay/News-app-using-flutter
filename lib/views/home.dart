import 'package:e_news/helper/news.dart';
import 'package:e_news/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Scaffold(
      body: _loading
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "e",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "News",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            )
          : PageView.builder(
              itemCount: articles.length,
              scrollDirection: Axis.vertical,
              controller: controller,
              itemBuilder: (context, index) {
                return BlogTile(
                  headline: articles[index].headline,
                  date: articles[index].date,
                  image: articles[index].image,
                  content: articles[index].content,
                );
              },
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String? headline, date, image, content;

  const BlogTile({
    Key? key,
    this.headline,
    this.date,
    this.content,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image.network(
            image!,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white60,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(16),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      headline!,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 40,
                          height: 2,
                          alignment: Alignment.topLeft,
                          color: Colors.blue,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          width: 20,
                          height: 2,
                          alignment: Alignment.topLeft,
                          color: Colors.blue,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            content!,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            date!,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottonIcons(
                      svgSrc: "https://www.svgrepo.com/show/93192/share.svg",
                      text: "Share",
                    ),
                    BottonIcons(
                      svgSrc: "https://www.svgrepo.com/show/39042/download.svg",
                      text: "Save",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottonIcons extends StatelessWidget {
  final String svgSrc, text;
  const BottonIcons({
    Key? key,
    required this.svgSrc,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.network(
          svgSrc,
          width: 18,
          height: 18,
          color: Colors.blue,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
