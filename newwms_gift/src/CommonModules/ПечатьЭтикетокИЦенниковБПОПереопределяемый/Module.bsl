#Область ПрограммныйИнтерфейс

// Вызывается при создании формы обработки ПечатьЭтикетокИЦенниковБПО.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма обработки
//
Процедура ФормаПечатьЭтикетокИЦенниковПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Вызывается при создании формы элемента ШаблоныЭтикетокИЦенниковБПО.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - форма обработки
//
Процедура ФормаШаблоныЭтикетокИЦенниковБПОПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Возвращает данные для построения шаблонов и печатных форм.
// 
// Параметры:
//  ПараметрыПечати - Структура - ПоляДляЗаполнения - Массив -
//  ПоляДляЗаполнения - Массив Из Структура - Поля для заполнения
// 
// Возвращаемое значение:
//  Массив из Структура - Данные для формирования печатных форм
Функция ДанныеДляФормированияПечатныхФорм(ПараметрыПечати, ПоляДляЗаполнения) Экспорт
	
	
	
КонецФункции

// Возвращает Макет стандартный схемы компоновки данных для обработки и печати данных.
// 
// Возвращаемое значение:
//  СхемаКомпоновкиДанных.
Функция МакетСхемыКомпоновкиДанных() Экспорт
	
	
	
КонецФункции

// При определении переопределения подбора товаров.
// 
// Параметры:
//  Использовать - Булево - Использовать
Процедура ПриОпределенииПереопределенияПодбораТоваров(Использовать) Экспорт
	
	Использовать = Истина;
	
КонецПроцедуры

// При определении переопределения подбора по штрихкоду.
// 
// Параметры:
//  Использовать - Булево - Использовать
Процедура ПриОпределенииПереопределенияПодбораПоШтрихкоду(Использовать) Экспорт
	
	Использовать = Ложь;
	
КонецПроцедуры

#КонецОбласти
