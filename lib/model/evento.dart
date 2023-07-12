const String tableEventos = 'Evento';

class EventField {
  static final List<String> values =[
   id,title,fecha,descripcion,pathVoice,pathImage
  ];

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

  const Evento(
      {this.id,
      required this.title,
      required this.fecha,
      required this.descripcion,
      required this.pathVoice,
      required this.pathImage});

  Evento copy({
    int? id,
    String? title,
    DateTime? fecha,
    String? descripcion,
    String? pathVoice,
    String? pathImage,
  }) =>
      Evento(
          id: id ?? this.id,
          title: title ?? this.title,
          fecha: fecha ?? this.fecha,
          descripcion: descripcion ?? this.descripcion,
          pathVoice: pathVoice ?? this.pathVoice,
          pathImage: pathImage ?? this.pathImage);

  static Evento fromJson(Map<String, Object?> json) => Evento(
      id: json[EventField.id] as int?,
      title: json[EventField.title] as String,
      fecha: DateTime.parse(json[EventField.fecha] as String),
      descripcion: json[EventField.descripcion] as String,
      pathVoice: json[EventField.pathVoice] as String,
      pathImage: json[EventField.pathImage] as String);

  Map<String, Object?> toJson() => {
        EventField.id: id,
        EventField.title: title,
        EventField.fecha: fecha.toIso8601String(),
        EventField.descripcion: descripcion,
        EventField.pathVoice: pathVoice,
        EventField.pathImage: pathImage,
      };
}
