# FACET - СПОСОБЫ ГРУППИРОВКИ ДАННЫХ НА ГРАФИКЕ

# группировку данных на графике можно выполнять различными способами

library ('ggplot2')
library ('ggdark')
ggplot (mtcars, aes (hp, mpg, col = factor (am), size = disp,
                     shape = factor (cyl))) +
  geom_point ()

# для отображения и настройки паттернов данных лучше использовать "facet"
ggplot (diamonds, aes (carat)) +
  geom_density ()

# "facet_grid" разбивает наблюдения на группы
ggplot (diamonds, aes (carat)) +
  geom_density () +
  facet_grid (cut ~ color)
# первый аргумент фасета - строка, второй - столбец
# иначе, вместо одной из меременных необходимо поставить точку
ggplot (diamonds, aes (carat)) +
  geom_density () +
  facet_grid (. ~ cut)
# далее можно добавить любую другую переменную

# воспользуемся датафреймом "mtcars"
library ('dplyr')
mtcars <- mutate (mtcars,
                  am = factor (am, labels = c ('A', 'M')),
                  vs = factor (vs, labels = c ('V', "s")))
ggplot (mtcars, aes (hp)) +
  geom_dotplot () +
  facet_grid (am ~ vs)
# аргумент "margin" по умолчанию отключёт, однако если его включить, то на
# диаграмму будут добавлены третий стобец и третья строка с агрегированными по
# строке/столбцу данными
ggplot (mtcars, aes (hp)) +
  geom_dotplot () +
  facet_grid (am ~ vs, margin = T)

# внутри фасета возможно отображение нескольких переменных
ggplot (mtcars, aes (hp, mpg)) +
  geom_point (aes (col = factor (cyl))) +
  facet_grid (am ~ vs, margins = T) +
  geom_smooth ()

# при использовании фасета "grid" получаем таблицу сопряжённостей
# фасет "wrap" строит не взаимосвязанные диаграммы
ggplot (diamonds, aes (carat, fill = color)) +
  geom_density () +
  facet_wrap (. ~ cut + color)
# каждая диаграмма фасета имеет подпись принадлежности к определённой подгруппе
# аргументы "nrow" и "ncol" позволяют указать количество строк и стобцов фасета

# фасет можно построить по одной переменной, причём каждый сабсет фасета будет
# соответствовать одной подгруппе
ggplot (diamonds, aes (carat)) +
  geom_density () +
  facet_wrap (~ cut)
