
#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОперацияЗавершение(РезультатВыполнения, Параметры) Экспорт
	
	Доступность = Истина;
	
	ТекстСообщения = ?(РезультатВыполнения.Результат, НСтр("ru='Операция успешно завершена.'"), РезультатВыполнения.ОписаниеОшибки);
	ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСмену(Команда)
	
	ВыполнитьОперацию("ОткрытьСмену");
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьСмену(Команда)
	
	ВыполнитьОперацию("ЗакрытьСмену");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчетОТекущемСостоянииРасчетов(Команда)
	
	ВыполнитьОперацию("ОтчетОТекущемСостоянииРасчетов");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчетБезГашения(Команда)
	
	ВыполнитьОперацию("ОтчетБезГашения");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОперацию(Команда)
	
	ОчиститьСообщения();
	
	ПоддерживаемыеТипыВО = Новый Массив();
	ПоддерживаемыеТипыВО.Добавить("ФискальныйРегистратор");
	ПоддерживаемыеТипыВО.Добавить("ПринтерЧеков");
	ПоддерживаемыеТипыВО.Добавить("ККТ");
	
	ДополнительныеПараметры = Новый Структура("Команда", Команда);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыполнитьОперациюВыбораУстройства", ЭтотОбъект, ДополнительныеПараметры);
	МенеджерОборудованияКлиент.ВыбратьУстройство(ОписаниеОповещения, ПоддерживаемыеТипыВО,
		НСтр("ru='Выберите фискальное устройство'"), 
		НСтр("ru='Фискальное устройство не подключено.'"), 
		НСтр("ru='Фискальное устройство не выбрано.'"));

КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОперациюВыбораУстройства(РезультатВыбора, ДополнительныеПараметры) Экспорт
	
	Если НЕ РезультатВыбора.Результат Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(РезультатВыбора.ОписаниеОшибки);      
		Возврат;
	КонецЕсли;
	
	ОчиститьСообщения();
	Доступность = Ложь;
	
	ПараметрыОперации = ОборудованиеЧекопечатающиеУстройстваКлиентСервер.ПараметрыОткрытияЗакрытияСмены();
	Кассир = "";
	
	СтандартнаяОбработка = Истина;
	МенеджерОборудованияКлиентСерверПереопределяемый.ОбработкаЗаполненияИмяКассира(Кассир, СтандартнаяОбработка); 
	ПараметрыОперации.Кассир = ?(Не СтандартнаяОбработка, Кассир, НСтр("ru='Администратор'")); 
	ОповещениеПриЗавершении = Новый ОписаниеОповещения("ОперацияЗавершение", ЭтотОбъект);
	
	Если ДополнительныеПараметры.Команда = "ОткрытьСмену" Тогда
		ОборудованиеЧекопечатающиеУстройстваКлиент.НачатьОткрытиеСменыНаФискальномУстройстве(ОповещениеПриЗавершении, 
			УникальныйИдентификатор, РезультатВыбора.ИдентификаторУстройства, ПараметрыОперации);
	ИначеЕсли ДополнительныеПараметры.Команда = "ЗакрытьСмену" Тогда
		ОборудованиеЧекопечатающиеУстройстваКлиент.НачатьЗакрытиеСменыНаФискальномУстройстве(ОповещениеПриЗавершении, 
			УникальныйИдентификатор, РезультатВыбора.ИдентификаторУстройства, ПараметрыОперации);
	ИначеЕсли ДополнительныеПараметры.Команда = "ОтчетОТекущемСостоянииРасчетов" Тогда
		ОборудованиеЧекопечатающиеУстройстваКлиент.НачатьФормированиеОтчетаОТекущемСостоянииРасчетов(ОповещениеПриЗавершении, 
			УникальныйИдентификатор, РезультатВыбора.ИдентификаторУстройства, ПараметрыОперации);
	ИначеЕсли ДополнительныеПараметры.Команда = "ОтчетБезГашения" Тогда
		ОборудованиеЧекопечатающиеУстройстваКлиент.НачатьФормированиеОтчетаБезГашения(ОповещениеПриЗавершении, 
			УникальныйИдентификатор, РезультатВыбора.ИдентификаторУстройства, ПараметрыОперации);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

