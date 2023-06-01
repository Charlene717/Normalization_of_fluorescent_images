##### Presetting ######
rm(list = ls()) # Clean variable
memory.limit(150000)

## 讀取圖像： 有幾種方式可以在R中讀取影像檔案。一種常用的方式是使用 EBImage 套件，該套件提供了讀取和操作圖像的工具。
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!require("EBImage", quietly = TRUE)) BiocManager::install("EBImage")
library(EBImage)
img <- readImage("direct-if-3.jpg") # img <- readImage("your_image_file")
img<- channel(img, "gray") #灰階化
display(img)

## 選取背景區域： 選擇圖像上無細胞的地方並抓取螢光值可以手動進行，或者如果能夠確定這些區域的大概位置和大小，也可以用程式自動選取。
## 手動抓點


# 繪製影像
plot(1:dim(img)[2], type='n', xlab="", ylab="", xaxt='n', yaxt='n')
rasterImage(img, 1, 1, dim(img)[2], dim(img)[1])

# 使用locator函數選取區域
coordinates <- locator(n = 10, type="p")  # n是你要選取的點的數量，這裡選擇一個點
print(coordinates)  # 這將列印出點擊位置的座標



# 初始化一個空的向量來儲存背景螢光值
background_values <- c()

# 窗口大小，這將定義取值範圍的大小
window_size <- 5

for (i in 1:length(coordinates$x)) {
  x <- round(coordinates$x[i])
  y <- round(coordinates$y[i])

  # 確保窗口範圍不會超出圖像邊界
  x_range <- max(1, (x-window_size)):min(dim(img)[2], (x+window_size))
  y_range <- max(1, (y-window_size)):min(dim(img)[1], (y+window_size))

  # 抓取小範圍的區域並取平均
  subimg <- img[y_range, x_range]
  background_values <- c(background_values, mean(subimg))
}

# 計算背景螢光平均值
average_background <- mean(background_values)

# 進行標準化
img_normalized = img - average_background
display(img_normalized)
