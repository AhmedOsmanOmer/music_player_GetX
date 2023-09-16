import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';
const bold="bold";
const regular="regular";
ourStyle({weight,double? size=14 ,color=whiteColor}){
  return TextStyle(
    fontWeight:weight ,
   fontSize:size ,
   color: color
  );
}