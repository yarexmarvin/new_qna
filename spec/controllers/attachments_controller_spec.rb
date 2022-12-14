require "rails_helper"

RSpec.describe AttachmentsController, type: :controller do
  describe "DELETE #destroy" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    let(:question_files) { create(:question, :question_files, user: user1) }
    let(:answer_files) { create(:answer, :answer_files, question: question_files, user: user1) }

    describe "Question file" do
      context "Authenticate user" do
        before { login(user1) }
        it "can remove their files" do
          expect { delete :destroy, params: { id: question_files.files.first }, format: :js }.to change(question_files.files, :count).by(-1)
        end

        it "renders destroy template" do
          delete :destroy, params: { id: question_files.files.first }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context "Authenticate user" do
        before { login(user2) }

        it "tries to delete other user's files" do
          expect { delete :destroy, params: { id: question_files.files.first }, format: :js }.to_not change(question_files.files, :count)
        end

      end

      context "Unauthenticate user " do
        it "tries to delete any files" do
          expect { delete :destroy, params: { id: question_files.files.first }, format: :js }.to_not change(question_files.files, :count)
        end
      end
    end

    describe "Answer file" do
      context "Authenticate user" do
        before { login(user1) }
        it "can remove their files" do
          expect { delete :destroy, params: { id: answer_files.files.first }, format: :js }.to change(answer_files.files, :count).by(-1)
        end

        it "renders destroy template" do
          delete :destroy, params: { id: answer_files.files.first }, format: :js
          expect(response).to render_template :destroy
        end
      end

      context "Authenticate user" do
        before { login(user2) }

        it "tries to delete other user's files" do
          expect { delete :destroy, params: { id: answer_files.files.first }, format: :js }.to_not change(answer_files.files, :count)
        end

      end

      context "Unauthenticate user " do
        it "tries to delete any files" do
          expect { delete :destroy, params: { id: answer_files.files.first }, format: :js }.to_not change(answer_files.files, :count)
        end
      end
    end
  end
end
