import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/features/product/data/models/product_model.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<ProductModel> get collection {
    return _firestore.collection('products').withConverter(
          fromFirestore: (doc, _) {
            final docData = doc.data();
            final docId = doc.id;
            return ProductModel.fromMap({'id': docId, ...docData!});
          },
          toFirestore: (product, _) => product.toMap(),
        );
  }

  @override
  Future<ProductModel?> getById(String id) async {
    final ref = _productRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  @override
  Future<List<ProductModel>> search(String query) async {
    final snapshots = await collection.where('name', isEqualTo: query).get();

    return snapshots.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<ProductModel>> findAll() async {
    final snapshots = await collection.get();
    return snapshots.docs.map((e) => e.data()).toList();
  }

  DocumentReference<ProductModel> _productRef(String id) =>
      collection.doc(id).withConverter(
            fromFirestore: (doc, _) {
              final docData = doc.data();
              final docId = doc.id;
              return ProductModel.fromMap({'id': docId, ...docData!});
            },
            toFirestore: (product, _) => product.toMap(),
          );
}
