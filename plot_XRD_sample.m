% 파일 읽기
filename = '230717_XRD results.xlsx';  % 본인의 파일명으로 교체
[num, txt, raw] = xlsread(filename);

% x축 및 y축 데이터 추출
x_data = num(:, 1);
y_data = num(:, 2:end);

% 샘플 정보
samples = txt(1, 2:end);

% 샘플명과 양생일 분리
sample_parts = cellfun(@(x) split(x, '-'), samples, 'UniformOutput', false);

% 샘플명과 양생일 각각 추출
sample_names = cellfun(@(x) x{1}, sample_parts, 'UniformOutput', false);
sample_days = cellfun(@(x) x{2}, sample_parts, 'UniformOutput', false);

% 양생일 순서
day_order = {'1d', '3d', '7d', '14d', '28d'};

% 샘플 명을 기반으로 색상 지정
sample_types = unique(sample_names);  % 고유한 샘플 타입

% 컬러맵 지정 (각 샘플 타입별로)
colors = jet(length(day_order));

% offset 계산 (최대값의 1/2)
offset = max(y_data(:)) / 2;

% 각 샘플명에 대해 반복
for k = 1:length(sample_types)
    sample_type = sample_types{k};
    indices = find(contains(sample_names, sample_type));
figure;
    % 같은 샘플명의 데이터에 대해 양생일 순서대로 반복
    for i = 1:length(day_order)
        day_indices = find(contains(sample_days(indices), day_order{i}));
        
        if isempty(day_indices)
            continue;
        end
        
        % 색상의 명도를 변경하기 위해 인덱스 i를 사용
        % 명도가 낮아지도록 (length(day_order) - i + 1)을 사용
        color = colors(i,:) * ((length(day_order) - i + 1) / length(day_order));
        
        % offset 추가 (위에서 아래로 그리기 위해 순서 변경)
        y_plot = y_data(:, indices(day_indices)) + offset * (length(day_order) - i);
        
        % 플롯 그리기
        plot(x_data, y_plot, 'Color', color, 'DisplayName', [sample_type '-' day_order{i}]);
        hold on;
        xlim([5 22])
    end
    % legend 생성
legend('Location', 'eastoutside');
    hold off
    saveas(gcf, [sample_type '.fig']);  % .fig 파일로 저장
    saveas(gcf, [sample_type '.png']);  % .png 파일로 저장
    
    clf;  % 현재 그림을 지우고 새로운 그림을 생성함 (다음 그림을 그리기 전에 필요
end



