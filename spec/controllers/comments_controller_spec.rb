require 'rails_helper'
 include SessionsHelper

 RSpec.describe CommentsController, type: :controller do
   let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
   let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld", role: :member) }
   let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
   let(:my_post_comment) { Comment.create!(body: 'Comment Body', commentable: my_post, user: my_user) }
   let(:my_topic_comment) { Comment.create!(body: 'Comment Body', commentable: my_topic, user: my_user) }
 
 # #6
   context "guest" do
     describe "POST create" do
       it "redirects the user to the sign in view from post" do
         post :create, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
         expect(response).to redirect_to(new_session_path)
       end
       it "redirects the user to the sign in view from topic" do
         post :create, topic_id: my_topic.id, comment: {body: RandomData.random_paragraph}
         expect(response).to redirect_to(new_session_path)
       end
     end
 
     describe "DELETE destroy" do
       it "redirects the user to the sign in view from post" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         expect(response).to redirect_to(new_session_path)
       end
       it "redirects the user to the sign in view from topic" do
         delete :destroy, post_id: my_topic.id, id: my_topic_comment.id
         expect(response).to redirect_to(new_session_path)
       end
     end
   end
 
 # #7
   context "member user doing CRUD on a comment they don't own" do
     before do
       create_session(other_user)
     end
 
     describe "POST create" do
       it "increases the number of comments by 1 in post" do
         expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
       end
 
       it "redirects to the post show view in post" do
         post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}
         expect(response).to redirect_to [my_topic, my_post]
       end
       
       it "increases the number of comments by 1 in topic" do
         expect{ post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
       end
 
       it "redirects to the post show view in topic" do
         post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence}
         expect(response).to redirect_to [my_topic]
       end
     end
 
     describe "DELETE destroy" do
       it "redirects the user to the posts show view in post" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         expect(response).to redirect_to([my_topic, my_post])
       end
       
       it "redirects the user to the posts show view in topic" do
         delete :destroy, topic_id: my_topic.id, id: my_topic_comment.id
         expect(response).to redirect_to([my_topic])
       end
     end
   end
 
 
 # #8
   context "member user doing CRUD on a comment they own" do
     before do
       create_session(my_user)
     end
 
     describe "POST create" do
       it "increases the number of comments by 1 in post" do
         expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
       end
 
       it "redirects to the post show view in post" do
         post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}
         expect(response).to redirect_to [my_topic, my_post]
       end
       
       it "increases the number of comments by 1 in topic" do
         expect{ post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
       end
 
       it "redirects to the post show view in topic" do
         post :create, topic_id: my_topic.id, comment: {body: RandomData.random_sentence}
         expect(response).to redirect_to [my_topic]
       end
     end
 
     describe "DELETE destroy" do
       it "deletes the comment in post" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         count = Comment.where({id: my_post_comment.id}).count
         expect(count).to eq 0
       end
 
       it "redirects to the post show view in post" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         expect(response).to redirect_to [my_topic, my_post]
       end
       
       it "deletes the comment in topic" do
         delete :destroy, topic_id: my_topic.id, id: my_topic_comment.id
         count = Comment.where({id: my_topic_comment.id}).count
         expect(count).to eq 0
       end
 
       it "redirects to the post show view in topic" do
         delete :destroy, topic_id: my_topic.id, id: my_topic_comment.id
         expect(response).to redirect_to [my_topic]
       end
     end
   end
 
 # #9
   context "admin user doing CRUD on a comment they don't own" do
     before do
       other_user.admin!
       create_session(other_user)
     end
 
     describe "POST create" do
       it "increases the number of comments by 1" do
         expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
       end
 
       it "redirects to the post show view" do
         post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}
         expect(response).to redirect_to [my_topic, my_post]
       end
     end
 
     describe "DELETE destroy" do
       it "deletes the comment" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         count = Comment.where({id: my_post_comment.id}).count
         expect(count).to eq 0
       end
 
       it "redirects to the post show view" do
         delete :destroy, post_id: my_post.id, id: my_post_comment.id
         expect(response).to redirect_to [my_topic, my_post]
       end
     end
   end
 end
