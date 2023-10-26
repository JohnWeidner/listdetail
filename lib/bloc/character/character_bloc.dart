import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:listdetail/api_client.dart';
import 'package:listdetail/bloc/character/character_event.dart';
import 'package:listdetail/bloc/character/character_state.dart';

class CharacterBloc extends HydratedBloc<CharacterEvent, CharacterState> {
  CharacterBloc({required this.characterApiUrl}) : super(CharacterState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<FilterUpdated>(_onFilterUpdated);
    on<ReloadDataRequested>(_onReloadDataRequested);
  }

  final String characterApiUrl;

  Future<void> _onAppStarted(AppStarted event, Emitter<CharacterState> emit) async {
    await _loadData(emit);
  }

  Future<void> _onFilterUpdated(FilterUpdated event, Emitter<CharacterState> emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onReloadDataRequested(ReloadDataRequested event, Emitter<CharacterState> emit) async {
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<CharacterState> emit) async {
    emit(state.copyWith(loading: true, error: false));
    try {
      final characters = await fetchCharacters(url: characterApiUrl);
      emit(state.copyWith(filter: '', characters: characters, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: state.characters.isEmpty));
    }
  }

  @override
  CharacterState? fromJson(Map<String, dynamic> json) => CharacterState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(CharacterState state) => state.toJson();
}
