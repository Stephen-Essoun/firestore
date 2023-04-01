import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:indexed_stacked/main.dart';

class MyIndexedStack extends StatefulWidget {
  const MyIndexedStack({super.key});

  @override
  State<MyIndexedStack> createState() => _MyIndexedStackState();
}

class _MyIndexedStackState extends State<MyIndexedStack> {
  final pages = const <Widget>[MyHomePage(title: 'Home Page'), SecondPage()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
              child: GestureDetector(
                onTap: () => setState(() {
                  index = 0;
                }),
                child: Icon(Icons.home_filled),
              ),
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: GestureDetector(
                onTap: () => setState(() {
                  index = 1;
                }),
                child: Icon(Icons.home),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
