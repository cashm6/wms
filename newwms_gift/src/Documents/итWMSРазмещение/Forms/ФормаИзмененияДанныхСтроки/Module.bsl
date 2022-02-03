
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если не Параметры.Свойство("СписокСтрок") тогда
		Возврат
	КонецЕсли;
	//ЗаполнитьЗначенияСвойств(ЭтаФорма,Параметры);
	ИдентификаторУпаковки=Параметры.ИдентификаторУпаковки;
	ИдЗадачи=Параметры.ИдЗадачи;
	Комментарий=Параметры.Комментарий;
	Склад=Параметры.Склад;
	ЯчейкаОтправитель=Параметры.ЯчейкаОтправитель;
	ЯчейкаПолучатель=Параметры.ЯчейкаПолучатель;
	для Каждого стр из Параметры.СписокСтрок цикл
		СписокСтрок.Добавить(стр.Значение);
	КонецЦикла;		
КонецПроцедуры

&НаКлиенте
Процедура Отменить(Команда)
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура Завершить(Команда)
	ОповеститьОВыборе(новый Структура("ИдЗадачи,ЯчейкаПолучатель,Склад,СписокСтрок",ИдЗадачи,ЯчейкаПолучатель,Склад,СписокСтрок));
КонецПроцедуры
