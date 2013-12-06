class DataDict < Settingslogic
  source "#{Rails.root}/config/data.yml"
  namespace Rails.env
end