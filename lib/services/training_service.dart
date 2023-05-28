import '../models/activity_model.dart';

class TrainingService {
  List<ActivityType> _trainingActivities = [];

  Future<List<ActivityType>> getTrainingActivities() async {
    return _trainingActivities;
  }

  Future<void> addToTraining(ActivityType activity) async {
    _trainingActivities.add(activity);
  }

  Future<void> removeFromTraining(int aid) async {
    _trainingActivities.removeWhere((activity) => activity.aid == aid);
  }
}
