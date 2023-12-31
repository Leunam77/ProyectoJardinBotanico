class GardenInfo {
  final String id;
  final String numero;
  final String direccionMaps;
  final String linkFacebook;
  final String linkInstagram;
  final String linkTikTok;
  final String descripcion;
  final String? imageURLInfo;

  GardenInfo({
    required this.id,
    required this.numero,
    required this.direccionMaps,
    required this.linkFacebook,
    required this.linkInstagram,
    required this.linkTikTok,
    required this.descripcion,
    this.imageURLInfo,
  });

  GardenInfo.fromMap(this.id, Map<String, dynamic> snapshot)
      : numero = snapshot['numero'] ?? '',
        direccionMaps = snapshot['direccionMaps'] ?? '',
        linkFacebook = snapshot['linkFacebook'] ?? '',
        linkInstagram = snapshot['linkInstagram'] ?? '',
        linkTikTok = snapshot['linkTikTok'] ?? '',
        descripcion = snapshot['descripcion'] ?? '',
        imageURLInfo = snapshot['imageURLInfo'];

  toJson() {
    return {
      "id": id,
      "numero": numero,
      "direccionMaps": direccionMaps,
      "linkFacebook": linkFacebook,
      "linkInstagram": linkInstagram,
      "linkTikTok": linkTikTok,
      "descripcion": descripcion,
      "ImageURLInfo": imageURLInfo,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GardenInfo &&
        other.id == id &&
        other.numero == numero &&
        other.direccionMaps == direccionMaps &&
        other.linkFacebook == linkFacebook &&
        other.linkInstagram == linkInstagram &&
        other.linkTikTok == linkTikTok &&
        other.descripcion == descripcion &&
        other.imageURLInfo == imageURLInfo;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      numero.hashCode ^
      direccionMaps.hashCode ^
      linkFacebook.hashCode ^
      linkInstagram.hashCode ^
      linkTikTok.hashCode ^
      descripcion.hashCode ^
      imageURLInfo.hashCode;
}
