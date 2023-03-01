import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab5_quiz_and_chat/data/chat_item.dart';
import 'package:lab5_quiz_and_chat/data/image_adapter.dart';
import 'package:lab5_quiz_and_chat/data/quiz_item.dart';
import 'package:lab5_quiz_and_chat/screens/base_screen.dart';
import 'package:lab5_quiz_and_chat/screens/chat/chat_list_screen.dart';
import 'package:lab5_quiz_and_chat/screens/quiz/quiz_initial_screen.dart';

int randomSeed = 0;

Future main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatItemAdapter());
  Hive.registerAdapter(ImageAdapter());
  final chatBox = await Hive.openBox<ChatItem>('chat');
  if (chatBox.isEmpty) {
    chatBox.addAll([
      ChatItem(
        authorName: 'Игорь Головастов',
        message: 'В японской мифологии существуют лисы-оборотни кицунэ, умеющие принимать человеческий облик. '
            'Они обладают огромными знаниями и владеют магией. Позже кицунэ стали популярны в литературе, '
            'кино и видеоиграх. Духи, схожие с кицунэ, фигурируют также в китайских и корейских мифах.',
      ),
      ChatItem(
        authorName: 'Ольга Александровна Матвеева',
        message: 'Лиса - млекопитающий хищник небольших размеров. В биологической классификации многочисленный '
            'род лисиц относят к семейству псовых.',
        image: Image.network(
          'http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcQSSfAvuq0V49Jo1_lLrF4hwtovxyR_NTu_ZVDYrS9VB3VCJAhZ4vh7UT_2b31eWHiB',
        ),
      ),
    ]);
  }
  randomSeed = DateTime.now().millisecondsSinceEpoch;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лаб 5. Сивков',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(235, 202, 78, 1),
          secondary: Color.fromRGBO(235, 202, 78, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Screen quizScreen = const QuizInitialScreen();
Screen chatScreen = const ChatListScreen();

final currentScreenListenable = ValueNotifier<Screen>(quizScreen);

final quizItems = [
  const QuizItem(
    question: 'К какому семейству относятся лисы?',
    answers: ['Псовые', 'Лисьи', 'Волчьи', 'Кошачьи'],
    correctAnswerIndex: 0, // Псовые
  ),
  const QuizItem(
    question: 'Какой вид лисиц является самым крупным?',
    answers: ['Африканская лисица', 'Обыкновенная лисица', 'Афганская лисица', 'Гигантская лисица'],
    correctAnswerIndex: 1, // Обыкновенная лисица
  ),
  const QuizItem(
    question: 'Какого цвета лапы у обыкновенной лисицы?',
    answers: ['Рыжие', 'Белые', 'Темные', 'Разного цвета'],
    correctAnswerIndex: 2, // Темные
  ),
  const QuizItem(
    question: 'В каком городе лисицы живут на окраинах и иногда появляются в центре?',
    answers: ['Архангельск', 'Тюмень', 'Рим', 'Лондон'],
    correctAnswerIndex: 3, // Лондон
  ),
  const QuizItem(
    question: 'На какое животное внешне и по поведению похожа афганская лисица?',
    answers: ['Собака', 'Волк', 'Кошка', 'Жираф'],
    correctAnswerIndex: 2, // Кошка
  ),
  const QuizItem(
    question: 'Какой вид лисиц считается очень скрытным?',
    answers: ['Африканская лисица', 'Бенгальская лисица', 'Песчаная лисица', 'Афганская лисица'],
    correctAnswerIndex: 0, // Африканская лисица
  ),
  const QuizItem(
    question: 'Какая лисица обитает в предгорьях Южных Гималаев?',
    answers: ['Бенгальская лисица', 'Корсак', 'Тибетская лисица', 'Гималайская лисица'],
    correctAnswerIndex: 0, // Бенгальская лисица
  ),
  const QuizItem(
    question: 'Как называется самый маленький представитель семейства псовых?',
    answers: ['Корсак', 'Песчаная лисица', 'Фенек', 'Бенгальская лисица'],
    correctAnswerIndex: 2, // Фенек
  ),
  const QuizItem(
    question: 'На какой монете изображен Фенек?',
    answers: ['На алжирском дукате', 'На оманском байсе', 'На монгольском тугрике', 'На белорусском рубле'],
    correctAnswerIndex: 0, // На алжирском дукате
  ),
  const QuizItem(
    question: 'Кто из перечисленных видов лисиц питается в основном термитами?',
    answers: ['Корсак', 'Африканская лисица', 'Фенек', 'Большеухая лисица'],
    correctAnswerIndex: 3, // Большеухая лисица
  ),
];

AppBar createAppBar({required BuildContext context, required String title, List<Widget>? actions}) {
  return AppBar(
    title: Text(title),
    centerTitle: false,
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const Border(bottom: BorderSide(color: Color.fromRGBO(59, 59, 59, 1), width: 1)),
    actions: actions,
    leading: ModalRoute.of(context)?.canPop == true
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
          )
        : null,
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: currentScreenListenable,
      builder: (context, _) {
        return Scaffold(
          appBar: createAppBar(
            context: context,
            title: currentScreenListenable.value.appBarTitle,
            actions: currentScreenListenable.value.appBarActions
                .map(
                  (a) => IconButton(
                    onPressed: () => a.onTap(context),
                    icon: Icon(
                      a.icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
                .toList(),
          ),
          body: currentScreenListenable.value,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentScreenListenable.value.bottomNavigationBarButtonIndex,
            onTap: (itemIndex) {
              if (itemIndex == 0) {
                currentScreenListenable.value = quizScreen;
              } else if (itemIndex == 1) {
                currentScreenListenable.value = chatScreen;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Викторина',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Чат',
              ),
            ],
          ),
        );
      },
    );
  }
}

void changeScreen(Screen newScreen) {
  currentScreenListenable.value = newScreen;
  if (newScreen.bottomNavigationBarButtonIndex == 0) {
    quizScreen = newScreen;
  } else if (newScreen.bottomNavigationBarButtonIndex == 1) {
    chatScreen = newScreen;
  }
}
