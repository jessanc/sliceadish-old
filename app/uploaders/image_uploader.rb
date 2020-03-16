Shrine.plugin :activerecord
Shrine.plugin :validation_helpers
Shrine.plugin :logging, logger: Rails.logger
class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :processing
  plugin :versions
  plugin :determine_mime_type
  Attacher.validate do
    validate_max_size 3.megabytes, message: 'is huge (max is 3 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end
  process(:store) do |io, context|
      { original: io, thumb: resize_to_limit!(io.download, 250, 250) }
  end
end
