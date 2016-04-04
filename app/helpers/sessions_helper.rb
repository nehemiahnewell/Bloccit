module SessionsHelper
   def create_session(user)
     session[:user_id] = user.id
   end
 
 # #5
   def destroy_session(user)
     session[:user_id] = nil
   end
 
 # #6
   def current_user
     User.find_by(id: session[:user_id])
   end
   
   def avatar_url(user)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
end
