class QuizItem {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  const QuizItem({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });
}