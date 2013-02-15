class Document < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
end
