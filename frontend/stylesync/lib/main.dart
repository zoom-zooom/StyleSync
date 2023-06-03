import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

final GlobalKey<_StyleSyncAppState> appKey = GlobalKey<_StyleSyncAppState>();

void main() {
  runApp(StyleSyncApp(key: appKey));
}

class StyleSyncApp extends StatefulWidget {
  StyleSyncApp({Key? key}) : super(key: key);

  @override
  _StyleSyncAppState createState() => _StyleSyncAppState();
}

class _StyleSyncAppState extends State<StyleSyncApp> {
  bool eyeProtectorModeEnabled = false;

  void toggleEyeProtectorMode(bool value) {
    setState(() {
      eyeProtectorModeEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyleSync',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: eyeProtectorModeEnabled ? Brightness.dark : Brightness.light,
      ),
      home: WelcomeScreen(),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(253, 175, 19, 1),
              Color.fromARGB(255, 78, 232, 240),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset('images/logo.jpg', height: 150),
              ),
              SizedBox(height: 16),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Welcome to StyleSync'),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
              SizedBox(height: 32),
              AnimatedOpacity(
                opacity: 1,
                duration: Duration(seconds: 2),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(15),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blueAccent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Pixelated',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Connect with us',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle social media button action
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle social media button action
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle social media button action
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController pronounsController = TextEditingController();
  bool isNameValid = true;
  bool isAgeValid = true;
  bool isPronounsValid = true;

  void validateFields() {
    setState(() {
      isNameValid = nameController.text.isNotEmpty;
      isAgeValid = ageController.text.isNotEmpty;
      isPronounsValid = pronounsController.text.isNotEmpty;

      if (isNameValid && isAgeValid && isPronounsValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeelLikeScreen(
              name: nameController.text,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        automaticallyImplyLeading: false, // Disables back button
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(253, 175, 19, 1),
                Color.fromARGB(255, 78, 232, 240),
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildAnimatedTextField(nameController, 'Name', isNameValid),
              SizedBox(height: 16),
              buildAnimatedTextField(ageController, 'Age', isAgeValid),
              SizedBox(height: 16),
              buildAnimatedTextField(pronounsController, 'Pronouns', isPronounsValid),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: validateFields,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedTextField(
    TextEditingController controller,
    String labelText,
    bool isValid,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isValid ? Colors.transparent : Colors.red),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          errorText: isValid ? null : 'Please enter $labelText',
        ),
      ),
    );
  }
}

class FeelLikeScreen extends StatefulWidget {
  final String name;

  FeelLikeScreen({required this.name});

  @override
  _FeelLikeScreenState createState() => _FeelLikeScreenState();
}

class _FeelLikeScreenState extends State<FeelLikeScreen> {
  final TextEditingController feelingController = TextEditingController();
  bool isFeelingValid = true;

  void validateFields() {
    setState(() {
      isFeelingValid = feelingController.text.isNotEmpty;

      if (isFeelingValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakeSeatScreen(
              feeling: feelingController.text,
              name: widget.name,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What do you feel like?'),
        automaticallyImplyLeading: true, // Disables back button
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(253, 175, 19, 1),
              Color.fromARGB(255, 78, 232, 240),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildAnimatedTextField(
                feelingController,
                'What do you feel like?',
                isFeelingValid,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: validateFields,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedTextField(
    TextEditingController controller,
    String labelText,
    bool isValid,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isValid ? Colors.transparent : Colors.red),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          errorText: isValid ? null : 'Please enter $labelText',
        ),
      ),
    );
  }
}

class TakeSeatScreen extends StatelessWidget {
  final String feeling;
  final String name;

  TakeSeatScreen({required this.feeling, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/temp_back.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              child: TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 50),
                repeatForever: false,
                text: ['Take a seat and relax $name, we will do everything for you.'],
                textStyle: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddClothesScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.add),
                      SizedBox(height: 8),
                      Text('Add Clothes'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenerateFitScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.auto_awesome),
                      SizedBox(height: 8),
                      Text('Generate Fit'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(height: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddClothesScreen extends StatefulWidget {
  @override
  _AddClothesScreenState createState() => _AddClothesScreenState();
}

class _AddClothesScreenState extends State<AddClothesScreen> {
  List<List<String>> clothesList = [];
  TextEditingController clothController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Clothes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: clothController,
              decoration: InputDecoration(hintText: 'Enter clothes name'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: clothesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(clothesList[index].join(',')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (clothController.text.isNotEmpty) {
            setState(() {
              clothesList.add([clothController.text]);
            });
            clothController.clear();

            String csvData = const ListToCsvConverter().convert(clothesList);

            File file = File('C:/Users/Nimish Shukla/Documents/GitHub/StyleSync/backend/wardrobe.csv');
            await file.writeAsString(csvData);
          }
        },
      ),
    );
  }
}



class GenerateFitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Fit'),
      ),
      body: Container(
        child: Center(
          child: Text('Generate Fit'),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool eyeProtectorModeEnabled = false;

  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  
  final List<Map<String, dynamic>> faqList = [
    {
      "question": "What is Eye Protector Mode?",
      "answer": "Eye Protector Mode is designed to reduce eye strain by adjusting the color temperature of your screen.",
    },
    {
      "question": "How to enable Eye Protector Mode?",
      "answer": "You can toggle the Eye Protector Mode switch in the Settings screen.",
    },
    // Add more FAQs here...
  ];

  final List<Map<String, dynamic>> aboutAppList = [
    {
      "question": "Who are the creators of this app?",
      "answer": "This app is created by Nyanners Company.",
    },
    {
      "question": "Which languages does the app support?",
      "answer": "The app supports English, with more languages coming soon.",
    },
    // Add more about app FAQs here...
  ];

  void _submitFeedback() async {
    // existing feedback submission code...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: Text('Eye Protector Mode'),
              value: eyeProtectorModeEnabled,
              onChanged: (value) {
                setState(() {
                  eyeProtectorModeEnabled = value;
                  // Perform any other necessary actions when enabling or disabling eye protector mode
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Existing feedback form code...
                  ],
                ),
              ),
            ),
            Text('FAQ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...faqList.map((faq) => ExpansionTile(
              title: Text(faq['question']),
              children: [ListTile(title: Text(faq['answer']))],
            )).toList(),
            Text('About the App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...aboutAppList.map((about) => ExpansionTile(
              title: Text(about['question']),
              children: [ListTile(title: Text(about['answer']))],
            )).toList(),
            // Add more settings options here...
          ],
        ),
      ),
    );
  }
}
