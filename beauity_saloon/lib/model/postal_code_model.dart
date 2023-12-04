class PostalModel {
  String? SEARCHVAL;
  String? BLKNO;
  String? ROADNAME;
  String? BUILDING;
  String? ADDRESS;
  String? POSTAL;

  PostalModel(
      {this.SEARCHVAL,
      this.BLKNO,
      this.ROADNAME,
      this.BUILDING,
      this.ADDRESS,
      this.POSTAL});

  PostalModel.fromJson(Map<String, dynamic> json) {
    SEARCHVAL = json['SEARCHVAL'];
    BLKNO = json['BLK_NO'];
    ROADNAME = json['ROAD_NAME'];
    BUILDING = json['BUILDING'];
    ADDRESS = json['ADDRESS'];
    POSTAL = json['POSTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SEARCHVAL'] = SEARCHVAL;
    data['BLK_NO'] = BLKNO;
    data['ROAD_NAME'] = ROADNAME;
    data['BUILDING'] = BUILDING;
    data['ADDRESS'] = ADDRESS;
    data['POSTAL'] = POSTAL;
    return data;
  }
}
