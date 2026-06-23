# -----------------------------------------------------------------------------------------------------------
# Rosé Pine Glamour — Makefile
# -----------------------------------------------------------------------------------------------------------
# Glamour styles for terminal markdown (Glow, CLIs, upstream charmbracelet/glamour).
#
#   make help        — list targets
#   make check       — verify tools
#   make build       — regenerate styles/*.json
#   make test        — validate JSON + Glamour render
#   make screenshots — gallery PNGs (Python + Pillow)
#   make preview     — glow examples/sample.md (STYLE=rose-pine-moon-dark)
# -----------------------------------------------------------------------------------------------------------

include Common.make

# Override default preview style:
#   make preview STYLE=rose-pine-dawn
