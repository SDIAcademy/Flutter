import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Example',
      home: VideoExample(),
    );
  }
}

class VideoExample extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          "https:\/\/r3---sn-p5qs7nee.googlevideo.com\/videoplayback?c=WEB&itag=22&key=yt6&mt=1526684629&mn=sn-p5qs7nee%2Csn-p5qlsnsy&mm=31%2C29&signature=80E167C85587F1158060A1AE27AFC715FEB88624.048CD2E4206399A7DA9366982EA58A58C8DEE37F&ms=au%2Crdu&initcwndbps=3825000&mv=m&sparams=dur%2Cei%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cexpire&source=youtube&pl=15&dur=996.507&ei=DFz_WuCmMOnf8gSpj7Mg&ratebypass=yes&lmt=1525147666626510&requiressl=yes&ip=54.234.59.16&fvip=5&ipbits=0&expire=1526706284&mime=video%2Fmp4&id=o-AMLmQRAfQrgC4ugBOXz_mY2B3bOARsHlJHIezWV9qkPT")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
          playerController.play();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
