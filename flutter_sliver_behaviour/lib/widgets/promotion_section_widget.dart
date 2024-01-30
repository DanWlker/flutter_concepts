import 'package:flutter/material.dart';
import 'package:flutter_csw/models/promotion_section.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:provider/provider.dart';

class PromotionSectionWidget extends StatefulWidget {
  const PromotionSectionWidget({super.key});

  @override
  State<PromotionSectionWidget> createState() => _PromotionSectionWidgetState();
}

class _PromotionSectionWidgetState extends State<PromotionSectionWidget> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return ChangeNotifierProvider.value(
      value: context.read<ProviderStorer>().promotionSection ??=
          PromotionSection(),
      builder: (context, child) {
        print('building provider builder $runtimeType');

        return Container(
          height: 700,
          width: 70,
          color: Colors.yellow,
          child: Text('${context.watch<PromotionSection>().number}'),
        );
      },
    );
  }
}
