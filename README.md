When this in run, it indexes the whole bazel output base:

```
./generate.sh compile_commands.1.json
```

```
  Folder: /usr/local/include/ will be indexed
  Folder: /usr/lib/gcc/x86_64-linux-gnu/7/include-fixed/ will be indexed
  Folder: /usr/lib/gcc/x86_64-linux-gnu/7/include/ will be indexed
  Folder: /usr/include/ will be indexed
  Folder: /home/cameronm/.cache/bazel/_bazel_cameronm/23db515bf9e8b2132aa912742e0bbc96/ will be indexed
```

However, when this is run, it only indexes the folder containing the main.cpp file:

```
./generate.sh compile_commands.2.json
```

```
  Folder: /home/cameronm/tests/vscode_cpp_bazel_output_base/foo/ will be indexed
  Folder: /usr/local/include/ will be indexed
  Folder: /usr/lib/gcc/x86_64-linux-gnu/7/include-fixed/ will be indexed
  Folder: /usr/lib/gcc/x86_64-linux-gnu/7/include/ will be indexed
  Folder: /usr/include/ will be indexed
```

The only difference between these two files is which path components are put into `file` and `directory`. Shifting just one path component from `path` to `directory` results in the directory that is indexed shifting by two, before symlink resolution: from `$(bazel info output_base)` to `$(bazel info output_base)/external/foo`. Moving main.cpp into subdirectories also increases this effect, for example shifting just one path component in the compile_commands.json results in the indexed folder changing to e.g. `$(bazel info output_base)/external/foo/bar/baz`.
