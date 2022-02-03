
&НаКлиенте
Процедура НастройкаЗаданияПолученияДанныхТранзита(Команда)
	ОткрытьФорму("ОбщаяФорма.УнивирсальнаяФормаНастройкаЗапускаЗадания",новый Структура("ИмяПредопределенногоЗадания","ИтWMSПолучениеДанныхТранзита"),ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаЗаданияЗаписиДанныхТранзита(Команда)
	ОткрытьФорму("ОбщаяФорма.УнивирсальнаяФормаНастройкаЗапускаЗадания",новый Структура("ИмяПредопределенногоЗадания","итWMSЗаписьДанныхТранзита"),ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЗаданияАнализаТоваровВПути(Команда)
	ОткрытьФорму("ОбщаяФорма.УнивирсальнаяФормаНастройкаЗапускаЗадания",новый Структура("ИмяПредопределенногоЗадания","ит_WMS_АнализТоваровВПути"),ЭтаФорма);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Значение=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилища();
	Если ТипЗнч(Значение)=Тип("Структура") тогда
		СписокРеквизитов=ПолучитьРеквизиты();
		для Каждого Рекв из СписокРеквизитов цикл
				
			Если Значение.Свойство(Рекв.Имя) тогда
				Если ТипЗнч(Значение[Рекв.Имя])=тип("ТаблицаЗначений") тогда
					ЭтаФорма[Рекв.Имя].Загрузить(Значение[Рекв.Имя]);
				иначе
					ЭтаФорма[Рекв.Имя]=Значение[Рекв.Имя];
				КонецЕсли;
			КонецЕсли;	
		КонецЦикла;
	КонецЕсли;	
КонецПроцедуры

&НаСервере
Процедура СохранитьНаСервере()
	СписокРеквизитов=ПолучитьРеквизиты();
	СтруктураХраненияДанных=новый Структура;
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
	итWMSПривилегированныйМодуль.СохранитьНастройкиВХранилище(СтруктураХраненияДанных);
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

