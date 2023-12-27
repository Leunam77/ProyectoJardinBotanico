import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PlantModel {
  final String? id;
  final List<String> nombreColoquial;
  final String nombreCientifico;
  final String descripcion;
  final String usosMedicinales;
  final String? imageUrl;
  final String? qrCodeUrl;
  final List<String> categoriesIds;
  final Timestamp fechaCreacion;

  PlantModel({
    this.id,
    required this.nombreColoquial,
    required this.nombreCientifico,
    required this.descripcion,
    required this.usosMedicinales,
    this.imageUrl,
    this.qrCodeUrl,
    required this.categoriesIds,
    required this.fechaCreacion,
  });

  PlantModel.fromMap(this.id, Map<String, dynamic> snapshot)
      : nombreColoquial = List<String>.from(snapshot['nombreColoquial'] ?? []),
        nombreCientifico = snapshot['nombreCientifico'] ?? '',
        descripcion = snapshot['descripcion'] ?? '',
        usosMedicinales = snapshot['usosMedicinales'] ?? '',
        imageUrl = snapshot['imageUrl'],
        qrCodeUrl = snapshot['qrCodeUrl'],
        categoriesIds = List<String>.from(snapshot['categoriesIds'] ?? []),
        fechaCreacion = snapshot['fechaCreacion'] ?? Timestamp.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombreColoquial': nombreColoquial,
        'nombreCientifico': nombreCientifico,
        'descripcion': descripcion,
        'usosMedicinales': usosMedicinales,
        'imageUrl': imageUrl,
        'qrCodeUrl': qrCodeUrl,
        'categoriesIds': categoriesIds,
        'fechaCreacion': fechaCreacion,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlantModel &&
        other.id == id &&
        listEquals(other.nombreColoquial, nombreColoquial) &&
        other.nombreCientifico == nombreCientifico &&
        other.descripcion == descripcion &&
        other.usosMedicinales == usosMedicinales &&
        other.imageUrl == imageUrl &&
        other.qrCodeUrl == qrCodeUrl &&
        listEquals(other.categoriesIds, categoriesIds) &&
        other.fechaCreacion.millisecondsSinceEpoch ==
            fechaCreacion.millisecondsSinceEpoch;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nombreColoquial.hashCode ^
      nombreCientifico.hashCode ^
      descripcion.hashCode ^
      usosMedicinales.hashCode ^
      (imageUrl?.hashCode ?? 0) ^
      (qrCodeUrl?.hashCode ?? 0) ^
      categoriesIds.hashCode ^
      fechaCreacion.millisecondsSinceEpoch.hashCode;
}
