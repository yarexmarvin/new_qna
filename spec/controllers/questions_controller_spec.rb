require "rails_helper"

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe "GET #index" do
    let(:questions) { create_list(:question, 3, user: user) }

    before { get :index }

    it "popultes an array of all questions" do
      expect(assigns(:questions)).to match_array(questions)
    end

    it "renders index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, params: { id: question } }

    it "assigns question to @questipn" do
      expect(assigns(:question)).to eq question
    end

    it "renders show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { login(user) }

    before { get :new }

    it "assigns a new Question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { login(user) }

    before { get :edit, params: { id: question } }

    it "assigns a new Question to @question" do
      expect(assigns(:question)).to eq question
    end

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before { login(user) }

    context "with valid attributes" do
      it "saves a new question in database" do
        expect { post :create, params: { user: user, question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it "redirects to show view" do
        post :create, params: { user: user, question: attributes_for(:question) }

        expect(response).to redirect_to assigns(:question)
      end
    end

    context "with invalid attributes" do
      it "does not save a new question in database" do
        expect { post :create, params: { user: user, question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it "re-renders new view" do
        post :create, params: { user: user, question: attributes_for(:question, :invalid) }

        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    before { login(user) }

    context "with valid attributes" do
      it "assigns requested question to @question" do
        patch :update, params: { id: question, user: user, question: attributes_for(:question) }, format: :js

        expect(assigns(:question)).to eq question
      end

      it "changes question attributes" do
        patch :update, params: { id: question, user: user, question: { title: "new title", body: "new body" }, format: :js }
        question.reload

        expect(question.title).to eq "new title"
        expect(question.body).to eq "new body"
      end

      it "redirects to updated question" do
        patch :update, params: { id: question, user: user, question: attributes_for(:question) }, format: :js

        expect(response).to render_template :update
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: question, user: user, question: attributes_for(:question, :invalid) }, format: :js }

      it "does not change question attributes" do
        question.reload

        expect(question.title).to eq "MyString"
        expect(question.body).to eq "MyText"
      end

      it "re-renders edit view" do
        expect(response).to render_template :update
      end
    end
  end

  describe "DELETE #destroy" do
    before { login(user) }
    let!(:question) { create(:question, user: user) }

    it "deletes the question" do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it "redirects to index view" do
      delete :destroy, params: { id: question }

      expect(response).to redirect_to questions_path
    end
  end
end
