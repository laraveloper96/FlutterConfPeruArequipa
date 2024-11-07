enum Topic {
  human('human/register/robot'),
  move('robot/movement');

  const Topic(this.url);

  final String url;
}
