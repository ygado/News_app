# 📰 News App - تطبيق الأخبار



<p align="center">



</p>



<p align="center">

  <strong>تطبيق أخبار متكامل يعمل على Android و iOS</strong>

</p>



<p align="center">

  <a href="#-المميزات">المميزات</a> •

  <a href="#-التقنيات-المستخدمة">التقنيات</a> •

  <a href="#-التثبيت">التثبيت</a> •

  <a href="#-المساهمة">المساهمة</a>

</p>



---



## 📱 المميزات



- ✅ **تسجيل الدخول وإنشاء حساب** - نظام متكامل للمستخدمين

- ✅ **عرض الأخبار** - تصفح الأخبار حسب الأقسام المختلفة

- ✅ **البحث** - بحث متقدم مع مؤشر تحميل ونتائج فورية

- ✅ **الوضع المظلم** - دعم كامل للوضع المظلم والفاتح

- ✅ **عرض صفحة الويب** - فتح الروابط داخل التطبيق

- ✅ **تغيير كلمة المرور** - تحديث كلمة المرور بسهولة

- ✅ **تخصيص الملف الشخصي** - إضافة صورة شخصية



---



## 🛠 التقنيات المستخدمة



| التقنية | الاستخدام |

|---------|-----------|

| **Flutter** | إطار العمل الرئيسي |

| **BLoC / Cubit** | إدارة الحالة (State Management) |

| **SQLite** | قاعدة بيانات محلية للمستخدمين |

| **Dio** | طلبات API |

| **Shared Preferences** | تخزين الإعدادات المحلية |

| **WebView** | عرض صفحات الويب |

| **ScreenUtil** | تصميم متجاوب مع جميع الشاشات |



---



## 📦 المكتبات المستخدمة



```yaml

dependencies:

  flutter:

    sdk: flutter



  # State Management

  flutter_bloc: ^8.1.3



  # Networking

  dio: ^5.3.3



  # Local Storage

  sqflite: ^2.3.0

  shared_preferences: ^2.2.2



  # UI

  flutter_screenutil: ^5.9.0

  conditional_builder_null_safety: ^1.0.8



  # WebView

  webview_flutter: ^4.4.2



  # Image Picker

  image_picker: ^1.0.4

```



---



## 🚀 التثبيت



```bash

# 1. Clone المشروع

git clone https://github.com/ygado/news_app.git



# 2. ادخل على فولدر المشروع

cd news_app



# 3. حمّل الـ dependencies

flutter pub get



# 4. شغّل التطبيق

flutter run

```



---



## 📁 هيكل المشروع



```

lib/

├── layout/

│   ├── cubit/

│   │   ├── news_cubit.dart

│   │   └── news_states.dart

│   └── news_layout.dart

├── modules/

│   ├── login_views/

│   │   ├── cubit/

│   │   │   ├── login_cubit.dart

│   │   │   └── login_states.dart

│   │   └── login_views.dart

│   ├── register_views/

│   │   └── register_views.dart

│   ├── news_views/

│   │   └── news_views.dart

│   ├── search_views/

│   │   └── search_views.dart

│   └── web_view/

│       └── web_view.dart

├── shared/

│   ├── components/

│   │   └── components.dart

│   ├── network/

│   │   ├── local/

│   │   │   └── shared_prefeence.dart

│   │   └── remote/

│   │       └── dio_helper.dart

│   └── bloc_observer.dart

└── main.dart

```



---



## 🔑 API المستخدمة



يستخدم التطبيق **[NewsAPI](https://newsapi.org/)** لجلب الأخبار.



- **Endpoint:** `https://newsapi.org/v2/`

- **المفاتيح المطلوبة:** `apiKey` — سجّل على [newsapi.org](https://newsapi.org/) واحصل على مفتاح مجاني



> ⚠️ **تنبيه:** لا ترفع الـ API Key الخاص بك على GitHub. أضفه يدوياً بعد ما تعمل clone للمشروع.



---



## 🎯 الميزات القادمة



- [ ] حفظ الأخبار المفضلة

- [ ] مشاركة الأخبار عبر وسائل التواصل

- [ ] دعم اللغتين العربية والإنجليزية



---



## 🤝 المساهمة



نرحب بمساهماتكم! اتبع الخطوات دي:



1. **Fork** المشروع

2. إنشاء فرع جديد (`git checkout -b feature/AmazingFeature`)

3. **Commit** التغييرات (`git commit -m 'Add some AmazingFeature'`)

4. **Push** إلى الفرع (`git push origin feature/AmazingFeature`)

5. افتح **Pull Request**



---



## 📄 الترخيص



هذا المشروع مرخص تحت **MIT License**



---



## 📞 التواصل



- **GitHub:** [@ygado](https://github.com/ygado)



---



<p align="center">Made with ❤️ by <strong>YoussefGado</strong></p>
