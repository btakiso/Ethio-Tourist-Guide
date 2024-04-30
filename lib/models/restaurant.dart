class Restaurant {
 final int id;
 final String name;
 final double rating;
 final String imageUrl;
 final String description; // Added description property

 Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.description, // Added description to constructor
 });

 factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      rating: map['rating'],
      imageUrl: map['imageUrl'],
      description: map['description'], // Added description mapping
    );
 }

 // Add the toMap method here
 Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'imageUrl': imageUrl,
      'description': description,
    };
 }
}