# Microblogging Social Network (Twitter)

## Description
Microblogging Social Network (Twitter)


## Objectives

### Learning Objectives

After completing this assignment, you should…

* Understand gems and their place in Rails developmeny
* Understand Relationships between models
* Understand Personalization
* Understand Authentication
* Understand Pagination


### Performance Objectives

After completing this assignment, you be able to effectively use

* authentication, sessions, and `current_user`
* `bootstrap-sass`
* `acts_as_follower`
* `kaminari`
* Validations
* Controllers



## Details

### Deliverables

* A repo containing at least:
  * a user model
  * a post model that users can write
  * a follow model
  * a signup wizard

### Requirements



## Normal Mode

* Users can signup, and sign in
* User can follow other users
* User can see posts from [User + Friends] in their Timeline
* User can Post posts
* User can unfollow a person
* Site should look nice
* Posts should be paginated
* Data should be seeded (use `faker`)
* Get live and up and working on Heroku


## Hard Mode

* User can view a profile (/users/jwo)
* Users can block users for being a-holes
* Users can search for posts
* People can put the URL of a picture in for their picture and it will be shown on their profile. Or even better, use Identicons (https://en.wikipedia.org/wiki/Identicon). You can have another site create them (https://github.com/cupcake/sigil) or make them yourself (https://rubygems.org/gems/identicon).


## Notes

* When logged in, the root URL should show the messages from all the people you follow.
* People can post "messages," "cheeps," or whatever you want to call them. They're tweets, but please don't call them that.
* Getting the list of messages for You + people you follow is tricky'ish. Think of it like this:

```ruby
class User
  def timeline
    follower_ids = following_users.pluck(:id)
    all_ids = follower_ids << user.id
    Post.where(user_id: all_ids).order("created_at DESC")
  end
end
```

## Additional Resources

* [Acts As Follower](https://github.com/tcocca/acts_as_follower)
