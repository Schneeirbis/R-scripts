# "Scale" и "Theme": оси, легенда, внешний вид диаграммы
# -------------------------------------------------------

# Функция "scale" отвечает за занчения, которые отображаются на осях

library ('ggplot2')
df <- mtcars
str (df)
df$am <- as.factor (df$am)
df$vs <- as.factor (df$vs)
str (df)
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am)))
# Каждая точка на графике закодирована тремя переменными
# Для налядности я соединил точки линиями, прописав дополнительный геом

# Аргумент "scale_x" обращается к переменной, лежащей на оси "x"
# "name" позволяет переименовать переменную
# Название оси можно задать при помощи функции "xlab", аналогично функции "name"
# "breaks" определяет значения, отображаемые на осях в качестве делений

ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am))) +
  scale_x_continuous (name = "Miles /(US) gallon",
                      breaks = seq_x) # Ошибка

# Для использования в качестве аргумента функции "breaks" её необходимо
# предварительно задать, или прописать непосредственно в коде
seq_x <- round (seq (min (df$mpg), max (df$mpg), length.out = 10))
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am))) +
  scale_x_continuous (name = "Miles / (US) gallon",
                      breaks = seq_x) +
  ylab ('Horse power')
# "limits" отвечает за верхнюю и нижнюю границы, в которых что-то можно
# нарисовать
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am))) +
  scale_x_continuous (name = "Miles / (US) gallon",
                      breaks = c (1, seq (10, 35, 5)),
                      limits = c (1, 35)) +
  ylab ('Hpse power')

# Лимиты также можно прописать при помощи команды "xlim"
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am))) +
  xlab ('Miles / (US) gallon') +
  ylab ('Horse power') +
  xlim (c (1, 35))

