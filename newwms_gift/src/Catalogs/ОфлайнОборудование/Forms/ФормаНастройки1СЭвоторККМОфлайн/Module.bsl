#Область ОбработчикСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Параметры.Свойство("Идентификатор", Идентификатор);
	
	Заголовок = НСтр("ru='Оборудование:'") + Символы.НПП  + Строка(Идентификатор);
	
	времТокен  = Неопределено;
	времМагазин = Неопределено;
	времМагазинПредставление = Неопределено;
	времТерминал = Неопределено;
	времТерминалПредставление = Неопределено;
	времПериодИзмененВручную = Неопределено;
	времДатаНачала = Неопределено;
	времДатаОкончания = Неопределено;
	времЭтоПерваяЗагрузка = Неопределено;
	времИспользоватьФорматЗагрузкиВ2 = Неопределено;
	
	Параметры.ПараметрыОборудования.Свойство("Токен", времТокен);
	Параметры.ПараметрыОборудования.Свойство("Магазин", времМагазинПредставление);
	Параметры.ПараметрыОборудования.Свойство("МагазинЗначение", времМагазин);
	Параметры.ПараметрыОборудования.Свойство("Терминал", времТерминалПредставление);
	Параметры.ПараметрыОборудования.Свойство("ТерминалЗначение", времТерминал);
	Параметры.ПараметрыОборудования.Свойство("ПериодИзмененВручную", времПериодИзмененВручную);
	Параметры.ПараметрыОборудования.Свойство("ДатаНачала", времДатаНачала);
	Параметры.ПараметрыОборудования.Свойство("ДатаОкончания", времДатаОкончания);
	Параметры.ПараметрыОборудования.Свойство("ЭтоПерваяЗагрузка", времЭтоПерваяЗагрузка);
	Параметры.ПараметрыОборудования.Свойство("ИспользоватьФорматЗагрузкиВ2", времИспользоватьФорматЗагрузкиВ2);
	
	Токен = ?(времТокен = Неопределено, "", времТокен);
	МагазинЗначение = ?(времМагазин = Неопределено, "", времМагазин);
	ТерминалЗначение = ?(времТерминал = Неопределено, "", времТерминал);
	
	ЭтоПерваяЗагрузка = Истина;
	ПериодИзмененВручную = Ложь;
	
	Если ЗначениеЗаполнено(времМагазин) Тогда
		Магазин = ЭтаФорма.Элементы.Магазин.СписокВыбора.Добавить(времМагазин, времМагазинПредставление);
	Иначе
		Магазин = "";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(времТерминал) Тогда
		Терминал = ЭтаФорма.Элементы.Терминал.СписокВыбора.Добавить(времТерминал, времТерминалПредставление);
	Иначе
		Терминал = "";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(времИспользоватьФорматЗагрузкиВ2) Тогда
		ИспользоватьФорматЗагрузкиВ2 = времИспользоватьФорматЗагрузкиВ2;
	Иначе
		ИспользоватьФорматЗагрузкиВ2 = Ложь;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Токен) Тогда 
		Элементы.Магазин.Доступность = Ложь;
		Элементы.Терминал.Доступность = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ПустаяСтрока(Токен) Тогда
		ПолучитьДанныеОбУстройстве();
	КонецЕсли;
	
#Если ВебКлиент Тогда
	Оповещение = Новый ОписаниеОповещения("ПроверкаРасширенияРаботыСФайлами", ЭтотОбъект);
	НачатьПодключениеРасширенияРаботыСФайлами(Оповещение);
