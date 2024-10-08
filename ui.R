library(dplyr)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(openxlsx)
library(ggbeeswarm)
library(ggthemes)
library(shiny)
library(shinyBS)
library(data.table)
library(markdown)
ui <- navbarPage(title = "ShinyBeeswarm",
                 tabPanel(
                   "Corrplot",
                   tabPanel(
                     "Chord Diagram",
                     sidebarPanel(
                       fileInput("file", h4("Upload Data :")),
                       downloadButton("Download1", "示例数据"),
                       checkboxInput("shape", "形状", FALSE) ,
                       conditionalPanel(
                         condition = "input.shape",
                         sliderInput(
                           "slider1",
                           label = "图形点的大小",
                           min = 0,
                           max = 5,
                           value = 1.5,
                           step = 0.1
                         ),
                         selectInput(
                           "select6",
                           label = "形状",
                           choices = list(
                             "圆形" = 16,
                             "三角形" = 17,
                             "菱形" = 18,
                             "正方形" = 15
                           )
                         )
                       ),
                       checkboxInput("others", "方向", FALSE) ,
                       conditionalPanel(
                         condition = "input.others",
                         selectInput(
                           "select7",
                           label = h5("朝向"),
                           choices = list("默认" = 0, "向右" = 1, "向左" = -1)
                         ),
                         selectInput(
                           "select8",
                           label = h5("点的排列方式 "),
                           choices = list("swarm", "square", "hex", "center")
                         ),
                         selectInput(
                           "select9",
                           h5(
                             "点的布局方法:",
                             bsButton(
                               "bs0",
                               label = "",
                               icon = icon("question"),
                               style = "info",
                               size = "small"
                             )
                           ),
                           choices = list("descending", "random", "density", "none")
                         ),
                         bsPopover("bs0", "当点的排列方式选为swarm时，可以更改点的布局方法。", trigger = "focus"),
                         selectInput(
                           "select10",
                           h5(
                             "corral:",
                             bsButton(
                               "bs1",
                               label = "",
                               icon = icon("question"),
                               style = "info",
                               size = "small",
                             )
                           ),
                           choices = list("omit", "random", "wrap", "gutter", "none")
                         ),
                         bsPopover(
                           "bs1",
                           "用于调整横向放置过宽的点的方法，当排列方式选为swarm并且布局方法选为random时可以更改。",
                           trigger = "focus"
                         )
                       ),
                       checkboxInput("lollipoptitle", "标题", FALSE) ,
                       conditionalPanel(
                         condition = "input.lollipoptitle",
                         textInput("text1", "标题:",
                                   value = c("Beeswarm")),
                         textInput("MyX", "x轴标题:", value = c("")),
                         textInput("MyY", "y轴标题:", value = c("")),
                       ),
                       checkboxInput("condition1", "字体", FALSE),
                       conditionalPanel(
                         condition = "input.condition1",
                         selectInput(
                           "select1",
                           label = "字体位置",
                           choices = list(
                             "标题" = 1,
                             "横坐标" = 2,
                             "纵坐标" = 3,
                             "横坐标标题" = 4,
                             "纵坐标标题" = 5
                           )
                         ),
                         conditionalPanel(
                           condition = "input.select1 == '1'",
                           radioButtons(
                             "f2",
                             label = h4("字体粗斜"),
                             choices = list(
                               "默认" = "plain",
                               "粗体" = "bold",
                               "斜体" = "italic",
                               "粗斜体" = "bold.italic"
                             )
                           ),
                           radioButtons(
                             "t2",
                             label = h4("字体样式"),
                             choices = list("sans", "serif", "mono", "wqy-microhei" , "STKaiti", "simhei")
                           ),
                           sliderInput(
                             "slider2",
                             label = "标题",
                             min = 1,
                             max = 40,
                             value = 30
                           )
                         ),
                         conditionalPanel(
                           condition = "input.select1 == '2'",
                           radioButtons(
                             "f1",
                             label = h4("字体粗斜"),
                             choices = list(
                               "默认" = "plain",
                               "粗体" = "bold",
                               "斜体" = "italic",
                               "粗斜体" = "bold.italic"
                             )
                           ),
                           radioButtons(
                             "t1",
                             label = h4("字体样式"),
                             choices = list("sans", "serif", "mono", "wqy-microhei" , "STKaiti", "simhei")
                           ),
                           sliderInput(
                             "slider4",
                             label = "横坐标字体大小",
                             min = 5,
                             max = 40,
                             value = 15
                           )
                         ),
                         conditionalPanel(
                           condition = "input.select1 == '3'",
                           radioButtons(
                             "fx1",
                             label = h4("字体粗斜"),
                             choices = list(
                               "默认" = "plain",
                               "粗体" = "bold",
                               "斜体" = "italic",
                               "粗斜体" = "bold.italic"
                             )
                           ),
                           radioButtons(
                             "tx1",
                             label = h4("字体样式"),
                             choices = list("sans", "serif", "mono", "wqy-microhei" , "STKaiti", "simhei")
                           ),
                           sliderInput(
                             "sliderx1",
                             label = "纵坐标字体大小",
                             min = 5,
                             max = 40,
                             value = 15
                           )
                         ),
                         conditionalPanel(
                           condition = "input.select1 == '4'",
                           radioButtons(
                             "f4",
                             label = h4("字体粗斜"),
                             choices = list(
                               "默认" = "plain",
                               "粗体" = "bold",
                               "斜体" = "italic",
                               "粗斜体" = "bold.italic"
                             )
                           ),
                           radioButtons(
                             "t4",
                             label = h4("字体样式"),
                             choices = list("sans", "serif", "mono", "wqy-microhei" , "STKaiti", "simhei")
                           ),
                           sliderInput(
                             "slider5",
                             label = "横坐标标题字体大小",
                             min = 1,
                             max = 40,
                             value = 20
                           )
                         ),
                         conditionalPanel(
                           condition = "input.select1 == '5'",
                           radioButtons(
                             "f3",
                             label = h4("字体粗斜"),
                             choices = list(
                               "默认" = "plain",
                               "粗体" = "bold",
                               "斜体" = "italic",
                               "粗斜体" = "bold.italic"
                             )
                           ),
                           radioButtons(
                             "t3",
                             label = h4("字体样式"),
                             choices = list("sans", "serif", "mono", "wqy-microhei" , "STKaiti", "simhei")
                           ),
                           sliderInput(
                             "slider3",
                             label = "纵坐标标题字体大小",
                             min = 1,
                             max = 40,
                             value = 20
                           )
                         ),
                       ),
                       h4("图片下载"),
                       numericInput("h", "图形高度", value = "800"),
                       numericInput("w", "图形宽度", value = "900"),
                       actionButton("action",
                                    label = "运行")
                     ),
                     mainPanel(
                       downloadButton("downloadpdf", "PDF 下载"),
                       downloadButton("downloadsvg", "SVG 下载"),
                       plotOutput("p1")
                     )
                   )
                 ),
                 tabPanel("Help", includeMarkdown("README.md")))