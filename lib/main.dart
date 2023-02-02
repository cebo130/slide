import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:slide/screens/auth_screen/AuthScreen.dart';
import 'package:slide/screens/home_screen/home_screen.dart';
import 'package:slide/screens/profile/create_profile.dart';
import 'package:slide/screens/splash/custom_splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Start());
}
class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        backgroundColor: Colors.white,
        splash: Image.asset('assets/images/trans_logo.png',),
        splashIconSize: 160,
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: Duration(seconds: 3),
        //pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        backgroundColor: Colors.teal,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.teal,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
        ),
        textTheme: TextTheme(subtitle1: TextStyle(color: Colors.blue,fontSize: 30)),//change entered text color
      ),
      //home: CreateProfile(myDate: 'for now',),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx, userSnapshot){
        if(userSnapshot.connectionState == ConnectionState.waiting){
          return CustomSplash();
        }
        if(userSnapshot.hasData){
          return Home();
        }
        return AuthScreen();
      },),
    );
  }
}
