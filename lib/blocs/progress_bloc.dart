import 'dart:async';

import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/services/auth_service.dart';

class ProgressBloc {
  final _authService = AuthService();
  StreamController<Map<String, List<TrainingDetailModel>>>?
      _authStreamController =
      StreamController<Map<String, List<TrainingDetailModel>>>.broadcast();

  Stream<Map<String, List<TrainingDetailModel>>> get dayAndProgramStream =>
      _authStreamController!.stream;

  void getAllDatesAndUserPrograms() async {
    Map<String, List<TrainingDetailModel>> dayAndPrograms =
        await _authService.getAllDatesAndUserPrograms();
    _authStreamController?.sink.add(dayAndPrograms);
  }

  void dispose() {
    _authStreamController?.close();
  }

  void reset() {
    _authStreamController?.close();
    _authStreamController =
        StreamController<Map<String, List<TrainingDetailModel>>>.broadcast();
  }
}

final progressBloc = ProgressBloc();
