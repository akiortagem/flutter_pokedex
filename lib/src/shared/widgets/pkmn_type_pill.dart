import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PKMNTypePill extends StatelessWidget {
  const PKMNTypePill({
    super.key,
    required this.cardFgColor,
    required this.pkmnType,
  });

  final Color cardFgColor;
  final PKMNTypes pkmnType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardFgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            pkmnType.name.toUpperCase(),
            style: PKMNText.bodyText1,
          ),
        ),
      ),
    );
  }
}
