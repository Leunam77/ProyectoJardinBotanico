
class Category {
  String id;
  String nombreCategoria;

  Category({required this.id, required this.nombreCategoria});

  Category.fromMap(Map snapshot, String id): 
        id = id ?? '',
        nombreCategoria = snapshot['nombreCategoria'] ?? '';

  toJson() {
    return {
      "nombreCategoria": nombreCategoria,
    };
  }
}
