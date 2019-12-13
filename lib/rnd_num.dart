import 'package:pointycastle/pointycastle.dart';
import 'dart:typed_data';
import 'dart:math';

class RandomBytes {
  final _length;
  final _rnd = new SecureRandom("AES/CTR/AUTO-SEED-PRNG");
  final _key = new Uint8List(16);

  RandomBytes(this._length) {
    this._rnd.seed(this._getParams());

    var random = new Random();
    for (int i = 0; i < random.nextInt(255); i++) {
      this._rnd.nextUint8();
    }
  }

  KeyParameter _getKeyParams() {
    return new KeyParameter(_key);
  }

  ParametersWithIV<KeyParameter> _getParams() {
    return new ParametersWithIV(this._getKeyParams(), new Uint8List(16));
  }

  getBytes() {
    return this._rnd.nextBytes(this._length);
  }
}
