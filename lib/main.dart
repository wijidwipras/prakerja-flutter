// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan di bottom navigation
  final List<Widget> _pages = [
    const FirstPage(),
    const SecondPage(),
    const ThirdPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aplikasi Todo dan Baca Artikel',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Daftar tugas
  final List<String> _todoList = [];
  final TextEditingController _todoController = TextEditingController();

  void _removeTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masukkan Todo List'),
      ),
      body: Column(
        children: <Widget>[
          // Input untuk menambahkan tugas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                hintText: 'Tambahkan tugas',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Tambahkan tugas ke daftar
                    setState(() {
                      _todoList.add(_todoController.text);
                      _todoController.clear();
                    });
                  },
                ),
              ),
            ),
          ),
          // Daftar tugas
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${index + 1}. ${_todoList[index]}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Article {
  final String title;
  final String content;

  Article(this.title, this.content);
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final List<Article> dummyArticles = [
    Article(
      'Artikel 1',
      'Ini adalah isi dari Artikel 1. Lorem ipsum dolor sit amet...',
    ),
    Article(
      'Artikel 2',
      'Ini adalah isi dari Artikel 2. Lorem ipsum dolor sit amet...',
    ),
    Article(
      'Artikel 3',
      'Ini adalah isi dari Artikel 3. Lorem ipsum dolor sit amet...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca Artikel'),
      ),
      body: ListView.builder(
        itemCount: dummyArticles.length,
        itemBuilder: (context, index) {
          final article = dummyArticles[index];
          return ListTile(
            title: Text(article.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(article as Article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              article.content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String bio;

  UserProfile(this.name, this.email, this.bio);
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final UserProfile userProfile = UserProfile(
    'Wiji Dwi Prasetyo',
    'wijidwiprasetyo@gmail.com',
    'Saya adalah seorang pengguna Flutter yang senang belajar dan berkembang.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/D5603AQFwlwDVauivNw/profile-displayphoto-shrink_800_800/0/1689424588269?e=2147483647&v=beta&t=ZLqY3i2O9aFsWWxp2udmR5aP7eTeOd04ZlAzdRjsqjI'),
            ),
            const SizedBox(height: 16),
            Text(
              'Nama: ${userProfile.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${userProfile.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tentang Saya:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              userProfile.bio,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
