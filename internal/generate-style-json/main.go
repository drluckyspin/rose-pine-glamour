package main //nolint:revive

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"

	"charm.land/glamour/v2/ansi"
	"github.com/drluckyspin/rose-pine-glamour/styles"
)

func writeStyleJSON(filename string, styleConfig *ansi.StyleConfig) error {
	f, err := os.Create(filename)
	if err != nil {
		return fmt.Errorf("rose-pine-glamour: create %s: %w", filename, err)
	}
	defer f.Close() //nolint:errcheck

	e := json.NewEncoder(f)
	e.SetIndent("", "  ")
	if err := e.Encode(styleConfig); err != nil {
		return fmt.Errorf("rose-pine-glamour: encode %s: %w", filename, err)
	}
	return nil
}

func run() error {
	root := "."
	if len(os.Args) > 1 {
		root = os.Args[1]
	}
	for name, cfg := range styles.DefaultStyles {
		path := filepath.Join(root, "styles", name+".json")
		if err := writeStyleJSON(path, cfg); err != nil {
			return err
		}
		fmt.Println("wrote", path)
	}
	return nil
}

func main() {
	if err := run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
