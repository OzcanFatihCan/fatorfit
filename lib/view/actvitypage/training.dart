import 'package:fatorfit/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../blocs/training_bloc.dart';
import '../../models/activity_model.dart';
import '../../theme/themecolor.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  Map<String, dynamic> selectedOptions = {};

  List<String> SetRepetitionList = [
    "2 * 5",
    "2 * 8",
    "2 * 10",
    "2 * 13",
    "3 * 5",
    "3 * 8",
    "3 * 10",
    "3 * 13",
    "3 * 15",
    "4 * 5",
    "4 * 8",
    "4 * 10",
    "4 * 13",
    "4 * 15",
    "5 * 5",
    "5 * 10",
    "5 * 15",
  ];

  List<int> OnlyMinuteList = [20, 30, 40, 50, 60];

  List<String> SetSecondList = [
    "2 * 30",
    "2 * 60",
    "3 * 30",
    "3 * 60",
    "4 * 30",
    "4 * 60",
  ];

  @override
  void initState() {
    super.initState();
    trainingBloc.getTrainingActivities();
    trainingBloc.reset();
  }

  @override
  void dispose() {
    trainingBloc.reset();
    super.dispose();
  }

  void _showTrainingOptionDialog(ActivityType activity) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hedefinizi Seçiniz',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: _buildTrainingOptionWidget(activity),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedOptions.remove(activity.name);
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTrainingOptionWidget(ActivityType activity) {
    final activityName = activity.name;

    if (activityName == 'Pull-up - Barfiks' ||
        activityName == 'Dumbbell Shoulder Press' ||
        activityName == 'Lunges' ||
        activityName == 'Push-up - Şınav') {
      return ListView(
        shrinkWrap: true,
        children: SetRepetitionList.map((repetition) {
          var parts = repetition.split(' * ');
          int value1 = int.parse(parts[0].trim());
          int value2 = int.parse(parts[1].trim());
          int reptetionInt = value1 * value2;
          return Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            color: AppColors.appbarColor,
            child: ListTile(
              title: Text('${repetition} Set-Tekrar'),
              onTap: () {
                setState(() {
                  selectedOptions[activityName!] = reptetionInt;

                  print(selectedOptions);
                  Navigator.of(context).pop();
                });
              },
            ),
          );
        }).toList(),
      );
    } else if (activityName == 'Elliptical Bike' ||
        activityName == 'Treadmill') {
      return ListView(
        shrinkWrap: true,
        children: OnlyMinuteList.map((minute) {
          return Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            color: AppColors.appbarColor,
            child: ListTile(
              title: Text('$minute Dakika'),
              onTap: () {
                setState(() {
                  selectedOptions[activityName!] = minute;
                  print(selectedOptions);
                  Navigator.of(context).pop();
                });
              },
            ),
          );
        }).toList(),
      );
    } else if (activityName == 'Battle-ropes' || activityName == 'Plank') {
      return ListView(
        shrinkWrap: true,
        children: SetSecondList.map((second) {
          var parts = second.split(' * ');
          int value1 = int.parse(parts[0].trim());
          int value2 = int.parse(parts[1].trim());
          int secondInt = value1 * value2;
          return Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            color: AppColors.appbarColor,
            child: ListTile(
              title: Text('$second Set-Saniye'),
              onTap: () {
                setState(() {
                  selectedOptions[activityName!] = secondInt;
                  print(selectedOptions);
                  Navigator.of(context).pop();
                });
              },
            ),
          );
        }).toList(),
      );
    }

    return const SizedBox(); // Default case, empty widget
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.appbarColor),
          ),
          title: const Text(
            'Program Oluşturucu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                if (selectedOptions.keys.isEmpty ||
                    selectedOptions.values.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen Hareket ve Hedef Girdisi Yapınız.'),
                    ),
                  );
                } else {
                  await performSetOperation(selectedOptions);
                  print(
                      "hareket: ${selectedOptions.keys} hedef:${selectedOptions.values} ");
                }
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: StreamBuilder<List<ActivityType>>(
                stream: trainingBloc.trainingStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ActivityType> trainingList = snapshot.data!;
                    return ListView.builder(
                      itemCount: trainingList.length,
                      itemBuilder: (context, index) {
                        final training = trainingList[index];
                        return Dismissible(
                          key: Key(training.aid.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            trainingBloc.removeFromTraining(training.aid!);
                          },
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            color: Colors.white54,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: ListTile(
                                    title: Text(
                                      training.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                        "Hedefiniz: ${selectedOptions[training.name] ?? ''}"),
                                    trailing: ElevatedButton(
                                      child: const Text(
                                        "Hedef",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                        backgroundColor: AppColors.appbarColor,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black87),
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showTrainingOptionDialog(training);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Programınıza veri eklemesi yapmadınız.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.65,
                child: ElevatedButton(
                  child: const Text(
                    "Programım",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bottomNavBarColor,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black87),
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, 'detailtraining');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> performSetOperation(Map<String, dynamic> programs) async {
  try {
    AuthService authService = AuthService();
    await authService.performSetOperation(programs);
    print("Set işlemi başarı ile tamamlandı!");
  } catch (e) {
    print('Set işlemi sırasında bir hata oluştu: $e');
  }
}
