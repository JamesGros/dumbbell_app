part of 'weightrack_bloc.dart';

abstract class WeightrackEvent extends Equatable {
  const WeightrackEvent();
}

class WeightrackInitializePlate extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final int _oneRepMax;
  final double _percent;
  final AnimatedBarbell _animatedBarbell;
  final bool _topLeftDumbbell;

  const WeightrackInitializePlate(
      this._context,
      this._queryEnteredWeight,
      this._oneRepMax,
      this._percent,
      this._animatedBarbell,
      this._topLeftDumbbell);

  @override
  List<Object> get props => [
        _context,
        _queryEnteredWeight,
        _oneRepMax,
        _percent,
        _animatedBarbell,
        _topLeftDumbbell
      ];
}

class WeightrackChangeBarbell extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final AnimatedBarbell _animatedBarbell;
  final bool _topLeftDumbbell;

  const WeightrackChangeBarbell(this._context, this._queryEnteredWeight,
      this._animatedBarbell, this._topLeftDumbbell);

  @override
  List<Object> get props =>
      [_context, _queryEnteredWeight, _animatedBarbell, _topLeftDumbbell];
}

class WeightrackUpdatePlate extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final int _oneRepMax;
  final double _percent;
  final AnimatedBarbell _animatedBarbell;
  final bool _topLeftDumbbell;

  const WeightrackUpdatePlate(
      this._context,
      this._queryEnteredWeight,
      this._oneRepMax,
      this._percent,
      this._animatedBarbell,
      this._topLeftDumbbell);

  @override
  List<Object> get props => [
        _context,
        _queryEnteredWeight,
        _oneRepMax,
        _percent,
        _animatedBarbell,
        _topLeftDumbbell
      ];
}

class WeightrackGet extends WeightrackEvent {
  final List<WeightPlatesItemClass> _weightRack;

  const WeightrackGet(this._weightRack);

  @override
  List<Object> get props => [_weightRack];
}

class WeightrackAddPlate extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final WeightPlatesItemClass _plateItem;
  final AnimatedBarbell _animatedBarbell;

  const WeightrackAddPlate(this._context, this._queryEnteredWeight,
      this._plateItem, this._animatedBarbell);

  @override
  List<Object> get props =>
      [_context, _queryEnteredWeight, _plateItem, _animatedBarbell];
}

class WeightrackRemovePlate extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final AnimatedBarbell _animatedBarbell;

  const WeightrackRemovePlate(
      this._context, this._queryEnteredWeight, this._animatedBarbell);

  @override
  List<Object> get props => [_context, _queryEnteredWeight, _animatedBarbell];
}

class WeightrackAnimatePlate extends WeightrackEvent {
  final BuildContext _context;
  final int _queryEnteredWeight;
  final AnimatedBarbell _animatedBarbell;

  const WeightrackAnimatePlate(
      this._context, this._queryEnteredWeight, this._animatedBarbell);

  @override
  List<Object> get props => [_context, _queryEnteredWeight, _animatedBarbell];
}
