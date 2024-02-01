import 'package:flutter/material.dart';

enum Gender { male, female }

class Question {
  String question;
  bool response;
  String explanation;
  String imagePath;

  Question({
    required this.question,
    required this.response,
    required this.explanation,
    required this.imagePath
  });

  String getImage() => 'img/$imagePath';
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

  SnackBar customSnackBar({required String text}) {
    return SnackBar(
        content: Text(text)
    );
  }

  List<Question> _questionList =[

  Question(question: "L'île de Manhattan a été achetée aux Indiens algonquins pour 24dollar.",response:true,explanation:"en 1659 Steve Brandon Refugié Politique anglais décide d'acheté une partie des terre d'une tribut qui à finit par devenir newyork",imagePath:"ami1.png")
  ,Question(question:"Quand on marche, 40% de notre poids est supporté par les gros orteils.",response:false,explanation:"c'est faux",imagePath:"ami2.png")
  ,Question(question:"Le regime de corée du nord c'est inspiré des civilisation des pinguins",response:true,explanation:"c'est faux",imagePath:"ami3.png")
  ,Question(question:"Les nains sont majoritaire au Cap Vert",response:true,explanation:"c'est faux",imagePath:"img.png")
  ,Question(question:"Les process d'investissement des banque americaine sont inspiré des location de sac de riz au burkina fasso",response:false,explanation:"c'est faux",imagePath:"ami1.png")
  ,Question(question:"La crise financiere liée au covid à été evité grace à la monté du prix du carburant",response:false,explanation:"c'est faux",imagePath:"ami1.png")
  ,Question(question:"Des duo singe de madagascar ont apris à ce servir d'une voiture",response:false,explanation:"c'est faux",imagePath:"ami1.png")
  ,Question(question:"Les japonais sont minauritaire dans leur propre pays",response:true,explanation:"c'est faux",imagePath:"ami1.png",)
  ,Question(question:"Les habitant de cuba n'ont pas encore connu la 3g",response:false,explanation:"c'est faux",imagePath:"ami1.png")
  ,Question(question:"Statistiquement 1 personne sur 3 dans le monde parle arabe",response:true,explanation:"c'est faux",imagePath:"ami1.png")
  ];
 int numberquestion = 0;
 int score = 0;


  void _TrueAnswer() {
    setState(() {
      if(numberquestion >= 10){
        showCustomDialog(
          dialog: customAlertDialog(),
          context: context,
        );
      }else{


      if (_questionList[numberquestion].response == true){
        showCustomDialog(
          dialog: customSimpleDialog(true),
          context: context,
        );

        score++;
      }else{

        showCustomDialog(
          dialog: customSimpleDialog(false),
          context: context,
        );

      }
      numberquestion++;
      }
    });
  }
  void _FalseAnswer() {
    setState(() {
      if(numberquestion >= 10){
        showCustomDialog(
          dialog: customAlertDialog(),
          context: context,
        );
      }else {
        if (_questionList[numberquestion].response == false) {
          showCustomDialog(
            dialog: customSimpleDialog(true),
            context: context,
          );

          score++;
        } else {
          showCustomDialog(
            dialog: customSimpleDialog(false),
            context: context,
          );
        }
        numberquestion++;
      }
    });
  }

  Future<void> showCustomDialog({required Widget dialog, required BuildContext context}) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext buildContext) {
          return dialog;
        }
    );
  }


  SimpleDialog customSimpleDialog( bool isCorrect) {
    String text = isCorrect ? "Bonne réponse" : "Mauvaise réponse" ;
    String img = isCorrect ? "img/ami3.png" : "img/img.png" ;
  return SimpleDialog(
    title: Text("${text}"),
    elevation: 12,
    children: [
      const Divider(),
      Image.asset("${img}"),
      Text(
        "${_questionList[numberquestion].explanation.toString()}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10),
      ),
    ],
  );
  }

  SimpleDialogOption simpleDialogOption({required String text}) {
  return SimpleDialogOption(
  onPressed: () {
  // Do something here
  },
  child: Text(text),
  );
  }

  AlertDialog customAlertDialog() {
    String text= (score >= 5) ? "T'est chaud l'ami" : "T'est trop null";
    String img= (score >= 5) ? "img/ami1.png" : "img/img.png";

    return AlertDialog(
      title: const Text("Fin de la Partie!"),
      content: const Text("Vous avez repondu à toute les question"),
      actions: [
        Text(
          "Vous avez un score de ${score}/10",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        Text(
          "${text}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        Image.asset("${img}"),
        TextButton(
            onPressed: () {

            },
            child: const Text("Go Home")
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Text(
            'Quizz',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
            Text(
              'Question ${numberquestion + 1}',
              style: TextStyle(fontSize: 30),
            ),
            Image.asset("img/${_questionList[numberquestion].imagePath.toString()}"),
          Text(
              "${_questionList[numberquestion].question.toString()}",
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 20),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffF18265),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _TrueAnswer();

                },
                child: Text(
                  "Vrai",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffF18265),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: _FalseAnswer,
                child: Text(
                  "Faux",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),

            Text(
              "Score: ${score.toString()}",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

  }
}