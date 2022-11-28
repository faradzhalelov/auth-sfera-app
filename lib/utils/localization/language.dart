class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'RU', 'ru'),
      Language(2, 'US', 'en'),
      Language(3, 'ES', 'es'),
    ];
  }
}
