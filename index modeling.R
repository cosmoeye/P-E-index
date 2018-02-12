## index modeling ##
library(readxl)
tv <- read_excel("tv_data.xlsx")

## modeling의 편의상 pannel, quality data를 dummy variable로 변환(excel 함수 이용) ##
## pannel : LED = 0, QLED = 1, OLED = 2 (QLED는 아직 이슈가 많고 상용화가 덜 된점에서 OLED보다 낮은 점수를 배정) ##
## quality : HD = 0, FullHD = 1, UHD = 2 ##
## width : int(화면크기 / 10)

width_z <- scale(tv$width)
summary(width_z)
pannel_z <- scale(tv$pannel)
summary(pannel_z)
quality_z <- scale(tv$quality)
summary(quality_z)

E_index <- 0.4*quality_z + 0.4*pannel_z + 0.2*width_z
summary(E_index)

## Price data와 함께 시각화 ##
P_index <- tv$`기간내 최저가`
summary(P_index)
head(P_index)

plot(P_index,E_index,xlab="Price",ylab="Efficiency",main="P_E_analysis",col="red")
