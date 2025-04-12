# 🛒 Ageno Flutter Projekt

Przykładowa aplikacja sklepu mobilnego z obsługą logiki koszyka. Dodatkowo zostały obsłużone takie rzeczy jak:
- Rabaty
- Kod promocyjny
- Możliwość zwiększania ilości artykułu (usuwanie artykułu opcją odejmowania ilości w koszyku)

## 🛠️ Instalacja

Projekt można pozyskać poprzez plik .apk lub też jego kompilację. Jeśli po pobraniu repozytorium pojawiłyby się jakiekolwiek błędy można skorzystać z danych komend:

Budowanie projektu: 
```bash
flutter pub get
```

Budowanie plików generowanych:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Budowanie opcji językowych (EasyLocalization):
```bash
flutter pub run easy_localization:generate --source-dir assets/translations -f keys -o locale_keys.g.dart
```

## 🧱 Architektura

### 🔹 Feature-first + Clean Architecture

Aplikacja została zorganizowana w podejściu **Feature-first**, gdzie każda funkcjonalność posiada swoją własną strukturę (`data`, `presentation`, `domain`). Takie podejście jest szczególnie skuteczne w większych projektach, jak np. aplikacje e-commerce, ponieważ:

- Ułatwia skalowanie projektu
- Ogranicza zależności między modułami
- Ułatwia pracę wielu programistom jednocześnie
- Łatwiej utrzymać spójność i separację warstw

### 🔹 Warstwy Clean Architecture:

- `domain` – logika biznesowa, interfejsy repozytoriów
- `data` – implementacje źródeł danych i modeli DTO
- `presentation` – UI, providery, widżety

### Zarządzanie stanem

Do zarządzania stanem aplikacji wybrałem `Riverpod`. Pierwszym z powodu dlaczego ją wybrałem to jest to, że wcześniej przy rekrutacji wysyłałem mój przykładowy kod wykonany w BLoC (przez co tutaj chciałem wykorzystać inne podejście), a drugim powodem jest to, że paczka podobna jest do zarządzania stanem w Reactcie oraz jeśli będzie trzeba istnieje możliwość wprowadzenia hooksów za pomocą paczki `hooks_riverpod`.

### Opis w praktyce

W aplikacji architektura została utworzony w ten sposób, że wszystkie elementy powiązane z listą produktów posiadają trzy warstwy, gdzie w warstwie `data` przechowywane są zmockowane dane produktów. Elementy powiązane z koszykiem, nie posiadają warstwy `data`, aby nie komplikować implementacji. Całość logiki i przechowywanie stanu dzieje się w Providerze.

## 📦 Wykorzystane paczki i uzasadnienie wyboru

- `Freezed` - Dla łatwego tworzenia modeli i klas oraz ich edycji, co przyspiesza development
- `Injectable + GetIt` - Paczki wykorzystywane do wstrzykiwania zależności
- `Device Preview Plus` - Idealna paczka do szybkiego testowania widoków na różnych rozdzielczościach urządzeń (poniżej ss programu)
- `Uuid` - Wykorzystywana do generowania unikalnych identyfikatorów
- `FlutterGen` - Do automatycznego generowania ścieżek assetów

## Offtopic
Lista produktów została zapożyczona (zdjęcia, tytuł itp.) z Amazonu 

## 📱 Zdjęcia aplikacji










