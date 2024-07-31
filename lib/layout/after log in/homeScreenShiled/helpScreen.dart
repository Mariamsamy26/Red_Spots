import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class helpScreen extends StatefulWidget {
  const helpScreen({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  State<helpScreen> createState() => _helpScreenState();
}

class _helpScreenState extends State<helpScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _intializeVideoPlayerFuture;
  @override
  void initstate() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _intializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _intializeVideoPlayerFuture,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
