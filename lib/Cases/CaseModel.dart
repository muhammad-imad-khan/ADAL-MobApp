class Cases {
  final int id;
  final String name;
  final String clientName;
  final String description;
  final String comment;
  final String status;
  final int offer;
  final int categoryId;
  final int clientId;

  const Cases({
    required this.id,
    required this.name,
    required this.clientName,
    required this.description,
    required this.comment,
    required this.status,
    required this.offer,
    required this.categoryId,
    required this.clientId,
  });

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      clientName: json['clientName'] ?? '',
      description: json['description'] ?? '',
      comment: json['comment'] ?? '',
      status: json['status'] ?? '',
      offer: json['offer'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      clientId: json['clientId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "clientName": clientName,
    "description": description,
    "comment": comment,
    "status": status,
    "offer": offer,
    "categoryId": categoryId,
    "clientId": clientId
  };
}
