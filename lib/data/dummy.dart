import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChoiceItem {
  String name;
  bool isChoice;

  ChoiceItem({required this.name, required this.isChoice});
}

List<ChoiceItem> iotList = [
  ChoiceItem(name: 'JasmineKu', isChoice: true),
  ChoiceItem(name: 'Rosemary', isChoice: false),
  ChoiceItem(name: 'Blueberry Ponakan', isChoice: false),
];

Map<String, dynamic> infoBloom = {
  'status': 0, //0 perlu disiram //1 perlu diberi cahaya //2 tanaman sedang baik
  'name': 'MyJasmine',
};



Future<void> updatestatus(BuildContext context, String device, String name) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("devices/$device");

  try {
    final snapshot = await ref.get();
    if (!snapshot.exists) {
      await showAlertDialog(
      context,
      "Error",
      "Perangkat dengan token tersebut tidak ditemukan.",
    );
    }

    if (snapshot.exists) {
      await ref.update({
        "status" : 'active'
      });

      DatabaseReference refSet = FirebaseDatabase.instance.ref("iot/$device");
      await refSet.set({
        "name": name,
        "notified": 0,
        "humidity": 0,
        "intensity": 0,
        "temperature": 0,
        "condition": "Aku sehat"
      });
      
      await showAlertDialog(
        context,
        "Sukses",
        "Perangkat Berhasil Dihubungkan",
      );
    }
    print("Age updated successfully!");
  } catch (error) {
    await showAlertDialog(
          context,
          "Error",
          "Terjadi kesalahan",
        );
    print("Failed to update age: $error");
  }
}

Future<void> showAlertDialog(BuildContext context, String title, String message) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}