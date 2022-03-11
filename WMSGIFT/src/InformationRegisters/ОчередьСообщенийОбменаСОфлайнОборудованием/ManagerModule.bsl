#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

// Добавить пакет с ошибкой в очередь
//
// Параметры:
//  ОфлайнОборудование - СправочникСсылка.ОфлайнОборудование
//  ИдентификаторПередачи - Неопределено, Произвольный
//  ТекстОшибки - Строка
//
Процедура ДобавитьПакетОшибкуДанныхВОчередь(ОфлайнОборудование, ИдентификаторПередачи, ТекстОшибки) Экспорт
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных();
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ОфлайнОборудование",ОфлайнОборудование);
		ЭлементБлокировки.УстановитьЗначение("ИдентификаторПередачи",ИдентификаторПередачи);
		Блокировка.Заблокировать();
	
		НаборЗаписей = РегистрыСведений.ОчередьСообщенийОбменаСОфлайнОборудованием.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ОфлайнОборудование.Установить(ОфлайнОборудование);
		НаборЗаписей.Отбор.ИдентификаторПередачи.Установить(ИдентификаторПередачи);
		НаборЗаписей.Прочитать();
		
		НоваяЗапись 						= НаборЗаписей.Добавить();
		НоваяЗапись.ОфлайнОборудование 		= ОфлайнОборудование;
		НоваяЗапись.ИдентификаторПередачи 	= ИдентификаторПередачи;
		НоваяЗапись.Ошибка 					= Истина;
		НоваяЗапись.ОписаниеОшибки 			= ТекстОшибки;
		
		НаборЗаписей.Записать(Истина);
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		ОтменитьТранзакцию();
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Добавление пакета ошибки данных в очередь'", ОбщегоНазначения.КодОсновногоЯзыка()), 
			УровеньЖурналаРегистрации.Ошибка,,, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
КонецПроцедуры

// Добавить пакет данных в очередь
//
// Параметры:
//  ОфлайнОборудование - СправочникСсылка.ОфлайнОборудование
//  ИдентификаторПередачи - Неопределено, Произвольный
//  ТекстСообщения - Строка
//  ПорядковыйНомер - Число
//  ПакетовВсего - Число
//
Процедура ДобавитьПакетДанныхВОчередь(ОфлайнОборудование, ИдентификаторПередачи, ТекстСообщения, ПорядковыйНомер = 1, ПакетовВсего = 1) Экспорт
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных();
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ОфлайнОборудование", ОфлайнОборудование);
		ЭлементБлокировки.УстановитьЗначение("ИдентификаторПередачи", ИдентификаторПередачи);
		ЭлементБлокировки.УстановитьЗначение("ПорядковыйНомер", ПорядковыйНомер);
		Блокировка.Заблокировать();
	
		НаборЗаписей = РегистрыСведений.ОчередьСообщенийОбменаСОфлайнОборудованием.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ОфлайнОборудование.Установить(ОфлайнОборудование);
		НаборЗаписей.Отбор.ИдентификаторПередачи.Установить(ИдентификаторПередачи);
		НаборЗаписей.Отбор.ПорядковыйНомер.Установить(ПорядковыйНомер);
		НаборЗаписей.Прочитать();
		
		// Если сообщение с таким номером уже есть в очереди, генерируем исключение.
		Если НаборЗаписей.Количество() = 0 Тогда
			
			НоваяЗапись 						= НаборЗаписей.Добавить();
			НоваяЗапись.ОфлайнОборудование 		= ОфлайнОборудование;
			НоваяЗапись.ИдентификаторПередачи 	= ИдентификаторПередачи;
			НоваяЗапись.ПорядковыйНомер 		= ПорядковыйНомер;
			НоваяЗапись.ДанныеПакета 			= Новый ХранилищеЗначения(ТекстСообщения, Новый СжатиеДанных(9));
			НоваяЗапись.ПакетовВсего 			= ПакетовВсего;
			
			НаборЗаписей.Записать(Истина);
			
			ОшибкаЗаписи = Ложь;
		Иначе
			
			ОшибкаЗаписи = Истина;
			
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		
		ОтменитьТранзакцию();
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Добавление пакета данных в очередь.'", ОбщегоНазначения.КодОсновногоЯзыка()), 
			УровеньЖурналаРегистрации.Ошибка,,, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
	Если ОшибкаЗаписи Тогда
		ВызватьИсключение(НСтр("ru='Не удалось выполнить отправку данных. Очередь сообщений обмена уже содержит сообщение с номером" + " " + Строка(ПорядковыйНомер) + ".'"));
	КонецЕсли;
	
КонецПроцедуры

// Очищает очередь сообщений
//
// Параметры:
//  ОфлайнОборудование - СправочникСсылка.ОфлайнОборудование
//
Процедура ОчиститьОчередьСообщений(ОфлайнОборудование) Экспорт
	
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных();
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ОфлайнОборудование", ОфлайнОборудование);
		Блокировка.Заблокировать();
	
		НаборЗаписей = РегистрыСведений.ОчередьСообщенийОбменаСОфлайнОборудованием.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ОфлайнОборудование.Установить(ОфлайнОборудование);
		НаборЗаписей.Прочитать();
		НаборЗаписей.Очистить();
		
		НаборЗаписей.Записать(Истина);

		ЗафиксироватьТранзакцию();
	Исключение
		
		ОтменитьТранзакцию();
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Очистка очереди сообщений.'", ОбщегоНазначения.КодОсновногоЯзыка()), 
			УровеньЖурналаРегистрации.Ошибка,,, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
КонецПроцедуры