# Ту жу операции можно проделать и с осью "y"
# "scale_color" отвечает за цвет, причём, если цвет зависит от факторной
# переменной, то функция записывается  как "scale_color_discrete"
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point () +
  geom_line (aes (group = factor (am))) +
  scale_x_continuous (name = 'Miles / (US) gallon',
                      breaks = c (5, seq (10, 35, 5)),
                      limits = c (5, 35)) +
  scale_y_continuous (name = 'Horse power',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_color_discrete (name = 'Transmission',
                        labels = c ('Auto', 'Manual'))

# Библиотека "ggplot2" позволяет указывать названия элементов диаграммы
# кириллицей, однако, кириллические символы могут некорректно отображаться
# в различных версиях программы и на разных компьютерах
# В частности, для корректного отображения кириллицы на "GitHub"
# необходимо сделить за кодировкой

# "scale_color_manual" позволяет вручную настраивать цвета
# Названия цветов можно увидеть в палитре библиотеки "ggplot2"
ggplot (df, aes (mpg, hp, col = factor (am))) +
  geom_point (size = 2) +
  geom_line (aes (group = factor (am)), size = 1) +
  scale_x_continuous (name = 'Расход топлива, миль/галлон',
                      breaks = c (5, seq (10, 35, 5)),
                      limits = c (10, 35)) +
  scale_y_continuous (name = 'Мощность, лошадиных сил',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_color_manual (values = c ('green', 'cyan'),
                      name = 'Тип трансмиссии',
                      labels = c ('Автоматическая', 'Ручная'))

# Функция "scale_fill" отвечает за настройку заливки
ggplot (df, aes (hp, fill = am)) +
  geom_density (alpha = 0.2) +
  scale_fill_discrete (name = 'Transmission',
                       labels = c ('Auto', 'Manual')) +
  scale_x_continuous (name = 'Horse power',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Density')

# Ручные настройки цвета работают аналогичено
ggplot (df, aes (hp, fill = am)) +
  geom_density (alpha = 0.2) +
  scale_fill_manual (name = 'Transmission',
                     labels = c ('Auto', 'Manual'),
                     values = c ('yellow', 'cyan')) +
  scale_x_continuous (name = 'Horse power',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Density')

# Функция "scale_size" отвеччает за настройку размера элементов графика,
# зависящих от переменных
ggplot (df, aes (hp, mpg, size = disp)) +
  geom_point (color = 'blue') +
  scale_size_continuous (name = 'Engine displacement',
                         breaks = c (100, seq (100, 500, 100))) +
  scale_x_continuous (name = 'Horse power',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Miles / gallon',
                      breaks = c (5, seq (10, 35, 5)),
                      limits = c (10, 35))

# Если добавить ещё одну переменную, от которой будут зависеть размеры
# элементов диаграммы, то пофвится ещё одна легенда, которую также
# можно настроить
ggplot (df, aes (hp, mpg, size = disp, shape = vs)) +
  geom_point (color = 'red') +
  scale_size_continuous (name = 'Engine displacement',
                         breaks = seq (100, 400, 50)) +
  scale_shape_discrete (name = 'Engine type',
                        labels = c ('V-shaped', 'Straight')) +
  scale_x_continuous (name = 'Horse power',
                      breaks = c (40, seq (50, 350, 25)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Miles per Gallon',
                      breaks = c (5, seq (10, 35, 5)),
                      limits = c (10, 35))

# Иногда по оси "x" отложена факторная переменная, при этом настройки
# отображения прописываются аналогично
ggplot (df, aes (factor (cyl), hp)) +
  geom_boxplot () +
  scale_x_discrete (name = 'Number of cylinders',
                    labels = c (4, 6, 8)) +
  scale_y_continuous (name = 'Gross horsepower',
                      breaks = c (40, seq (50, 350, 50)),
                      limits = c (40, 350))

# Функция "theme" контролирует внешний вид, положение и другие
# характеристики диаграммы
# "scale_fill_brewer" подволяет подобрать пользовательсикй набор цветов
ggplot (df, aes (am, hp, fill = vs)) +
  geom_boxplot () +
  scale_fill_brewer (type = 'qual', palette = 6,
                     name = 'Engine type',
                     labels = c ('V-shaped', 'Straight')) +
  scale_x_discrete (name = 'Transmission',
                    labels = c ('Automatic', 'Manual')) +
  scale_y_continuous (name = 'Gross horsepower',
                      breaks = c (50, seq (50, 350, 50)),
                      limits = c (40, 350)) +
  theme_bw () # Позволяет убрать серый фон на диаграмме

# В случае отображения переменных при помощи цвета настройки аналогичны
ggplot (df, aes (hp, mpg, col = factor (cyl))) +
  geom_point (size = 3) +
  scale_color_brewer (type = 'qual', palette = 3,
                      name = 'Number of cylinder') +
  theme_bw () +
  scale_x_continuous (name = 'Gross horsepower',
                      breaks = c (50, seq (50, 350, 50)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Miles per Gallon',
                      breaks = c (10, seq (10, 35, 5)),
                      limits = c (10, 35))

# "theme" отвечает за базовые настройки темы диаграммы
ggplot (df, aes (hp, mpg, col = factor (cyl))) +
  geom_point (size = 3) +
  theme_bw () +
  scale_color_brewer (type = 'qual', palette = 6,
                      name = 'Number of cylinder') +
  theme (text = element_text (size = 14),
         axis.line.x = element_line (size = 2),
         axis.line.y = element_line (size = 2)) +
  scale_x_continuous (name = 'Gross horsepower',
                      breaks = c (50, seq (50, 350, 50)),
                      limits = c (40, 350)) +
  scale_y_continuous (name = 'Miles per Gallon',
                      breaks = c (10, seq (10, 35, 5)),
                      limits = c (10, 35))

# Существуют готовые темы для отображения диаграмм
# "theme_classic" оставляет только отображение данных и подписи на осях
# Также существуют библиотеки, позволяющие менять и настраивать
# темы диаграмм, такие как "ggthemes"
install.packages ('ggthemes')
library ('ggthemes')
