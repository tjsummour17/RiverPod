import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_app/models/university.dart';

class FavoriteFirebaseRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<University>> fetchFavorites(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    List<University> universities =
        snapshot.docs.map((s) => University.fromJson(s.data())).toList();
    return universities;
  }

  Future addFavorite({
    required String userId,
    required University university,
  }) async {
    String? universityId = university.name?.replaceAll(RegExp(r'\s+'), '');
    if (universityId != null) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(universityId)
          .set(university.toJson());
    }
  }

  Future removeFavorite({
    required String userId,
    required University university,
  }) async {
    String? universityId = university.name?.replaceAll(RegExp(r'\s+'), '');
    if (universityId != null) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(universityId)
          .delete();
    }
  }
}
