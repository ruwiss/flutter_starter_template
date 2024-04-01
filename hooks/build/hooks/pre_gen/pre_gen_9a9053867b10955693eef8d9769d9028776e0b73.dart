// GENERATED CODE - DO NOT MODIFY BY HAND
import 'dart:collection';
import 'dart:convert';
import 'dart:isolate';
import 'package:mason/mason.dart';
import '../../../pre_gen.dart' as hook;

void main(List<String> args, SendPort port) {
  hook.run(_HookContext._(port, vars: json.decode(args.first)));
}

class _HookContext implements HookContext {
  _HookContext._(this._port, {Map<String, dynamic>? vars})
      : _vars = _Vars(_port, vars: vars);

  final SendPort _port;
  _Vars _vars;

  @override
  Map<String, dynamic> get vars => _vars;

  @override
  final logger = Logger();

  @override
  set vars(Map<String, dynamic> value) {
    _vars = _Vars(_port, vars: value);
    _port.send(json.encode(_vars));
  }
}

class _Vars with MapMixin<String, dynamic> {
  const _Vars(
    this._port, {
    Map<String, dynamic>? vars,
  }) : _vars = vars ?? const <String, dynamic>{};

  final SendPort _port;
  final Map<String, dynamic> _vars;

  @override
  dynamic operator [](Object? key) => _vars[key];

  @override
  void operator []=(String key, dynamic value) {
    _vars[key] = value;
    _updateVars();
  }

  @override
  void clear() {
    _vars.clear();
    _updateVars();
  }

  @override
  Iterable<String> get keys => _vars.keys;

  @override
  dynamic remove(Object? key) {
    final dynamic result = _vars.remove(key);
    _updateVars();
    return result;
  }

  void _updateVars() => _port.send(json.encode(_vars));
}
