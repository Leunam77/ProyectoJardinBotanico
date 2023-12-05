class PlantModel {
  String id;
  String nombreColoquial;
  String nombreCientifico;
  String descripcion;
  String usosMedicinales;

  PlantModel({
    required this.id,
    required this.nombreColoquial,
    required this.nombreCientifico,
    required this.descripcion,
    required this.usosMedicinales,
  });

  PlantModel.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        nombreColoquial = snapshot['nombreColoquial'] ?? '',
        nombreCientifico = snapshot['nombreCientifico'] ?? '',
        descripcion = snapshot['descripcion'] ?? '',
        usosMedicinales = snapshot['usosMedicinales'] ?? '';

  toJson() {
    return {
      "id": id,
      "nombreColoquial": nombreColoquial,
      "nombreCientifico": nombreCientifico,
      "descripcion": descripcion,
      "usosMedicinales": usosMedicinales,
    };
  }
}
