import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tut/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tut/features/num_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_architecture_tut/features/num_trivia/domain/repositories/number_trivia_repository.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
  mockNumberTriviaRepository = MockNumberTriviaRepository();
  useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  mockNumberTriviaRepository = MockNumberTriviaRepository();
  useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);


  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  
  test(
    'should get trivia for the number from the repository',
        () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(Random().nextInt(500)))
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await (useCase(const Params(number: tNumber)));
      // UseCase should simply return whatever was returned from the Repository
      expect(result, const Right(tNumberTrivia));
      // Verify that the method has been called on the Repository
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}