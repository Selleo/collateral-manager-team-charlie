# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Collateral.create(name: 'Google blog', description: 'blog description', url: 'https://google.com', collateral_type: 'blog')

a = Tag.create(name: 'Ruby')
b = Tag.create(name: 'Rails')
c = Tag.create(name: 'USA')

Collateral.create(name: 'Google blog', description: 'blog description', url: 'https://google.com', collateral_type: 'blog', tags: [a,b,c])

Lead.create(name: 'New Lead')
