# frozen_string_literal: true

require_relative 'library'

library = Library.new

=begin
#library.add_author('Ашли Ванс','Ashlee Vance (born 1977) is an American business columnist. His most well known book, Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future was released on May 19, 2015.')
library.add_author('Джером Дэвид Сэлинджер', 'Джеро́м Дэ́вид Сэ́линджер (англ. Jerome David Salinger, J. D. Salinger /ˈsælɪndʒər/; 1 января 1919, Нью-Йорк — 27 января[5][6][7] 2010, Корниш, Нью-Гэмпшир) -американский писатель, произведения которого увидели свет в журнале The New Yorker во 2-й половине 1940-х и в 1950-е годы.')
library.add_author('Франц Кафка','Франц Ка́фка — немецкоязычный писатель еврейского происхождения, бо́льшая часть работ которого была опубликована посмертно.')
library.add_author('Льюис Кэрролл','Лью́ис Кэ́рролл — английский писатель, математик, логик, философ, диакон и фотограф.')
library.add_author('Стендаль','Мари́-Анри́ Бейль — французский писатель, один из основоположников психологического романа. В печати выступал под различными псевдонимами, наиболее важные произведения опубликовал под именем Стенда́ль.')
library.add_author('Дэвид Аллен', 'Дэвид Аллен (англ. David Allen) (род. 28 декабря 1945 г.) — эксперт, консультант в вопросах управления временем и личной продуктивности. Аллен — создатель популярного метода повышения личной эффективности Getting Things Done (GTD), автор нескольких книг в этой области.')
library.add_author('Габриэл Винер', 'Габриэль Винер — оперный певец и полиглот из Чикаго, автор нашумевшей книги «Fluent Forever», посвященной изучению иностранных языков. К лингвистике его привело желание помочь своей оперной карьере. ')

#library.add_book('Elon Musk','Ашли Ванс')
library.add_book('Над пропастью во ржи', 'Джером Дэвид Сэлинджер')
library.add_book('Превращение', 'Франц Кафка')
library.add_book('Алиса в Стране чудес', 'Льюис Кэрролл')
library.add_book('Красное и чёрное', 'Стендаль')
library.add_book('Getting Things Done', 'Дэвид Аллен')
library.add_book('Fluent Forever', 'Габриэл Винер')

#library.add_reader('Inna', 'innashcherbak11@gmail.com', 'Dnipro', 'Veterenarna', '19')
library.add_reader('Pit', 'pit@gmail.com', 'Dnipro', 'Gogolya', '655')
library.add_reader('Met', 'met@gmail.com', 'Dnipro', 'Svobodi', '452')
library.add_reader('Egor', 'egor11@gmail.com', 'Dnipro', 'Petrova', '66')
library.add_reader('Masha', 'mery@gmail.com', 'Dnipro', 'Zvonka', '194')

library.add_order('Над пропастью во ржи','Pit')
library.add_order('Над пропастью во ржи','Met')
library.add_order('Над пропастью во ржи','Egor')

library.add_order('Алиса в Стране чудес','Pit')
library.add_order('Алиса в Стране чудес','Met')

library.add_order('Fluent Forever','Egor')
library.add_order('Fluent Forever','Masha')

library.add_order('Getting Things Done','Pit')
=end

library.add_author('Ашли Ванс',
                   'Ashlee Vance (born 1977) is an American business columnist. His most well known book, Elon Musk: Tesla, SpaceX, and the Quest for a Fantastic Future was released on May 19, 2015.')
library.add_book('Elon Musk', 'Ашли Ванс')

library.load('library_load.json')
library.add_order('Fluent Forever', 'Met')
library.save('library_save.json')

p library.find_most_popular_book
p library.find_greatest_reader
p library.count_readers_of_most_popular_book
