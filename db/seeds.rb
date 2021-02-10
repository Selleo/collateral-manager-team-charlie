# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

collateral_1 = Collateral.create(name: 'Google blog', description: 'blog description', url: 'https://google.com', collateral_type: 'blog')
collateral_2 = Collateral.create(name: 'Selleo blog', description: 'Selleo blog description', url: 'https://selleo.com', collateral_type: 'blog')

tag_1 = Tag.create(name: 'Ruby')
tag_2 = Tag.create(name: 'Rails')
tag_3 = Tag.create(name: 'USA')

collateral_1_tag = CollateralsTag.create({tag_id: tag_1['id'], collateral_id: collateral_1['id'], weight: 2})
collateral_1_tag = CollateralsTag.create({tag_id: tag_2['id'], collateral_id: collateral_1['id'], weight: 3})


Lead.create(name: 'New Lead')
