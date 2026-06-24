// Package styles provides Rosé Pine Glamour styles for terminal markdown.
package styles

import "charm.land/glamour/v2/ansi"

// Style name constants (upstream-shaped for charmbracelet/glamour PRs).
const (
	RosePineStyle         = "rose-pine"
	RosePineMoonStyle     = "rose-pine-moon"
	RosePineMoonDarkStyle = "rose-pine-moon-dark"
	RosePineDawnStyle     = "rose-pine-dawn"
)

// DefaultStyles maps style names to configs.
var DefaultStyles = map[string]*ansi.StyleConfig{
	RosePineStyle:         &RosePineStyleConfig,
	RosePineMoonStyle:     &RosePineMoonStyleConfig,
	RosePineMoonDarkStyle: &RosePineMoonDarkStyleConfig,
	RosePineDawnStyle:     &RosePineDawnStyleConfig,
}
