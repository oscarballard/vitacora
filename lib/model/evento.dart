const String tableEventos  ='Evento';

class EventField{
  static const String id = "_id";
  static const String title = "_title";
  static const String fecha = "_fecha";
  static const String descripcion = "_descripcion";
  static const String pathVoice = "_pathVoice";
  static const String pathImage = "_pathImage";
}
class Evento {
  final int? id;
  final String title;
  final DateTime fecha;
  final String descripcion;
  final String pathVoice;
  final String pathImage;

  const Evento({this.id,
      required this.title,
      required this.fecha,
      required this.descripcion,
      required this.pathVoice,
      required this.pathImage
  });

  Map<String, Object?> toJson() => {
    EventField.id:id,
    EventField.title:title,
    EventField.fecha:createTime.toIso860,
    EventField.descripcion:descripcion,
    EventField.pathVoice:pathVoice,
    EventField.pathImage:pathImage,
  };
}
