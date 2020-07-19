# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app --> (gem 'sinatra)
- [x] Use ActiveRecord for storing information in a database --> (gem 'activerecord' & 'sinatra-activerecord')
- [x] Include more than one model class (e.g. User, Post, Category) --> (User & Recipe models)
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) --> (User has many recipes)
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) --> (Recipe belongs to User)
- [x] Include user accounts with unique login attribute (username or email) --> (validates :username, presence: true, uniqueness: true)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying --> (it does. all located in the recipe_controller)
- [x] Ensure that users can't modify content created by other users --> (they can't. the edit/delete buttons are hidden and even going to routes manually is forbidden)
- [x] Include user input validations --> (Made sure to check for empty fields whenever a user was filling out their forms 'params[:ingredients].empty?')
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) --> (included flash messages & confirm() box for deleting of recipes)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message