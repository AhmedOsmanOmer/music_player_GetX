import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var isPlay=false.obs;
  var playIndex=0.obs;
  
  var duration=''.obs;
  var position=''.obs;
  
  var max=0.0.obs;
  var value=0.0.obs;

  var reverse=false.obs;

  reverseList(){
    if(reverse(true)){
      reverse(false);
    }
    else{
      reverse(true);
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }


updatePosition(){
  audioPlayer.durationStream.listen((d) {
  duration.value=d.toString().split(".")[0];
  max.value=d!.inSeconds.toDouble();
  });

  audioPlayer.positionStream.listen((p) {
  position.value=p.toString().split(".")[0];
  value.value=p.inSeconds.toDouble();
  });
}
///
  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }

//

playSong(url,index)async{
  playIndex.value=index;
  try {
     await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
  audioPlayer.play();
  isPlay(true);
    updatePosition();

  } catch (e) {
    print(e.toString());
  }
 
}

changeDuration(second){
  var duration=Duration(seconds: second);
  audioPlayer.seek(duration);
}
}
