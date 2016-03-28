require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do

  let(:my_add) { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 90) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_add] to @ads" do
      get :index
      expect(assigns(:ads)).to eq([my_add])
     end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_add.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: my_add.id}
      expect(response).to render_template :show
    end
    it "assigns my_post to @post" do
      get :show, {id: my_add.id}
      expect(assigns(:ads)).to eq(my_add)
    end
  end
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    it "instantiates @ads" do
      get :new
      expect(assigns(:ads)).not_to be_nil
    end
    #
  end

  # describe "GET #create" do
  #   it "increases the number of ads by 1" do
  #     expect{advertisement :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price:1}}.to change(Advertisement,:count).by(1)
  #   end
  #   it "assigns the new ad to @ads" do
  #     ad :create, ad: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}
  #     expect(assigns(:ad)).to eq Advertisement.last
  #   end
  #   it "redirects to the new ad" do
  #     advertisement :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 1}
  #     expect(response).to redirect_to Advertisement.last
  #   end
  # end

end
