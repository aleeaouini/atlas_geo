class Country {
  final String nom;
  final String capitale;
  final String population;
  final String superficie;
  final String langues;
  final String flagUrl;

  Country({
    required this.nom,
    required this.capitale,
    required this.population,
    required this.superficie,
    required this.langues,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      nom: json["nom"],
      capitale: json["capitale"],
      population: json["population"],
      superficie: json["superficie"],
      langues: json["langues"],
      flagUrl: json["flagUrl"] ?? "",
    );
  }
}
