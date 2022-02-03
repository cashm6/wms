////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и функции общего назначения:
// - для работы со списками в формах;
// - для работы с журналом регистрации;
// - для обработки действий пользователя в процессе редактирования
//   многострочного текста, например комментария в документах;
// - прочее.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОповещениеПользователя

// Формирует и выводит сообщение, которое может быть связано с элементом управления формы.
//
Процедура СообщитьПользователю(
	Знач ТекстСообщенияПользователю,
	Знач КлючДанных = Неопределено,
	Знач Поле = "",
	Знач ПутьКДанным = "",
	Отказ = Ложь) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщенияПользователю;
	Сообщение.Поле = Поле;
	
	Попытка
		Если НЕ ПустаяСтрока(ПутьКДанным) Тогда
			Сообщение.ПутьКДанным = ПутьКДанным;
		КонецЕсли;
	Исключение
	
	КонецПопытки;
	
	Сообщение.Сообщить();
	
	Отказ = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ЗапускВнешнихПриложений

////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции для работы с внешними приложениями.

// Открывает навигационную ссылку в программе, которая ассоциирована с протоколом навигационной ссылки.
//
// Допустимые протоколы: http, https, e1c, v8help, mailto, tel, skype.
//
// Для открытия проводника или файла в программе просмотра не следует формировать ссылку по протоколу file://
// - для открытия проводника см. ОткрытьПроводник.
// - для открытия файла по расширению см. ОткрытьФайлВПрограммеПросмотра.
//
// Параметры:
//  НавигационнаяСсылка - Строка - ссылка, которую требуется открыть.
//  Оповещение          - ОписаниеОповещения, Неопределено - оповещение о результате открытия.
//                            - если оповещение не задано - в случае ошибки будет показано предупреждение.
//      * ПриложениеЗапущено      - Булево    - Истина, если внешнее приложение не вызвало ошибок при открытии.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//
// Пример:
//  ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку("e1cib/navigationpoint/startpage"); // начальная страница.
//  ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку("v8help://1cv8/QueryLanguageFullTextSearchInData");
//  ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку("https://1c.ru");
//  ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку("mailto:help@1c.ru");
//  ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку("skype:echo123?call");
//
Процедура ОткрытьНавигационнуюСсылку(НавигационнаяСсылка, Знач Оповещение = Неопределено) Экспорт
	
	#Если ТолстыйКлиентОбычноеПриложение Тогда
		// Особенность платформы: ПерейтиПоНавигационнойСсылке не доступен в толстом клиенте обычного приложения.
		Оповещение = Новый ОписаниеОповещения;
		НачатьЗапускПриложения(Оповещение, НавигационнаяСсылка);
	#Иначе
		ПерейтиПоНавигационнойСсылке(НавигационнаяСсылка);
	#КонецЕсли

КонецПроцедуры

#КонецОбласти

#Область УсловныеВызовы

////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции для вызова необязательных подсистем.

// Возвращает Истина, если функциональная подсистема существует в конфигурации.
// Предназначена для реализации вызова необязательной подсистемы (условного вызова).
//
// Возвращаемое значение:
//  Булево - Истина, если существует.
//
Функция ПодсистемаСуществует(ПолноеИмяПодсистемы) Экспорт
	
	Возврат МенеджерОборудованияВызовСервера.ПодсистемаСуществует(ПолноеИмяПодсистемы);
	
КонецФункции

// Возвращает ссылку на общий модуль или модуль менеджера по имени.
//
// См. ОбщегоНазначения.ОбщийМодуль
//
// Параметры:
//  Имя - Строка - имя общего модуля.
//
// Возвращаемое значение:
//  ОбщийМодуль, МодульМенеджераОбъекта - общий модуль.
//
// Пример:
//	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОбновлениеКонфигурации") Тогда
//		МодульОбновлениеКонфигурации = ОбщегоНазначения.ОбщийМодуль("ОбновлениеКонфигурации");
//		МодульОбновлениеКонфигурации.<Имя метода>();
//	КонецЕсли;
//
//	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
//		МодульПолнотекстовыйПоискСервер = ОбщегоНазначения.ОбщийМодуль("ПолнотекстовыйПоискСервер");
//		МодульПолнотекстовыйПоискСервер.<Имя метода>();
//	КонецЕсли;
//
Функция ОбщийМодуль(Имя) Экспорт
	
	Модуль = Вычислить(Имя);
	
#Если Не ВебКлиент Тогда
	
	// В веб-клиенте не проверяется
	// т.к. при обращении к модулям с вызовом сервера типа такого модуля в веб-клиенте не существует.
	
	Если ТипЗнч(Модуль) <> Тип("ОбщийМодуль") Тогда
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Общий модуль ""%1"" не существует.'"), 
			Имя);
	КонецЕсли;
	
