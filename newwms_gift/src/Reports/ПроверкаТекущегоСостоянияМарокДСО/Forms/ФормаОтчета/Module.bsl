
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СкомпоноватьРезультат();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("ДокументОснование") Тогда 
		Отчет.ДокументОснование= Параметры.ДокументОснование;
	КонецЕсли;	
КонецПроцедуры
