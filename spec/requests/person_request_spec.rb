require "rails_helper"

include Rack::Test::Methods
include ActionDispatch::TestProcess

describe "Person" do

  context "#create" do

    # let(:csv_data) do
    #   <<-eos
    #     Name,Location,Species,Gender,Affiliations,Weapon,Vehicle
    #     jabba the Hutt,Tatooine,Hutt,Male,Hutt Clan,,Jabba's Sale Barge
    #     R2-D2,Naboo,Astromech Droid,Other,"Rebel Alliance, Galactic Republic",,X-wing Starfighter
    #     C-3PO,Tatooine,Protocol Droid,Other,The Resistance,,-1
    #   eos
    # end

    let(:csv_file) do
      # path = Rails.root.join('spec', 'fixtures', 'aitnes.csv')
      fixture_file_upload(path, 'text/csv')
    end

    # before do
    #   allow(ActionDispatch::Http::UploadedFile).to receive(:new)
    #     .and_return(csv_file)
    # end

    it "should create users for each row" do
    #   file = Tempfile.new('new_persons.csv')
    #   file.write(csv_data)
    #   file.rewind # need to investigate further

      post person_index_path(
        csv: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/aitnes.csv")
      )

      # expect(User.count).to eq(3)
      # expect(response).to redirect_to("/")
      # expect(flash[:notice]).to be_present
    end

  end

end
