import 'package:json_annotation/json_annotation.dart';

// I can't use the default json_serializable flow because the artemis generator
// would crash when importing options.dart file.
part 'options.g2.dart';

@JsonSerializable(fieldRename: FieldRename.snake, anyMap: true)
class GeneratorOptions {
  @JsonKey(defaultValue: '')
  final String prefix;
  final String customParserImport;
  @JsonKey(defaultValue: [])
  final List<ScalarMap> scalarMapping;
  @JsonKey(defaultValue: [])
  final List<SchemaMap> schemaMapping;

  GeneratorOptions({
    this.prefix,
    this.customParserImport,
    this.scalarMapping,
    this.schemaMapping,
  });

  factory GeneratorOptions.fromJson(Map<String, dynamic> json) =>
      _$GeneratorOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GeneratorOptionsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ScalarMap {
  @JsonKey(name: 'graphql_type')
  final String graphQLType;
  final String dartType;
  @JsonKey(defaultValue: false)
  final bool useCustomParser;

  ScalarMap({
    this.graphQLType,
    this.dartType,
    this.useCustomParser = false,
  });

  factory ScalarMap.fromJson(Map<String, dynamic> json) =>
      _$ScalarMapFromJson(json);

  Map<String, dynamic> toJson() => _$ScalarMapToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SchemaMap {
  final String schema;
  final String queriesGlob;

  SchemaMap({
    this.schema,
    this.queriesGlob,
  });

  factory SchemaMap.fromJson(Map<String, dynamic> json) =>
      _$SchemaMapFromJson(json);

  Map<String, dynamic> toJson() => _$SchemaMapToJson(this);
}
