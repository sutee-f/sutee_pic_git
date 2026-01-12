import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'calc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;

  final thaiCtrl = TextEditingController();
  final camCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sutee_pic")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
                Image.asset(
      'assets/thai.png',
      width: 150
    ),
            const Text("ธงชาติไทย ราคา 10 บาท"),
            TextField(controller: thaiCtrl, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
                Image.asset(
      'assets/cam.png',
      width: 150
    ),
            const Text("ธงชาติกัมพูชา ราคา 2 บาท"),
            TextField(controller: camCtrl, keyboardType: TextInputType.number),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text("ล้างข้อมูล"),
                  onPressed: () {
                    thaiCtrl.clear();
                    camCtrl.clear();
                  },
                ),
                ElevatedButton(
                  child: const Text("คำนวณราคา"),
                  onPressed: () async {
                    await firestore.collection("flag_tab").add({
                      "thai_pc": int.tryParse(thaiCtrl.text) ?? 0,
                      "cam_pc": int.tryParse(camCtrl.text) ?? 0,
                      "timestamp": FieldValue.serverTimestamp(),
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CalcPage()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
