# Flutter Pokédex

A simple Pokédex app built with **Flutter** that fetches data from **[PokeAPI](https://pokeapi.co/)**. It supports Pokémon listing, jumping directly to a Pokémon by name, and viewing per-Pokémon details (types, stats, and evolution info).

---

## Features

- **Flutter app** targeting mobile (Android/iOS).
- **PokeAPI integration** for live Pokémon data.
- **Pokémon listing** with basic info and artwork.
- **Jump to Pokémon by name**: type a name and go straight to its page.
- **Pokémon detail view**: types, base stats, and forward evolution steps.

---

## Data Source

All data is retrieved from **PokeAPI**:
- `pokemon/` – core per-Pokémon data (stats, types, sprites).
- `pokemon-species/` – species metadata and evolution chain pointer.
- `evolution-chain/` – evolution chain structure.

> Credit: PokeAPI (https://pokeapi.co/)

---

## Known Limitations

- **Eeveelutions not handled**: the UI may display them as a single long chain (branching not yet rendered).
- **Forward-only evolutions**: evolutions are shown from the **current Pokémon to the next one(s)** and **do not** include prior forms in the chain.
- **Stats gage percentage**: there's some debates amongst fans on how to properly present base stats. Certainly it's not just `stats/255`. The best input from a pokefan that this project currently use is to pick the highest stat and add some padding. The colors, as suggested by the fan, shows the two (or more) lowest stats.
- **Giratina**: The data on this pokemon is all kinds of messed up. So it might not render correctly

---

## Project Structure

```
lib/
├── main.dart           # Entry point
└── src/
├── app/                # Global app-level setup (providers, configs)
├── app.dart            # Root widget
├── core/               # Core infrastructure (not feature-specific)
│ ├── routing/          # Navigation & route handling
│ ├── services/         # API client(s), external integrations
│ └── settings/         # App-wide settings controller
├── features/           # Each feature follows MVVM layering
│ ├── pokemon_list/     # Listing screen: View, ViewModel, Models
│ └── pokemon_detail/   # Detail screen: View, ViewModel, Models
└── shared/             # Reusable building blocks
├── enums/              # Shared enums (e.g., Pokémon types)
├── themes/             # Colors, text styles, design tokens
├── utils.dart          # Small helpers
└── widgets/            # Generic reusable widgets
```

## Getting Started

### Prerequisites
- Flutter SDK installed (`flutter --version`)

### Run
```bash
flutter pub get
flutter run
```

## Project Goals
- Provide a clean Flutter baseline for consuming REST APIs.
- Keep the UI focused and performant for a simple Pokédex experience.
- Serve as a reference for list/detail navigation and simple search-by-name UX.

## Roadmap
- Properly render branching evolution chains (e.g., Eeveelutions).
- Add support for showing previous evolution(s) on the detail view.
- Offline caching and basic theming improvements.
  
## Chores Needed to be Done
- CI/CD to auto-release
- Tests

## Contributing
**PRs are welcome**

Please use semantic commits for your PRs and tell me Why, How, and What Changes your PR covers.


