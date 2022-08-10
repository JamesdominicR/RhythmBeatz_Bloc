import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rhythm_beatz_bloc/presentation/Screens/widgets/bottom_navigation.dart';
class AnimatedsplashScreen extends StatelessWidget {
  List<Audio> audioSongs;
  AnimatedsplashScreen({Key? key, required this.audioSongs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xffD9D8E0),
      duration: 4000,
      splash: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
         Lottie.asset('assets/lottie_splash/81966-girl-listening-to-music.json'),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'R',
                  style: TextStyle(
                    color: Color(0xffEA6553),
                    fontSize: 40,
                    fontFamily: 'Inter-Bold',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'hythm',
                  style: TextStyle(
                    color: Color(0xff8A53EA),
                    fontSize: 40,
                    fontFamily: 'Inter-Bold',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'B',
                  style: TextStyle(
                    color: Color(0xffEA6553),
                    fontSize: 40,
                    fontFamily: 'Inter-Bold',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'eatz',
                  style: TextStyle(
                    color: Color(0xff8A53EA),
                    fontSize: 40,
                    fontFamily: 'Inter-Bold',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      splashIconSize: double.infinity,
     nextScreen: BottomNavigationWidget(
       allsong: audioSongs,
     ),
     splashTransition: SplashTransition.fadeTransition,
    );
  }
}
