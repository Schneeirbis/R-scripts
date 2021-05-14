# ПРИМЕР РЕШЕНИЯ ПРАКТИЧЕСКОЙ ЗАДАЧИ

# По возможности более точно воспроизвести диаграмму, найденную по запросу в интернете

library ('ggplot2')
library ('dplyr')
# Загрузим датафрем, по данным из которого будем строить диаграмму и происпектируем его
df <- read.csv ('example_data.csv')
str (df)
glimpse (df)
df$date <- as.factor (df$date)

# Поэтапно построим график, создав заготовку и добавляя новые слои

ggplot (df, aes (date, percent, col = system)) +
  geom_point () +
  geom_line (aes (group = system))
# Группировку данных можно прописать как в общей аестетике, так и в аестетике геома

# Добавим на график вертикальную линию, отделяющую группы наблюдений
ggplot (df, aes (date, percent, col = system)) +
  geom_point () +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5)

# Ось "x" представляет собой фактор, но фактор, это одновременно и целое число и
# строка, то есть, каждая градация фактора закодирована целым числом

# Изменим внешний вид графика, для этого поработаем над точками наблюдений
ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 4) +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5)

# Границы точек тонки, потому, чтобы нарастить их пропишем данный геом несколько
# раз, при этом незначительно меняя размер
# Однако, у точек есть параметр "stroke", который отвечает за толщину границ
ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 3, stroke = 2) +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5)

# Изменим цвета отображения линий, обратившись на
# "http://sape.inf.usi.ch/quick-reference/ggplot2/colour"

ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 3, stroke = 2) +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5) +
  scale_color_manual (values = c ('orangered1', 'red', 'cyan', 'yellow1',
                                  'springgreen2'))

# На тестовом графике отсутствуют названия осей, однако, по умолчанию
# библиотека "ggplot2" подписи указывает, потому от них необходимо избавиться
# Также избавимся от бэкграунда диаграммы и поработаем над подписями данных
ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 3, stroke = 2) +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5) +
  scale_color_manual (values = c ('orangered1', 'red', 'cyan', 'yellow1',
                                  'springgreen2')) +
  xlab ('') +
  ylab ('') +
  scale_y_continuous (breaks = c (0, 0.04, 0.08, 0.11, 0.15),
                      limits = c (0, 0.15), labels = scales::percent) +
  theme_classic ()

# Поработаем над внешним видом и положением легенды
ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 3, stroke = 2) +
  geom_line (aes (group = system)) +
  geom_vline (xintercept = 7.5) +
  scale_color_manual (values = c ('orangered1', 'red', 'cyan', 'yellow',
                                  'springgreen2')) +
  xlab ('') +
  ylab ('') +
  scale_y_continuous (breaks = c (0, 0.04, 0.08, 0.11, 0.15),
                      limits = c (0, 0.15),
                      labels = scales::percent) +
  theme_classic () +
  theme (legend.title = element_blank (),
         legend.position = 'top')

# Изменим цветовое оформление диаграммы и настроим вид текста
ggplot (df, aes (date, percent, col = system)) +
  geom_point (shape = 21, size = 3, stroke = 2) +
  geom_line (aes (group = system), size = 1.25) +
  geom_vline (xintercept = 7.5, color = 'white', linetype = 'dotted') +
  scale_color_manual (values = c ('orangered1', 'red', 'cyan', 'yellow',
                                  'springgreen2')) +
  xlab ('') +
  ylab ('') +
  scale_y_continuous (breaks = c (0, 0.04, 0.08, 0.11, 0.15),
                      limits = c (0, 0.15),
                      labels = scales::percent) +
  theme_classic () +
  theme (legend.title = element_blank (),
         legend.position = 'top') +
  theme (plot.background = element_rect (color = 'black', fill = 'black'),
         text = element_text (color = 'white'),
         panel.background = element_rect (color = 'black', fill = 'black'),
         legend.background = element_rect (color = 'black', fill = 'black'),
         panel.grid.major.y = element_line (color = 'gray50',
                                            linetype = 'longdash', size = 0.3),
         axis.text.x = element_text (face = 'bold', size = 16, color = 'white'),
         axis.text.y = element_text (face = 'bold', size = 16, color = 'white'),
         legend.text = element_text (face = 'bold', size = 14))

# Добавим название графика, копирайты и другие подписи
# Копирайты, в данном случае, не являются элементами графика, потому добавлять
# их будем не средствами библиотеки "ggplot2", а при помощи библиотеки "grid"
ggplot (df, aes (date, percent, col = system)) +
  geom_line (aes (group = system), size = 1.25) +
  geom_point (shape = 21, size = 3, stroke = 2, fill = 'black') +
  geom_vline (xintercept = 7.5, color = 'white', linetype = 'dotted') +
  scale_color_manual (values = c ('orangered1', 'red', 'cyan', 'yellow',
                                  'springgreen2')) +
  xlab ('') +
  ylab ('') +
  scale_y_continuous (breaks = c (0, 0.04, 0.08, 0.11, 0.15),
                      limits = c (0, 0.15),
                      labels = scales::percent) +
  theme_classic () +
  theme (legend.title = element_blank (),
         legend.position = 'top',
         plot.background = element_rect (color = 'black', fill = 'black'),
         panel.background = element_rect (color = 'black', fill = 'black'),
         legend.background = element_rect (color = 'black', fill = 'black'),
         text = element_text (color = 'white'),
         panel.grid.major.y = element_line (color = 'gray50',
                                            linetype = 'longdash', size = 0.3),
         axis.text.x = element_text (face = 'bold', size = 16, color = 'white'),
         axis.text.y = element_text (face = 'bold', size = 16, color = 'white'),
         legend.text = element_text (face = 'bold', size = 16, color = 14)) +
  ggtitle ('Top 5 Linux distributions (percent of total per year)')
library ('grid')
grid.text ("Data sourse: The DistroWatch's Page Hit Ranking (Nov. 23, 2011)",
           x = 0.02, y = 0.01, just = c ('left', 'bottom'),
           gp = gpar (fontface = 'bold', fontsize = 9, col = 'white'))
grid.text ("www.pingdom.com",
           x = 0.98, y = 0.01, just = c ('right', 'bottom'),
           gp = gpar (fontface = 'bold', fontsize = 9, col = 'white'))

# Для орблегчения задачи заготовку графика можно было сохранить в переменную и уже к
# переменной добавлять геомы, настройки, темы и подписи
# Также, весь данный график можно сохранить в переменную, создав шаблон и
# адаптировав под решение повседневных задач


