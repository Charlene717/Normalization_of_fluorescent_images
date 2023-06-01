## 讀取圖像： 有幾種方式可以在R中讀取影像檔案。一種常用的方式是使用 EBImage 套件，該套件提供了讀取和操作圖像的工具。

install.packages("BiocManager")
BiocManager::install("EBImage")
library(EBImage)
img <- readImage("your_image_file")


## 選取背景區域： 選擇圖像上無細胞的地方並抓取螢光值可以手動進行，或者如果能夠確定這些區域的大概位置和大小，也可以用程式自動選取。
## 手動抓點
display(img)

# Replace x, y, width, height with your coordinates
subimg <- img[y:(y+height), x:(x+width)]
background_value <- mean(subimg)



## 計算背景螢光平均值： 您可以將所有選取的背景區域的螢光值取平均，得到一個代表性的背景螢光值。
average_background <- mean(background_values)


## 進行標準化： 在得到平均背景螢光值後，您可以使用它來對您的螢光圖像進行標準化。
img_normalized = img - average_background
