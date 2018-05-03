
class fuliBean {
  final bool error;
  final List<T> results;

  fuliBean(this.error, this.results);

  factory fuliBean.fromJson(Map<String, dynamic> json){
    return new fuliBean(json['error'], json['results']);
  }
}

class T {
  final String _id;
  final String createdAt;
  final String desc;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;

  T(this._id, this.createdAt, this.desc, this.publishedAt,
      this.source, this.type, this.url, this.used, this.who);

  factory T.fromJson(Map<String, dynamic> json){
    return new T(
        json["_id"],
        json["createdAt"],
        json["desc"],
        json["publishedAt"],
        json["source"],
        json["type"],
        json["url"],
        json["used"],
        json["who"]);
  }
}