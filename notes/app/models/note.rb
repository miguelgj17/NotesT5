class Note < ActiveRecord::Base
    belongs_to :user
    aatr_accesible :image,:text
    IMAGES = File.join Rails.root, 'public', 'image_store'
    after_save : guardar_image


    def image=(file_data)
	unless file_data.blank?
		@file_data = file_data
		self.extension = file_data.original_filename.split('.').last.downcase
	end
    end
    
    def image_filename
	File.join IMAGES, "#{id}.#{extension}"
    end
    def image_path
	"/image_store/#{id}.#{extension}"
    end
    def has_pimage?
	File.exists? image_filename
    end
    private

    def guardar_image
	if @file_data
	    FileUtils.mkdir_p IMAGES
	    File.open(image_filename, 'wb') do |f|
		f.write(@file_data.read)
	end
	@file_data = nil
    end

end
