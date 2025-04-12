# 🛒 Ageno Flutter Projekt

Przykładowa aplikacja sklepu mobilnego z obsługą logiki koszyka. Dodatkowo zostały obsłużone takie rzeczy jak:
- Rabaty
- Kod promocyjny
- Możliwość zwiększania ilości artykułu (usuwanie artykułu opcją odejmowania ilości w koszyku)
- Kategorie

W aplikacji przejście do koszyka zostało zaimplementowane po kliknięciu w sumę produktów w koszyku. Dodawanie do koszyka odbywa się poprzez w górnym prawym rogu produktu ikonę koszyka.

Aplikacja była testowana na platformach Android oraz iOS oraz urządzeniu fizycznym (Xiaomi POCO X3). Aby przetestować responsywność aplikacji, warto załączyć DevicePreview (w pliku `main.dart` zamienić pole `enabled` na true)

## 🛠️ Instalacja

Projekt można pozyskać poprzez plik .apk (w folderze `/apk`) lub też przez jego kompilację. Jeśli po pobraniu repozytorium pojawiłyby się jakiekolwiek błędy można skorzystać z danych komend:

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
Lista produktów została zapożyczona (zdjęcia, tytuł itp.) ze strony internetowej Amazonu 😁

## 📱 Zdjęcia aplikacji


### Iphone 12 Pro Max 428x926

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/06ffd6c5-6a0f-4a2d-8800-6f1577da1330" width="48%" />
  <img src="https://github.com/user-attachments/assets/c21effc3-45fd-4894-92d7-d4f58ef982c5" width="48%" />
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/b63e7efb-da51-47ea-a8ba-18ec0feb7b7b" width="48%" />
  <img src="https://github.com/user-attachments/assets/8d969908-0c62-4ff1-8ba2-965d1ff84829" width="48%" />
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/b8cb204a-5bae-4b79-b7c5-adafafaeb247" width="48%" />
</div>

### Tablet 800x1280 Android
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/48fd0ff5-f423-47fd-9dc5-26b00e4946f8" width="48%" />
  <img src="https://github.com/user-attachments/assets/451e63ea-e279-41e8-b9f3-923d9a81b932" width="48%" />
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/7b2d9c41-e6a5-417f-8a1d-8156dfa18630" width="48%" />
  <img src="https://github.com/user-attachments/assets/514de45d-357f-4f6d-96bc-e114fa75c997" width="48%" />
</div>

### Mały smartfon 360x640 Android
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/994a3340-e894-4f7e-a4cc-12dcf4211c42" width="48%" />
  <img src="https://github.com/user-attachments/assets/954c6e7e-82c8-459f-9f2d-f0b802be20a8" width="48%" />
</div>

<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/d2f56cce-c26e-4be4-b294-7e575a2b79a6" width="48%" />
  <img src="https://github.com/user-attachments/assets/99e4604e-c69b-4ca6-b338-2159377f3401" width="48%" />
</div>











