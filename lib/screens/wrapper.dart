
import 'package:flutter/material.dart';
import 'package:flutterapp/model/signinmodel.dart';
import 'package:flutterapp/model/user.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'auth/signin.dart';

class Wrapper extends StatelessWidget {
  final AuthServices auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: auth.getCurrentUser() ,
     builder: (context , AsyncSnapshot<User> snopshot){
        if(snopshot.connectionState == ConnectionState.waiting){
          return Container(
            color: Colors.white,
            child: Loading(),
          );
        }else{
          if(snopshot.hasData){
            return Home();
          }else{
            return ChangeNotifierProvider(
                create: (_)=>Authmodel(),
            builder: (ctx , _ )=> Signin(),
            );
          }
        }
     }

    );
  }
}
