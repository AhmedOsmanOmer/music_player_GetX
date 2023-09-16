import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controller/palyer_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 350,
                  width: 350,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: slideColor),
                  child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 100,
                      ))),
            )),
            const SizedBox(height: 15),
            Expanded(
                child: Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    alignment: Alignment.center,
                    width: Get.width,
                    decoration: const BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Obx(
                      () => Column(
                        children: [
                          Text(
                            data[controller.playIndex.value].title,
                            textAlign: TextAlign.center,
                            style: ourStyle(
                                color: whiteColor,
                                weight: FontWeight.bold,
                                size: 21),
                          ),
                          const SizedBox(height: 15),
                          Text(
                              data[controller.playIndex.value]
                                  .artist
                                  .toString(),
                              style: ourStyle(color: whiteColor, size: 15)),
                          Row(
                            children: [
                              Text(controller.position.value,
                                  style: ourStyle(color: whiteColor)),
                              Expanded(
                                child: Slider(
                                  min: const Duration(seconds: 0)
                                      .inSeconds
                                      .toDouble(),
                                  max: controller.max.value,
                                  thumbColor: slideColor,
                                  inactiveColor: whiteColor,
                                  activeColor: slideColor,
                                  value: controller.value.value,
                                  onChanged: (seconds) {
                                    controller.changeDuration(seconds.toInt());
                                  },
                                ),
                              ),
                              Text(
                                controller.duration.value,
                                style: ourStyle(color: whiteColor),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    if (controller.playIndex.value - 1 < 0) {
                                    } else {
                                      controller.playSong(
                                          data[controller.playIndex.value].uri,
                                          controller.playIndex.value - 1);
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: slideColor,
                                    child: Icon(
                                      Icons.skip_previous_rounded,
                                      color: whiteColor,
                                      size: 40,
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    if (controller.isPlay.value) {
                                      controller.audioPlayer.pause();
                                      controller.isPlay(false);
                                    } else {
                                      controller.audioPlayer.play();
                                      controller.isPlay(true);
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: slideColor,
                                    radius: 50,
                                    child: controller.isPlay.value
                                        ? const Icon(
                                            Icons.pause,
                                            color: whiteColor,
                                            size: 55,
                                          )
                                        : const Icon(
                                            Icons.play_arrow,
                                            color: whiteColor,
                                            size: 55,
                                          ),
                                  )),
                              CircleAvatar(
                                backgroundColor: slideColor,
                                radius: 30,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller.playIndex.value + 1 >=
                                        data.length) {
                                    } else {
                                      controller.playSong(
                                          data[controller.playIndex.value].uri,
                                          controller.playIndex.value + 1);
                                    }
                                  },
                                  icon: const Icon(Icons.skip_next_rounded,
                                      color: whiteColor),
                                  iconSize: 40,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
