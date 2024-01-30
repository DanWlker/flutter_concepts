import 'package:flutter/material.dart';
import 'package:flutter_csw/models/provider_storer.dart';
import 'package:flutter_csw/models/video_section.dart';
import 'package:provider/provider.dart';

class VideoSectionWidget extends StatefulWidget {
  const VideoSectionWidget({super.key});

  @override
  State<VideoSectionWidget> createState() => _VideoSectionWidgetState();
}

class _VideoSectionWidgetState extends State<VideoSectionWidget> {
  @override
  Widget build(BuildContext context) {
    print('building $runtimeType');
    return ChangeNotifierProvider.value(
      value: context.read<ProviderStorer>().videoSection ??= VideoSection(),
      builder: (context, child) {
        print('building provider builder $runtimeType');

        return Container(
          height: 700,
          width: 70,
          color: Colors.pink,
          child: Text('${context.watch<VideoSection>().number}'),
        );
      },
    );
  }
}
