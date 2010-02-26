h1. merb-sexy-grid


<pre><code>
<%= grid_for(@obj, :class => "list", :border => 1) do %>
  <%= column 'Id', :id %>
  <%= column 'Name', :name %>
<% end =%>
</code></pre>


