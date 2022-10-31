import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../Api/LocalAuth.dart';
import './Home.dart';
import 'package:flutter_fingerprint/main.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool trust = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                trust?
                'https://static.wikia.nocookie.net/gensin-impact/images/8/88/Icon_Emoji_061_Tartaglia_Shocked.png/revision/latest/scale-to-width-down/185?cb=20210906044048'
                    :
                'https://static.wikia.nocookie.net/gensin-impact/images/c/c3/Icon_Emoji_062_Tartaglia_The_light_fades.png/revision/latest/scale-to-width-down/185?cb=20210906044050'

              ),
              SizedBox(height: 32,),
              buildAvailability(context),
              SizedBox(height: 24,),
              buildAuthenticate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
}){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
      ),
      icon: Icon(
        icon,
        size: 26,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 20
        ),
      ),
      onPressed: onClicked,
    );
  }


  Widget buildAvailability(BuildContext context){
    return buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: ()async{
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();
          final hasFingerprint = biometrics.contains(BiometricType.weak);

          print(biometrics);
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  backgroundColor: Colors.blueGrey,
                  title: Text(
                    'Availability',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildText('Biometrics', isAvailable,),
                      buildText('Fingerprint', hasFingerprint),
                    ],
                  ),
                );
              }
          );
        }
    );
  }

  Widget buildText(String text,bool checked){
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8
      ),
      child: Row(
        children: [
          checked
            ? Icon(
            Icons.check,
            color: Colors.green,
            size: 24,
          ):Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 12,),
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }

  Widget buildAuthenticate(BuildContext context){
    return buildButton(
      text: 'Authenticate',
      icon: Icons.lock_open,
      onClicked: ()async{
        final isAuthenticate = await LocalAuthApi.authenticate();

        if(isAuthenticate){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context){
                return Home();
              }
            )
          );
        }
      }
    );
  }
}
