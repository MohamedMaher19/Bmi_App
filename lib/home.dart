import 'package:flutter/material.dart';
import 'dart:math';
import 'result.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;

  double heightVal = 170;

  int weight = 55;

  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boody Mass Index'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                 child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                children: [
                  m1Expanded(context, 'male'),
                  SizedBox(
                    width: 15,
                  ),
                  m1Expanded(context, 'female'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Height',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(heightVal.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headline1),
                          SizedBox(
                            width: 10,
                          ),
                          Text('cm',
                              style: Theme.of(context).textTheme.headline1)
                        ],
                      ),
                      Slider(
                        value: heightVal,
                        onChanged: (newvalue) {
                          setState(() {
                              heightVal= newvalue ;
                          });
                        },
                        max: 200,
                        min: 50,
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  m2Expanded(context, 'weight'),
                  SizedBox(
                    width: 15,
                  ),
                  m2Expanded(context, 'age'),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.teal,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 13,
            child: TextButton(
              onPressed: () {
                var result = weight / pow(heightVal / 100, 2);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Result(
                    result: result,
                    isMale: isMale,
                    age: age,
                  );
                }));
              },
              child: Text(
                ' Calculate',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          )
        ],
      )),
    );
  }

  Expanded m1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = (type == 'male') ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (isMale && type == 'male') || (!isMale && type == 'female')
                  ? Colors.teal
                  : Colors.blueGrey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == 'male' ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(height: 15),
              Text(type == 'male' ? 'Male' : 'Female',
                  style: Theme.of(context).textTheme.headline1)
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type == 'age' ? 'Age' : 'Weight',
                style: Theme.of(context).textTheme.headline1),
            const SizedBox(height: 15),
            Text(type == 'age' ? '$age' : '$weight',
                style: Theme.of(context).textTheme.headline1),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age --' : 'weight --',
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age-- : weight--;
                    });
                  },
                  child: Icon(Icons.remove),
                  mini: true,
                ),
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age ++' : 'weight ++',
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age++ : weight++;
                    });
                  },
                  child: Icon(Icons.add),
                  mini: true,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
