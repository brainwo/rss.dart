import 'package:rss_dart/domain/media/category.dart';
import 'package:rss_dart/domain/media/content.dart';
import 'package:rss_dart/domain/media/credit.dart';
import 'package:rss_dart/domain/media/description.dart';
import 'package:rss_dart/domain/media/thumbnail.dart';
import 'package:rss_dart/domain/media/rating.dart';
import 'package:rss_dart/util/helpers.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content> contents;
  final List<Credit> credits;
  final Category? category;
  final Rating? rating;
  final List<Thumbnail> thumbnail;
  final Description? description;

  const Group({
    this.contents = const <Content>[],
    this.credits = const <Credit>[],
    this.category,
    this.rating,
    this.thumbnail = const <Thumbnail>[],
    this.description,
  });

  static Group? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }
    return Group(
      contents: element
          .findElements('media:content')
          .map((e) => Content.parse(e))
          .toList(),
      credits: element
          .findElements('media:credit')
          .map((e) => Credit.parse(e))
          .toList(),
      category: Category.parse(findElementOrNull(element, 'media:category')),
      rating: Rating.parse(findElementOrNull(element, 'media:rating')),
      thumbnail: element
          .findElements('media:thumbnail')
          .map((e) => Thumbnail.parse(e))
          .toList(),
      description: Description.parse(
        findElementOrNull(element, 'media:description'),
      ),
    );
  }
}
