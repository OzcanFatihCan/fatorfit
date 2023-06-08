class TrainingModel {
  String activityName;

  TrainingModel(this.activityName);
}

class TrainingDetailModel {
  String? programName;
  int? target;
  double progresValue;

  TrainingDetailModel({this.programName, this.target, this.progresValue = 0});
}
