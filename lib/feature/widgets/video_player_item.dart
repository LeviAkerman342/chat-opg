import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          videoPlayerController.setVolume(1);
        });
      });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (isPlay) {
                    videoPlayerController.pause();
                  } else {
                    videoPlayerController.play();
                  }
                  isPlay = !isPlay;
                });
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
