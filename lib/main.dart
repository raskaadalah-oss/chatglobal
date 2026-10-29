import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async'; // WAJIB BUAT TIMER

import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatGlobalApp());
}

class ChatGlobalApp extends StatelessWidget {
  const ChatGlobalApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0A0E1A)),
      home: const LoginScreen(),
    );
  }
}

// ================= WARNA CYBERPUNK =================
const neonCyan = Color(0xFF00F0FF);
const neonMagenta = Color(0xFFFF2E97);
const surfaceDark = Color(0xFF121826);

// ================= 1. LOGIN SCREEN =================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('CHATGLOBAL', style: GoogleFonts.orbitron(fontSize: 32, fontWeight: FontWeight.bold, color: neonCyan)),
              const SizedBox(height: 40),
              TextField(decoration: InputDecoration(hintText: 'Username', filled: true, fillColor: surfaceDark, border: OutlineInputBorder(borderSide: const BorderSide(color: neonCyan)))),
              const SizedBox(height: 16),
              TextField(obscureText: true, decoration: InputDecoration(hintText: 'Password', filled: true, fillColor: surfaceDark, border: OutlineInputBorder(borderSide: const BorderSide(color: neonCyan)))),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: neonCyan, minimumSize: const Size(double.infinity, 50)),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WelcomeScreen())),
                child: const Text('LOGIN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              const Text('Dev AmarAfterDark', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.grey, fontSize: 12, letterSpacing: 2)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= 2. WELCOME SCREEN =================
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnimationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent, size: 80),
            SizedBox(height: 20),
            Text('WELCOME BACK', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
            SizedBox(height: 10),
            Text('Powered by AmarAfterDark', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ================= 3. ANIMASI VIDEO =================
class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});
  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  late VideoPlayerController _videoController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    
    // Timer 8 detik biar gak nyangkut
    _timeoutTimer = Timer(const Duration(seconds: 8), () {
      _goToMain();
    });

    // LINK VIDEO BARU
    _videoController = VideoPlayerController.networkUrl(Uri.parse('https://www.image2url.com/r2/default/videos/1793270666266-a6409dc1-6030-4134-8b64-61cc3d3839b7.mp4'))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _videoController.play();
          // LINK MP3 BARU
          _audioPlayer.setUrl('https://videotourl.com/audio/1793270826897-e8b6e4cb-3299-4f26-9667-dbafae8354cf.mp3').then((_) => _audioPlayer.play()).catchError((e) {});
        }
      }).catchError((error) {
        _goToMain();
      });
  }

  void _goToMain() {
    _timeoutTimer?.cancel();
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell()));
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _videoController.value.isInitialized
              ? AspectRatio(aspectRatio: _videoController.value.aspectRatio, child: VideoPlayer(_videoController))
              : const CircularProgressIndicator(color: neonCyan),
          Positioned(
            top: 40, right: 20,
            child: SafeArea(
              child: TextButton(
                onPressed: _goToMain,
                child: const Text('SKIP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ================= 4. MAIN SHELL =================
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  
  @override
  Widget build(BuildContext context) {
    final screens = [
      const ChatPlaceholderScreen(), 
      const ToolsScreen(),           
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: surfaceDark,
        selectedItemColor: neonCyan,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'CHAT'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'TOOLS'),
        ],
      ),
    );
  }
}

// ================= 5. CHAT PLACEHOLDER =================
class ChatPlaceholderScreen extends StatelessWidget {
  const ChatPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons.forum_outlined, size: 80, color: neonCyan),
            const SizedBox(height: 20),
            Text('GLOBAL CHAT', style: GoogleFonts.orbitron(fontSize: 24, fontWeight: FontWeight.bold, color: neonCyan)),
            const SizedBox(height: 10),
            const Text('Fitur chat sedang disiapkan oleh Dev.', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => _showRules(context),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: surfaceDark,
                  border: Border.all(color: neonCyan.withOpacity(0.5), width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: neonCyan.withOpacity(0.2), blurRadius: 10, spreadRadius: 1)]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.menu_book_rounded, color: neonCyan, size: 24),
                    const SizedBox(width: 10),
                    Text('RULES CHAT', style: GoogleFonts.orbitron(fontSize: 12, color: neonCyan, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text('Dev AmarAfterDark', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.grey, fontSize: 12, letterSpacing: 2)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showRules(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, 
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: surfaceDark,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border(top: BorderSide(color: neonCyan, width: 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_book_rounded, color: neonCyan, size: 30),
                  const SizedBox(width: 12),
                  Text('RULES CHATGLOBAL', style: GoogleFonts.orbitron(fontSize: 18, color: neonCyan, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                '1. Dilarang berkata kasar / toxic.\n'
                '2. Saling menghormati antar sesama member.\n'
                '3. Dilarang melakukan spam chat.\n'
                '4. Dilarang menyebarkan konten terlarang (18+, judi, dll).\n'
                '5. Patuhi aturan dari Admin & Dev.\n'
                '6. Pelanggaran akan dikenakan sanksi skorsing & banding.',
                style: TextStyle(color: Colors.white, height: 1.6, fontSize: 14),
              ),
              const SizedBox(height: 30),
              Center(child: Text('Dev AmarAfterDark', style: TextStyle(color: Colors.grey[600], fontFamily: 'ShareTechMono', fontSize: 12))),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

// ================= 6. TOOLS SCREEN =================
class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.engineering, size: 80, color: neonMagenta),
            const SizedBox(height: 20),
            Text('FITUR INI SEDANG MAINTENANCE', textAlign: TextAlign.center, style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold, color: neonMagenta)),
            const SizedBox(height: 10),
            const Text('Mohon bersabar. Terima kasih.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 40),
            const Text('Dev AmarAfterDark', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic, letterSpacing: 2)),
          ],
        ),
      ),
    );
  }
}
