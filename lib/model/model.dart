class Users {
   String?  id;
  final String?  nom;
  final String ? contact;
  final String ? image;

  Users({
     this.id = '',
    required this.nom,
    required this.contact,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'contact': contact,
        'image':image,
      };
       static Users fromJson(Map<String, dynamic> json) => Users(
     id: json['id'],
      nom: json['nom'],
      contact: json['contact'],
      image:json['image'],
      );
}