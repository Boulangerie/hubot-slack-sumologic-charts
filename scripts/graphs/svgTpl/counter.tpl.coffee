module.exports = """
<svg version="1.1"
     style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;"
     xmlns="http://www.w3.org/2000/svg" width="<%= width %>" height="<%= height %>">
  <rect x="0" y="0" width="100%" height="100%" fill="#EFEFEF"></rect>
  <text x="50%" y="50%" dy="0.45em" text-anchor="middle" style="font-size: 3.5em;">
    <tspan fill="#6AA84F"><%= value %></tspan>
    <tspan fill="#6AA84F"><%= metric %></tspan>
  </text>
</svg>
"""
