---
title: Rosé Pine Glamour sample
description: Fixture for previewing Glamour styles
---

# Heading one

## Heading two

### Heading three

#### Heading four

##### Heading five

###### Heading six

All natural pine, faux fur and a bit of soho vibes for the classy minimalist.

**Bold text**, *italic text*, and ~~strikethrough~~. Inline `code` in a sentence.

> Block quotes use muted tones and stay readable beside body copy.

- Bullet one
- Bullet two
  - Nested bullet

1. First item
2. Second item
3. Third item

- [x] Completed task
- [ ] Open task

[Glamour](https://github.com/charmbracelet/glamour) renders this file. [Rosé Pine](https://rosepinetheme.com/) supplies the palette.

---

| Variant | Base     | Mood        |
| ------- | -------- | ----------- |
| Main    | `#191724` | Cozy dark   |
| Moon    | `#232136` | Soft night  |
| Dawn    | `#faf4ed` | Warm light  |

### Bash

```bash
#!/usr/bin/env bash
export GLAMOUR_STYLE="$PWD/styles/rose-pine-moon-dark.json"
glow -s "$GLAMOUR_STYLE" examples/sample.md
```

### Go

```go
package main

import "fmt"

func greet(name string) {
	fmt.Printf("Hello, %s\n", name)
}

func main() {
	greet("Rosé Pine")
}
```

### JSON

```json
{
  "style": "rose-pine-moon-dark",
  "variants": ["rose-pine", "rose-pine-moon", "rose-pine-moon-dark", "rose-pine-dawn"]
}
```
