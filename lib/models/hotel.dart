class Hotel {
  final int id;
  final String name;
  final double rating;
  final String imageUrl; // Added imageUrl property
  final String description; // Added description property

  Hotel({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl, // Added imageUrl to constructor
    required this.description, // Added description to constructor
  });

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'],
      name: map['name'],
      rating: map['rating'],
      imageUrl: map['imageUrl'], // Added imageUrl mapping
      description: map['description'], // Added description mapping
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'imageUrl': imageUrl, // Added imageUrl to map
      'description': description, // Added description to map
    };
  }
}