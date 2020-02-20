import 'package:artemis/generator/data.dart';
import 'package:test/test.dart';

import '../helpers.dart';

void main() {
  group('On complex input objects', () {
    test(
      'On complex input objects',
      () async => testGenerator(
        query: r'''
          query some_query($filter: ComplexType!) { 
            o(filter: $filter) { 
              s 
            } 
          }''',
        schema: r'''
          schema {
            query: QueryRoot
          }
          
          type QueryRoot {
            o(filter: ComplexType!): SomeObject
          }
          
          type ComplexType {
            s: String!
            e: MyEnum
            ls: [String]
          }
          
          type SomeObject {
            s: String
          }
          
          enum MyEnum {
            value1
            value2
          }
        ''',
        libraryDefinition: libraryDefinition,
        generatedFile: generatedFile,
        generateHelpers: true,
      ),
    );
  });
}

final LibraryDefinition libraryDefinition =
    LibraryDefinition(basename: r'query', queries: [
  QueryDefinition(
      queryName: r'some_query',
      queryType: r'SomeQuery$QueryRoot',
      classes: [
        ClassDefinition(
            name: r'SomeQuery$QueryRoot$SomeObject',
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
            name: r'SomeQuery$QueryRoot',
            properties: [
              ClassProperty(
                  type: r'SomeQuery$QueryRoot$SomeObject',
                  name: r'o',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: false),
        EnumDefinition(
            name: r'SomeQuery$ComplexType$MyEnum',
            values: [r'value1', r'value2', r'ARTEMIS_UNKNOWN']),
        ClassDefinition(
            name: r'SomeQuery$ComplexType',
            properties: [
              ClassProperty(
                  type: r'String',
                  name: r's',
                  isOverride: false,
                  isNonNull: true,
                  isResolveType: false),
              ClassProperty(
                  type: r'SomeQuery$ComplexType$MyEnum',
                  name: r'e',
                  isOverride: false,
                  annotation:
                      r'JsonKey(unknownEnumValue: SomeQuery$ComplexType$MyEnum.ARTEMIS_UNKNOWN)',
                  isNonNull: false,
                  isResolveType: false),
              ClassProperty(
                  type: r'List<String>',
                  name: r'ls',
                  isOverride: false,
                  isNonNull: false,
                  isResolveType: false)
            ],
            factoryPossibilities: {},
            typeNameField: r'__typename',
            isInput: true)
      ],
      inputs: [
        QueryInput(
            type: r'SomeQuery$ComplexType', name: r'filter', isNonNull: true)
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
class SomeQuery$QueryRoot$SomeObject with EquatableMixin {
  SomeQuery$QueryRoot$SomeObject();

  factory SomeQuery$QueryRoot$SomeObject.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRoot$SomeObjectFromJson(json);

  String s;

  @override
  List<Object> get props => [s];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRoot$SomeObjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$QueryRoot with EquatableMixin {
  SomeQuery$QueryRoot();

  factory SomeQuery$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$QueryRootFromJson(json);

  SomeQuery$QueryRoot$SomeObject o;

  @override
  List<Object> get props => [o];
  Map<String, dynamic> toJson() => _$SomeQuery$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SomeQuery$ComplexType with EquatableMixin {
  SomeQuery$ComplexType({@required this.s, this.e, this.ls});

  factory SomeQuery$ComplexType.fromJson(Map<String, dynamic> json) =>
      _$SomeQuery$ComplexTypeFromJson(json);

  String s;

  @JsonKey(unknownEnumValue: SomeQuery$ComplexType$MyEnum.ARTEMIS_UNKNOWN)
  SomeQuery$ComplexType$MyEnum e;

  List<String> ls;

  @override
  List<Object> get props => [s, e, ls];
  Map<String, dynamic> toJson() => _$SomeQuery$ComplexTypeToJson(this);
}

enum SomeQuery$ComplexType$MyEnum {
  value1,
  value2,
  ARTEMIS_UNKNOWN,
}

@JsonSerializable(explicitToJson: true)
class SomeQueryArguments extends JsonSerializable with EquatableMixin {
  SomeQueryArguments({@required this.filter});

  factory SomeQueryArguments.fromJson(Map<String, dynamic> json) =>
      _$SomeQueryArgumentsFromJson(json);

  final SomeQuery$ComplexType filter;

  @override
  List<Object> get props => [filter];
  Map<String, dynamic> toJson() => _$SomeQueryArgumentsToJson(this);
}

class SomeQueryQuery
    extends GraphQLQuery<SomeQuery$QueryRoot, SomeQueryArguments> {
  SomeQueryQuery({this.variables});

  @override
  final DocumentNode document = DocumentNode(definitions: [
    OperationDefinitionNode(
        type: OperationType.query,
        name: NameNode(value: 'some_query'),
        variableDefinitions: [
          VariableDefinitionNode(
              variable: VariableNode(name: NameNode(value: 'filter')),
              type: NamedTypeNode(
                  name: NameNode(value: 'ComplexType'), isNonNull: true),
              defaultValue: DefaultValueNode(value: null),
              directives: [])
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
              name: NameNode(value: 'o'),
              alias: null,
              arguments: [
                ArgumentNode(
                    name: NameNode(value: 'filter'),
                    value: VariableNode(name: NameNode(value: 'filter')))
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
  final String operationName = 'some_query';

  @override
  final SomeQueryArguments variables;

  @override
  List<Object> get props => [document, operationName, variables];
  @override
  SomeQuery$QueryRoot parse(Map<String, dynamic> json) =>
      SomeQuery$QueryRoot.fromJson(json);
}
''';
