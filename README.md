# Readme for TGA Data Plotting
- [TG/DTG data read & plot (한국어)](#TG/DTG-data-read-&-plot-(한국어))
- [TG/DTG data read & plot (Eng)](#TG/DTG-data-read-&-plot-(Eng))

# TG/DTG data read & plot (한국어)

## 개요
- 이 코드는 열중량분석(TGA) 데이터를 포함하는 텍스트 파일을 읽고 샘플 이름을 기준으로 데이터를 플롯합니다.
- 각 샘플의 데이터는 온도 vs %무게, 그리고 온도 vs DTG 두 가지 플롯으로 나뉩니다. 
- 파일은 'SampleName-Date.txt' 형식의 이름을 가져야 합니다.

## 설명
1. 스크립트는 먼저 현재 디렉토리의 모든 .txt 파일 목록을 가져옵니다.
2. 각 파일에 대해 루프를 실행합니다:
- 파일 이름에서 샘플 이름과 날짜를 추출합니다.
- 'min'으로 시작하는 줄을 찾을 때까지 파일의 헤더 줄을 건너뜁니다.
- 파일의 나머지 부분에서 데이터를 읽습니다.
- 데이터를 샘플 이름별로 그룹화하여 구조체에 저장합니다.
3. 각 샘플에 대해 figure을 생성합니다:
- date_order 변수에서 지정한 날짜 순서에 따라 데이터를 정렬합니다.
- 각 날짜에 대해 온도 vs %무게와 온도 vs 도함수 무게를 플롯합니다.
- 지정된 순서에 따라 날짜를 보여주는 범례를 추가합니다.
- 그림을 샘플 이름으로 PNG 파일로 저장합니다.

## 스크립트 수정
- 범례의 날짜 순서는 date_order 변수를 변경하여 수정할 수 있습니다.
- 플롯의 y축 범위는 플로팅 섹션의 ylim에서 매개변수를 변경하여 조정할 수 있습니다.

## 요구 사항
- 이 스크립트는 MATLAB이 필요하며 입력 파일은 탭이 구분자인 .txt 확장자를 가져야 합니다.
- 각 데이터 행은 다섯 개의 열을 포함해야 합니다: 시간, 온도, 무게, %무게, 도함수 무게 순서입니다.
- 스크립트는 **'min'**으로 시작하는 행을 찾을 때까지 헤더 행을 건너뜁니다.


# TG/DTG data read & plot (Eng)

## Overview
- This script reads text files containing Thermogravimetric Analysis (TGA) data and plots the data based on sample names.
- Each sample's data is divided into two plots: temperature vs %weight, and temperature vs derivative weight, which are plotted in the same figure.
- The files are expected to have the naming convention **'SampleName-Date.txt'.**

## How it works
1. The script first retrieves a list of all .txt files in the current directory.
2. It then loops through each file:
- Extracts the sample name and date from the filename.
- Skips the header lines in the file until it reaches a line starting with 'min'.
- Reads the data from the rest of the file.
- Stores the data into a structure, grouped by sample name.
3. The script then creates a figure for each sample:
- Sorts the data by the order of dates specified in the date_order variable.
- Plots temperature vs %weight and temperature vs derivative weight for each date.
- Adds a legend showing the dates in the order specified.
- Saves the figure as a PNG file with the sample name.

## Modifying the script
- The order of dates in the legend can be modified by changing the date_order variable.
- The range of the y-axis in the plots can be adjusted by changing the parameters in ylim in the plotting sections.

## Requirements
- This script requires MATLAB and the input files should be in **.txt format** with a **tab** as delimiter. 
- Each row of data should contain **five columns**: time, temperature, weight, %weight, and derivative weight, in that order.
- The script skips the header rows until it finds a row starting with **'min'**.
