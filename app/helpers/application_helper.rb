module ApplicationHelper


	#module to provide title on per-page basis 
	def full_title (page_title)
		base_title = "Litter"
		if page_title.empty?
			base_title 
		else
			base_title + ' | ' + page_title
		end
	end 
end
