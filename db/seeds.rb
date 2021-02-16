# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

collateral_1 = Collateral.create(name: 'Google blog', description: 'blog description', url: 'https://google.com', collateral_type: 'article')
collateral_2 = Collateral.create(name: 'Selleo blog', description: 'Selleo blog description', url: 'https://selleo.com', collateral_type: 'article')
collateral_3 = Collateral.create(name: 'JS IRL', description: 'Javascript in real life', url: 'https://selleo.com', collateral_type: 'video')
collateral_4 = Collateral.create(name: 'How to get good', description: 'Tutorial git gud', url: 'https://gitgud.com', collateral_type: 'podcast')
collateral_5 = Collateral.create(name: 'Russia times', description: 'News from USSR', url: 'https://russia.ru', collateral_type: 'podcast')
collateral_6 = Collateral.create(name: 'USA Journal', description: 'podcast from USA', url: 'https://nytimes.com', collateral_type: 'podcast')

tag_1 = Tag.create(name: 'Ruby')
tag_2 = Tag.create(name: 'Rails')
tag_3 = Tag.create(name: 'USA')
tag_4 = Tag.create(name: 'Russia')
tag_5 = Tag.create(name: 'JS')

collateral_1_tag = CollateralsTag.create({tag_id: tag_1['id'], collateral_id: collateral_1['id'], weight: 2})
collateral_1_tag = CollateralsTag.create({tag_id: tag_2['id'], collateral_id: collateral_1['id'], weight: 1})
collateral_2_tag = CollateralsTag.create({tag_id: tag_2['id'], collateral_id: collateral_2['id'], weight: 2})
collateral_3_tag = CollateralsTag.create({tag_id: tag_5['id'], collateral_id: collateral_3['id'], weight: 3})
collateral_3_tag = CollateralsTag.create({tag_id: tag_2['id'], collateral_id: collateral_3['id'], weight: 1})
collateral_3_tag = CollateralsTag.create({tag_id: tag_3['id'], collateral_id: collateral_3['id'], weight: 1})
collateral_4_tag = CollateralsTag.create({tag_id: tag_5['id'], collateral_id: collateral_4['id'], weight: 2})
collateral_5_tag = CollateralsTag.create({tag_id: tag_3['id'], collateral_id: collateral_5['id'], weight: 4})
collateral_6_tag = CollateralsTag.create({tag_id: tag_4['id'], collateral_id: collateral_6['id'], weight: 2})
collateral_6_tag = CollateralsTag.create({tag_id: tag_5['id'], collateral_id: collateral_6['id'], weight: 1})


Lead.create(name: 'New Lead')