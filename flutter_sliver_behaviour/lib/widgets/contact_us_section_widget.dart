import 'package:flutter/material.dart';
import 'package:flutter_csw/models/contact_us_section.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:provider/provider.dart';

class ContactUsSectionWidget extends StatefulWidget {
  const ContactUsSectionWidget({super.key});

  @override
  State<ContactUsSectionWidget> createState() => _ContactUsSectionWidgetState();
}

class _ContactUsSectionWidgetState extends State<ContactUsSectionWidget> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return ChangeNotifierProvider.value(
      value: context.read<ProviderStorer>().contactUsSection ??=
          ContactUsSection(),
      builder: (context, child) {
        print('building provider builder $runtimeType');

        return Container(
          height: 700,
          width: 70,
          color: Colors.blue,
          child: Text('${context.watch<ContactUsSection>().number}'),
        );
      },
    );
  }
}
