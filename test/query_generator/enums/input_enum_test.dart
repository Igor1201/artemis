import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('On enums', () {
    test(
      'Enums can be part of input objects',
      () async => testGenerator(
        query: query,
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            q(input: Input!, o: OtherEnum!): QueryResponse
          }
          
          type QueryResponse {
            s: String
          }
          
          type Input {
            e: MyEnum!
          }
          
          enum MyEnum {
            A
            B
          }
          
          enum OtherEnum {
            O1
            O2
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
      ),
    );
  });
}

const query = r'''
  query custom($input: Input!, $o: OtherEnum!) {
    q(input: $input, o: $o) {
      s
    }
  }
''';

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'custom',
      queryType: r'Custom$QueryRoot',
      classes: [
        ClassDefinition(
            name: r'Custom$QueryRoot$QueryResponse',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        ClassDefinition(
            name: r'Custom$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'Custom$QueryRoot$QueryResponse',
                  name: r'q',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        EnumDefinition(
            name: r'Custom$Input$MyEnum',
            values: [r'A', r'B', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'Custom$Input',
            properties: [
              ClassProperty(
                  type: r'Custom$Input$MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: Custom$Input$MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: true,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true),
        EnumDefinition(
            name: r'Custom$OtherEnum',
            values: [r'O1', r'O2', r'ARTEMIS_UNKNOWN'])
      ],
      inputs: [
        QueryInput(type: r'Custom$Input', name: r'input', isNonNull: true),
        QueryInput(type: r'Custom$OtherEnum', name: r'o', isNonNull: true)
      ],
      generateHelpers: true,
      suffix: r'Query')
]);

const generatedFile = r'''// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:meta/meta.dart';
import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'query.g.dart';

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot$QueryResponse with EquatableMixin {
  Custom$QueryRoot$QueryResponse();

  factory Custom$QueryRoot$QueryResponse.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRoot$QueryResponseFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$Custom$QueryRoot$QueryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$QueryRoot with EquatableMixin {
  Custom$QueryRoot();

  factory Custom$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Custom$QueryRootFromJson(json);

  Custom$QueryRoot$QueryResponse q;

  @override
  List<Object> get props => [q];
  Map<String, dynamic> toJson() => _$Custom$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Custom$Input with EquatableMixin {
  Custom$Input({@required this.e});

  factory Custom$Input.fromJson(Map<String, dynamic> json) =>
      _$Custom$InputFromJson(json);

  @JsonKey(unknownEnumValue: Custom$Input$MyEnum.ARTEMIS_UNKNOWN)
  Custom$Input$MyEnum e;

  @override
  List<Object> get props => [e];
  Map<String, dynamic> toJson() => _$Custom$InputToJson(this);
}

enum Custom$Input$MyEnum {
  A,
  B,
  ARTEMIS_UNKNOWN,
}
enum Custom$OtherEnum {
  O1,
  O2,
  ARTEMIS_UNKNOWN,
}

@JsonSerializable(explicitToJson: true)
class CustomArguments extends JsonSerializable with EquatableMixin {
  CustomArguments({@required this.input, @required this.o});

  factory CustomArguments.fromJson(Map<String, dynamic> json) =>
      _$CustomArgumentsFromJson(json);

  final Custom$Input input;

  final Custom$OtherEnum o;

  @override
  List<Object> get props => [input, o];
  Map<String, dynamic> toJson() => _$CustomArgumentsToJson(this);
}

class CustomQuery extends GraphQLQuery<Custom$QueryRoot, CustomArguments> {
  CustomQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'custom'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'input')),
              type: NamedTypeNode(
                  name: NameNode(value: 'Input'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: []),
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'o')),
              type: NamedTypeNode(
                  name: NameNode(value: 'OtherEnum'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'q'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'input'),
                    value: VariableNode(name: NameNode(value: 'input'))),
                ArgumentNode(
                    name: NameNode(value: 'o'),
                    value: VariableNode(name: NameNode(value: 'o')))
              ],
              directives: [],
              selectionSet: SelectionSetNode(selections: [
                FieldNode(
                    name: NameNode(value: 's'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null)
              ]))
        ]))
  ]);

  @override
  final String operationName = 'custom';

  @override
  final CustomArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  Custom$QueryRoot parse(Map<String, dynamic> json) =>
      Custom$QueryRoot.fromJson(json);
}
''';
