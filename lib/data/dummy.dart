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
