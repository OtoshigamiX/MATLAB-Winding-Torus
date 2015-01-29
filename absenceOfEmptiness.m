%przyjmuje kolumne danych
function out=absenceOfEmptiness(data,dataname)
if isnumeric(data(1))
    count=0;
    sum=0;
    nancount=0;
    nanindexes=[];
    for i=1:length(data)
        if isnan(data(i))
            nancount=nancount+1;
            nanindexes(nancount)=i;
        else
            count=count+1;
            sum=data(i)+sum;
        end
    end
    if nancount~=0
        msg=['Wykryto ' num2str(nancount) ' pustych rekordow w ' dataname '. Co chcesz zrobic?'];
        choice=questdlg(msg,'Faza 1', 'Stala', 'Srednia', 'Wartosc losowa', 'Wartosc losowa');
        switch choice
            case 'Stala'
                answer=inputdlg({'Podaj stala: '},'Stala',1,{'0'});
                filler=str2num(answer{1});
                for i=1:nancount;
                    data(nanindexes(i))=filler;
                end
            case 'Srednia'
                filler=sum/count;
                for i=1:nancount
                    data(nanindexes(i))=filler;
                end
            case 'Wartosc losowa'
                prompt=[{'Podaj zakres:'} {''}];
                answer=inputdlg(prompt,'Zakres losowania',[1 1]',[{'0'} {'1'}]);
                a=str2num(answer{1}); b=str2num(answer{2});
                for i=1:nancount
                   data(nanindexes(i))=(b-a)*rand+a;%ew. randi([a b])
                end
        end
    end
elseif ischar(data(1))
    nancount=0;
    nanindexes=[];
    for i=1:length(data)
        if isempty(data(i))
            nancount=nancount+1;
            nanindexes(nancount)=i;
        end
    end
    if nancount~=0
        msg=['Wykryto ' num2str(nancount) ' pustych rekordow w ' dataname '. Co chcesz zrobic?'];
        choice=questdlg(msg,'Faza 1','Stala','Stala');
        for i=1:nancount
            data(nanindexes(i))=choice;
        end
    end
end
out=data;