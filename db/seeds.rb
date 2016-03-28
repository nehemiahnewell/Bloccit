require 'random_data'

# Create Posts
50.times do
    Post.create!(
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
    )
end

50.times do
    Advertisement.create!(
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph,
        price:  100
    )
end

posts = Post.all
# Create Comments

100.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

post = Post.find_or_create_by(title: "A Random Post", body: "This is just another post")
post.comments.find_or_create_by(body: "This is just a random comment")
puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"