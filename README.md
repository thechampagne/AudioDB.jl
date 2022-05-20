# AudioDB.jl

[![](https://img.shields.io/github/v/tag/thechampagne/AudioDB.jl?label=version)](https://github.com/thechampagne/AudioDB.jl/releases/latest) [![](https://img.shields.io/github/license/thechampagne/AudioDB.jl)](https://github.com/thechampagne/AudioDB.jl/blob/main/LICENSE)

AudioDB API client for **Julia**.

### Download

**Julia pkg REPL**

write `]` to enter the pkg repl 

```
add AudioDB
```
**Julia REPL**
```
using Pkg; Pkg.add("AudioDB")
```

### Example

```julia
using AudioDB

for album in searchalbums_byartistid(111674)
	println(album["strAlbum"])
end
```

### License

AudioDB API client is released under the [Apache License 2.0](https://github.com/thechampagne/AudioDB.jl/blob/main/LICENSE).

```
 Copyright 2022 XXIV

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
```