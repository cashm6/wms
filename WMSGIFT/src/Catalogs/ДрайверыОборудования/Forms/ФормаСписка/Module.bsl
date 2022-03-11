
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// АПК: 484-выкл не используется БСП
	Список.ТекстЗапроса = СтрШаблон(Список.ТекстЗапроса, 
		НСтр("ru = 'Поставляемый в составе конфигурации'"),
		НСтр("ru = 'Подключаемый по стандарту """"1С:Совместимо""""'"));
	// АПК: 484-вкл
	
	ДобавлениеНовыхДрайверов = МенеджерОборудованияВызовСервера.ДоступноДобавлениеНовыхДрайверов();
	
	ПравоДоступаДобавление = ПравоДоступа("Добавление", Метаданные.Справочники.ДрайверыОборудования);
	
	Элементы.ДрайверыОборудования.КоманднаяПанель.Видимость = ПравоДоступаДобавление;

	Элементы.ДрайверыОборудования.ИзменятьСоставСтрок = ДобавлениеНовыхДрайверов;
	ЭлементГруппировки = Список.Группировка.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ЭлементГруппировки.Поле = Новый ПолеКомпоновкиДанных("ВариантПоставки");
	ЭлементГруппировки.Использование = Истина;
	
	Элементы.ДрайверыОборудования.ИзменятьСоставСтрок = ДобавлениеНовыхДрайверов;
	ЭлементГруппировки = Список.Группировка.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
	ЭлементГруппировки.Поле = Новый ПолеКомпоновкиДанных("ТипОборудования");
	ЭлементГруппировки.Использование = Истина;
	
	ОбновитьПользовательскийИнтерфейс();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановленныйНаЛокальномКомпьютере(Команда)
	
	Элементы.ДрайверыОборудования.ДобавитьСтроку();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНовыйДрайверИзФайла(Команда)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Ключ", "Значение");
	
	ПараметрыПоискаТипаКомпонентыПодключения = ВнешниеКомпонентыКлиент.ПараметрыПоискаДополнительнойИнформации();
	ПараметрыПоискаТипаКомпонентыПодключения.ИмяФайлаXML = "INFO.XML";
	ПараметрыПоискаТипаКомпонентыПодключения.ВыражениеXPath = "//drivers/component/@type";
	
	ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыЗагрузки();
	ПараметрыЗагрузки.ПараметрыПоискаДополнительнойИнформации.Вставить("ТипКомпонентыПодключения", ПараметрыПоискаТипаКомпонентыПодключения);
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьНовыйДрайверИзФайла_Завершение", ЭтотОбъект, ДополнительныеПараметры);
	
	ВнешниеКомпонентыКлиент.ЗагрузитьКомпонентуИзФайла(Оповещение, ПараметрыЗагрузки);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьДрайверОборудования(Команда)
	
	ОчиститьСообщения();
	
	ТекущиеДанные = Элементы.ДрайверыОборудования.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.Свойство("Ссылка") Тогда
		МенеджерОборудованияКлиент.УстановитьДрайверОборудования(Неопределено, ТекущиеДанные.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПользовательскийИнтерфейс()
	
#Если МобильноеПриложениеСервер Тогда 
	ОтображатьДопЭлементы = Ложь;
#Иначе
	ОтображатьДопЭлементы = Истина;
#КонецЕсли
	Элементы.ДрайверыОборудования.Шапка = ОтображатьДопЭлементы;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНовыйДрайверИзФайла_Завершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат.Загружена Тогда  
		
		ТипОборудования = Результат.ДополнительнаяИнформация.Получить("ТипКомпонентыПодключения");
		Если ПустаяСтрока(ТипОборудования) Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'Не указан тип оборудования загружаемого драйвера.'") );
			Возврат;
		КонецЕсли;
		
		ТипыОборудования = СтрРазделить(СтрЗаменить(ТипОборудования, ";", ","), ",");
		Для Каждого ТипОборудованияВрем Из ТипыОборудования Цикл 
			ПараметрыСоздания = МенеджерОборудованияКлиентСервер.ПараметрыСозданияНовогоДрайвера();
			ПараметрыСоздания.Вставить("Загружена", Истина);
			ПараметрыСоздания.ТипОборудования = ТипОборудованияВрем;
			ПараметрыСоздания.ИдентификаторОбъекта = Результат.Идентификатор;
			ПараметрыСоздания.Наименование         = Результат.Наименование;
			ПараметрыСоздания.ВерсияДрайвера       = Результат.Версия;
			ПараметрыСоздания.СпособПодключения    = ПредопределенноеЗначение("Перечисление.СпособПодключенияДрайвера.ИзИнформационнойБазы");
			НовыйЭлемент = МенеджерОборудованияВызовСервера.СоздатьДрайверОборудования(ПараметрыСоздания);
			Элементы.ДрайверыОборудования.Обновить();
			Элементы.ДрайверыОборудования.ТекущаяСтрока = НовыйЭлемент;
		КонецЦикла;
		
		УстановитьДрайверОборудования(Неопределено);
	Иначе 
		ПоказатьПредупреждение(, НСтр("ru = 'Ошибка загрузки нового драйвера.'") );
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти