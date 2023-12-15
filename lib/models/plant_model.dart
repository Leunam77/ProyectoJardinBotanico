class PlantModel {
  final String? id; 
  final String nombreColoquial;
  final String nombreCientifico;
  final String descripcion;
  final String usosMedicinales;
  final String? imageUrl;
  final String? qrCodeUrl;

  PlantModel({
    this.id,
    required this.nombreColoquial,
    required this.nombreCientifico,
    required this.descripcion,
    required this.usosMedicinales,
    this.imageUrl,
    this.qrCodeUrl,
  });

  PlantModel.fromMap(this.id, Map<String, dynamic> snapshot)
      : nombreColoquial = snapshot['nombreColoquial'] ?? '',
        nombreCientifico = snapshot['nombreCientifico'] ?? '',
        descripcion = snapshot['descripcion'] ?? '',
        usosMedicinales = snapshot['usosMedicinales'] ?? '',
        imageUrl = snapshot['imageUrl'],
        qrCodeUrl = snapshot['qrCodeUrl'];

  toJson() {
    return {
      "id": id,
      "nombreColoquial": nombreColoquial,
      "nombreCientifico": nombreCientifico,
      "descripcion": descripcion,
      "usosMedicinales": usosMedicinales,
      "imageUrl": imageUrl,
      "qrCodeUrl": qrCodeUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantModel &&
        other.id == id &&
        other.nombreColoquial == nombreColoquial &&
        other.nombreCientifico == nombreCientifico &&
        other.descripcion == descripcion &&
        other.usosMedicinales == usosMedicinales &&
        other.imageUrl == imageUrl &&
        other.qrCodeUrl == qrCodeUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nombreColoquial.hashCode ^
      nombreCientifico.hashCode ^
      descripcion.hashCode ^
      usosMedicinales.hashCode ^
      (imageUrl?.hashCode ?? 0) ^
      (qrCodeUrl?.hashCode ?? 0);
}