import 'package:flutter/material.dart';
import 'package:flutter_csw/models/article_section.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:provider/provider.dart';

class ArticleSectionWidget extends StatefulWidget {
  const ArticleSectionWidget({super.key});

  @override
  State<ArticleSectionWidget> createState() => _ArticleSectionWidgetState();
}

class _ArticleSectionWidgetState extends State<ArticleSectionWidget> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return ChangeNotifierProvider.value(
        value: context.read<ProviderStorer>().articleSection ??=
            ArticleSection(),
        builder: (context, child) {
          print('building provider builder $runtimeType');

          return Container(
            height: 700,
            width: 70,
            color: Colors.red,
            child: Text('${context.watch<ArticleSection>().number}'),
          );
        });
  }
}
