import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("สรุปข้อมูลการสั่งซื้อ")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("flag_tab")
            .orderBy("timestamp", descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs.first;
          final thai = data["thai_pc"] * 10;
          final cam = data["cam_pc"] * 2;
          final total = thai + cam;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("ธงชาติไทย = $thai บาท"),
                Text("ธงชาติกัมพูชา = $cam บาท"),
                const Divider(),
                Text("รวมสุทธิ = $total บาท",
                    style: const TextStyle(fontSize: 20)),
                const Spacer(),
                ElevatedButton(
                  child: const Text("กลับไปเลือกสินค้า"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
