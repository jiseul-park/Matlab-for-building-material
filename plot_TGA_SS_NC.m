% 디렉토리에 있는 모든 txt 파일 목록 가져오기
files = dir('*.txt');

% 데이터를 샘플별로 그룹화하기 위한 구조체
data_by_sample = struct();

% 각 파일에 대해 루프 실행
for file = files'
    % 파일 열기
    fileID = fopen(file.name);

    % 파일 이름에서 '샘플명-양생일' 정보 추출
    file_info = split(file.name, '.'); % 파일 확장자 제거
    file_info = split(file_info{1}, '-'); % 샘플명과 양생일 분리
    sample_name = file_info{1};
    date_str = file_info{2};
    
    % 헤더 라인들을 건너뛰기 위해 파일을 라인 단위로 읽어들이는 반복문 설정
    tline = fgetl(fileID);
    while ischar(tline)
        % 만약 tline이 "min"으로 시작하면 헤더 라인을 읽은 것이므로 반복문 종료
        if startsWith(tline, 'min')
            break;
        end
        tline = fgetl(fileID);
    end

    % 데이터 읽기
    data = textscan(fileID, '%f %f %f %f %f %*[^\n]', 'Delimiter', '\t');

    % 파일 닫기
    fclose(fileID);

    % Time, Temperature, %Weight, Deriv. Weight 데이터 추출
    time = data{1};
    temperature = data{2};
    weight = data{4};
    deriv_weight = data{5};
    
    % 데이터를 구조체에 저장
    if isfield(data_by_sample, sample_name)
        data_by_sample.(sample_name)(end+1) = struct('date', date_str, 'temperature', temperature, 'weight', weight, 'deriv_weight', deriv_weight);
    else
        data_by_sample.(sample_name) = struct('date', date_str, 'temperature', temperature, 'weight', weight, 'deriv_weight', deriv_weight);
    end
end

% 원하는 날짜 순서 지정
date_order = {'1d', '3d', '7d', '14d', '28d'}; % -------------------------- 수정 필요

% 샘플별로 그룹화된 데이터를 plot
samples = fieldnames(data_by_sample);
for i = 1:numel(samples)
    sample_name = samples{i};
    data_group = data_by_sample.(sample_name);
    
    % 데이터를 원하는 순서대로 정렬
    [~, sort_order] = ismember(date_order, {data_group.date});
    data_group = data_group(sort_order);
    
    figure;
    for j = 1:numel(data_group)
        data_entry = data_group(j);
        
        % Temperature와 %Weight plot
        subplot(2, 1, 1);
        hold on;
        plot(data_entry.temperature, data_entry.weight);
        title([sample_name, ', %Weight']);
        xlabel('Temperature (°C)');
        ylabel('%Weight');
        ylim([92 100])
        
        % Temperature와 Deriv. Weight plot
        subplot(2, 1, 2);
        hold on;
        plot(data_entry.temperature, data_entry.deriv_weight);
        title([sample_name, ', Deriv. Weight']);
        xlabel('Temperature (°C)');
        ylabel('Deriv. Weight (% / °C)');
        ylim([-0.06 0])
    end
    legend(date_order);
    saveas(gcf, [sample_name, '.png']);
end