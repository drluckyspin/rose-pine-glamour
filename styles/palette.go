package styles

// Palette holds official Rosé Pine color roles for one variant.
type Palette struct {
	Base    string
	Surface string
	Overlay string
	Muted   string
	Subtle  string
	Text    string
	Love    string
	Gold    string
	Rose    string
	Pine    string
	Foam    string
	Iris    string
}

// Rosé Pine (main, dark).
var RosePinePalette = Palette{
	Base:    "#191724",
	Surface: "#1f1d2e",
	Overlay: "#26233a",
	Muted:   "#6e6a86",
	Subtle:  "#908caa",
	Text:    "#e0def4",
	Love:    "#eb6f92",
	Gold:    "#f6c177",
	Rose:    "#ebbcba",
	Pine:    "#31748f",
	Foam:    "#9ccfd8",
	Iris:    "#c4a7e7",
}

// Rosé Pine Moon (official moon base).
var RosePineMoonPalette = Palette{
	Base:    "#232136",
	Surface: "#2a273f",
	Overlay: "#393552",
	Muted:   "#6e6a86",
	Subtle:  "#908caa",
	Text:    "#e0def4",
	Love:    "#eb6f92",
	Gold:    "#f6c177",
	Rose:    "#ea9a97",
	Pine:    "#3e8fb0",
	Foam:    "#9ccfd8",
	Iris:    "#c4a7e7",
}

// Rosé Pine Moon Dark — moon syntax on main base; pairs with rose-pine-bat.
var RosePineMoonDarkPalette = Palette{
	Base:    "#191724",
	Surface: "#2a273f",
	Overlay: "#26233a",
	Muted:   "#6e6a86",
	Subtle:  "#908caa",
	Text:    "#e0def4",
	Love:    "#eb6f92",
	Gold:    "#f6c177",
	Rose:    "#ea9a97",
	Pine:    "#3e8fb0",
	Foam:    "#9ccfd8",
	Iris:    "#c4a7e7",
}

// Rosé Pine Dawn (light).
var RosePineDawnPalette = Palette{
	Base:    "#faf4ed",
	Surface: "#fffaf3",
	Overlay: "#f2e9e1",
	Muted:   "#9893a5",
	Subtle:  "#797593",
	Text:    "#464261",
	Love:    "#b4637a",
	Gold:    "#ea9d34",
	Rose:    "#d7827e",
	Pine:    "#286983",
	Foam:    "#56949f",
	Iris:    "#907aa9",
}
