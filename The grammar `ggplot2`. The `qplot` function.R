# ГРАММАТИКА "GGPLOT2" И ФУНКЦИЯ "QPLOT"


# атрибуты аэстетики определяют, какие данные будут отображены на графике
# объекты геометрии определяют, как будут отображены и как расположены данные
# статистическая транформация позволяет производить с данными преобразования
# фасет определяет группировку данных

library (ggplot2)
data ('diamonds')
diamonds <- diamonds

# функция "qplot" в зависимости от типа и количества вводных данных строит
# определённые типы диаграмм
# переменные могут быть заданы в неявном виде, источник данных - в явном
qplot (x = price, data = diamonds) # гистограмма
qplot (x = price, y = carat, data = diamonds) # диаграмма рассеяния
qplot (cut, carat, data = diamonds) # дотплот с разбивкой по качеству огранки

# не обязательно указывать датафрейм
# информацию можно визуализировать из вектора, причём вектор можно указать напрямую
v <- diamonds$carat
qplot (v)
qplot (diamonds$carat, diamonds$price)

# графики "qplot" можно сохранять в переменные
qplot (price, carat, data = diamonds)
my_plot <- qplot (price, carat, data = diamonds)

# характеристики диаграммы можно менять
qplot (x = price, y = carat,
       color = color, # добавление цвета
       data = diamonds)

# вид фигуры, отображающей данные можно прописать отдельно
qplot (price, carat, color = color, data = diamonds,
       geom = 'point')

# функция "shape" отвечает за внешний вид точек
# количество фигур ограничено и функция ожидает на вход фактор
mtcars <- mtcars
qplot (mpg, hp, color = factor (am), shape = factor (cyl),
       data = mtcars, size = I (3))

# функция "size" отвечает за размер точек, однако необходимо указывать, что
# это графическая настройка "size = I (3)"
# это также справедливо и по отношению к другим графическим настройкам диаграммы
qplot (price, data = diamonds,
       col = I ('black'), # цвет границы фигуры
       fill = factor (color), # заливка, в зависимости от значения "color"
       geom = 'density', # объект отображения "dendity"
       alpha = I (0.25)) # прорачность слоя


# агрумент "ggplot" является главной заготовкой диаграммы
# на вход требует заготовку данных
# "mapping" отвечает за распределение элементов на графике
# "aes" определяет переменные, отображаемые на графике
# "geom" определяет вид отображения данных
ggplot (diamonds, aes (x = price)) +
  geom_histogram ()

# аргументы, определяющие данные не обязательны для явного указания
ggplot (diamonds, aes (price, carat)) +
  geom_point () +
  geom_smooth () # дополнительный геом определяет линию тренда
diamonds$color <- as.factor (diamonds$color)
ggplot (diamonds, aes (price, carat)) +
  geom_point () +
  geom_smooth (method = 'lm') # линейная модель линии тренда

# все переменные, которые необходимо нанести на график указываются в аэстетике
# аэстетика может быть указана как внутри функции, так и внутри геома
# параметры аэстетики, введённые внутри функции применяются ко всем геомам
ggplot (diamonds, aes (price, carat, color = cut)) +
  geom_point () +
  geom_smooth (method = 'lm')

# чтобы цветом оборазить точки, но не трогать линии, в настройках геома
# прописывается дополнительная аэстетика
ggplot (diamonds, aes (price, carat)) +
  geom_point (aes (color = cut)) +
  geom_smooth (method = 'lm')

# аргументы внутри геомов задают настройки отображения геома
# "size" - задаёт размер фигуры
# "alpha" - задаёт прозрачность
# настройки внутри одного геома не переходят на другой геом
airquality <- airquality
library (dplyr)
glimpse (airquality)
gr_airquality <- group_by (airquality, Month)
t <- summarise (gr_airquality, mean_temp = mean (Temp),
                mean_wind = mean (Wind))
ggplot (t, aes (Month, mean_temp)) + # строим диаграмму без дополнительных настроек
  geom_point () +
  geom_line ()

ggplot (t, aes (Month, mean_temp)) +
  geom_point (aes (size = mean_wind)) + # размер точек зависит от значения "mean_wind"
  geom_line ()

