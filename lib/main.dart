import 'package:flutter/material.dart';

void main() {
  runApp(const StudentDashboardApp());
}

class StudentDashboardApp extends StatelessWidget {
  const StudentDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0866E8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
        fontFamily: 'Roboto',
      ),
      home: const StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int counter = 0;
  bool isFavorite = false;
  int selectedIndex = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void openMenuPage(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuDetailPage(menuTitle: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      buildHomeTab(),
      buildCoursesTab(),
      buildProfileTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0866E8),
        foregroundColor: Colors.white,
        title: const Text(
          'Student Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tidak ada notifikasi baru saat ini.'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: pages[selectedIndex],
      ),

      // BOTTOM NAVIGATION (Home, Courses, Profile)
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // TAB 1: HOME DASHBOARD
  Widget buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello, Student!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Welcome to Mobile Programming',
            style: TextStyle(
              fontSize: 17,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 20),

          // STUDENT PROFILE CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0879F9),
                  Color(0xFF0756D8),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Farrel Aryasatya Raharjo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Teknik Informatika',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'NRP: 5053251036 • Kelas: PPB M',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFFDCEEFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // INTERACTIVE COUNTER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE0E7F2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Interactive Counter',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$counter',
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0866E8),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    counterButton(
                      icon: Icons.remove,
                      onPressed: decrementCounter,
                    ),
                    counterButton(
                      icon: Icons.add,
                      onPressed: incrementCounter,
                    ),
                    counterButton(
                      icon: Icons.refresh,
                      onPressed: resetCounter,
                      backgroundColor: const Color(0xFFDCEEFF),
                      iconColor: const Color(0xFF0866E8),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // LEARNING MENU
          const Text(
            'Learning Menu',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.4,
            children: [
              menuCard(
                icon: Icons.code,
                title: 'Flutter',
                color: const Color(0xFFDCEEFF),
                iconColor: Colors.blue,
              ),
              menuCard(
                icon: Icons.school,
                title: 'Courses',
                color: const Color(0xFFFFEFD9),
                iconColor: Colors.orange,
              ),
              menuCard(
                icon: Icons.menu_book,
                title: 'Materials',
                color: const Color(0xFFDCF9DF),
                iconColor: Colors.green,
              ),
              menuCard(
                icon: Icons.assignment,
                title: 'Assignments',
                color: const Color(0xFFEDE1FF),
                iconColor: Colors.deepPurple,
              ),
              menuCard(
                icon: Icons.grade,
                title: 'Grades',
                color: const Color(0xFFFFE4E8),
                iconColor: Colors.pink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TAB 2: COURSES PAGE
  Widget buildCoursesTab() {
    final courses = [
      {
        'title': 'Pemrograman Perangkat Bergerak (PPB M)',
        'lecturer': 'Semester 3 • 3 SKS',
        'progress': 0.85,
        'color': Colors.blue,
      },
      {
        'title': 'Pemrograman Web (PWEB)',
        'lecturer': 'Semester 3 • 3 SKS',
        'progress': 0.90,
        'color': Colors.orange,
      },
      {
        'title': 'Desain & Analisis Algoritma (DAA)',
        'lecturer': 'Semester 3 • 3 SKS',
        'progress': 0.78,
        'color': Colors.green,
      },
      {
        'title': 'Sistem Operasi & Jaringan Komputer',
        'lecturer': 'Semester 3 • 4 SKS',
        'progress': 0.80,
        'color': Colors.deepPurple,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'My Courses',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Daftar Mata Kuliah Aktif Semester 3',
          style: TextStyle(fontSize: 15, color: Colors.blueGrey),
        ),
        const SizedBox(height: 18),
        ...courses.map(
          (c) => Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE0E7F2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: (c['color'] as Color).withValues(alpha: 0.15),
                child: Icon(Icons.school, color: c['color'] as Color),
              ),
              title: Text(
                c['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(c['lecturer'] as String),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: c['progress'] as double,
                    color: c['color'] as Color,
                    backgroundColor: const Color(0xFFE0E7F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // TAB 3: PROFILE PAGE
  Widget buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0879F9), Color(0xFF0756D8)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Farrel Aryasatya Raharjo',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Teknik Informatika • ITS',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'NRP: 5053251036 • Kelas: PPB M',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Color(0xFFE0E7F2)),
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.badge, color: Color(0xFF0866E8)),
                  title: Text('NRP / NIM'),
                  subtitle: Text('5053251036'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.class_, color: Color(0xFF0866E8)),
                  title: Text('Kelas'),
                  subtitle: Text('Pemrograman Perangkat Bergerak (PPB M)'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.pink,
                  ),
                  title: const Text('Status Favorit'),
                  subtitle: Text(isFavorite ? 'Ditandai Favorit' : 'Belum Favorit'),
                  trailing: Switch(
                    value: isFavorite,
                    onChanged: (_) => toggleFavorite(),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.countertops, color: Color(0xFF0866E8)),
                  title: const Text('Nilai Counter Saat Ini'),
                  subtitle: Text('$counter'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // COUNTER BUTTON COMPONENT
  Widget counterButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFF0879F9),
    Color iconColor = Colors.white,
  }) {
    return SizedBox(
      width: 75,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: iconColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Icon(icon, size: 26),
      ),
    );
  }

  // LEARNING MENU COMPONENT
  Widget menuCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
  }) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () => openMenuPage(title),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101828),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SEPARATE PAGE FOR EACH LEARNING MENU (Flutter, Courses, Materials, Assignments, Grades)
