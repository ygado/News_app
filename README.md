# 📰 News App

<p align="center">
  <strong>A Complete Flutter News Application for Android & iOS</strong>
</p>

<p align="center">
  Browse news, search articles, manage your profile, and enjoy a modern responsive UI built with Flutter.
</p>

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-demo-video">Demo</a> •
  <a href="#-installation">Installation</a> •
  <a href="#-project-structure">Project Structure</a>
</p>

---

## 📱 Features

✅ User Authentication (Login & Register)
✅ Browse News by Categories
✅ Real-Time Search
✅ Dark & Light Theme Support
✅ Read Full Articles with WebView
✅ Profile Management
✅ Local Data Persistence
✅ Responsive UI for Different Screen Sizes

---

## 🛠 Tech Stack

| Technology         | Purpose                    |
| ------------------ | -------------------------- |
| Flutter            | Cross-platform development |
| Dart               | Programming language       |
| BLoC / Cubit       | State Management           |
| Dio                | API Requests               |
| SQLite             | Local Database             |
| Shared Preferences | Local Storage              |
| WebView            | Display Articles           |
| ScreenUtil         | Responsive Design          |

---

## 📦 Dependencies

```yaml
flutter_bloc: ^8.1.3
dio: ^5.3.3
sqflite: ^2.3.0
shared_preferences: ^2.2.2
flutter_screenutil: ^5.9.0
conditional_builder_null_safety: ^1.0.8
webview_flutter: ^4.4.2
image_picker: ^1.0.4
```

---

## 🎥 Demo Video

Watch the application in action:

📺 [Demo Video](https://www.youtube.com/watch?v=eV6UE5Hy0wY)

https://www.youtube.com/watch?v=eV6UE5Hy0wY

---

## 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/ygado/News_app.git

# Navigate to project folder
cd News_app

# Install dependencies
flutter pub get

# Run the application
flutter run
```

---

## 📂 Project Structure

```text
lib/
├── layout/
│   ├── cubit/
│   ├── news_layout.dart
│
├── modules/
│   ├── login_views/
│   ├── register_views/
│   ├── news_views/
│   ├── search_views/
│   ├── settings/
│   └── web_view/
│
├── shared/
│   ├── components/
│   ├── network/
│   │   ├── local/
│   │   └── remote/
│   └── bloc_observer.dart
│
└── main.dart
```

---

## 🔑 API

This application uses NewsAPI to fetch news articles.

Endpoint:
```text
https://newsapi.org/v2/
```

> ⚠️ **Important:** Do not upload your API Key to GitHub. Create your own API key from [NewsAPI](https://newsapi.org/) and add it locally before running the application.

---

## 🎯 Future Improvements

- [ ] Save Favorite Articles
- [ ] Share Articles
- [ ] Arabic & English Localization

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create your feature branch
```bash
git checkout -b feature/AmazingFeature
```
3. Commit your changes
```bash
git commit -m "Add AmazingFeature"
```
4. Push your branch
```bash
git push origin feature/AmazingFeature
```
5. Open a Pull Request

---

## 👨‍💻 Author

**Youssef Gado**

- GitHub: [ygado](https://github.com/ygado)
- LinkedIn: [Youssef Gado](https://www.linkedin.com/in/youssef-gado-464a98234)

---

<p align="center">
Made with ❤️ using Flutter
</p>
