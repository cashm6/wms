
&НаКлиенте
Процедура Выбрать(Команда)
	ОповеститьОВыборе(ВидСкладскойДеятельности);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ВидСкладскойДеятельности=Перечисления.ит_WMS_ВидыСкладскойДеятельности.Оптовая;
КонецПроцедуры
