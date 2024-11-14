
class ImageProcessingJob < ApplicationJob
  queue_as :default

  def perform(image_id)
    image = Image.find(image_id)
    # Logic to resize/process the image
    ImageProcessor.new(image).process
  end
end
