enum LanguageType {
  american('English, US', 'images/flags/usa.png'),
  english('English, UK', 'images/flags/great-britain.png'),
  german('Deutsch', 'images/flags/germany.png'),
  italian('Italiano', 'images/flags/italy.png'),
  japanese('日本語', 'images/flags/japan.png'),
  chinese('中国人', 'images/flags/china.png'),
  spanish('Español', 'images/flags/spain.png'),
  french('Français', 'images/flags/france.png'),
  russian('Pусский', 'images/flags/russian-federation.png');

  final String name;
  final String asset;

  const LanguageType(this.name, this.asset);
}
