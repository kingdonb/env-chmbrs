Chartkick.options = {
  height: "400px",
  width: "600px",
  colors: ["#b00", "#666"]
}

Chartkick.options[:html] = '<div id="%{id}" style="height: %{height};width: %{width};">Loading...</div>'
Chartkick.options[:content_for] = :charts_js

