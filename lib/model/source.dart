class Source {
  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? country;
  final String? language;
  Source(
      {required this.category,
      required this.country,
      required this.description,
      required this.id,
      required this.language,
      required this.name,
      required this.url});

  Source.fromMap(Map<String, dynamic> map)
      : category = map['category'],
        country = map['country'],
        description = map['description'],
        id = map['id'],
        language = map['language'],
        name = map['name'],
        url = map['url'];
}
