import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

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
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF05050A)),
      home: const LoginScreen(),
    );
  }
}

// ================= WARNA COSMIC =================
const cosmicPurple = Color(0xFF9D4EDD);
const starlightPink = Color(0xFFFF6B9E);
const nebulaBlue = Color(0xFF00B4D8);
const spaceDark = Color(0xFF05050A);
const textWhite = Color(0xFFF0F0FF);
const goldOwner = Color(0xFFFFD700);

// ================= WIDGET BACKGROUND GALAKSI =================
class CosmicBackground extends StatelessWidget {
  final Widget child;
  const CosmicBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.5,
          colors: [Color(0xFF2D0A4C), Color(0xFF0F081D), spaceDark],
        ),
      ),
      child: child,
    );
  }
}

// ================= WIDGET EFEK KACA =================
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double padding;
  final Color? borderColor;
  const GlassContainer({super.key, required this.child, this.padding = 20, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor ?? Colors.white.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(color: (borderColor ?? cosmicPurple).withOpacity(0.2), blurRadius: 20, spreadRadius: 2)
            ]
          ),
          child: child,
        ),
      ),
    );
  }
}

// ================= 1. LOGIN SCREEN =================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(colors: [nebulaBlue, cosmicPurple, starlightPink]).createShader(bounds),
                  child: Text('CHATGLOBAL', style: GoogleFonts.orbitron(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                ),
                const SizedBox(height: 50),
                GlassContainer(
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(color: textWhite),
                        decoration: InputDecoration(
                          hintText: 'Username', hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                          prefixIcon: const Icon(Icons.person, color: cosmicPurple),
                          filled: true, fillColor: Colors.black.withOpacity(0.2),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        obscureText: true, style: const TextStyle(color: textWhite),
                        decoration: InputDecoration(
                          hintText: 'Password', hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                          prefixIcon: const Icon(Icons.lock, color: cosmicPurple),
                          filled: true, fillColor: Colors.black.withOpacity(0.2),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity, height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(colors: [cosmicPurple, starlightPink], begin: Alignment.centerLeft, end: Alignment.centerRight),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell())),
                          child: const Text('ENTER THE COSMOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                const Text('Dev AmarAfterDark', style: TextStyle(fontFamily: 'ShareTechMono', color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= 2. MAIN SHELL =================
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
      const GlobalChatScreen(), 
      const ToolsScreen(),           
    ];

    return Scaffold(
      body: CosmicBackground(child: screens[_index]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: spaceDark.withOpacity(0.8), border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1)))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, elevation: 0,
          selectedItemColor: starlightPink, unselectedItemColor: Colors.white38,
          currentIndex: _index, onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'CHAT'),
            BottomNavigationBarItem(icon: Icon(Icons.widgets_outlined), activeIcon: Icon(Icons.widgets), label: 'TOOLS'),
          ],
        ),
      ),
    );
  }
}

// ================= 3. GLOBAL CHAT SCREEN =================
class GlobalChatScreen extends StatefulWidget {
  const GlobalChatScreen({super.key});

  @override
  State<GlobalChatScreen> createState() => _GlobalChatScreenState();
}

