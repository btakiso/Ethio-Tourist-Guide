class Destination {
  final int id;
  final String name;
  final String imageUrl;
  final String openingHours;
  final String description;
  bool isFavorite;
  final double rating; // Added rating property

  Destination({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.openingHours,
    required this.description,
    this.isFavorite = false,
    required this.rating, // Added rating to constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'openingHours': openingHours,
      'description': description,
      'isFavorite': isFavorite ? 0 : 1,
      'rating': rating, // Added rating to map
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      openingHours: map['openingHours'],
      description: map['description'],
      isFavorite: map['isFavorite'] == 1,
      rating: map['rating'], // Added rating mapping
    );
  }
}
