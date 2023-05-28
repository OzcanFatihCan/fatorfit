import 'package:fatorfit/models/activity_model.dart';
import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/services/activity_service.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';

import '../../blocs/activity_bloc.dart';
import '../../blocs/training_bloc.dart';
import 'activity_detail.dart';

class AktivityPage extends StatefulWidget {
  const AktivityPage({super.key});

  @override
  State<AktivityPage> createState() => _AktivityPageState();
}

class _AktivityPageState extends State<AktivityPage> {
  @override
  void initState() {
    super.initState();
    activityBloc.reset();
    activityBloc.getAll();
  }

  @override
  void dispose() {
    activityBloc.dispose();
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
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: AppColors.appbarColor),
            ),
            title: const Text(
              "Hareketler",
              style: const TextStyle(
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
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                flex: 9,
                child: _buildActivityList(),
              ),
              SizedBox(
                height: 7,
              ),
              Expanded(
                flex: 1,
                child: _buildTrainingGo(),
              )
            ],
          )),
    );
  }

  _buildActivityList() {
    return StreamBuilder<List<ActivityType>>(
      stream: activityBloc.activityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ActivityType> activities = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // İki sütunlu bir grid oluşturacak
            ),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'detailaktivity',
                      arguments: activity,
                    );
                  },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Colors.white54,
                    child: ListTile(
                      title: Center(
                        child: Text(
                          activity.name ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildTrainingGo() {
    return Container(
      width: MediaQuery.of(context).size.height * 0.65,
      child: ElevatedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "training");
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.bottomNavBarColor),
        child: const Text(
          "Program Oluşturucu",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}




//235, 63, 183, 219
//9c9791