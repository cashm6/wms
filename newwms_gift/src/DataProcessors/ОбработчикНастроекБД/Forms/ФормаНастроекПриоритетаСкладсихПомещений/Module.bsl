

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Значение=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилищаПоСвойствам("СкладскиеПомещенияПриоритет");
	Если ТипЗнч(Значение)=Тип("Структура") тогда
		Если Значение.Свойство("СкладскиеПомещенияПриоритет")Тогда 
			СкладскиеПомещенияПриоритет.Загрузить(Значение.СкладскиеПомещенияПриоритет);
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	ЗаписатьИЗакрытьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаписатьИЗакрытьНаСервере()
СтруктураХраненияДанных=новый Структура;
СтруктураХраненияДанных.Вставить("СкладскиеПомещенияПриоритет",СкладскиеПомещенияПриоритет.Выгрузить());
итWMSПривилегированныйМодуль.СохранитьНастройкиВХранилище(СтруктураХраненияДанных);
КонецПроцедуры

