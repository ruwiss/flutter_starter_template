# Starter Template

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Flutter yeni proje şeması. HTTP servis, temalar, navigasyon, çoklu dil, animasyonlar ve bağımlılık enjeksiyonu içerir.

## Kullanılanlar:

- [dio](https://pub.dev/packages/dio) http client
- [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) dio için log oluşturucu
- [auto_route](https://pub.dev/packages/auto_route) navigasyon için
- [get_it](https://pub.dev/packages/get_it) bağımlılık enjeksiyonu için
- [envied](https://pub.dev/packages/envied) güvenli ortam değişkenleri oluşturmak için
- [very_good_analysis](https://pub.dev/packages/very_good_analysis) kod yazım kuralları için
- [animations](https://pub.dev/packages/animations/install) hoş animasyonlar için

## Proje Yapısı

- "app" klasörü uygulamanın özel dosyalarını içerir.
- "core" klasörü, diğer projelerde yeniden kullanılabilecek uygulamadan bağımsız kodlar içerir.
- "feature" klasörü uygulamanın sayfalarını (özelliklerini) içerir.

## Nasıl kullanılır? 🚀

[mason_cli](https://github.com/felangel/mason/tree/master/packages/mason_cli) Kurulu olduğundan emin olun.
[git](https://git-scm.com/) Kurulu olduğundan emin olun.

```sh
dart pub global activate mason_cli
```

Şemayı Mason'a ekleyin.

```sh
mason add [isim] --path [şema yolu]
```

Daha sonra oluşturduğunuz şemayı kullanın

```sh
mason make [isim]
```

## Output 📦

```sh

📦lib
 ┣ 📂app
 ┃ ┣ 📂constants
 ┃ ┃ ┗ 📜string_constants.dart
 ┃ ┣ 📂environment
 ┃ ┃ ┣ 📜app_environment.dart
 ┃ ┃ ┣ 📜development_environment.dart
 ┃ ┃ ┣ 📜development_environment.g.dart
 ┃ ┃ ┣ 📜production_environment.dart
 ┃ ┃ ┗ 📜production_environment.g.dart
 ┃ ┣ 📂l10n
 ┃ ┃ ┣ 📂arb
 ┃ ┃ ┃ ┣ 📜app_en.arb
 ┃ ┃ ┃ ┗ 📜app_tr.arb
 ┃ ┃ ┗ 📜l10n.dart
 ┃ ┣ 📂router
 ┃ ┃ ┣ 📜app_router.dart
 ┃ ┃ ┗ 📜app_router.gr.dart
 ┃ ┣ 📂theme
 ┃ ┃ ┣ 📂base
 ┃ ┃ ┃ ┗ 📜base_theme.dart
 ┃ ┃ ┣ 📂dark
 ┃ ┃ ┃ ┗ 📜dark_theme.dart
 ┃ ┃ ┗ 📂light
 ┃ ┃ ┃ ┗ 📜light_theme.dart
 ┃ ┗ 📂view
 ┃ ┃ ┗ 📜app.dart
 ┣ 📂core
 ┃ ┣ 📂base
 ┃ ┃ ┗ 📜base_viewmodel.dart
 ┃ ┣ 📂clients
 ┃ ┃ ┗ 📂network
 ┃ ┃ ┃ ┗ 📜network_client.dart
 ┃ ┣ 📂extensions
 ┃ ┃ ┗ 📜context_extensions.dart
 ┃ ┗ 📂utils
 ┃ ┃ ┣ 📂device_info
 ┃ ┃ ┃ ┗ 📜device_info_utils.dart
 ┃ ┃ ┗ 📂package_info
 ┃ ┃ ┃ ┗ 📜package_info_utils.dart
 ┣ 📂feature
 ┃ ┗ 📂home
 ┃ ┃ ┣ 📂model
 ┃ ┃ ┃ ┗ 📜.gitkeep
 ┃ ┃ ┣ 📂view
 ┃ ┃ ┃ ┗ 📜home_view.dart
 ┃ ┃ ┗ 📂view_model
 ┃ ┃ ┃ ┗ 📜.gitkeep
 ┣ 📜bootstrap.dart
 ┣ 📜locator.dart
 ┣ 📜main_development.dart
 ┗ 📜main_production.dart

```