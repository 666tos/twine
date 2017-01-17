require 'command_test'

class TestConsumeLocalizationArchive < CommandTest
  def setup
    super

    options = {}
    options[:input_path] = fixture_path 'consume_localization_archive.zip'
    options[:output_path] = @output_path
    options[:format] = 'apple'

    @twine_file = build_twine_file 'en', 'es' do
      add_section 'Section' do
        add_definition key1: 'value1'
      end
    end

    @runner = Twine::Runner.new(options, @twine_file)
  end

  def test_consumes_zip_file
    @runner.consume_localization_archive

    assert @twine_file.definitions_by_key['key1'].translations['en'], 'value1-english'
    assert @twine_file.definitions_by_key['key1'].translations['es'], 'value1-spanish'
  end
end
