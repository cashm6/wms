
#Область ПрограммныйИнтерфейс

// Заполняет структуру параметров операции на Оборудовании.
//
// Параметры:
//  ВесТары - Число
// 
// Возвращаемое значение:
//  Структура.
//
Функция ПараметрыОперацииЭлектронныеВесы(ВесТары = 0) Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ВесТары", ВесТары);
	Возврат Параметры;
	
КонецФункции

// Заполняет структуру параметров операции на Оборудовании.
// 
// Возвращаемое значение:
//  Структура.
//
Функция ПараметрыОперацииВесыСПечатьюЭтикеток() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ТаблицаТоваров", Новый Массив());
	Параметры.Вставить("ЧастичнаяВыгрузка", Ложь);
	Возврат Параметры;
	
КонецФункции

// Заполняет структуру выгрузки товарной позиции на весы с печатью этикеток.
// 
// Возвращаемое значение:
//  Структура.
Функция ПараметрыСтрокиВыгрузкиВВесыСПечатьюЭтикеток() Экспорт
	
	ПараметрыСтроки = Новый Структура();
	ПараметрыСтроки.Вставить("PLU"); // Число,Обязательно   - Индекс товара на весах.
	ПараметрыСтроки.Вставить("Код"); // Число,Обязательно   - Код товара который печатается на штрихкоде этикетки.
	ПараметрыСтроки.Вставить("Штрихкод");
	ПараметрыСтроки.Вставить("Наименование"); // Строка,Необязательно
	ПараметрыСтроки.Вставить("НаименованиеПолное");  // Строка,Необязательно
	ПараметрыСтроки.Вставить("ВесовойТовар", Истина);
	ПараметрыСтроки.Вставить("Цена", 0);
	ПараметрыСтроки.Вставить("ОписаниеТовара");  // Строка,Необязательно
	ПараметрыСтроки.Вставить("СрокХранения");  
	Возврат ПараметрыСтроки;
	
КонецФункции

#КонецОбласти

