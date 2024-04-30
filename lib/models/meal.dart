class Meal {
  final int? id;
  final String name;
  final String description;
  final String imageUrl;
  final int calories;

  Meal({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.calories,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'calories': calories,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      calories: map['calories'],
    );
  }
}