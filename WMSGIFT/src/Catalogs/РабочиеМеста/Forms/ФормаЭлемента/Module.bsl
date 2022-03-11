#Область ОписаниеПеременных

&НаКлиенте
Перем ОтветПередЗаписью;

#КонецОбласти

#Область ОбработчикиСобытийФорм

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда     
		Возврат;
	КонецЕсли;

	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();

	#Если Не ВебКлиент Тогда
	Объект.ИмяКомпьютера = ИмяКомпьютера();
	#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ПустаяСтрока(Объект.Код) Тогда
		Объект.Код = МенеджерОборудованияКлиентСервер.ИдентификаторКлиентаДляРабочегоМеста();
	КонецЕсли;
	
	МенеджерОборудованияКлиентСервер.ЗаполнитьНаименованиеРабочегоМеста(Объект, ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если Не ПроверкаУникальностиПоИдентификаторуКлиента(Объект.Ссылка, Объект.Код) Тогда
		Отказ = Истина;
		Текст = НСтр("ru='Ошибка сохранение рабочего места.
					|Рабочее место с таким идентификатором клиента уже существует.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(Текст);
		Возврат;
	КонецЕсли;
	
	Если Не ПроверкаУникальностиПоНаименованию(Объект.Ссылка, Объект.Наименование)Тогда
		Если ОтветПередЗаписью <> Истина Тогда
			Отказ = Истина;
			Текст = НСтр("ru='Указано неуникальное наименование рабочего места.
						|Возможно в дальнейшем это затруднит идентификацию и выбор рабочего места.
						|Рекомендуется указывать уникальное наименование рабочих мест.
						|Продолжить сохранение с указанным наименованием?'");
			Оповещение = Новый ОписаниеОповещения("ПередЗаписьюЗавершение", ЭтотОбъект);
			ПоказатьВопрос(Оповещение, Текст, РежимДиалогаВопрос.ДаНет);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписьюЗавершение(Результат, Параметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ОтветПередЗаписью = Истина;
		Записать();
	КонецЕсли;  
	
КонецПроцедуры 
   
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если Объект.Код = МенеджерОборудованияКлиентСервер.ИдентификаторКлиентаДляРабочегоМеста() Тогда
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	МенеджерОборудованияКлиентСервер.ЗаполнитьНаименованиеРабочегоМеста(Объект, ТекущийПользователь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПроверкаУникальностиПоНаименованию(Ссылка, Наименование)
	
	Результат = Истина;
	
	Если Не ПустаяСтрока(Наименование) Тогда
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|    1
		|ИЗ
		|    Справочник.РабочиеМеста КАК РабочиеМеста
		|ГДЕ
		|    РабочиеМеста.Наименование = &Наименование
		|    И РабочиеМеста.Ссылка <> &Ссылка
		|");
		Запрос.УстановитьПараметр("Наименование", Наименование);
		Запрос.УстановитьПараметр("Ссылка"      , Ссылка);
		Результат = Запрос.Выполнить().Пустой();
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПроверкаУникальностиПоИдентификаторуКлиента(Ссылка, ИдентификаторКлиента)
	
	Результат = Истина;
	
	Если Не ПустаяСтрока(ИдентификаторКлиента) Тогда
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|    1
		|ИЗ
		|    Справочник.РабочиеМеста КАК РабочиеМеста
		|ГДЕ
		|    РабочиеМеста.Код = &Код
		|    И РабочиеМеста.Ссылка <> &Ссылка
		|");
		Запрос.УстановитьПараметр("Код"    , ИдентификаторКлиента);
		Запрос.УстановитьПараметр("Ссылка" , Ссылка);
		Результат = Запрос.Выполнить().Пустой();
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти