# Напишите функцию, которая будет принимать data.table с этими данными, и
# возвращать объект plotly с трехмерной моделью. Следует воспользоваться
# установкой индексов i, j, k.

# Подключим необходимые библиотеки
library ('plotly')
library ('data.table')

# Загрузим датафрейм, на основе данных которого будем строить чайник
teapot <- read.csv ('teapot.csv', sep = ';')

# Напишем функцию, которая будет возвращать нам требуемый объект
make.fancy.teapot <- function (teapot.coords) {
  ind <- data.table (i = seq (0, nrow (teapot.coords) -1, by = 3),
                     j = seq (1, nrow (teapot.coords) -1, by = 3),
                     k = seq (2, nrow (teapot.coords) -1, by = 3))
  plot_ly (teapot.coords,
           x = teapot.coords$x, 
           y = teapot.coords$y, 
           z = teapot.coords$z, 
           i = ind$i, 
           j = ind$j, 
           k = ind$k, 
           type = "mesh3d")
}
make.fancy.teapot (teapot)

# Альтернативное решение №1
make.fancy.teapot <- function (teapot.coords) {
  is <- (1 : (nrow (teapot.coords) / 3)) * 3 - 3
  js <- (1 : (nrow (teapot.coords) / 3)) * 3 - 2
  ks <- (1 : (nrow (teapot.coords) / 3)) * 3 - 1
  plot_ly (teapot.coords,
           x = ~x,
           y = ~y,
           z = ~z,
           i = ~is, 
           j = ~js,
           k = ~ks, type = 'mesh3d')
}
make.fancy.teapot1 (teapot)

# Важно, при проверке различными он-лайн средствами, вроде "stdin → stdout",
# используемой на "Степике", тильды "~" необходимо убрать, однако без них
# в RDtudio код работать не будет

# Альтернативное решение №2 (более развёрнутое)
teapot <- read.csv('teapot.csv', sep = ";") # Импортируем датафрейм
library (plotly)
library (data.table) # Подключаем требуемые библиотеки
teapot # Смотрим импортированный датафрейм
mesh <- data.table (x = rnorm (40),
                    y = rnorm (40),
                    z = rnorm (40)) # Задаём координаты полигонов
i = teapot [1 : 3, 1]
j = teapot [1 : 3, 2]
k = teapot [1 : 3, 3] # Задаём полигоны
plot_ly (teapot [1 : 3, ], type = "mesh3d",
         x = ~x, y = ~y, z = ~z,
         i = ~i, j = ~j, k = ~k) # Строим объёмную координатную сетку
i.s <- seq (from = 0, to = nrow (teapot) - 1, by = 3)
j.s <- seq (from = 1, to = nrow (teapot), by = 3)
k.s <- seq (from = 2, to = nrow (teapot), by = 3) # Задаём код полигонов
plot_ly (teapot,
         x = ~x, y = ~y, z = ~z,
         i = ~i.s, j = ~j.s, k = ~k.s,
         type = "mesh3d") # Строим фигуру
# Запаковываем полигоны и заданную ими фигуру в функцию
make.fancy.teapot <- function (teapot.coords) {
  i.s <- seq (from = 0, to = nrow (teapot.coords) - 1, by = 3)
  j.s <- seq (from = 1, to = nrow (teapot.coords), by = 3)
  k.s <- seq (from = 2, to = nrow (teapot.coords), by = 3)
  plot_ly (teapot.coords,
           x = ~x, y = ~y, z = ~z,
           i = ~i.s, j = ~j.s, k = ~k.s,
           type = "mesh3d")
}
# Конвертируем датафрейм в дататейбл, что, в принципе, не обязательно, 
# "plot_ly" прекрасно будет работать и с датафреймом
teapot <- as.data.table (teapot) 
make.fancy.teapot (teapot) # Вызываем фигуру