class _GlobalChatScreenState extends State<GlobalChatScreen> {
  bool _showBanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: spaceDark.withOpacity(0.5),
        elevation: 0,
        title: Text('Global Chat', style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, color: textWhite)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.gavel, color: starlightPink),
            onPressed: () => _showRules(context),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: textWhite),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Banner Peringatan
          if (_showBanner)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: cosmicPurple.withOpacity(0.2),
                border: Border(bottom: BorderSide(color: cosmicPurple.withOpacity(0.5))),
              ),
              child: Row(
                children: [
                  const Icon(Icons.campaign, color: starlightPink, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'BACA RULE — KLIK ICON PALU DIATAS',
                      style: TextStyle(color: textWhite.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showBanner = false),
                    child: const Icon(Icons.close, color: Colors.white54, size: 18),
                  )
                ],
              ),
            ),
          
          // Area Chat
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Bot Warn 1/3
                _buildBotMessage(
                  'Chat deleted by moderation\nDETECTED LANGGAR RULE\nDILARANG KIRIM SPAM LINK\n@user_test — warn 1/3',
                ),
                const SizedBox(height: 16),
                
                // User Chat
                _buildUserMessage('USER', 'MEMBER', 'Budi', 'Halo bang, mau open order jasa ketik nih!', isReply: false),
                const SizedBox(height: 16),

                // Bot Warn 3/3
                _buildBotMessage(
                  'Chat deleted by moderation\nDETECTED LANGGAR RULE\nSPAM CHAT BERULANG\n@spammer — warn 3/3\nMute chat 7 hari (3/3).',
                ),
              ],
            ),
          ),

          // Input Chat
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GlassContainer(
              padding: 8,
              child: Row(
                children: [
                  const Icon(Icons.sticky_note_2, color: Colors.white54),
                  const SizedBox(width: 10),
                  const Icon(Icons.emoji_emotions_outlined, color: Colors.white54),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Ketik pesan...', hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: starlightPink),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // WIDGET BOT MESSAGE
  Widget _buildBotMessage(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: cosmicPurple.withOpacity(0.3),
          radius: 16,
          child: const Icon(Icons.security, color: starlightPink, size: 16),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Moderation', style: TextStyle(color: starlightPink, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: starlightPink.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                    child: const Text('BOT', style: TextStyle(color: starlightPink, fontSize: 8, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: starlightPink.withOpacity(0.3)),
                ),
                child: Text(text, style: const TextStyle(color: textWhite, fontSize: 13, height: 1.4)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // WIDGET USER MESSAGE
  Widget _buildUserMessage(String role, String badge, String username, String message, {bool isReply = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white24,
          radius: 16,
          child: Icon(Icons.person, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(role, style: const TextStyle(color: nebulaBlue, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.blue)),
                    child: Text(badge, style: const TextStyle(color: Colors.blueAccent, fontSize: 8, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(username, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(message, style: const TextStyle(color: textWhite, fontSize: 14)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= RULES MODAL (UPDATE JUALAN DIPERBOLEHKAN) =================
  void _showRules(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, 
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (_, scrollController) {
            return GlassContainer(
              padding: 0,
              borderColor: cosmicPurple,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
                  ),
                  Text('Rules Of GLOBAL CHAT', style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold, color: cosmicPurple)),
                  const SizedBox(height: 8),
                  const Text('Komunitas resmi ChatGlobal', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 20),
                  
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      children: [
                        const Text(
                          'Global Chat adalah tempat buat ngobrol santai, lapor bug, dan jual beli. Tapi tetep jaga ketertiban ya!',
                          style: TextStyle(color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 20),
                        
                        // Box Diperbolehkan (Jualan Masuk Sini)
                        _buildRulesBox(
                          title: 'Diperbolehkan',
                          icon: Icons.check_circle_outline,
                          color: Colors.greenAccent,
                          items: [
                            'Lapor bug atau error di aplikasi ChatGlobal.',
                            'Berdiskusi seputar fitur ChatGlobal.',
                            'Saling membantu sesama pengguna.',
                            'Jualan / Open Order (Jasa, APK, dsb).',
                          ]
                        ),

                        // Box Dilarang
                        _buildRulesBox(
                          title: 'Dilarang Keras',
                          icon: Icons.cancel_outlined,
                          color: Colors.redAccent,
                          items: [
                            'Bahasa kasar, hinaan, atau pelecehan.',
                            'Spam link / URL (termasuk shortlink) secara berlebihan.',
                            'Spam nomor HP / WA secara berulang (flooding).',
                            'Spam chat atau flood yang mengganggu kenyamanan.',
                            'Menghina Developer (AmarAfterDark) atau sesama user.',
                          ]
                        ),

                        // Box Moderasi
                        _buildRulesBox(
                          title: 'Moderasi Sistem',
                          icon: Icons.shield_outlined,
                          color: cosmicPurple,
                          items: [
                            'Pesan melanggar akan dihapus oleh bot.',
                            '1 Pelanggaran = 1 Warn.',
                            'Total 3 Warn = Mute Global Chat selama 7 hari.',
                            'Keputusan Dev/Admin bersifat mutlak.',
                          ]
                        ),
                        
                        const SizedBox(height: 30),
                        Center(child: Text('Dev AmarAfterDark', style: GoogleFonts.orbitron(fontSize: 12, color: Colors.white38))),
                        const SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }

  Widget _buildRulesBox({required String title, required IconData icon, required Color color, required List<String> items}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontS
