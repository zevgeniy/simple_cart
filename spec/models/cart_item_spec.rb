require 'spec_helper'

describe SimpleCart::CartItem do
  it { should belong_to(:cart) }
  it { should belong_to(:cartable) }
end