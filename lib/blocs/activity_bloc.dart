import 'dart:async';

import '../models/activity_model.dart';
import '../services/activity_service.dart';

class ActivityBloc {
  final _activityService = ActivityService();
  StreamController<List<ActivityType>>? _activityStreamController;

  Stream<List<ActivityType>> get activityStream {
    if (_activityStreamController != null) {
      return _activityStreamController!.stream;
    } else {
      // Hata durumunda boş bir stream döndürebilirsiniz.
      return const Stream.empty();
    }
  }

  void getAll() async {
    List<ActivityType> activities = await _activityService.getAll();
    _activityStreamController?.sink.add(activities);
  }

  void dispose() {
    _activityStreamController?.close();
  }

  void reset() {
    _activityStreamController?.close();
    _activityStreamController =
        StreamController<List<ActivityType>>.broadcast();
  }
}

final activityBloc = ActivityBloc();
