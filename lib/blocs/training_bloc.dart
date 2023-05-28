import 'dart:async';

import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/services/auth_service.dart';

import '../models/activity_model.dart';
import '../services/training_service.dart';

class TrainingBloc {
  final _authService = AuthService();
  StreamController<List<TrainingDetailModel>>? _authStreamController;
  final _trainingService = TrainingService();
  StreamController<List<ActivityType>>? _trainingStreamController;

  Stream<List<ActivityType>> get trainingStream {
    if (_trainingStreamController != null) {
      return _trainingStreamController!.stream;
    } else {
      return const Stream.empty();
    }
  }

  Future<void> getTrainingActivities() async {
    if (_trainingStreamController == null) {
      _trainingStreamController = StreamController<List<ActivityType>>();
    }

    try {
      List<ActivityType> activities =
          await _trainingService.getTrainingActivities();
      _trainingStreamController?.sink.add(activities);
    } catch (e) {
      _trainingStreamController?.addError(e);
    }
  }

  Future<void> addToTraining(ActivityType activity) async {
    await _trainingService.addToTraining(activity);
    await getTrainingActivities(); // Verileri yeniden getir
  }

  Future<void> removeFromTraining(int aid) async {
    await _trainingService.removeFromTraining(aid);
    await getTrainingActivities(); // Verileri yeniden getir
  }

  Stream<List<TrainingDetailModel>> get programStream {
    if (_authStreamController != null) {
      return _authStreamController!.stream;
    } else {
      // Hata durumunda boş bir stream döndürebilirsiniz.
      return const Stream.empty();
    }
  }

  void getPrograms() async {
    List<TrainingDetailModel> programs = await _authService.getUserPrograms();
    _authStreamController?.sink.add(programs);
  }

  Future<void> deleteProgram(String? programName) async {
    await _authService.deleteProgram(programName);
    getPrograms();
  }

  void dispose() {
    _trainingStreamController?.close();
  }

  void disposeAuth() {
    _authStreamController?.close();
  }

  void resetAuth() {
    _authStreamController?.close();
    _authStreamController =
        StreamController<List<TrainingDetailModel>>.broadcast();
  }

  void reset() {
    _trainingStreamController?.close();
    _trainingStreamController = null;
    _trainingStreamController = StreamController<List<ActivityType>>();
  }
}

final trainingBloc = TrainingBloc();
