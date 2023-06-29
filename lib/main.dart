import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hmc_map/firebase_options.dart';
import 'package:hmc_map/mainpage.dart';

import 'join.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String? id;
  String? pw;

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  Text("루트 코드", style: TextStyle(fontSize: 50),),
                  Text("로그인이 필요합니다.")
                ],
              )

          ),
          CustomTextField(label: "mail address", onChangedFunc: (String text){id = text;} , isPassword: false, ),
          CustomTextField(label: "password", onChangedFunc: (String text){pw = text;}, isPassword: true, ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("회원가입"),
              TextButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Join())
                  );
                },
                child: const Text(">>"),)
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential useCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: id!, password: pw!
                  );

                  if (context.mounted) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage(user: useCredential.user!))
                    );
                  }

                }on FirebaseAuthException catch(e) {

                  if (e.code == "user-not-found") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text("로그인 유효성 체크"),
                              content: const Text("이메일이 존재하지 않습니다."),
                              actions: [TextButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, child: const Text("OK"))
                              ]
                          );
                        }
                    );
                  } else if (e.code == "wrong-password") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text("로그인 유효성 체크"),
                              content: const Text("비밀번호가 잘못되었습니다."),
                              actions: [TextButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, child: const Text("OK"))
                              ]
                          );
                        }
                    );
                  }
                }

              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: const Text("Login", textAlign: TextAlign.center,),
              )
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  String label;
  void Function(String text) onChangedFunc;
  bool isPassword;

  CustomTextField({
    required this.label,
    required this.onChangedFunc,
    required this.isPassword,
    Key? key,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child: TextField(
          onChanged: (newText){
            onChangedFunc(newText);
          },
          obscureText: isPassword ? true : false,
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          )
      ),
    );
  }
}