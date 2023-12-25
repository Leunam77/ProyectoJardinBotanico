class Category {
  final String? id;
  final String nombreCategoria;

  Category({this.id, required this.nombreCategoria});

  Category.fromMap(this.id, Map<String, dynamic> snapshot)
      : nombreCategoria = snapshot['nombreCategoria'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombreCategoria': nombreCategoria,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.nombreCategoria == nombreCategoria;
  }

  @override
  int get hashCode => id.hashCode ^ nombreCategoria.hashCode;
}
