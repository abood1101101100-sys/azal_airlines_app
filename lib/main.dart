import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const AzalAirlinesApp());
}

class AppColors {
  static const Color primary = Color(0xFF0B2E59);
  static const Color secondary = Color(0xFF1E88E5);
  static const Color gold = Color(0xFFD9A441);
  static const Color background = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF1F2937);
  static const Color white = Color(0xFFFFFFFF);
}

class StaticContent {
  static const String appName = 'Azal Airlines';

  static const String homeTitle = 'مرحبًا بك في Azal Airlines';

  static const String homeDescription =
      'استمتع بتجربة سفر سهلة ومريحة، وتابع أحدث العروض والخدمات من خلال التطبيق.';

  static const List<String> destinations = [
    'صنعاء',
    'عدن',
    'سيئون',
    'القاهرة',
    'عمّان',
    'جدة',
    'الرياض',
    'دبي',
    'إسطنبول',
    'الدوحة',
  ];

  static const List<Map<String, String>> offers = [
    {
      'title': 'عروض خاصة على الرحلات',
      'description': 'تابع أحدث عروض السفر المتاحة عبر Azal Airlines.',
    },
    {
      'title': 'احجز رحلتك بسهولة',
      'description': 'واجهة سهلة للبحث عن الرحلات واختيار وجهتك المفضلة.',
    },
    {
      'title': 'خدمات المسافرين',
      'description': 'معلومات مهمة حول الأمتعة، الوجهات، وإجراءات السفر.',
    },
  ];

  static const String about =
      'Azal Airlines تطبيق مصمم لتقديم تجربة سفر سهلة للمستخدمين، من خلال عرض الخدمات والوجهات والعروض ومعلومات التواصل.';

  static const String website = 'https://www.azalairlinesye.com';
  static const String email = 'info@azalairlinesye.com';
  static const String phone = 'سيتم إضافة رقم التواصل الرسمي';
  static const String address = 'سيتم إضافة العنوان الرسمي';
}

class AzalAirlinesApp extends StatelessWidget {
  const AzalAirlinesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StaticContent.appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.white,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: SplashScreen(),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/azal_logo.svg',
      width: size,
      height: size,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppLogo(size: 145),
            SizedBox(height: 24),
            Text(
              'Azal Airlines',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'رحلتك تبدأ معنا',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final pages = const [
    HomePage(),
    BookingPage(),
    DestinationsPage(),
    OffersPage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.flight_takeoff_outlined),
            selectedIcon: Icon(Icons.flight_takeoff),
            label: 'الحجز',
          ),
          NavigationDestination(
            icon: Icon(Icons.place_outlined),
            selectedIcon: Icon(Icons.place),
            label: 'الوجهات',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer_outlined),
            selectedIcon: Icon(Icons.local_offer),
            label: 'العروض',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent_outlined),
            selectedIcon: Icon(Icons.support_agent),
            label: 'تواصل',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('هذه الخدمة ستكون متاحة قريبًا بعد ربط النظام.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Azal Airlines'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: AppLogo(size: 105)),
                SizedBox(height: 18),
                Text(
                  StaticContent.homeTitle,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  StaticContent.homeDescription,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'الخدمات السريعة',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.05,
            children: [
              ServiceCard(
                icon: Icons.flight_takeoff,
                title: 'حجز رحلة',
                subtitle: 'ابحث عن رحلتك',
                onTap: () => showComingSoon(context),
              ),
              ServiceCard(
                icon: Icons.confirmation_number,
                title: 'إدارة الحجز',
                subtitle: 'تابع بيانات حجزك',
                onTap: () => showComingSoon(context),
              ),
              ServiceCard(
                icon: Icons.luggage,
                title: 'الأمتعة',
                subtitle: 'معلومات السفر',
                onTap: () => showComingSoon(context),
              ),
              ServiceCard(
                icon: Icons.support_agent,
                title: 'خدمة العملاء',
                subtitle: 'تواصل معنا',
                onTap: () => showComingSoon(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'عن التطبيق',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                StaticContent.about,
                style: TextStyle(fontSize: 14, height: 1.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 38),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? fromCity;
  String? toCity;
  DateTime? departureDate;
  DateTime? returnDate;
  int passengers = 1;

  Future<void> pickDate({required bool isReturn}) async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (date == null) return;

    setState(() {
      if (isReturn) {
        returnDate = date;
      } else {
        departureDate = date;
      }
    });
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'اختر التاريخ';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void searchFlights() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم تفعيل البحث عن الرحلات بعد إضافة API.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destinations = StaticContent.destinations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز رحلة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ابحث عن رحلتك',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'هذه واجهة مبدئية، وسيتم ربطها بنظام الرحلات لاحقًا.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: fromCity,
            decoration: const InputDecoration(
              labelText: 'من',
              prefixIcon: Icon(Icons.flight_takeoff),
            ),
            items: destinations.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                fromCity = value;
              });
            },
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: toCity,
            decoration: const InputDecoration(
              labelText: 'إلى',
              prefixIcon: Icon(Icons.flight_land),
            ),
            items: destinations.map((city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                toCity = value;
              });
            },
          ),
          const SizedBox(height: 14),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('تاريخ المغادرة'),
              subtitle: Text(formatDate(departureDate)),
              onTap: () => pickDate(isReturn: false),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('تاريخ العودة'),
              subtitle: Text(formatDate(returnDate)),
              onTap: () => pickDate(isReturn: true),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'عدد المسافرين',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: passengers > 1
                        ? () {
                            setState(() {
                              passengers--;
                            });
                          }
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$passengers',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        passengers++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: searchFlights,
            icon: const Icon(Icons.search),
            label: const Text('بحث عن الرحلات'),
          ),
        ],
      ),
    );
  }
}

class DestinationsPage extends StatelessWidget {
  const DestinationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = StaticContent.destinations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الوجهات'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: destinations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final city = destinations[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.secondary.withOpacity(0.12),
                child: const Icon(Icons.place, color: AppColors.primary),
              ),
              title: Text(
                city,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('وجهة متاحة ضمن القائمة التجريبية'),
              trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
          );
        },
      ),
    );
  }
}

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = StaticContent.offers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('العروض والأخبار'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final offer = offers[index];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.local_offer,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer['title'] ?? '',
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          offer['description'] ?? '',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void showNotReady(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم تفعيل هذه الخاصية لاحقًا.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تواصل معنا'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'يسعدنا تواصلك معنا',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'يمكنك متابعة الموقع الرسمي أو استخدام بيانات التواصل التالية.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ContactItem(
            icon: Icons.language,
            title: 'الموقع الإلكتروني',
            value: StaticContent.website,
            onTap: () => showNotReady(context),
          ),
          ContactItem(
            icon: Icons.email,
            title: 'البريد الإلكتروني',
            value: StaticContent.email,
            onTap: () => showNotReady(context),
          ),
          ContactItem(
            icon: Icons.phone,
            title: 'الهاتف',
            value: StaticContent.phone,
            onTap: () => showNotReady(context),
          ),
          ContactItem(
            icon: Icons.location_on,
            title: 'العنوان',
            value: StaticContent.address,
            onTap: () => showNotReady(context),
          ),
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ContactItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withOpacity(0.12),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_back_ios_new, size: 16),
      ),
    );
  }
}
