class LiveVideoObject {
final String id;
  final String name;
  final int viewers;
  final String url;
  final DateTime started;

  LiveVideoObject(this.name, this.viewers, this.url, this.started, this.id);
}