#КонецЕсли
	
	Возврат Модуль;
	
КонецФункции

#КонецОбласти

#Область ВнешниеКомпоненты

////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции для подключения и установки внешних компонент из макетов конфигурации.

// Возвращает структуру параметров для см. процедуру УстановитьКомпонентуИзМакета.
//
Функция ПараметрыУстановкиКомпоненты() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ТекстПояснения", "");
	
	Возврат Параметры;
	
КонецФункции

// Результат установки компоненты.
//
Функция РезультатУстановкиКомпоненты() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Установлено", Ложь);
	Результат.Вставить("ОписаниеОшибки", "");
	Возврат Результат;
	
КонецФункции

Процедура УстановитьКомпонентуИзМакетаЗавершение(ДополнительныеПараметры) Экспорт
	
	РезультатУстановки = РезультатУстановкиКомпоненты();
	РезультатУстановки.Установлено = Истина;
	
	Если  ДополнительныеПараметры.ОповещениеПриЗавершении <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеПриЗавершении, РезультатУстановки);
	КонецЕсли;
	
КонецПроцедуры

// Устанавливает компоненту, выполненную по технологии Native API и COM асинхронном режиме.
// Компонента должна храниться в макете конфигурации в виде ZIP-архива.
//
Процедура УстановитьКомпонентуИзМакета(Оповещение, ПолноеИмяМакета, ПараметрыУстановки = Неопределено) Экспорт
	
	Параметры = Новый Структура("ПолноеИмяМакета, ОповещениеПриЗавершении", ПолноеИмяМакета, Оповещение);
	Оповещение = Новый ОписаниеОповещения("УстановитьКомпонентуИзМакетаЗавершение", ЭтотОбъект, Параметры);
	
	НачатьУстановкуВнешнейКомпоненты(Оповещение, ПолноеИмяМакета);
	
КонецПроцедуры

// Возвращает структуру параметров для см. процедуру ПодключитьКомпонентуИзМакета.
//
Функция ПараметрыПодключенияКомпоненты() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Кэшировать", Истина);
	Параметры.Вставить("ПредложитьУстановить", Истина);
	Параметры.Вставить("ТекстПояснения", "");
	Параметры.Вставить("ИдентификаторыСозданияОбъектов", Новый Массив);
	
	Возврат Параметры;
	
КонецФункции

// Результат подключения компоненты.
//
Функция РезультатПодключенияКомпоненты()
	
	Результат = Новый Структура;
	Результат.Вставить("Подключено", Ложь);
	Результат.Вставить("ОписаниеОшибки", "");
	Результат.Вставить("ПодключаемыйМодуль", Неопределено);
	Возврат Результат;
	
КонецФункции

// Подключает компоненту, выполненную по технологии Native API и COM асинхронном режиме.
// Компонента должна храниться в макете конфигурации в виде ZIP-архива.
//
Процедура ПодключитьКомпонентуИзМакета(ОповещениеПриПодключении, Идентификатор, ПолноеИмяМакета, ПараметрыПодключения = Неопределено) Экспорт
	
	РезультатПодключения = РезультатПодключенияКомпоненты();
	
	Если ПустаяСтрока(Идентификатор) Тогда
		РезультатПодключения.ОписаниеОшибки = НСтр("ru = 'Идентификатор компоненты не указан.'");
		ВыполнитьОбработкуОповещения(ОповещениеПриПодключении, РезультатПодключения);
	Иначе
		Параметры = Новый Структура("Идентификатор, ОповещениеПриПодключении", Идентификатор, ОповещениеПриПодключении);
		Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуИзМакетаЗавершение", ЭтотОбъект, Параметры);
		НачатьПодключениеВнешнейКомпоненты(Оповещение, ПолноеИмяМакета, СтрЗаменить(Идентификатор, ".", "_"));
	КонецЕсли; 
	
КонецПроцедуры

Процедура ПодключитьКомпонентуИзМакетаЗавершение(Подключено, ПараметрыПодключения) Экспорт
	
	РезультатПодключения = РезультатПодключенияКомпоненты();

	Если Подключено Тогда 
		Попытка
			ProgID = "AddIn." + СтрЗаменить(ПараметрыПодключения.Идентификатор, ".", "_") + "." + ПараметрыПодключения.Идентификатор;
			РезультатПодключения.ПодключаемыйМодуль = Новый (ProgID);
			РезультатПодключения.Подключено = Истина;
		Исключение
			РезультатПодключения.ОписаниеОшибки = ОписаниеОшибки();
		КонецПопытки;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ПараметрыПодключения.ОповещениеПриПодключении, РезультатПодключения);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти