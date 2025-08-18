import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';

Color pkmnType2BgColor(PKMNTypes? pkmnType) {
  switch (pkmnType) {
    case PKMNTypes.normal:
      return PKMNColors.typeNormalBg;
    case PKMNTypes.fire:
      return PKMNColors.typeFireBg;
    case PKMNTypes.water:
      return PKMNColors.typeWaterBg;
    case PKMNTypes.electric:
      return PKMNColors.typeElectricBg;
    case PKMNTypes.grass:
      return PKMNColors.typeGrassBg;
    case PKMNTypes.ice:
      return PKMNColors.typeIceBg;
    case PKMNTypes.fighting:
      return PKMNColors.typeFightingBg;
    case PKMNTypes.poison:
      return PKMNColors.typePoisonBg;
    case PKMNTypes.ground:
      return PKMNColors.typeGroundBg;
    case PKMNTypes.flying:
      return PKMNColors.typeFlyingBg;
    case PKMNTypes.psychic:
      return PKMNColors.typePsychicBg;
    case PKMNTypes.bug:
      return PKMNColors.typeBugBg;
    case PKMNTypes.rock:
      return PKMNColors.typeRockBg;
    case PKMNTypes.ghost:
      return PKMNColors.typeGhostBg;
    case PKMNTypes.dragon:
      return PKMNColors.typeDragonBg;
    case PKMNTypes.dark:
      return PKMNColors.typeDarkBg;
    case PKMNTypes.steel:
      return PKMNColors.typeSteelBg;
    case PKMNTypes.fairy:
      return PKMNColors.typeFairyBg;
    default:
      return PKMNColors.typeDefaultBg;
  }
}

Color pkmnType2FgColor(PKMNTypes? pkmnType) {
  switch (pkmnType) {
    case PKMNTypes.normal:
      return PKMNColors.typeNormalFg;
    case PKMNTypes.fire:
      return PKMNColors.typeFireFg;
    case PKMNTypes.water:
      return PKMNColors.typeWaterFg;
    case PKMNTypes.electric:
      return PKMNColors.typeElectricFg;
    case PKMNTypes.grass:
      return PKMNColors.typeGrassFg;
    case PKMNTypes.ice:
      return PKMNColors.typeIceFg;
    case PKMNTypes.fighting:
      return PKMNColors.typeFightingFg;
    case PKMNTypes.poison:
      return PKMNColors.typePoisonFg;
    case PKMNTypes.ground:
      return PKMNColors.typeGroundFg;
    case PKMNTypes.flying:
      return PKMNColors.typeFlyingFg;
    case PKMNTypes.psychic:
      return PKMNColors.typePsychicFg;
    case PKMNTypes.bug:
      return PKMNColors.typeBugFg;
    case PKMNTypes.rock:
      return PKMNColors.typeRockFg;
    case PKMNTypes.ghost:
      return PKMNColors.typeGhostFg;
    case PKMNTypes.dragon:
      return PKMNColors.typeDragonFg;
    case PKMNTypes.dark:
      return PKMNColors.typeDarkFg;
    case PKMNTypes.steel:
      return PKMNColors.typeSteelFg;
    case PKMNTypes.fairy:
      return PKMNColors.typeFairyFg;
    default:
      return PKMNColors.typeDefaultFg;
  }
}

extension PKMNTypeColor on PKMNTypes {
  Color get fgColor => pkmnType2FgColor(this);
  Color get bgColor => pkmnType2BgColor(this);
}

extension Capitalise on String {
  String get capitalise {
    return [this[0].toUpperCase(), ...split('').skip(1)].join();
  }

  String get dashToCapitalized {
    return split('-')
        .map((word) =>
            word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
