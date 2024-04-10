import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class EventRecord extends FirestoreRecord {
  EventRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  bool hasEventName() => _eventName != null;

  // "event_date" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  bool hasEventDate() => _eventDate != null;

  // "event_location" field.
  String? _eventLocation;
  String get eventLocation => _eventLocation ?? '';
  bool hasEventLocation() => _eventLocation != null;

  // "event_duration" field.
  String? _eventDuration;
  String get eventDuration => _eventDuration ?? '';
  bool hasEventDuration() => _eventDuration != null;

  // "event_image" field.
  String? _eventImage;
  String get eventImage => _eventImage ?? '';
  bool hasEventImage() => _eventImage != null;

  // "categories" field.
  List<String>? _categories;
  List<String> get categories => _categories ?? const [];
  bool hasCategories() => _categories != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _eventName = snapshotData['event_name'] as String?;
    _eventDate = snapshotData['event_date'] as DateTime?;
    _eventLocation = snapshotData['event_location'] as String?;
    _eventDuration = snapshotData['event_duration'] as String?;
    _eventImage = snapshotData['event_image'] as String?;
    _categories = getDataList(snapshotData['categories']);
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('event');

  static Stream<EventRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventRecord.fromSnapshot(s));

  static Future<EventRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventRecord.fromSnapshot(s));

  static EventRecord fromSnapshot(DocumentSnapshot snapshot) => EventRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventRecordData({
  String? eventName,
  DateTime? eventDate,
  String? eventLocation,
  String? eventDuration,
  String? eventImage,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'event_name': eventName,
      'event_date': eventDate,
      'event_location': eventLocation,
      'event_duration': eventDuration,
      'event_image': eventImage,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventRecordDocumentEquality implements Equality<EventRecord> {
  const EventRecordDocumentEquality();

  @override
  bool equals(EventRecord? e1, EventRecord? e2) {
    const listEquality = ListEquality();
    return e1?.eventName == e2?.eventName &&
        e1?.eventDate == e2?.eventDate &&
        e1?.eventLocation == e2?.eventLocation &&
        e1?.eventDuration == e2?.eventDuration &&
        e1?.eventImage == e2?.eventImage &&
        listEquality.equals(e1?.categories, e2?.categories) &&
        e1?.description == e2?.description;
  }

  @override
  int hash(EventRecord? e) => const ListEquality().hash([
        e?.eventName,
        e?.eventDate,
        e?.eventLocation,
        e?.eventDuration,
        e?.eventImage,
        e?.categories,
        e?.description
      ]);

  @override
  bool isValidKey(Object? o) => o is EventRecord;
}