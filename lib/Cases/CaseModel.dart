class Cases {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final int clientId;

  const Cases({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.clientId,
  });

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      clientId: json['clientId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "categoryId": categoryId,
    "clientId": clientId
  };
}
