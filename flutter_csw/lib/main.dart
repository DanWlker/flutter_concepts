import 'package:flutter/material.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:flutter_csw/widgets/article_section_widget.dart';
import 'package:flutter_csw/widgets/contact_us_section_widget.dart';
import 'package:flutter_csw/widgets/news_section_widget.dart';
import 'package:flutter_csw/widgets/promotion_section_widget.dart';
import 'package:flutter_csw/widgets/video_section_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return Provider(
        create: (context) => ProviderStorer(),
        builder: (context, child) {
          print('building ProviderStorer');

          return Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.read<ProviderStorer>().articleSection?.refresh();
            }),
            // ListView will built ListView.builder items all at once when even one scrolls into view (since shrinkwrap)
            body: ListView(
              children: [
                const ArticleSectionWidget(),
                const ContactUsSectionWidget(),
                const NewsSectionWidget(),
                // When scrolling up again notice the widget above gets rebuild
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 90,
                  itemBuilder: (context, index) {
                    print('building item pink $index');
                    return Container(
                      height: 50,
                      width: 60,
                      color: Colors.pink[index % 9 * 100],
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    print('building item orange $index');
                    return Container(
                      height: 50,
                      width: 60,
                      color: Colors.orange[index * 100],
                    );
                  },
                ),
                const PromotionSectionWidget(),
                const VideoSectionWidget(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    print('building item blue $index');
                    return Container(
                      height: 50,
                      width: 60,
                      color: Colors.blue[index * 100],
                    );
                  },
                )
              ],
            ),

            // Uncomment this section to see that SliverList items are only built when each individual items are
            // scrolled into view.
            // body: CustomScrollView(
            //   slivers: [
            //     const SliverToBoxAdapter(child: ArticleSectionWidget()),
            //     const SliverToBoxAdapter(child: ContactUsSectionWidget()),
            //     const SliverToBoxAdapter(child: NewsSectionWidget()),
            //     // Notice for CustomScrollView, the top items doesn't get rebuilt even when the list is huge
            //     SliverList.builder(
            //       itemCount: 180,
            //       itemBuilder: (context, index) {
            //         print('building item pink $index');
            //         return Container(
            //           height: 50,
            //           width: 60,
            //           color: Colors.pink[index % 9 * 100],
            //         );
            //       },
            //     ),
            //     SliverList.builder(
            //       itemCount: 9,
            //       itemBuilder: (context, index) {
            //         print('building item orange $index');
            //         return Container(
            //           height: 50,
            //           width: 60,
            //           color: Colors.orange[index * 100],
            //         );
            //       },
            //     ),
            //     const SliverToBoxAdapter(child: PromotionSectionWidget()),
            //     const SliverToBoxAdapter(child: VideoSectionWidget()),
            //     SliverList.builder(
            //       itemCount: 9,
            //       itemBuilder: (context, index) {
            //         print('building item blue $index');
            //         return Container(
            //           height: 50,
            //           width: 60,
            //           color: Colors.blue[index * 100],
            //         );
            //       },
            //     ),
            //   ],
            // ),
          );
        });
  }
}
