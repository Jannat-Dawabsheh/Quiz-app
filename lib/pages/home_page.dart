import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
     int questionIndex=0;
     bool showResultMessage=false;
     int score=0;
     int? yourChoiceIndex;
     int answerCount=0;
List<Map<String,dynamic>>questionsWithAnswers=[
{
  'question':'what is your favorite sport?',
  'answer':['Handball','Basketball','Swimming','Tennis'],
  'value':['F','T','F','F'],
  'Icons':[Icons.sports_handball,Icons.sports_basketball,Icons.water,Icons.sports_tennis],
},

{
  'question':'what is your favorite Interest?',
  'answer':['Making Music','Languages','Travel',' Photography'],
  'value':['T','F','F','F'],
  'Icons':[Icons.music_note,Icons.language,Icons.flight_takeoff,Icons.photo_camera],
},

{
  'question':'what is your favorite shape?',
  'answer':['circle','rectangle','square','star'],
  'value':['T','F','F','F'],
  'Icons':[Icons.circle,Icons.rectangle,Icons.square,Icons.star],
},

];
 
 void ResetQuiz(){
    setState(() {
      questionIndex=0;
      score=0;
     showResultMessage=false;
    });
 }
  @override
  Widget build(BuildContext context) {
    final questionsWithAnswer=questionsWithAnswers[questionIndex];
    final size=MediaQuery.of(context).size;
    answerCount=questionsWithAnswers.length;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: showResultMessage==false ?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(showResultMessage==false)...[
                SizedBox(height: size.height*0.1),
              Text(
                questionsWithAnswer['question'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                 
                  
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                 'Answer and get points',
                 style: TextStyle(
                  fontSize: 16,
                  color:Colors.black54,
                 ),
              ),

              SizedBox(height: size.height*0.03),
              
              Text(
                '${questionIndex+1} of $answerCount',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                ),
              Container(
                child: LinearProgressIndicator(
                   
                  value:((100/(questionsWithAnswer['answer'].length-1))*(questionIndex+1))/100 ,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 17, 163, 76)),
                ),
              ),
              
              SizedBox(height: size.height*0.06),
              for(int i=0;i<questionsWithAnswer['answer'].length;i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      yourChoiceIndex=i;
                      
                    });
                    print(yourChoiceIndex);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color:i==yourChoiceIndex? Colors.green:Colors.white ,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color:Colors.grey.withOpacity(0.3),
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            questionsWithAnswer['Icons'][i],
                             color:i==yourChoiceIndex? Colors.white: Colors.black ,
                          ),
                          SizedBox(width:16.0 ),
                          Text(questionsWithAnswer['answer'][i],
                          style: TextStyle(
                              color:i==yourChoiceIndex? Colors.white: Colors.black , 
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                          if(yourChoiceIndex!=null){
                            if(questionIndex<questionsWithAnswers.length-1){
                                        
                          questionIndex++;
                        }else{
                            showResultMessage=true;                     
                        }
                        if(questionsWithAnswer['value'][yourChoiceIndex]=='T'){
                         score++;
                          
                        }
                        yourChoiceIndex=null;
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(
                              content: Text("Please choose one of the Answers"),
                              backgroundColor: Color.fromARGB(255, 183, 28, 28),
                              duration: Duration(seconds:1),
                              ),
                              
                            );
                            
                          }
                        });
                  },
                   child:
                    Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )
                    )
                    ),
                    
              )

              ],
              
            ]
          ): Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "The End",
                    style:TextStyle(
                       fontSize: 40,
                       fontWeight: FontWeight.bold,
                       color:Colors.black,
                    ),
                  ),
                  Text(
                    "Your score is ${score}/${questionsWithAnswers.length}",
                     style:TextStyle(
                       fontSize: 20,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                  onPressed: ResetQuiz,
                   child: Text(
                    'Reset Quiz',
                    style: TextStyle(
                    fontSize: 17, 
                    color: Color.fromARGB(255, 43, 154, 40),
                    ),
                    ),
                    ),
                   
              ],
            ),
          ),
        ),
      ), 
    );
  }
}
