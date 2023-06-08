import 'package:fatorfit/blocs/progress_bloc.dart';
import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

class ProgressHistoryPage extends StatefulWidget {
  const ProgressHistoryPage({super.key});

  @override
  State<ProgressHistoryPage> createState() => _ProgressHistoryPageState();
}

class _ProgressHistoryPageState extends State<ProgressHistoryPage> {
  List<String> dayList = []; // Sistemden gelen günleri tutmak için bir liste
  String? selectedDay; // Seçilen günü tutmak için değişken

  @override
  void initState() {
    super.initState();
    progressBloc.reset();
    progressBloc.getAllDatesAndUserPrograms();
  }

  @override
  void dispose() {
    progressBloc.dispose();
    super.dispose();
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.appbarColor),
          ),
          title: const Text(
            'GEÇMİŞ',
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
        body: StreamBuilder<Map<String, List<TrainingDetailModel>>>(
          stream: progressBloc.dayAndProgramStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, List<TrainingDetailModel>> dayAndPrograms =
                  snapshot.data!;
              dayList = dayAndPrograms.keys.toList(); // Gün listesini güncelle

              return ListView.builder(
                itemCount: dayList.length,
                itemBuilder: (context, index) {
                  String day = dayList.reversed.toList()[index];
                  return Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.white54,
                    child: ListTile(
                      title: Text(
                        day,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedDay = day; // Seçilen günü güncelle
                        });
                        _showProgramsBottomSheet(context, dayAndPrograms[day]);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _showProgramsBottomSheet(
      BuildContext context, List<TrainingDetailModel>? programs) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Programlar',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (programs != null && programs.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      TrainingDetailModel program = programs[index];
                      return Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        color: AppColors.appbarColor,
                        child: ListTile(
                          title: Text(
                            program.programName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Hedef: ${program.target}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            'İlerleme: ${program.progresValue}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Text(
                    'Bu güne ait program bulunamadı.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bottomNavBarColor,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Kapat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
