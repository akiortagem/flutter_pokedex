enum PKMNMoveLearnMethod {
  levelUp(label: 'Level Up'),
  egg(label: 'Egg'),
  tutor(label: 'Tutor'),
  machine(label: 'HM/TM'),
  stadiumSurfingPikachu(label: 'SSP'),
  lightBallEgg(label: 'Light Ball Egg'),
  colloseumPurification(label: 'CollPurif'),
  xdShadow(label: 'XDShadow'),
  xdPurification(label: 'XdPurif'),
  formChange(label: 'Form Change'),
  zygardeCube(label: 'Zygarde Cube'),
  unknown(label: 'Unknown');

  const PKMNMoveLearnMethod({required this.label});

  final String label;
}

class PKMNMoveModel {
  const PKMNMoveModel({
    this.name,
    this.moveId,
    this.learnMethod = PKMNMoveLearnMethod.unknown,
  });

  final String? name;
  final String? moveId;
  final PKMNMoveLearnMethod learnMethod;
}
