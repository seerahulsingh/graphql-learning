This is an example solution for the homework
in the first section of the "Basics of GraphQL in Ruby on Rails"
course, by Alex Deva.

Here is an example query that works with this project (assuming 
you have some data in the database):

{
  user(id:1) {
    first_name
    address
    posts {
      id
      body
      user {
        id
      }
      comments {
        id
        body
      }
    }
  }
}