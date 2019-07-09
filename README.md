<p align="center">
  <img src="https://user-images.githubusercontent.com/735858/58768495-8ecbd600-8572-11e9-9321-4fa5ce4ea007.png" height="200">
  <h1><b>Artemis</b></h1>
</p>

<!-- Badges -->

[![Pub Package](https://img.shields.io/pub/v/artemis.svg)](https://pub.dartlang.org/packages/artemis)

**Build dart types from a GraphQL schema.**

Artemis is a code generator that looks for `*.schema.json` (GraphQL Introspection Query response schema) and `*.query.graphql` files and builds `.dart` files typing that query, based on schema. That's similar to what [Apollo](https://github.com/apollographql/apollo-client) does (Artemis is his sister anyway).

---

## **Installation**
Add the following to your `pubspec.yaml` file:
```yaml
dev_dependencies:
  artemis: <1.0.0
  build_runner: ^1.5.0
  json_serializable: ^3.0.0
```

>ℹ️ Note that `build_runner` and `json_serializable` are required!

Then run:
```shell
pub packages get
```
or
```shell
flutter packages get
```

Now Artemis will generate the API files for you by running:
```shell
pub run build_runner build
```
or
```shell
flutter pub run build_runner build
```

## **Configuration**
Artemis offers some configuration options to generate code. All options should be included on `build.yaml` file on the root of the project:
```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          # custom configuration options!
```

| Option | Default value | Description |
| - | - | - |
| `generate_helpers` | `true` | If Artemis should generate query/mutation helper functions (with inputs and coercing). |
| `custom_parser_import` | `null` | Import path to the file implementing coercer functions for custom scalars. See [Custom scalars](#custom-scalars). |
| `scalar_mapping` | `[]` | Mapping of GraphQL and Dart types. See [Custom scalars](#custom-scalars). |
| `schema_mapping` | `[]` | Mapping of queries and which schemas they will use for code generation. See [Schema mapping](#schema-mapping). |

## **Custom scalars**
If your schema uses custom scalars, they must be defined on `build.yaml`. If it needs a custom parser (to decode from/to json), the `custom_parser_import` path must be set and the file must implement both `fromGraphQL___ToDart___` and `fromDart___toGraphQL___` constant functions.

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          custom_parser_import: 'package:graphbrainz_example/coercers.dart'
          scalar_mapping:
          - graphql_type: Date
            dart_type: DateTime
```

Each `ScalarMap` is configured this way:

| Option | Default value | Description |
| - | - | - |
| `graphql_type` |  | The GraphQL custom scalar name on schema. |
| `dart_type` |  | The Dart type this custom scalar should be converted from/to. |
| `use_custom_parser` | `false` | Wheter `custom_parser_import` should be imported on the beginning of the file. |

See [examples](./example) for more information and configuration options.

## **Schema mapping**
By default, Artemis won't generate anything. That's because your queries/mutations should be linked to GraphQL schemas. To configure it, you need to point `schema_mapping` to the path of those queries and schemas:

```yaml
targets:
  $default:
    builders:
      artemis:
        options:
          schema_mapping:
            - schema: lib/my_graphql.schema.json
              queries_glob: lib/**.query.graphql
```

Each `SchemaMap` is configured this way:

| Option | Default value | Description |
| - | - | - |
| `schema` |  | Relative path to the GraphQL schema. Its extension must be `.schema.json`. |
| `queries_glob` |  | Glob that selects all query files to be used with this schema. Their extension must be `.query.graphql`. |
| `resolve_type_field` | `__resolveType` | The name of the field used to differentiatiate interfaces and union types (commonly `__resolveType` or `__typename`). Note that `__resolveType` field are not added automatically to the query. If you want interface/union type resolution, you need to manually add it to the query. |

See [examples](./example) for more information and configuration options.
