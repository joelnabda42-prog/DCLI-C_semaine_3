class Redacteur {
  int? id;
  String nom;
  String prenom;
  String email;

  // Constructeur sans id (pour insertion)
  Redacteur({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // Constructeur avec id (pour lecture / mise à jour)
  Redacteur.withId({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }

  //  récupérer depuis SQLite
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur.withId(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}
