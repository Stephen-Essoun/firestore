import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:indexed_stacked/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:indexed_stacked/provider/user.dart';
import 'package:indexed_stacked/stacked_pages.dart';

import 'model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const MyHomePage(
        title: 'Firestore',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream<QuerySnapshot<User>>? getData;
  @override
  void initState() {
    getData = UserProvider().getUser();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    getData = UserProvider().getUser();
    super.didChangeDependencies();
  }

  void _incrementCounter() async {
    await UserProvider().createuser();
  }

  void delete(index) async {
    await UserProvider().delete(index);
  }

  final list = UserProvider().list;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<User>>(
        stream: getData,
        builder: (context, snapshot) {
          final user = snapshot.data;
          final data = user!.docs;
          if (snapshot.hasError) log(snapshot.error.toString());
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final users = data[index].data();
                    return ListTile(
                      onTap: () => UserProvider().delete(data[index].id),
                      title: Text(users.name),
                      subtitle: Text(users.sex),
                      trailing: Text(data[index].id),
                    );
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.8,
                    bottom: 100,
                    child: FloatingActionButton(
                      onPressed: () => delete(data[0].id),
                      tooltip: 'Increment',
                      child: const Icon(Icons.delete),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.8,
                    bottom: 20,
                    child: FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
