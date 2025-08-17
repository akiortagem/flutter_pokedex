import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PKMNDetailNoDataTab extends StatelessWidget {
  const PKMNDetailNoDataTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NO DATA',
            style: PKMNText.title,
          ),
          Text(
            'Please contact Prof. Oak for support',
            style: PKMNText.bodyText1.small.italic.textSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
