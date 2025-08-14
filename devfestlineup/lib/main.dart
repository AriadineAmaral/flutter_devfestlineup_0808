import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const DevFestLineUp());
}

class DevFestLineUp extends StatelessWidget {
  const DevFestLineUp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFest Lineup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const SplashPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Talk> _talksFavoritas = [];
  final List<Talk> talks = [
    Talk(
      'Jetpack Compose e o Futuro das UIs Android',
      'Heider Lopes',
      '10:00',
      'Como o Jetpack Compose está mudando a forma como desenvolvemos interfaces para Android.',
      TalkCategory.android,
    ),
    Talk(
      'SwiftUI: Interfaces com Menos Código',
      'Eric Brito',
      '11:00',
      'Como o SwiftUI tem revolucionado o desenvolvimento de interfaces no ecossistema Apple.',
      TalkCategory.ios,
    ),
    Talk(
      'Flutter Clean Architecture na Prática',
      'Ricardo Ogliari',
      '12:00',
      'Uma introdução prática à arquitetura limpa com Flutter e Dart.',
      TalkCategory.flutter,
    ),
    Talk(
      'Integração Flutter com Plataformas Nativas',
      'Heider Lopes',
      '13:00',
      'Utilizando Platform Channels para acessar recursos Android e iOS no Flutter.',
      TalkCategory.flutter,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DevFest LineUp")),
      body: ListView.builder(
        itemCount: talks.length,
        itemBuilder: (context, index) {
          final talk = talks[index];
          final isFavorito = _talksFavoritas.contains(talk);

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TalkPage(talk: talk)),
              );
            },
            title: Text(talk.title),
            subtitle: Text('${talk.speaker} • ${talk.time}'),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Icon(
                _getCategoryIcon(talk.category),
                color: Colors.indigo,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorito) {
                    _talksFavoritas.remove(talk);
                  } else {
                    _talksFavoritas.add(talk);
                  }
                });
              },
              icon: isFavorito
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
            ),
          );
        },
      ),
    );
  }
}

IconData _getCategoryIcon(TalkCategory category) {
  switch (category) {
    case TalkCategory.android:
      return Icons.android;
    case TalkCategory.ios:
      return Icons.apple;
    case TalkCategory.flutter:
      return Icons.flutter_dash;
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return; // verifica se o widget ainda está montado
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/lottie/animation.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TalkPage extends StatelessWidget {
  final Talk talk;
  const TalkPage({super.key, required this.talk});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe da Talk")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              talk.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo.shade100,
                  child: Icon(
                    _getCategoryIcon(talk.category),
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      talk.speaker,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(talk.time),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Descrição",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(talk.description, style: const TextStyle(fontSize: 14)),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Voltar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum TalkCategory { android, ios, flutter }

class Talk {
  final String title;
  final String speaker;
  final String time;
  final String description;
  final TalkCategory category;
  Talk(this.title, this.speaker, this.time, this.description, this.category);
}
