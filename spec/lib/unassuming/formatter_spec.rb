describe RSpec::Core::Formatters::Unassuming do
  let(:unassuming) { RSpec::Core::Formatters::Unassuming.new(StringIO.new)}

  it 'Works' do
    expect(true).to be_truthy
  end

  it 'Does not work' do
    expect(unassuming.cyan_line).to eq "Pass"
    end
  it 'Also Does not work' do
    expect(unassuming.cyan_line).to eq "Fail!"
  end

end