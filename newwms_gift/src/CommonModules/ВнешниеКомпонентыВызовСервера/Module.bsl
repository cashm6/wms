
#Область ПрограммныйИнтерфейс

// Информация о внешней компоненте по идентификатору и версии.
//
// Параметры:
//  Идентификатор - Строка - идентификатор объекта внешней компоненты.
//  Версия - Строка - (необязательный) версия компоненты. 
//
// Возвращаемое значение:
//  Структура - информация о компоненте, где:
//      * Существует - Булево - признак отсутствия компоненты.
//      * ОписаниеОшибки - Строка - краткое описание ошибки.
//      * Идентификатор - Строка - идентификатор объекта внешней компоненты.
//      * Версия - Строка - версия компоненты.
//      * Наименование - Строка - наименование и краткая информация о компоненте.
//
Функция ИнформацияОКомпоненте(Идентификатор, Версия = Неопределено) Экспорт
	
	Результат = РезультатИнформацияОКомпоненте();
	Результат.Идентификатор = Идентификатор;
	Результат.Существует = Ложь;
	Результат.ОписаниеОшибки = НСтр("ru = 'Внешняя компонента не найдена'");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция РезультатИнформацияОКомпоненте()
	
	Результат = Новый Структура;
	Результат.Вставить("Существует");
	Результат.Вставить("Идентификатор");
	Результат.Вставить("Версия");
	Результат.Вставить("Наименование");
	Результат.Вставить("ОписаниеОшибки");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти