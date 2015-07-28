require 'yaml'
require 'uri'

class ValorDual

  def initialize(path)
    data = YAML.load_file(path)
    @access_key = data["s3"]["access_key"]
    @secret_key = data["s3"]["secret_access_key"]
    @region = data["s3"]["region"]
    @bucket = data["s3"]["bucket"]
    @versions = data["versions"]
  end

  def aws_instance(name, file_path)
    # Create an instance of the Aws::S3::Resource class.
    s3 = Aws::S3::Resource.new(
          credentials: Aws::Credentials.new(@access_key, @secret_key),
          region: @region
        )

    # Reference the target object by bucket name and key.
    obj = s3.bucket(@bucket).object(name)

    # Call#upload_file on the object.
    obj.upload_file(file_path, acl:'public-read')
    return obj.public_url 
  end

  def create_image(url)
    dump = Hash.new
    @array_of_dumps = []
    @versions.each do |key, value|
      name = key.dup
      full_name = Time.now.to_i.to_s << '_' << name << File.extname(URI.parse(url).path)
      
      image = MiniMagick::Image.open(url) 
      image.resize value
      image.write(full_name)

      object_url = self.aws_instance(full_name, File.expand_path(full_name))

      dump = { 'version' => name, 'public_url' => object_url} 

      @array_of_dumps << dump
      File.delete(full_name)
    end
    return @array_of_dumps
  end

  def fetch version
    version_name = @array_of_dumps.find{|i| i['version'] == version }
    (version_name.nil?) ? "Specify correct version" : version_name["public_url"]
  end

end