#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		НовыеЗначениеПараметров = Новый Структура;
		НовыеЗначениеПараметров.Вставить("Токен", Токен);
		НовыеЗначениеПараметров.Вставить("МагазинЗначение", МагазинЗначение);
		НовыеЗначениеПараметров.Вставить("ТерминалЗначение", ТерминалЗначение);
		НовыеЗначениеПараметров.Вставить("Магазин", Магазин);
		НовыеЗначениеПараметров.Вставить("Терминал", Терминал);
		НовыеЗначениеПараметров.Вставить("ЭтоПерваяЗагрузка", ЭтоПерваяЗагрузка);
		НовыеЗначениеПараметров.Вставить("ДатаНачала", ДатаНачала);
		НовыеЗначениеПараметров.Вставить("ДатаОкончания", ДатаОкончания);
		НовыеЗначениеПараметров.Вставить("ПериодИзмененВручную", ПериодИзмененВручную);
		НовыеЗначениеПараметров.Вставить("ИспользоватьФорматЗагрузкиВ2", ИспользоватьФорматЗагрузкиВ2);
		
		ПараметрыУстройства = Новый Структура;
		ПараметрыУстройства.Вставить("Идентификатор"        , Идентификатор);
		ПараметрыУстройства.Вставить("ПараметрыОборудования", НовыеЗначениеПараметров);
		
		Закрыть(ПараметрыУстройства);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТестУстройства(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		
		ВходныеПараметры = Неопределено;
	
		ПараметрыУстройства = Новый Структура;
		ПараметрыУстройства.Вставить("Токен", Токен);
		ПараметрыУстройства.Вставить("Идентификатор", Идентификатор);
		ПараметрыУстройства.Вставить("Команда", "ТестУстройства");
		
		ПараметрыПодключения = Новый Структура;
		ПараметрыПодключения.Вставить("ТипОборудования", "ККМOffline");
	
		ОписаниеОповещения = Новый ОписаниеОповещения("ТестУстройстваЗавершение", ЭтотОбъект, ПараметрыУстройства);
		ОфлайнОборудование1СЭвоторКлиент.НачатьВыполнениеКоманды(ОписаниеОповещения, "ТестУстройства", ВходныеПараметры, Идентификатор, ПараметрыУстройства);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТокенПриИзменении(Элемент)
	
	Если Не ПустаяСтрока(Токен) Тогда
		Элементы.Магазин.Доступность = Истина;
		Элементы.Терминал.Доступность = Истина;
		ПолучитьДанныеОбУстройстве();
	Иначе
		Элементы.Магазин.Доступность = Ложь;
		Элементы.Терминал.Доступность = Ложь;
		МагазинЗначение = "";
		ТерминалЗначение = "";
		Магазин = "";
		Терминал = "";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МагазинОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Значение = Элемент.СписокВыбора.НайтиПоЗначению(ВыбранноеЗначение);
	Магазин = Значение.Представление;
	МагазинЗначение = ВыбранноеЗначение;
	
КонецПроцедуры

&НаКлиенте
Процедура ТерминалОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Значение = Элемент.СписокВыбора.НайтиПоЗначению(ВыбранноеЗначение);
	Терминал = Значение.Представление;
	ТерминалЗначение = ВыбранноеЗначение;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаполнитьСписокВыбора(Результат, ПараметрыУстройства) Экспорт
	
	Данные = Результат.ВыходныеПараметры;
	
	Если Не Результат.Результат Тогда
		ТекстСообщения = НСтр("ru='По введенному токену нет данных для заполнения. Проверьте корректность введенного токена.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		ЭтаФорма.Элементы.Магазин.СписокВыбора.Очистить();
		ЭтаФорма.Элементы.Магазин.Доступность = Ложь;
		МагазинЗначение = "";
		Магазин = "";
		ЭтаФорма.Элементы.Терминал.СписокВыбора.Очистить();
		ЭтаФорма.Элементы.Терминал.Доступность = Ложь;
		ТерминалЗначение = "";
		Терминал = "";
		КорректностьТокена = Ложь;
	Иначе
		КорректностьТокена = Истина;
		Если ПараметрыУстройства.Команда = "ЗагрузитьМагазины" Тогда
			
			Для Каждого Элемент Из Данные Цикл
				НаименованиеМагазина = Элемент.name + " " + Элемент.address;
				УИДМагазина = Элемент.uuid;
				Если ЭтаФорма.Элементы.Магазин.СписокВыбора.НайтиПоЗначению(УИДМагазина) = Неопределено Тогда
					ЭтаФорма.Элементы.Магазин.СписокВыбора.Добавить(УИДМагазина, НаименованиеМагазина);
				КонецЕсли;
			КонецЦикла;
		ИначеЕсли ПараметрыУстройства.Команда = "ЗагрузитьТерминалы" Тогда
			Для Каждого Элемент Из Данные Цикл
				НаименованиеТерминала = Элемент.name;
				УИДТерминала = Элемент.uuid;
				Если ЭтаФорма.Элементы.Терминал.СписокВыбора.НайтиПоЗначению(УИДТерминала) = Неопределено Тогда
					ЭтаФорма.Элементы.Терминал.СписокВыбора.Добавить(УИДТерминала, НаименованиеТерминала);
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанныеОбУстройстве()
	
	ВходныеПараметры = Неопределено;
	
	ПараметрыУстройства = Новый Структура;
	ПараметрыУстройства.Вставить("Токен", Токен);
	ПараметрыУстройства.Вставить("Идентификатор", Идентификатор);
	ПараметрыУстройства.Вставить("Команда", "ЗагрузитьМагазины");
	
	ПараметрыПодключения = Новый Структура;
	ПараметрыПодключения.Вставить("ТипОборудования", "ККМOffline");
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьСписокВыбора", ЭтотОбъект, ПараметрыУстройства);
	ОфлайнОборудование1СЭвоторКлиент.НачатьВыполнениеКоманды(ОписаниеОповещения, "ЗагрузитьМагазины", ВходныеПараметры, Идентификатор, ПараметрыУстройства);
		
	Если КорректностьТокена Тогда
		ПараметрыУстройства.Команда = "ЗагрузитьТерминалы";
		ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьСписокВыбора", ЭтотОбъект, ПараметрыУстройства);
		ОфлайнОборудование1СЭвоторКлиент.НачатьВыполнениеКоманды(ОписаниеОповещения, "ЗагрузитьТерминалы", ВходныеПараметры, Идентификатор, ПараметрыУстройства);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТестУстройстваЗавершение(Результат, ПараметрыУстройства) Экспорт
	
	Если Результат.Результат Тогда
		ТекстСообщения = НСтр("ru = 'Тест успешно выполнен.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	Иначе
		ТекстСообщения = НСтр("ru = 'Тест не пройден.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаРасширенияРаботыСФайлами(Установлено, ДополнительныеПараметры) Экспорт
	
	Если Не Установлено Тогда
		Оповещение = Новый ОписаниеОповещения("УстановкаРасширенияРаботыСФайлами", ЭтотОбъект, ДополнительныеПараметры);
		ТекстСообщения = НСтр("ru='Для продолжении работы необходимо установить расширение для веб-клиента ""1С:Предприятие"". Установить?'");
		ПоказатьВопрос(Оповещение, ТекстСообщения, РежимДиалогаВопрос.ДаНет); 
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановкаРасширенияРаботыСФайлами(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		НачатьУстановкуРасширенияРаботыСФайлами();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
