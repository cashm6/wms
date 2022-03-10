
&НаСервере
Процедура СохранитьНаСервере()
	СписокРеквизитов=ПолучитьРеквизиты();
	Значение=ХранилищеОбщихНастроек.Загрузить("итWMSТоварыВпутиНастройки","итWMSТоварыВпутиНастройки",,"итWMSТоварыВпутиНастройки");
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
	ХранилищеОбщихНастроек.Сохранить("итWMSТоварыВпутиНастройки","итWMSТоварыВпутиНастройки",СтруктураХраненияДанных,,"итWMSТоварыВпутиНастройки");
КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		Значение=ХранилищеОбщихНастроек.Загрузить("итWMSТоварыВпутиНастройки","итWMSТоварыВпутиНастройки",,"итWMSТоварыВпутиНастройки");
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
		//ЗаполнитьЗначенияСвойств(ЭтаФорма,Значение);
	КонецЕсли;	
	 СтатусРегламетногоЗадания();

КонецПроцедуры
&НаСервере
Процедура СтатусРегламетногоЗадания()
	Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_АнализТоваровВПути");
	Если Задание.Использование Тогда 
		Элементы.ХелперСтатусаРаботыЗадания.Заголовок="Регламетное задание запущено";
		Элементы.ХелперСтатусаРаботыЗадания.ЦветТекста=WebЦвета.Зеленый;
	иначе
		Элементы.ХелперСтатусаРаботыЗадания.Заголовок="Регламетное задание выключено";
		Элементы.ХелперСтатусаРаботыЗадания.ЦветТекста=WebЦвета.Красный;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗапуститьНаСервере()
Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_АнализТоваровВПути");
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
	Задание=РегламентныеЗадания.НайтиПредопределенное("ит_WMS_АнализТоваровВПути");
	Задание.Использование=Ложь;
	Задание.Записать();
	СтатусРегламетногоЗадания();
КонецПроцедуры

&НаКлиенте
Процедура Остановить(Команда)
	ОстановитьНаСервере();
КонецПроцедуры