// Получить неотправленный идентификатор.
// 
// Параметры:
//  ОфлайнОборудование - СправочникСсылка.ОфлайнОборудование - Офлайн-оборудование
// 
// Возвращаемое значение:
//  Неопределено, Произвольный - Получить неотправленный идентификатор
//
Функция ПолучитьНеотправленныйИдентификатор(ОфлайнОборудование) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ОчередьСообщенийОбменаСОфлайнОборудованием.ИдентификаторПередачи КАК ИдентификаторПередачи
		|ИЗ
		|	РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием КАК ОчередьСообщенийОбменаСОфлайнОборудованием
		|ГДЕ
		|	ОчередьСообщенийОбменаСОфлайнОборудованием.ОфлайнОборудование = &ОфлайнОборудование
		|	И НЕ ОчередьСообщенийОбменаСОфлайнОборудованием.Отправлен
		|	И НЕ ОчередьСообщенийОбменаСОфлайнОборудованием.Ошибка";
	
	Запрос.УстановитьПараметр("ОфлайнОборудование", ОфлайнОборудование);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.ИдентификаторПередачи;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

// Получить сообщение из очереди.
// 
// Параметры:
//  ОфлайнОборудование - СправочникСсылка.ОфлайнОборудование - Офлайн-оборудование
//  ИдентификаторПередачи - УникальныйИдентификатор - Идентификатор передачи
//  Рестарт - Булево - Рестарт
// 
// Возвращаемое значение:
//  Структура:
//   * ОфлайнОборудование - Произвольный -
//   * ИдентификаторПередачи - Произвольный -
//   * ПорядковыйНомер - Произвольный -
//   * ДанныеПакета - Произвольный -
//   * ПакетовВсего - Произвольный -
//   * Ошибка - Произвольный -
//   * ОписаниеОшибки - Произвольный -
//
Функция ПолучитьСообщениеИзОчереди(ОфлайнОборудование, ИдентификаторПередачи, Рестарт) Экспорт
	
	Если Рестарт Тогда
		СброситьФлагОтправкиВОчередиОбмена(ОфлайнОборудование, ИдентификаторПередачи);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ОфлайнОборудование КАК ОфлайнОборудование,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ИдентификаторПередачи КАК ИдентификаторПередачи,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ПорядковыйНомер КАК ПорядковыйНомер,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ДанныеПакета КАК ДанныеПакета,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ПакетовВсего КАК ПакетовВсего,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.Ошибка КАК Ошибка,
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ОписаниеОшибки КАК ОписаниеОшибки
	|ИЗ
	|	РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием КАК ОчередьСообщенийОбменаСОфлайнОборудованием
	|ГДЕ
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ОфлайнОборудование = &ОфлайнОборудование
	|	И НЕ ОчередьСообщенийОбменаСОфлайнОборудованием.Отправлен
	|	И ОчередьСообщенийОбменаСОфлайнОборудованием.ИдентификаторПередачи = &ИдентификаторПередачи
	|
	|УПОРЯДОЧИТЬ ПО
	|	ОчередьСообщенийОбменаСОфлайнОборудованием.ПорядковыйНомер";
	
	Запрос.УстановитьПараметр("ОфлайнОборудование",    ОфлайнОборудование);
	Запрос.УстановитьПараметр("ИдентификаторПередачи", ИдентификаторПередачи);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		СтруктураПакета = Новый Структура;
		СтруктураПакета.Вставить("ОфлайнОборудование", 		Выборка.ОфлайнОборудование);
		СтруктураПакета.Вставить("ИдентификаторПередачи", 	Выборка.ИдентификаторПередачи);
		СтруктураПакета.Вставить("ПорядковыйНомер", 		Выборка.ПорядковыйНомер);
		СтруктураПакета.Вставить("ДанныеПакета", 			Выборка.ДанныеПакета);
		СтруктураПакета.Вставить("ПакетовВсего", 			Выборка.ПакетовВсего);
		СтруктураПакета.Вставить("Ошибка", 					Выборка.Ошибка);
		СтруктураПакета.Вставить("ОписаниеОшибки", 			Выборка.ОписаниеОшибки);
		
		Возврат СтруктураПакета;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// СтандартныеПодсистемы.УправлениеДоступом
// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
//
// Параметры:
//  Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Менеджер = "РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием";
	МенеджерОборудованияВызовСервераПереопределяемый.ПриЗаполненииОграниченияДоступа(Менеджер, Ограничение);
	
КонецПроцедуры
// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СброситьФлагОтправкиВОчередиОбмена(ОфлайнОборудование, ИдентификаторПередачи)
	
	НачатьТранзакцию();
	Попытка
		
		Блокировка = Новый БлокировкаДанных();
		ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.ОчередьСообщенийОбменаСОфлайнОборудованием");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ОфлайнОборудование",ОфлайнОборудование);
		ЭлементБлокировки.УстановитьЗначение("ИдентификаторПередачи",ИдентификаторПередачи);
		Блокировка.Заблокировать();
	
		НаборЗаписей = РегистрыСведений.ОчередьСообщенийОбменаСОфлайнОборудованием.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ОфлайнОборудование.Установить(ОфлайнОборудование);
		НаборЗаписей.Отбор.ИдентификаторПередачи.Установить(ИдентификаторПередачи);
		НаборЗаписей.Прочитать();
		
		Для Каждого Запись Из НаборЗаписей Цикл
			Запись.Отправлен = Ложь;
		КонецЦикла;
		
		НаборЗаписей.Записать(Истина);
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Сброс флага отправки в очереди обмена'", ОбщегоНазначения.КодОсновногоЯзыка()), 
			УровеньЖурналаРегистрации.Ошибка,,, КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
		
КонецПроцедуры

#КонецОбласти


#КонецЕсли
