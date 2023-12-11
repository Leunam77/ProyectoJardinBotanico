class PlantModel {
  String id;
  String nombreColoquial;
  String nombreCientifico;
  String descripcion;
  String usosMedicinales;
  String? imageUrl;
  String? qrCodeUrl;

  PlantModel({
    required this.id,
    required this.nombreColoquial,
    required this.nombreCientifico,
    required this.descripcion,
    required this.usosMedicinales,
    this.imageUrl,
    this.qrCodeUrl,
  });

  PlantModel.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        nombreColoquial = snapshot['nombreColoquial'] ?? '',
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
}
