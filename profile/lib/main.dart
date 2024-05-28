import 'package:flutter/material.dart';

enum Gender { male, female }

class Profile {
  String firstName;
  String lastName;
  int? age;
  double height;
  Gender gender;
  List<String> hobbies;
  String favoriteProgrammingLanguage;
  String secret;

  Profile({
    this.firstName = "",
    this.lastName = "",
    this.age,
    this.height = 0.0,
    this.gender = Gender.male,
    this.hobbies = const [],
    this.favoriteProgrammingLanguage = "",
    this.secret = "",
  });
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Info',
      home: UserInfoPage(),
    );
  }
}

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  Profile profile = Profile();
  bool _isSecretShown = false;
  List<String> _hobbies = []; // Temporarily store hobbies as strings

  void _toggleSecret() {
    setState(() {
      _isSecretShown = !_isSecretShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info Page'),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExpansionTile(
                    title: Text("User Information Preview"),
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("${profile.firstName} ${profile.lastName}"),
                        subtitle: Text("${profile.age ?? ''} y/o, ${profile.height} cm"),
                      ),
                      ListTile(
                        leading: Icon(Icons.transgender),
                        title: Text("${profile.gender.toString().split('.').last}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.transgender),
                        title: Text("Hobbies: ${profile.hobbies.join(', ')}"),
                      ),
                      ListTile(
                        leading: Icon(Icons.code),
                        title: Text("Favorite Language: ${profile.favoriteProgrammingLanguage}"),
                      ),
                      if (_isSecretShown) ListTile(title: Text(profile.secret)),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    onSaved: (value) => profile.firstName = value ?? '',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    onSaved: (value) => profile.lastName = value ?? '',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => profile.age = int.tryParse(value ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => profile.height = double.tryParse(value ?? '') ?? 0.0,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Gender'),
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (Gender? newValue) {
                      profile.gender = newValue!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Hobbies (comma separated)'),
                    onSaved: (value) => profile.hobbies = value!.split(',').map((e) => e.trim()).toList(),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Favorite Programming Language'),
                    onSaved: (value) => profile.favoriteProgrammingLanguage = value ?? '',
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Secret'),
                    onSaved: (value) => profile.secret = value ?? '',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      setState(() {});
                    },
                    child: Text('Save Profile'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _toggleSecret,
                    child: Text(_isSecretShown ? 'Hide my secret!' : 'Show my secret!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}