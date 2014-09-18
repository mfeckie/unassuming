describe RSpec::Core::Formatters::Unassuming do
  include FormatterSupport

  before do
    send_notification :start, start_notification(1)
    allow(formatter).to receive(:color_enabled?).and_return(false)
  end

  let(:unassuming) { RSpec::Core::Formatters::Unassuming.new(StringIO.new)}

  it 'prints 好 for passed examples' do
    send_notification :example_passed, example_notification
    expect(output.string).to end_with("好 \e[0m")
  end

  it 'throws glitter if specs pass' do
    send_notification :example_failed, example_notification
    send_notification :dump_summary, summary_notification(0.00001, examples(2), [], [2], 0)
    expect(output.string).to include("(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧")
  end

  it 'prints ☢ for failed examples' do
    send_notification :example_failed, example_notification
    expect(output.string).to end_with("☢\e[0m")
  end

  it 'throws the table if specs fail' do
    send_notification :example_failed, example_notification
    send_notification :dump_summary, summary_notification(0.00001, examples(2), [1], [], 0)
    expect(output.string).to include("(╯°□°）╯︵ ┻━┻")
  end

end