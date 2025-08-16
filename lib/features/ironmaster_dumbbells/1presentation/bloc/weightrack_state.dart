part of 'weightrack_bloc.dart';

abstract class WeightrackState extends Equatable {
  const WeightrackState();
}

class WeightrackInitial extends WeightrackState {
  const WeightrackInitial();
  @override
  List<Object> get props => [];
}

class WeightrackLoading extends WeightrackState {
  const WeightrackLoading();
  @override
  List<Object> get props => [];
}

class WeightrackError extends WeightrackState {
  final String message;
  const WeightrackError(this.message);
  @override
  List<Object> get props => [message];
}

// final class WeightrackFailure extends WeightrackState {
//   final String error;
//   const WeightrackFailure(this.error);
//   @override
//   List<Object> get props => [error];
// }

// final class WeightrackUploadSuccess extends WeightrackState {
//   @override
//   List<Object> get props => [];
// }
