# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Set the Version Number from GIT
APP_VERSION = `git describe --always` unless defined? APP_VERSION