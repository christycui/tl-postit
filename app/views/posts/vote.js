<% if @vote.valid? %>
  $('#post_<%= @post.slug %>_vote').html("<%= @post.total_votes %>");
<% else %>
  alert("You have already voted on that.");
<% end %>