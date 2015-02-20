<% if @vote.valid? %>
  $('#comment_<%= @comment.id %>_vote').html("<%= @comment.total_votes %>");
<% else %>
  alert('You have already voted on that.');
<% end %>