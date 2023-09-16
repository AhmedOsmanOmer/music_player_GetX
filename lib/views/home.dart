import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controller/palyer_controller.dart';
import 'package:music_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: whiteColor))
          ],
          leading: const Icon(Icons.sort_rounded, color: whiteColor),
          title: Text(
            "Music Hub",
            style: ourStyle(weight: FontWeight.bold, size: 18),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.isEmpty) {
                return const Text("No Songs Available");
              } else {
                print("${snapshot.data}/////////////////****/");

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(()=>ListTile(
                            onTap: () {
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                              Get.to(() => Player(data: snapshot.data!),
                                  transition: Transition.downToUp);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgColor,
                            title: Text(snapshot.data![index].title,
                                maxLines: 2,
                                style: ourStyle(
                                    weight: FontWeight.bold, size: 18)),
                            subtitle: Text(
                                snapshot.data![index].artist.toString(),
                                maxLines: 1,
                                style: ourStyle(/*family:regular*/ size: 12)),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(Icons.music_note,
                                  color: whiteColor, size: 32),
                            ) /**/,
                            trailing: controller.playIndex.value == index &&
                                    controller.isPlay.value
                                ? const Icon(Icons.pause,
                                    color: whiteColor, size: 26)
                                : const Icon(Icons.play_arrow,
                                    color: whiteColor, size: 26),
                          ),)
                        );
                      }),
                );
              }
            }));
  }
}
