enum LanguageLabel {
  english('English', 'en'),
  russian('Russian', 'ru'),
  german('German', 'de'),
  estonian('Estonian', 'et'),
  italian('Italian', 'it');

  const LanguageLabel(this.label, this.code);

  final String label;
  final String code;
}
