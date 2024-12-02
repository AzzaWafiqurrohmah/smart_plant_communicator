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