# для каждой переменной можно ввести свой геом, комбинируя которые можно
# улучшить внешний вид и читаемость диаграммы
# отрисовка геомов осуществляется по слоям, в порядке их расположения
# некоторые геомы могут не иметь связи к данными и задаваться напрямую
ggplot (t, aes (Month, mean_temp)) +
  geom_line () + # точки отобразятся поверх линии
  geom_point (aes (size = mean_wind), color = 'red') +
  geom_hline (yintercept = 75) # дополнительная линия

# геом "errorbar" позволяет строить диаграммы для наблюдений, имеющих
# доверительные интервалы
# требует указания группирующей переменной и некоторых минимальных и
# максимальных значений
# геом "pointrange" выполняет схожую функцию, но, помимо прочего,
# отображает средние значения
gr_mtcars <- group_by (mtcars, am)
se_data <- summarise (gr_mtcars, mean_mpg = mean (mpg),
                      y_max = mean_mpg + 1.96 * sd (mpg) / sqrt (length (mpg)),
                      y_min = mean_mpg - 1.96 * sd (mpg) / sqrt (length (mpg)))
ggplot (se_data, aes (factor (am), mean_mpg)) +
  geom_errorbar (aes (ymin = y_min, ymax = y_max)) +
  geom_point ()
ggplot (se_data, aes (factor (am), mean_mpg)) +
  geom_pointrange (aes (ymin = y_min, ymax = y_max))

# или при отображении нескольких групп переменнных
gr_mtcars1 <- group_by (mtcars, am, vs)
se_data1 <- summarise (gr_mtcars1, mean_mpg = mean (mpg),
                       y_max = mean (mpg) + 1.96 * sd (mpg) / sqrt (length (mpg)),
                       y_min = mean (mpg) - 1.96 * sd (mpg) / sqrt (length (mpg)))
ggplot (se_data1, aes (x = factor (am), y = mean_mpg)) +
  geom_errorbar (aes (ymin = y_min, ymax = y_max)) +
  geom_point (shape = 21, fill = 'white', size = 3)

# чтобы объединить группы линиями необходимо в настройках аэстетики прописать
# переменную "group"
ggplot (se_data1, aes (x = factor (am), y = mean_mpg, col = factor (vs),
                       group = factor (vs))) +
  geom_errorbar (aes (ymin = y_min, ymax = y_max)) +
  geom_point (shape = 21, size = 2, fill = 'white') +
  geom_line ()
# при этом порядок геомов можно менять
# геомы, расположенные выше в коде отвечают за более глубокие слои диаграммы

# предобработку данных можно делать непосредственно внутри "ggplot"
ggplot (mtcars, aes (factor (am), mpg)) +
  stat_summary (fun.data = mean_cl_boot)
# по умолчанию "stat_summary" работает с осью "y"
ggplot (mtcars, aes (factor (am), mpg)) +
  stat_summary (fun.data = mean_cl_boot, geom = 'errorbar') +
  stat_summary (fun.data = mean_cl_boot, geom = 'point')
# соединим средние линией
ggplot (mtcars, aes (factor (am), mpg, col = factor (vs), group = factor (vs))) +
  stat_summary (fun.data = mean_cl_boot, geom = 'errorbar') +
  stat_summary (fun.data = mean_cl_boot, geom = 'point') +
  stat_summary (fun.data = mean_cl_boot, geom = 'line')

# функцию "fun.data = mean_cl_boot" при отрисовке линии можно заменить на
# "fun.y = mean"

# данные можно трансформировать без предобработки

# можно использовать некоторые собственные функции
# по умолчанию "mean_cl_boot" рассчитывает средние значения и границы доверительного
# интервала

sd_error <- function (x) {
  c (mean (x), mean (x) - sd (x), mean (x) + sd (x))
}
# данная функция рассчитывает средние значения и стандартные отклонения
# однако, для использования при отрисовке диаграмм, элементы вектора должны
# иметь соответствующие названия
sd_error1 <- function (x) {
  c (y = mean (x), ymin = mean (x) - sd (x), ymax = mean (x) + sd (x))
}

# функция "position_dodge" позволяет разнести элементы диаграммы
ggplot (mtcars, aes (factor(am), mpg, col = factor (cyl), group = factor(cyl))) + 
  stat_summary (fun.data = sd_error1, geom = "errorbar", 
                width = 0.2, 
                position = position_dodge (0.2)) + 
  stat_summary (fun.data = sd_error1, geom = "point", size = 2, 
                position = position_dodge (0.2)) +
  stat_summary (fun.y = mean, geom = "line", 
                position = position_dodge (0.2))
