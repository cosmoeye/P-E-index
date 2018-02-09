library(readxl)
tv <- read_excel("tv_data.xlsx")

summary(tv)

(m <- lm(score ~ brand + width + quality + pannel, data = tv))
## 리뷰별점을 종속변수로 브랜드, 화면크기, 화질, 패널의종류 의 독립변수로 하여 multiple linear regression을 함 ##
summary(m)
## brand와 pannelOLED에서 유의미한 p-value가 나옴 ##

(m1 <- lm(score ~ brand + pannel,data=tv))
summary(m1)
(m2 <- lm(score ~ brand,data=tv))
summary(m2)
## brand와 pannel 만을 독립변수로 하여 다시 모델을 구성함 but 모델자체의 R^2가 워낙 낮아 유의미한 상관관계를 찾기는 힘듦##


## 역으로 높은 별점을 받은 상품과 낮은 별점을 받은 상품들을 분리하여 dataset을 구성한 뒤 둘 사이의 차이점을 알아봄 ##
library("dplyr")

highscore <- filter(tv,score>=4)
lowscore <- filter(tv,score<3)

summary(highscore)
summary(lowscore)

## 구매후기수에서 유의미한 차이가 있음을 발견하고 이를 변수로 추가하여 다시 모델링##
(m3 <- lm(score ~ brand + review + pannel,data=tv ))
summary(m3)
(m4 <- lm(score ~ brand + review + width + pannel + quality,data=tv))
summary(m4)
(m5 <- lm(score ~ brand + review + pannel, data=tv))
summary(m5)

## stepwise selection 을 이용하여 AIC가 최소가 되는 최적 모델링 도출 ##
install.packages("mlbench")
library(mlbench)
model <- lm(score ~., data = tv)
model2 <- step(model, direction = "both")