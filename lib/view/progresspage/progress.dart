import 'package:fatorfit/blocs/training_bloc.dart';
import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/services/auth_service.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  Map<String, dynamic> progresSet = {};
  @override
  void initState() {
    super.initState();
    trainingBloc.resetAuth();
    trainingBloc.getPrograms();
  }

  @override
  void dispose() {
    trainingBloc.disposeAuth();
    super.dispose();
  }

  TrainingDetailModel? selectedActivite;
  double progressPercent = 0.00;
  double secondProgressPercent = 0.00;

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.appbarColor),
          ),
          title: const Text(
            'GELİŞİM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 40,
                            percent: progressPercent,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              '${(progressPercent * 100).toInt()}%',
                              style: const TextStyle(
                                  fontSize: 54,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            progressColor: Colors.cyan.shade800,
                            backgroundColor: Colors.cyan.shade200,
                          ),
                          CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 40,
                            percent: secondProgressPercent,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.green.shade900,
                            backgroundColor: Colors.green.shade400,
                            center: Image.asset(
                              'assets/Logo.png',
                              width: 130,
                              height: 130,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: _buildProgramsList(),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: _buildButton(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _buildProgramsList() {
    return SizedBox(
      height: 300,
      width: 500,
      child: Center(
        child: StreamBuilder<List<TrainingDetailModel>>(
          stream: trainingBloc.programStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TrainingDetailModel> programs = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: programs.length,
                itemBuilder: (context, index) {
                  final program = programs[index];

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        _updateSelectedProgram(program);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.bottomNavBarColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        color: Colors.white54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  program.programName ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Hedefiniz: ${program.target.toString()}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Yapılan',
                                    fillColor: AppColors.textFieldColor,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  initialValue: program.progresValue.toString(),
                                  onTap: () {
                                    _updateSelectedProgram(program);
                                  },
                                  onChanged: (value) {
                                    _updateProgressValue(program, value);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
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
                    "Bugünkü hedefinizi kaydetmediniz!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _updateSelectedProgram(TrainingDetailModel program) {
    setState(() {
      selectedActivite = program;
      progressPercent = program.progresValue / program.target!;
    });
  }

  _updateProgressValue(TrainingDetailModel program, String value) {
    if (selectedActivite != null) {
      if (value.isEmpty) {
        value = '0';
      } else if (double.parse(value) > selectedActivite!.target!) {
        value = selectedActivite!.target!.toString();
      }
      setState(() {
        selectedActivite!.progresValue = double.parse(value);
        progressPercent =
            selectedActivite!.progresValue / selectedActivite!.target!;
        progresSet[program.programName!] = selectedActivite!.progresValue;
        print("MAP: ${progresSet}");
      });
    }
  }

  _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                await progresSetOperation(progresSet);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bottomNavBarColor,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black87),
                ),
              ),
              child: const Text(
                "Kaydet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "progresshistory");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bottomNavBarColor,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black87),
                ),
              ),
              child: const Text(
                "Geçmiş",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> progresSetOperation(Map<String, dynamic> progres) async {
  try {
    AuthService authService = AuthService();
    await authService.progresSetOperation(progres);
    print("Set işlemi başarı ile tamamlandı!");
  } catch (e) {
    print('Set işlemi sırasında bir hata oluştu: $e');
  }
}
