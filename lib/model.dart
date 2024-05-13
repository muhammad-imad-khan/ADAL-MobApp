class User {
  final int id;
  final String name;
  final String description;
  final int price;
  final int categoryId;
  final int clientId;

  const User({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.clientId,
  });

  const User.empty({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.price = 0,
    this.categoryId = 0,
    this.clientId = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        categoryId: json['categoryId'],
        clientId: json['clientId'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "categoryId": categoryId,
        "clientId": clientId,
      };
}
