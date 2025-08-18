enum PKMNTypes {
  normal,
  fire,
  water,
  grass,
  electric,
  psychic,
  dragon,
  ice,
  fairy,
  fighting,
  ghost,
  poison,
  bug,
  dark,
  steel,
  ground,
  flying,
  rock,
  unknown
}

PKMNTypes mapTypeNameToEnum(String name) {
  switch (name) {
    case 'normal':
      return PKMNTypes.normal;
    case 'fire':
      return PKMNTypes.fire;
    case 'water':
      return PKMNTypes.water;
    case 'electric':
      return PKMNTypes.electric;
    case 'grass':
      return PKMNTypes.grass;
    case 'ice':
      return PKMNTypes.ice;
    case 'fighting':
      return PKMNTypes.fighting;
    case 'poison':
      return PKMNTypes.poison;
    case 'ground':
      return PKMNTypes.ground;
    case 'flying':
      return PKMNTypes.flying;
    case 'psychic':
      return PKMNTypes.psychic;
    case 'bug':
      return PKMNTypes.bug;
    case 'rock':
      return PKMNTypes.rock;
    case 'ghost':
      return PKMNTypes.ghost;
    case 'dragon':
      return PKMNTypes.dragon;
    case 'dark':
      return PKMNTypes.dark;
    case 'steel':
      return PKMNTypes.steel;
    case 'fairy':
      return PKMNTypes.fairy;
    default:
      return PKMNTypes.unknown;
  }
}
