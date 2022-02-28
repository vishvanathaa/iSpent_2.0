class Category {
  int id;
  String _category;

  Category(this._category);

  Category.map(dynamic obj) {
    this._category = obj["categoryname"];
  }

  String get categoryName => _category;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["categoryname"] = _category;
    return map;
  }

  void setCategoryId(int id) {
    this.id = id;
  }
}