class MenuDetailPage extends StatelessWidget {
  final String menuTitle;

  const MenuDetailPage({super.key, required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> contentByMenu = {
      'Flutter': [
        {
          'title': 'Pengenalan Flutter & Dart',
          'subtitle': 'Arsitektur Flutter, Widget Tree, dan Hot Reload',
        },
        {
          'title': 'StatelessWidget vs StatefulWidget',
          'subtitle': 'Pengelolaan state lokal menggunakan setState()',
        },
        {
          'title': 'Layouting dengan Column, Row, dan GridView',
          'subtitle': 'Menyusun komponen antarmuka responsif',
        },
      ],
      'Courses': [
        {
          'title': 'Pemrograman Perangkat Bergerak (PPB M)',
          'subtitle': '3 SKS • Praktikum Flutter & Android Modern',
        },
        {
          'title': 'Pemrograman Web (PWEB)',
          'subtitle': '3 SKS • Full-Stack Web Development',
        },
        {
          'title': 'Desain & Analisis Algoritma',
          'subtitle': '3 SKS • Kompleksitas & Strategi Algoritmik',
        },
      ],
      'Materials': [
        {
          'title': 'Modul 11 - Instalasi & Pengenalan Flutter',
          'subtitle': 'Setup Flutter SDK, Android Studio, dan VS Code',
        },
        {
          'title': 'Modul 12 - HOL Student Dashboard',
          'subtitle': 'Membangun UI interaktif dengan StatefulWidget',
        },
        {
          'title': 'Modul 13 - Navigasi & Multi-Screen',
          'subtitle': 'Penggunaan Navigator.push dan NavigationBar',
        },
      ],
      'Assignments': [
        {
          'title': 'Tugas 11: Aplikasi Pertama Hello Flutter',
          'subtitle': 'Status: Selesai & Terkumpul',
        },
        {
          'title': 'Tugas 12: HOL Student Dashboard Flutter',
          'subtitle': 'Status: Selesai & Dipublikasikan di Blogger',
        },
      ],
      'Grades': [
        {
          'title': 'Pemrograman Perangkat Bergerak (PPB M)',
          'subtitle': 'Nilai Sementara: A (95 / 100)',
        },
        {
          'title': 'Pemrograman Web (PWEB)',
          'subtitle': 'Nilai Sementara: A (94 / 100)',
        },
        {
          'title': 'Desain & Analisis Algoritma',
          'subtitle': 'Nilai Sementara: A (92 / 100)',
        },
        {
          'title': 'Indeks Prestasi Kumulatif (IPK)',
          'subtitle': 'IPK: 3.92 / 4.00',
        },
      ],
    };

    final items = contentByMenu[menuTitle] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0866E8),
        foregroundColor: Colors.white,
        title: Text(
          '$menuTitle Page',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFFE0E7F2)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFDCEEFF),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Color(0xFF0866E8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(item['subtitle']!),
              ),
            ),
          );
        },
      ),
    );
  }
}
