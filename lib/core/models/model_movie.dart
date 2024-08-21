class ModelMovie {
  int? id;
  String title;
  String description;
  String imagePath; // Store the file path as a string
  bool isFavourite;

  ModelMovie({
    this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isFavourite = false,
  });

  // Convert ImageModel to a Map. This will be used to insert/update the record in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'isFavourite': isFavourite ? 1 : 0, // SQLite doesn't have a boolean type
    };
  }

  // Convert a Map into an ImageModel object. This will be used to read data from the database.
  factory ModelMovie.fromMap(Map<String, dynamic> map) {
    return ModelMovie(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      isFavourite: map['isFavourite'] == 1,
    );
  }

  // Add a copyWith method to clone the object with modified properties.
  ModelMovie copyWith({
    int? id,
    String? title,
    String? description,
    String? imagePath,
    bool? isFavourite,
  }) {
    return ModelMovie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
