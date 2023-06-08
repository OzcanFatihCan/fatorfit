import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

import '../../blocs/training_bloc.dart';

class TrainingDetailPage extends StatefulWidget {
  const TrainingDetailPage({super.key});

  @override
  State<TrainingDetailPage> createState() => _TrainingDetailPageState();
}

class _TrainingDetailPageState extends State<TrainingDetailPage> {
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
            'PROGRAMIM',
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
              flex: 9,
              child: _buildProgramsList(),
            ),
          ],
        ),
      ),
    );
  }
}

_buildProgramsList() {
  return StreamBuilder<List<TrainingDetailModel>>(
    stream: trainingBloc.programStream,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<TrainingDetailModel> programs = snapshot.data!;
        return ListView.builder(
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange),
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
                          program.programName ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "Hedefiniz: ${program.target.toString()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await trainingBloc.deleteProgram(program.programName);
                        },
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
            Text("Bugünkü hedefinizi kaydetmediniz!"),
            SizedBox(height: 5),
            CircularProgressIndicator()
          ],
        ),
      );
    },
  );
}
