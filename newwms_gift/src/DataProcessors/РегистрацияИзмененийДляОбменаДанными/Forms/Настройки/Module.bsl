
#Область ОбработчикиСобытийФормы
//

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ВыполнитьПроверкуПравДоступа("Администрирование", Метаданные);
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ИдентификаторКонсолиЗапросов = "КонсольЗапросов";
	
	ТекущийОбъект = ЭтотОбъект();
	ТекущийОбъект.ПрочитатьНастройки();
	ТекущийОбъект.ПрочитатьПризнакиПоддержкиБСП();
	
	Строка = СокрЛП(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов);
	Если НРег(Прав(Строка, 4)) = ".epf" Тогда
		ВариантИспользованияКонсолиЗапросов = 2;
	ИначеЕсли Метаданные.Обработки.Найти(Строка) <> Неопределено Тогда
		ВариантИспользованияКонсолиЗапросов = 1;
		Строка = "";	
	Иначе 
		ВариантИспользованияКонсолиЗапросов = 0;
		Строка = "";
	КонецЕсли;
	ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = Строка;
	
	ЭтотОбъект(ТекущийОбъект);
	
	СписокВыбора = Элементы.ОбработкаЗапросаВнешняя.СписокВыбора;
	
	// В составе метаданных разрешаем, только если есть предопределенное
	Если Метаданные.Обработки.Найти(ИдентификаторКонсолиЗапросов) = Неопределено Тогда
		ТекЭлемент = СписокВыбора.НайтиПоЗначению(1);
		Если ТекЭлемент <> Неопределено Тогда
			СписокВыбора.Удалить(ТекЭлемент);
		КонецЕсли;
	КонецЕсли;
	
	// Строка опции из файла
	Если ТекущийОбъект.ЭтоФайловаяБаза() Тогда
		ТекЭлемент = СписокВыбора.НайтиПоЗначению(2);
		Если ТекЭлемент <> Неопределено Тогда
			ТекЭлемент.Представление = НСтр("ru = 'В каталоге:'");
		КонецЕсли;
	КонецЕсли;

	// БСП разрешаем только если она есть и нужной версии
	Элементы.ГруппаБСП.Видимость = ТекущийОбъект.КонфигурацияПоддерживаетБСП
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
//

&НаКлиенте
Процедура ОбработкаЗапросаПутьПриИзменении(Элемент)
	ВариантИспользованияКонсолиЗапросов = 2;
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаЗапросаПутьНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.ПроверятьСуществованиеФайла = Истина;
	Диалог.Фильтр = НСтр("ru = 'Внешние обработки (*.epf)|*.epf'");
	Если Диалог.Выбрать() Тогда
		ВариантИспользованияКонсолиЗапросов = 2;
		УстановитьНастройкуАдресВнешнейОбработкиЗапросов(Диалог.ПолноеИмяФайла);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
//

&НаКлиенте
Процедура ПодтвердитьВыбор(Команда)
	
	Проверка = ПроверитьНастройки();
	Если Проверка.ЕстьОшибки Тогда
		// Сообщаем об ошибках
		Если Проверка.НастройкаАдресВнешнейОбработкиЗапросов <> Неопределено Тогда
			СообщитьОбОшибке(Проверка.НастройкаАдресВнешнейОбработкиЗапросов, "Объект.НастройкаАдресВнешнейОбработкиЗапросов");
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	// Все успешно
	СохранитьНастройки();
	Закрыть();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
//

&НаКлиенте
Процедура СообщитьОбОшибке(Текст, ИмяРеквизита = Неопределено)
	
	Если ИмяРеквизита = Неопределено Тогда
		ЗаголовокОшибки = НСтр("ru = 'Ошибка'");
		ПоказатьПредупреждение(, Текст, , ЗаголовокОшибки);
		Возврат;
	КонецЕсли;
	
	Сообщение = Новый СообщениеПользователю();
	Сообщение.Текст = Текст;
	Сообщение.Поле  = ИмяРеквизита;
	Сообщение.УстановитьДанные(ЭтотОбъект);
	Сообщение.Сообщить();
КонецПроцедуры	

&НаСервере
Функция ЭтотОбъект(ТекущийОбъект = Неопределено) 
	Если ТекущийОбъект = Неопределено Тогда
		Возврат РеквизитФормыВЗначение("Объект");
	КонецЕсли;
	ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	Возврат Неопределено;
КонецФункции

&НаСервере
Функция ПроверитьНастройки()
	ТекущийОбъект = ЭтотОбъект();
	
	Если ВариантИспользованияКонсолиЗапросов = 2 Тогда
		
		ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = СокрЛП(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов);
		Если Лев(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов, 1) = """" 
			И Прав(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов, 1) = """"
		Тогда
			ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = Сред(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов, 
				2, СтрДлина(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов) - 2);
		КонецЕсли;
		
		Если НРег(Прав(СокрЛП(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов), 4)) <> ".epf" Тогда
			ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = СокрЛП(ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов) + ".epf";
		КонецЕсли;
		
	ИначеЕсли ВариантИспользованияКонсолиЗапросов = 0 Тогда
		ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = "";
		
	КонецЕсли;
	
	Результат = ТекущийОбъект.ПроверитьКорректностьНастроек();
	ЭтотОбъект(ТекущийОбъект);
	
	Возврат Результат;
КонецФункции

&НаСервере
Процедура СохранитьНастройки()
	ТекущийОбъект = ЭтотОбъект();
	Если ВариантИспользованияКонсолиЗапросов = 0 Тогда
		ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = "";
	ИначеЕсли ВариантИспользованияКонсолиЗапросов = 1 Тогда
		ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = ИдентификаторКонсолиЗапросов		;
	КонецЕсли;
	ТекущийОбъект.СохранитьНастройки();
	ЭтотОбъект(ТекущийОбъект);
КонецПроцедуры

&НаСервере
Процедура УстановитьНастройкуАдресВнешнейОбработкиЗапросов(ПутьКФайлу)
	ТекущийОбъект = ЭтотОбъект();
	ТекущийОбъект.НастройкаАдресВнешнейОбработкиЗапросов = ПутьКФайлу;
	ЭтотОбъект(ТекущийОбъект);
КонецПроцедуры

#КонецОбласти
