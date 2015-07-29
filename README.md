# valor-dual
A simple image re-sizer which converts image into different resolutions and pushes them onto AWS S3 bucket.
After successful image versions creation, the gem pushes them on the bucket and return the public urls of the image.
The image can be fetched either from url or local directory. The versions needed by the user needs to be mentioned in the config file along with the dimensions.

#requirements

The [Mini Magick](https://github.com/minimagick/minimagick) and [AWS SDK](https://github.com/aws/aws-sdk-ruby) gem has to be installed. Additional modules required are URI and YAML.
To check if above gems are installed on your system

```sh
$gem list
```
#installation

To install valor-dual into the system, run 
```sh
	$sudo gem install valor-dual
```

#usage

First, require the mini_magick, aws-sdk, uri gems and YAML to your project.
```ruby
require "mini_magick"
require "aws-sdk"
require "uri"
require "yaml"
```
Now to use valor-dual gem, add the gem to your project by
```ruby
require "valor-dual"
```

To use this gem is very simple. To create the instance of valor-dual pass the path of YAML file to new method. 
```ruby
valor = ValorDual.new(path_to_yaml_file)

e.g
valor = ValorDual.new('./config.yaml')
```
To create different versions of the image and push them to S3 bucket call create_image method. Pass the url or local path of the image for which you need to push in the bucket.
```ruby
valor.create_image(url/path)

e.g
valor.create_image('../img/image.jpg')
```
To fetch the image from aws s3 bucket. To get all images's different versions public_url call fetch method. Or pass the version of the image as specified in the config file to get only specific version of the image.
```ruby
valor.fetch
#["https://1985playground.s3-ap-southeast-1.amazonaws.com/1437722824_small.jpg", "https://1985playground.s3-ap-southeast-1.amazonaws.com/1437722857_large.jpg"]

valor.fetch('small')
#["https://1985playground.s3-ap-southeast-1.amazonaws.com/1437722824_small.jpg"]
```

#Config.yaml
Access_key, secret_access_key, region and bucket are mandatory. While the versions can be on users choice in the format given below

```ruby
---
s3: 
  access_key: '**********'
  secret_access_key: '*****************************'
  region: '*************'
  bucket: '************'
versions:
  small: '150x150'
  large: '600x500'
```
#rubygems.org link

```ruby
https://rubygems.org/gems/valor-dual
```