require 'spec_helper'
describe 'wine' do

  context 'with defaults for all parameters' do
    it { should contain_class('wine') }
  end
end
