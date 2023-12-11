import 'package:test/test.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';

void main() {
  group('GardenInfo', () {
    test('debería crear una información de jardín desde un mapa', () {
      // Configura el mapa
      final map = {
        'id': '1',
        'numero': '123',
        'direccionMaps': 'direccion',
        'linkFacebook': 'facebook',
        'linkInstagram': 'instagram',
        'linkTikTok': 'tiktok',
        'descripcion': 'descripcion',
      };

      // Crea una información de jardín desde el mapa
      final gardenInfo = GardenInfo.fromMap(map);

      // Comprueba que los valores son los esperados
      expect(gardenInfo.id, equals('1'));
      expect(gardenInfo.numero, equals('123'));
      expect(gardenInfo.direccionMaps, equals('direccion'));
      expect(gardenInfo.linkFacebook, equals('facebook'));
      expect(gardenInfo.linkInstagram, equals('instagram'));
      expect(gardenInfo.linkTikTok, equals('tiktok'));
      expect(gardenInfo.descripcion, equals('descripcion'));
    });

    test('debería convertir una información de jardín a un mapa', () {
      // Configura la información de jardín
      final gardenInfo = GardenInfo(
        id: '1',
        numero: '123',
        direccionMaps: 'direccion',
        linkFacebook: 'facebook',
        linkInstagram: 'instagram',
        linkTikTok: 'tiktok',
        descripcion: 'descripcion',
      );

      // Convierte la información de jardín a un mapa
      final map = gardenInfo.toJson();

      // Comprueba que los valores son los esperados
      expect(map['id'], equals('1'));
      expect(map['numero'], equals('123'));
      expect(map['direccionMaps'], equals('direccion'));
      expect(map['linkFacebook'], equals('facebook'));
      expect(map['linkInstagram'], equals('instagram'));
      expect(map['linkTikTok'], equals('tiktok'));
      expect(map['descripcion'], equals('descripcion'));
    });

    test('debería comparar dos informaciones de jardín correctamente', () {
      // Configura dos informaciones de jardín iguales y una diferente
      final gardenInfo1 = GardenInfo(
        id: '1',
        numero: '123',
        direccionMaps: 'direccion',
        linkFacebook: 'facebook',
        linkInstagram: 'instagram',
        linkTikTok: 'tiktok',
        descripcion: 'descripcion',
      );
      final gardenInfo2 = GardenInfo(
        id: '1',
        numero: '123',
        direccionMaps: 'direccion',
        linkFacebook: 'facebook',
        linkInstagram: 'instagram',
        linkTikTok: 'tiktok',
        descripcion: 'descripcion',
      );
      final gardenInfo3 = GardenInfo(
        id: '2',
        numero: '456',
        direccionMaps: 'otra direccion',
        linkFacebook: 'otro facebook',
        linkInstagram: 'otro instagram',
        linkTikTok: 'otro tiktok',
        descripcion: 'otra descripcion',
      );

      // Comprueba que las informaciones de jardín iguales son iguales y que las diferentes no lo son
      expect(gardenInfo1, equals(gardenInfo2));
      expect(gardenInfo1, isNot(equals(gardenInfo3)));
    });
  });
}