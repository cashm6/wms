#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область Системные

// Возвращает номер версии библиотеки подключаемого оборудования.
//
// Возвращаемое значение:
//  Строка.
//
Функция ВерсияБиблиотеки() Экспорт
	
	Возврат "3.1.3.4";
	
КонецФункции

// Ведется учет ИСМП в конфигурации
// 
// Возвращаемое значение:
//  Булево - Ведется учет ИСМП в конфигурации
//
Функция ВедетсяУчетПродукцииИСМП() Экспорт
	
	СтандартнаяОбработка = Истина;
	УчетПродукцииИСМП = Ложь;
	МенеджерОборудованияВызовСервераПереопределяемый.ВедетсяУчетПродукцииИСМП(УчетПродукцииИСМП, СтандартнаяОбработка);
	Результат = ?(Не СтандартнаяОбработка, УчетПродукцииИСМП, Ложь); 
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область ОбновлениеДрайверов

// Обновить поставляемые драйвера БПО.
//
Процедура ОбновитьПоставляемыеДрайвера() Экспорт
	
	ДрайвераОборудования = НоваяТаблицаПоставляемыхДрайверовОборудования();
	
	Для Каждого Подсистема Из Метаданные.Подсистемы.ПоддержкаОборудования.Подсистемы.ПодключаемоеОборудование.Подсистемы Цикл
		ИмяМодуля = "Оборудование" + Подсистема.Имя + "Обновление";
		Если Метаданные.ОбщиеМодули.Найти(ИмяМодуля) <> Неопределено Тогда
			Модуль = Вычислить(ИмяМодуля); // АПК: 486 ВычислитьВБезопасномРежиме не требуется, т.к. проверка надежная.
			Модуль.ОбновитьПоставляемыеДрайвера(ДрайвераОборудования);
		КонецЕсли;
	КонецЦикла;
	
	Справочники.ДрайверыОборудования.ПриНачальномЗаполненииЭлементов(ДрайвераОборудования);
	
КонецПроцедуры

// Обновить установленные драйвера.
//
Процедура ОбновитьУстановленныеДрайвера() Экспорт
	
	// ККТ с передачей данных ОФД
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.ККТ);
	// Конец ККТ с передачей данных ОФД.
	
	// Принтеры чеков
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.ПринтерЭтикеток);
	// Конец Принтеры чеков.
	
	// Сканеры штрихкода
	ОбновитьУстановленныеДрайвераПоТипу(Перечисления.ТипыПодключаемогоОборудования.СканерШтрихкода);
	// Конец Сканеры штрихкода
	
КонецПроцедуры

// Записывает изменения в переданном объекте.
// Для использования в обработчиках обновления.
//
// Параметры:
//   Данные                            - Произвольный - объект, набор записей или менеджер константы, который
//                                                      необходимо записать.
//   РегистрироватьНаУзлахПлановОбмена - Булево       - включает регистрацию на узлах планов обмена при записи объекта.
//   ВключитьБизнесЛогику              - Булево       - включает бизнес-логику при записи объекта.
//
Процедура ЗаписатьДанные(Знач Данные, Знач РегистрироватьНаУзлахПлановОбмена = Ложь, Знач ВключитьБизнесЛогику = Ложь) Экспорт
	
	Данные.ОбменДанными.Загрузка = Не ВключитьБизнесЛогику;
	Если Не РегистрироватьНаУзлахПлановОбмена Тогда
		Данные.ДополнительныеСвойства.Вставить("ОтключитьМеханизмРегистрацииОбъектов");
		Данные.ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
	КонецЕсли;
	
	Данные.Записать();
	
КонецПроцедуры

// Устанавливает признак необходимости переустановки оборудования для подключаемого оборудования на рабочем месте.
//
// Параметры:
//  РабочееМесто - СправочникСсылка.РабочиеМеста.
//  ДрайверОборудования - СправочникСсылка.ДрайверыОборудования. 
//  Признак - Булево - требуется переустановить драйвер
//
Процедура УстановитьПризнакПереустановкиДрайвера(РабочееМесто, ДрайверОборудования, Признак) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ  
	|	ПодключаемоеОборудование.Ссылка
	|ИЗ
	|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
	|ГДЕ
	|	ПодключаемоеОборудование.РабочееМесто = &РабочееМесто
	|	И ПодключаемоеОборудование.ДрайверОборудования = &ДрайверОборудования
	|	И НЕ ПодключаемоеОборудование.ТребуетсяПереустановка = &ТребуетсяПереустановка"); 
	
	Запрос.УстановитьПараметр("РабочееМесто", РабочееМесто);
	Запрос.УстановитьПараметр("ДрайверОборудования", ДрайверОборудования);
	Запрос.УстановитьПараметр("ТребуетсяПереустановка", Признак);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.ТребуетсяПереустановка = Признак;
		ЗаписатьДанные(СправочникОбъект)
	КонецЦикла;
	
КонецПроцедуры

// Обновить установленные драйвера по справочнику подключаемого оборудования.
//
// Параметры:
//  ТипОборудования - ПеречисленияСсылка.ТипыПодключаемогоОборудования
Процедура ОбновитьУстановленныеДрайвераПоТипу(ТипОборудования) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("ВЫБРАТЬ
							|	ПодключаемоеОборудование.Ссылка
							|ИЗ
							|	Справочник.ПодключаемоеОборудование КАК ПодключаемоеОборудование
							|ГДЕ
							|	(ПодключаемоеОборудование.ТипОборудования = &ТипОборудования)");
							
	Запрос.УстановитьПараметр("ТипОборудования", ТипОборудования);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.ТребуетсяПереустановка = Истина;
		ЗаписатьДанные(СправочникОбъект)
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает пустую таблицу поставляемых драйверов оборудования. 
//
Функция НоваяТаблицаПоставляемыхДрайверовОборудования()
	
	ДрайвераОборудования = Новый ТаблицаЗначений;
	// Общие свойства.
	ДрайвераОборудования.Колонки.Добавить("ТипОборудования"     , Новый ОписаниеТипов("ПеречислениеСсылка.ТипыПодключаемогоОборудования"));
	ДрайвераОборудования.Колонки.Добавить("Наименование"        , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИдентификаторОбъекта", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИмяДрайвера"         , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ИмяМакетаДрайвера"   , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("ВерсияДрайвера"      , Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(0)));
	ДрайвераОборудования.Колонки.Добавить("СнятСПоддержки"      , Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СпособПодключения"   , Новый ОписаниеТипов("ПеречислениеСсылка.СпособПодключенияДрайвера"));
	// Параметры работы
	ДрайвераОборудования.Колонки.Добавить("ЛокальныйРежим", Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СетевойРежим"  , Новый ОписаниеТипов("Булево"));
	ДрайвераОборудования.Колонки.Добавить("СерверныйРежим", Новый ОписаниеТипов("Булево"));   
	Возврат ДрайвераОборудования;
	
КонецФункции

#КонецОбласти

#КонецЕсли

