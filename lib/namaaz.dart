import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:just_audio/just_audio.dart';

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  late AudioPlayer player;
  Duration position = const Duration();
  Duration audiolength = const Duration();
  IconData playBtn = Icons.play_arrow;
  String number = "Select The Prayer";
  int no = 0;
  bool flag = true;
  bool _play = false;
  bool hide = false;

  @override
  void initState() {
    super.initState();

    initPlayer();
  }

  void initPlayer() {
    player = AudioPlayer();
    player.positionStream.listen((Duration d) {
      setState(() {
        position = d;
        if (d.inSeconds == audiolength.inSeconds) {
          playBtn = Icons.play_arrow;
        }
      });
    });

    player.durationStream.listen((totalDuration) {
      audiolength = totalDuration ?? Duration.zero;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void seekToSec(int sec) {
    Duration newpos = Duration(seconds: sec);
    player.seek(newpos);
  }

  Widget slider() {
    return Slider.adaptive(
      value: audiolength.inSeconds.toDouble() > position.inSeconds.toDouble()
          ? position.inSeconds.toDouble()
          : audiolength.inSeconds.toDouble(),
      min: 00.00,
      max: audiolength.inSeconds.toDouble() > 00.00
          ? audiolength.inSeconds.toDouble()
          : 00.00,
      activeColor: Colors.blue.shade900,
      inactiveColor: Colors.blue.shade700,
      onChanged: (value) {
        seekToSec(value.toInt());
        setState(() {
          if (position.inSeconds.toDouble() ==
              audiolength.inSeconds.toDouble()) {
            playBtn = Icons.play_arrow;
            _play = false;
          }
        });
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void playAudio(int number) async {
    await player.setAsset('assets/audio/audio$number.mp3');
    player.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.blue.shade900,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Namaaz',
            style: TextStyle(
              color: Colors.blue.shade900,
            )),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/icon.png",
          ),
        ),
      ),
      child: Center(
          child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                color: Colors.yellow.shade700,
                child: InkWell(
                  onTap: () {
                    playBtn = Icons.pause;
                    setState(() {
                      number = "Salat Al-Fajr \n 2 Unit \n Prayer";
                      no = 1;
                      hide = true;
                      playAudio(no);
                      _play = true;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 100,
                    child: Text(
                      'FAJR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Zohr \n 4 Unit \n Prayer";
                          no = 2;
                          playAudio(no);
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ZOHR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Asr \n 4 Unit \n Prayer";
                          no = 3;
                          playAudio(no);
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ASR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Maghrib \n 3 Unit \n Prayer";
                          no = 4;
                          playAudio(no);
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'MAGHRIB',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellow.shade700,
                    child: InkWell(
                      onTap: () {
                        playBtn = Icons.pause;
                        setState(() {
                          number = "Salat Al-Isha \n 4 Unit \n Prayer";
                          no = 5;
                          playAudio(no);
                          _play = true;
                          hide = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 100,
                        child: Text(
                          'ISHA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.shade700,
                elevation: 2.0,
                child: Container(
                  width: 350,
                  height: 140,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 45.0,
                              color: Colors.blue.shade700,
                              onPressed: () {
                                double value = position.inSeconds.toDouble();
                                if (value >= 10.0) {
                                  setState(() {
                                    value -= 10.0;
                                    seekToSec(value.toInt());
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                              )),
                          IconButton(
                              iconSize: 65.0,
                              color: Colors.blue.shade900,
                              onPressed: () {
                                if (!_play) {
                                  player.play();
                                  playBtn = Icons.pause;
                                  setState(() {
                                    _play = true;
                                  });
                                } else {
                                  player.pause();
                                  playBtn = Icons.play_arrow;
                                  setState(() {
                                    _play = false;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              )),
                          IconButton(
                              iconSize: 45.0,
                              color: Colors.blue.shade700,
                              onPressed: () {
                                double value = position.inSeconds.toDouble();
                                if (value <=
                                    audiolength.inSeconds.toDouble() - 10.0) {
                                  setState(() {
                                    value += 10.0;
                                    seekToSec(value.toInt());
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.skip_next,
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _printDuration(position),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          slider(),
                          Text(
                            _printDuration(audiolength),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
