import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatorfit/models/activity_model.dart';

class ActivityService {
  final CollectionReference _activityCollection =
      FirebaseFirestore.instance.collection('Activity');

  Future<List<ActivityType>> getAll() async {
    QuerySnapshot snapshot = await _activityCollection.get();
    List<ActivityType> activities = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return ActivityType(
        aid: data['aid'] as int?,
        name: data['name'] as String?,
        imageUrl: data['imageUrl'] as String?,
      );
    }).toList();

    return activities;
  }
}
