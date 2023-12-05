
class Category {
  String id;
  String nombreCategoria;

  Category({required this.id, required this.nombreCategoria});

  Category.fromMap(Map snapshot): 
    id = snapshot['id'] ?? '',
    nombreCategoria = snapshot['nombreCategoria'] ?? '';

  toJson() {
    return {
      "id": id,
      "nombreCategoria": nombreCategoria,
    };
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.nombreCategoria == nombreCategoria &&
        other.id == id;
  }

  @override
  int get hashCode => nombreCategoria.hashCode ^ id.hashCode;
}