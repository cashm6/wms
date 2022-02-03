
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Значение= итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилищаПоСвойствам("НастройкиЗаполненияРасстоянияМеждуЯчейками");	
	Если ТипЗнч(Значение)=Тип("Структура") тогда
		ДанныеОбхода=Значение.НастройкиЗаполненияРасстоянияМеждуЯчейками;
		Если ТипЗнч(ДанныеОбхода)=Тип("Структура") тогда		
			СписокРеквизитов=ПолучитьРеквизиты();
			для Каждого Рекв из СписокРеквизитов цикл		
				Если ДанныеОбхода.Свойство(Рекв.Имя) тогда
					Если ТипЗнч(ДанныеОбхода[Рекв.Имя])=тип("ТаблицаЗначений") тогда
						ЭтаФорма[Рекв.Имя].Загрузить(ДанныеОбхода[Рекв.Имя]);
					иначе
						ЭтаФорма[Рекв.Имя]=ДанныеОбхода[Рекв.Имя];
					КонецЕсли;
				КонецЕсли;	
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;	
	СтатусРегламетногоЗадания();
  
КонецПроцедуры
&НаСервере
Процедура СтатусРегламетногоЗадания()
	Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_РассчетРасстоянияМеждуЯчейками");
	Если Задание.Использование Тогда 
		Элементы.ХелперСтатусаРаботыЗадания.Заголовок="Регламетное задание запущено";
		Элементы.ХелперСтатусаРаботыЗадания.ЦветТекста=WebЦвета.Зеленый;
	иначе
		Элементы.ХелперСтатусаРаботыЗадания.Заголовок="Регламетное задание выключено";
		Элементы.ХелперСтатусаРаботыЗадания.ЦветТекста=WebЦвета.Красный;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СохранитьНаСервере()
	СписокРеквизитов=ПолучитьРеквизиты();
	Значение=ХранилищеОбщихНастроек.Загрузить("ЗаполнитьРасстоянияМеждуЯчейками","ЗаполнитьРасстоянияМеждуЯчейками",,"ЗаполнитьРасстоянияМеждуЯчейками");
	Если  ТипЗнч(Значение)=Тип("Структура") Тогда 
		СтруктураХраненияДанных=Значение;
	иначе
		СтруктураХраненияДанных=новый Структура;
	КонецЕсли;
	для Каждого Рекв из СписокРеквизитов цикл
		Если Рекв.Имя="Объект" тогда
			Продолжить;
		КонецЕсли;	
		Если ТипЗнч(ЭтаФорма[Рекв.Имя])=Тип("ДанныеФормыКоллекция") тогда
			СтруктураХраненияДанных.Вставить(Рекв.Имя,ЭтаФорма[Рекв.Имя].Выгрузить());
		иначе
			СтруктураХраненияДанных.Вставить(Рекв.Имя,ЭтаФорма[Рекв.Имя]);
		КонецЕсли;
	КонецЦикла;
	итWMSПривилегированныйМодуль.СохранитьНастройкиВХранилище(новый Структура("НастройкиЗаполненияРасстоянияМеждуЯчейками",СтруктураХраненияДанных));
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗапуститьНаСервере()
Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_РассчетРасстоянияМеждуЯчейками");
Расписание=новый РасписаниеРегламентногоЗадания;
Расписание.ПериодПовтораВТечениеДня=Периодичность;
Расписание.ПериодПовтораДней=1;
Задание.Расписание=Расписание;
Задание.Использование=Истина;
Задание.Записать();
СтатусРегламетногоЗадания();
КонецПроцедуры

&НаКлиенте
Процедура Запустить(Команда)
	ЗапуститьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОстановитьНаСервере()
Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_РассчетРасстоянияМеждуЯчейками");
Задание.Использование=Ложь;
Задание.Записать();
СтатусРегламетногоЗадания();
КонецПроцедуры

&НаКлиенте
Процедура Остановить(Команда)
	ОстановитьНаСервере();
КонецПроцедуры
&НаКлиенте
Процедура ОчиститьСохраненияПредыдущихСессийОповещение(Результат,Параметры) Экспорт 
	Если Результат=КодВозвратаДиалога.Нет Тогда 
		Возврат
	КонецЕсли;	
	ОчиститьСохраненияВыполненныхДанных();
	КонецПроцедуры
&НаСервере	
Процедура ОчиститьСохраненияВыполненныхДанных()
Значение=ХранилищеОбщихНастроек.Загрузить("ЗаполнитьРасстоянияМеждуЯчейками","ЗаполнитьРасстоянияМеждуЯчейками",,"ЗаполнитьРасстоянияМеждуЯчейками");
Если Значение.Свойство("МассивВыполненныхЯчеек") Тогда 
	Значение.МассивВыполненныхЯчеек=новый Массив;
КонецЕсли;
Если Значение.Свойство("МассивЯчеекВОбработке") Тогда
	Значение.МассивЯчеекВОбработке=новый Массив;
КонецЕсли;
ХранилищеОбщихНастроек.Сохранить("ЗаполнитьРасстоянияМеждуЯчейками","ЗаполнитьРасстоянияМеждуЯчейками",Значение,,"ЗаполнитьРасстоянияМеждуЯчейками");
		КонецПроцедуры
&НаКлиенте
Процедура ОчиститьСохраненияПредыдущихСессий(Команда)
	Оповещение=новый ОписаниеОповещения("ОчиститьСохраненияПредыдущихСессийОповещение",ЭтаФорма);
	ПоказатьВопрос(Оповещение,"Данная команда отвечает за удаление данных о выполненных действиях,после очистки всех сохранений, 
	|программа начет заного рассчитывать расстояния от каждой до каждой ячейки. Вы точно хотите очистить сохранения?",РежимДиалогаВопрос.ДаНет);
КонецПроцедуры
