import 'package:fatorfit/models/training_model.dart';
import 'package:fatorfit/theme/themecolor.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../blocs/training_bloc.dart';
import '../../models/activity_model.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isVideoPlaying = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ActivityType activity =
        ModalRoute.of(context)!.settings.arguments as ActivityType;
    _videoPlayerController =
        VideoPlayerController.network(activity.imageUrl ?? '');
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _toggleVideoPlayback() async {
    if (_isVideoPlaying) {
      await _videoPlayerController.pause();
    } else {
      await _videoPlayerController.play();
    }
    setState(() {
      _isVideoPlaying = !_isVideoPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ActivityType activity =
        ModalRoute.of(context)!.settings.arguments as ActivityType;
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
          title: Text(
            activity.name ?? '',
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
        body: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GestureDetector(
                            onTap: _toggleVideoPlayback,
                            child: AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    activity.name ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 230),
              ElevatedButton(
                onPressed: () {
                  trainingBloc.addToTraining(activity);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 44.0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Programıma Ekle",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
