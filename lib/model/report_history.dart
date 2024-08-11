class Report {
  String id ;
  String title;
  String description;

  bool isDone;
  Report ({
     this.id='',
    required this.title,
    required this.description,
    this.isDone=false,

});
  Report.fromFireStore(Map<String,dynamic>data):
    this(
      id:data['id'],
      title:data['title'],
      description:data['description'],
      isDone:data['isDone'],
    );
  Map<String,dynamic> toFireStore(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'isDone':isDone, 
    };
  }


}