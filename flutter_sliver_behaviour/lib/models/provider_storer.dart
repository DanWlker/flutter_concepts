import 'package:flutter_csw/models/article_section.dart';
import 'package:flutter_csw/models/contact_us_section.dart';
import 'package:flutter_csw/models/news_section.dart';
import 'package:flutter_csw/models/promotion_section.dart';
import 'package:flutter_csw/models/video_section.dart';

class ProviderStorer {
  ArticleSection? articleSection;
  ContactUsSection? contactUsSection;
  NewsSection? newsSection;
  PromotionSection? promotionSection;
  VideoSection? videoSection;

  ProviderStorer() {
    print('Creating $runtimeType');
  }
}
