require 'spec_helper'
describe 'proxmox4' do

  context 'with defaults for all parameters' do
    it { should contain_class('proxmox4') }
  end
end
