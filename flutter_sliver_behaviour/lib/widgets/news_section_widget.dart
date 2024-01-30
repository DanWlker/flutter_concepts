import 'package:flutter/material.dart';
import 'package:flutter_csw/models/news_section.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:provider/provider.dart';

class NewsSectionWidget extends StatefulWidget {
  const NewsSectionWidget({super.key});

  @override
  State<NewsSectionWidget> createState() => _NewsSectionWidgetState();
}

class _NewsSectionWidgetState extends State<NewsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return ChangeNotifierProvider.value(
      value: context.read<ProviderStorer>().newsSection ??= NewsSection(),
      builder: (context, child) {
        print('building provider builder $runtimeType');

        return Container(
          height: 700,
          width: 70,
          color: Colors.green,
          child: Text('${context.watch<NewsSection>().number}'),
        );
      },
    );
  }
}
