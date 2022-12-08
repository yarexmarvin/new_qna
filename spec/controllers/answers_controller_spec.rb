require "rails_helper"

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe "GET #show" do
    before { get :show, params: { id: answer } }

    it "assigns the requested to answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it "should render show view" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { login(user) }

    before { get :new, params: { question_id: question } }

    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "should render new view" do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { login(user) }

    before { get :edit, params: { id: answer } }

    it "assigns the requested to answer to @answer" do
      expect(assigns(:answer)).to eq answer
    end

    it "should render edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    before { login(user) }

    context "with valid attributes" do
      it "saves a new answer in database" do
        expect { post :create, params: { question_id: question, user: user, answer: attributes_for(:answer) }, format: :js }.to change(question.answers, :count).by(1)
      end

      it "redirects to show view" do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js

        expect(response).to render_template :create
      end
    end

    context "with invalid attributes" do
      it "does not save a new answer in database" do
        expect { post :create, params: { question_id: question, user: user, answer: attributes_for(:answer, :invalid) }, format: :js }.to_not change(question.answers, :count)
      end

      it "re-renders new view" do
        post :create, params: { question_id: question, user: user, answer: attributes_for(:answer, :invalid) }, format: :js

        expect(response).to render_template :create
      end
    end
  end

  describe "PATCH #update" do
    before { login(user) }

    context "with valid attributes" do
      it "assigns requested aswer to @answer" do
        patch :update, params: { id: answer, user: user, answer: attributes_for(:answer) }, format: :js

        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attributes" do
        patch :update, params: { id: answer, user: user, answer: { body: "new body" } }, format: :js
        answer.reload

        expect(answer.body).to eq "new body"
      end

      it "redirects to updated answer" do
        patch :update, params: { id: answer, user: user, answer: attributes_for(:answer) }, format: :js

        expect(response).to render_template :update
      end
    end

    context "with invalid attributes" do
      it "does not change question attributes" do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js

        expect(answer.body).to eq "MyAnswer"
      end
      it "re-renders edit view" do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js

        expect(response).to render_template :update
      end
    end
  end

  describe "DELETE #destroy" do
    before { login(user) }

    let!(:answer) { create(:answer, question: question, user: user) }

    it "deletes the answer" do
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it "redirects to the question view" do
      delete :destroy, params: { id: answer }, format: :js 

      expect(response).to render_template :destroy
    end
  end
end
