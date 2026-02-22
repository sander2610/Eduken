import 'package:eschool_teacher/data/repositories/assignmentRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DeleteAssignmentState {}

class DeleteAssignmentInitial extends DeleteAssignmentState {}

class DeleteAssignmentFetchInProgress extends DeleteAssignmentState {}

class DeleteAssignmentFetchSuccess extends DeleteAssignmentState {}

class DeleteAssignmentFetchFailure extends DeleteAssignmentState {
  DeleteAssignmentFetchFailure(this.errorMessage);
  final String errorMessage;
}

class DeleteAssignmentCubit extends Cubit<DeleteAssignmentState> {

  DeleteAssignmentCubit(this._assignmentRepository)
      : super(DeleteAssignmentInitial());
  final AssignmentRepository _assignmentRepository;

  Future<void> deleteAssignment({
    required int assignmentId,
  }) async {
    try {
      emit(DeleteAssignmentFetchInProgress());
      await _assignmentRepository
          .deleteAssignment(assignmentId: assignmentId)
          .then((_) => emit(DeleteAssignmentFetchSuccess()));
    } catch (e) {
      emit(DeleteAssignmentFetchFailure(e.toString()));
    }
  }
}
