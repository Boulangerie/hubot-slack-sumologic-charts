module.exports = """
<svg version="1.1"
     style="font-family:&quot;Lucida Grande&quot;, &quot;Lucida Sans Unicode&quot;, Arial, Helvetica, sans-serif;font-size:12px;"
     xmlns="http://www.w3.org/2000/svg" width="<%= width %>" height="<%= height %>">
  <rect x="0" y="0" width="100%" height="100%" style="fill: #EFEFEF;"></rect>
  <g class="main-value">
    <text x="50%" y="50%" dy="0.35em" style="text-anchor: middle; font-size: 3.3em;">
      <tspan class="value" style="font-size: 1.5em;fill: rgba(38, 38, 38, 0.901961);"><%= value %></tspan>
      <tspan class="subvalue" style="font-size: 0.7em;fill: rgba(38, 38, 38, 0.901961);"><%= metric %></tspan>
    </text>
  </g>
</svg>
"""
