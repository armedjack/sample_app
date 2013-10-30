def full_title(page_title)

  base_title = "My sample App"
  page_title.empty? ? base_title : "#{base_title} | #{page_title}"

end

