class Destination {
  final int id;
  final String title;
  final String location;
  final String rating;
  final String imagePath;
  final String overview;
  final String details;
  final String temperature;
  final String travelTime;
  final String minimumPrice;

  Destination({
    required this.id,
    required this.title,
    required this.location,
    required this.rating,
    required this.imagePath,
    required this.overview,
    required this.details,
    required this.temperature,
    required this.travelTime,
    required this.minimumPrice,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      rating: json['rating'],
      imagePath: json['imagePath'],
      overview: json['overview'],
      details: json['details'],
      temperature: json['temperature'],
      travelTime: json['travelTime'],
      minimumPrice: json['minimumPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'rating': rating,
      'imagePath': imagePath,
      'overview': overview,
      'details': details,
      'temperature': temperature,
      'travelTime': travelTime,
      'minimumPrice': minimumPrice,
    };
  }
}
