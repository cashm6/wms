
#Область СлужебныйПрограммныйИнтерфейс

// Подготовить данные операции.
// 
// Параметры:
//  ПараметрыПодключения - Структура -Параметры подключения
//  Команда - Строка - Команда
//  ПараметрыОперации - Структура -Параметры операции
// 
// Возвращаемое значение:
//  Неопределено.
Функция ПодготовитьДанныеОперации(ПараметрыПодключения, Команда, ПараметрыОперации) Экспорт

КонецФункции

Процедура ОбработатьДанныеОперации(ПараметрыПодключения, Команда, РезультатВыполнения, ДанныеОперации) Экспорт
	
	Если РезультатВыполнения.Свойство("ТекстСлипЧека")
		И Не ПустаяСтрока(РезультатВыполнения.ТекстСлипЧека) Тогда 
		
		Если МенеджерОборудованияВызовСервера.ИспользуетсяЧекопечатающиеУстройства() Тогда
			МодульОборудованиеЧекопечатающиеУстройстваВызовСервера = ОбщегоНазначения.ОбщийМодуль("ОборудованиеЧекопечатающиеУстройстваВызовСервера");
			ТестовыеЧеки = МодульОборудованиеЧекопечатающиеУстройстваВызовСервера.ПолучитьXMLПакетДляТекста(РезультатВыполнения.ТекстСлипЧека, ПараметрыПодключения.РевизияИнтерфейса);
			РезультатВыполнения.Вставить("ТестовыеЧеки", ТестовыеЧеки);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


