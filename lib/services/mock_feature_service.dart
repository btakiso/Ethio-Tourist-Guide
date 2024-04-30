import '../models/destination.dart';
import '../models/hotel.dart';
import '../models/restaurant.dart'; // Import Destination model

class MockDataService {
  static List<Hotel> getHotels() {
    return [
      Hotel(
          id: 1,
          name: "Sheraton Addis",
          rating: 5.0,
          imageUrl: 'images/sheraton_addis.jpg',
          description:
              'Luxury hotel in Addis Ababa with stunning views and world-class amenities.'),
      Hotel(
          id: 2,
          name: "Hilton Addis Ababa",
          rating: 4.5,
          imageUrl: 'images/hilton_addis.jpg',
          description:
              'A landmark hotel offering exceptional service in the heart of the city.'),
      Hotel(
          id: 3,
          name: "Radisson Blu Hotel, Addis Ababa",
          rating: 4.5,
          imageUrl: 'images/radisson_blu_addis.jpg',
          description:
              'Modern hotel with spacious rooms, located close to the airport.'),
      Hotel(
          id: 4,
          name: "Jupiter International Hotel",
          rating: 4.0,
          imageUrl: 'images/jupiter_international.jpg',
          description:
              'Comfortable accommodations with traditional Ethiopian hospitality.'),
    ];
  }

  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
          id: 1,
          name: "Kategna Restaurant",
          rating: 4.8,
          imageUrl: 'images/kategna_restaurant.jpg',
          description: 'Authentic Ethiopian cuisine with a cozy atmosphere.'),
      Restaurant(
          id: 2,
          name: "Yod Abyssinia Traditional Restaurant",
          rating: 4.7,
          imageUrl: 'images/yod_abyssinia.jpg',
          description:
              'Experience traditional Ethiopian music and dance along with your meal.'),
      Restaurant(
          id: 3,
          name: "2000 Habesha Cultural Restaurant",
          rating: 4.6,
          imageUrl: 'images/2000_habesha.jpg',
          description:
              'A cultural dining experience with a variety of Ethiopian dishes.'),
      Restaurant(
          id: 4,
          name: "Tomoca Coffee",
          rating: 4.9,
          imageUrl: 'images/tomoca_coffee.jpg',
          description: 'Famous for its rich Ethiopian coffee and pastries.'),
    ];
  }

  static List<String> getTopDestinationImages() {
    return [
      'images/rock_hewn_churches.jpg',
      'images/simien_mountains.jpg',
      'images/lalibela.jpg',
      'images/omo_valley.jpg',
    ];
  }

  static List<String> getPopularDestinationImages() {
    return [
      'images/gondar_castles.jpg',
      'images/axum_obelisks.jpg',
      'images/blue_nile_falls.jpg',
      'images/awash_national_park.jpg',
    ];
  }

  // Added getPopularDestinations method to return a list of popular destinations
  static List<Destination> getPopularDestinations() {
    return [
      Destination(
          id: 1,
          name: "Gondar Castles",
          imageUrl: 'images/gondar_castles.jpg',
          openingHours: "9:00 AM - 5:00 PM",
          description: "Explore the royal enclosures of Gondar.",
          rating: 4.5),
      Destination(
          id: 2,
          name: "Axum Obelisks",
          imageUrl: 'images/axum_obelisks.jpg',
          openingHours: "8:00 AM - 6:00 PM",
          description: "Discover the ancient obelisks of Axum.",
          rating: 4.7),
      Destination(
          id: 3,
          name: "Blue Nile Falls",
          imageUrl: 'images/blue_nile_falls.jpg',
          openingHours: "8:00 AM - 5:00 PM",
          description: "Witness the breathtaking Blue Nile Falls.",
          rating: 4.8),
      Destination(
          id: 4,
          name: "Awash National Park",
          imageUrl: 'images/awash_national_park.jpg',
          openingHours: "6:00 AM - 6:00 PM",
          description:
              "Experience the wildlife and natural beauty of Awash National Park.",
          rating: 4.9),
    ];
  }

  addFeature({required String title, required String description}) {}
}
