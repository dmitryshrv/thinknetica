module Validation
  def valid?
    valid!
    true
  rescue
    false
  end
end
