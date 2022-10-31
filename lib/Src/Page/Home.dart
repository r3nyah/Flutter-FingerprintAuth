import 'package:flutter/material.dart';
import './Login.dart';
import 'package:flutter_fingerprint/main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://static.wikia.nocookie.net/gensin-impact/images/6/6d/Icon_Emoji_038_Tartaglia_Pleased.png/revision/latest/scale-to-width-down/185?cb=20210906043952',
              ),
              /*Text(
                'Home',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),*/
              SizedBox(height: 40,),
              buildLogOutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogOutButton(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50)
      ),
      child: Text(
        'Logout',
        style: TextStyle(
          fontSize: 20
        ),
      ),
      onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context){
            return Login();
          }
        ));
      },
    );
  }
}
