#Область ПрограммныйИнтерфейс

// Обработчик события вызывается на сервере при установке номера кассовой смены.
//
// Параметры:
//	Объект - ДокументСсылка.КассоваяСмена - Значение, которое используется как основание для заполнения.
//	СтандартнаяОбработка - Булево - признак выполнения стандартной обработки,
//	Префикс - Строка - префикс, который будет использоваться для генерации номера
//
Процедура ПриУстановкеНовогоНомера(Объект, СтандартнаяОбработка, Префикс) Экспорт
	
КонецПроцедуры

// Обработчик события вызывается на сервере при необходимости проверки корректности заполнения кассовой смены.
//
// Параметры:
//  Объект - ДокументСсылка.КассоваяСмена - Значение, которое используется как основание для заполнения.
//  Отказ - Булево
//  ПроверяемыеРеквизиты - Массив - реквизиты, для которых будет выполнена проверка заполнения
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
КонецПроцедуры

// Обработчик события вызывается на сервере при вводе документа кассовая смена на основании.
//
// Параметры:
//  Объект - ДокументСсылка.КассоваяСмена - Значение, которое используется как основание для заполнения.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения,
//  ТекстЗаполнения - Строка, Неопределено - Текст, используемый для заполнения документа
//  СтандартнаяОбработка - Булево
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Обработчик события вызывается на сервере при создании на сервере формы списка Кассовая смена.
//
// Параметры:
//  Форма - Форма - открываемая форма.
//
Процедура ФормаСпискаПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Обработчик события вызывается на сервере при создании на сервере формы документа Кассовая смена.
//
// Параметры:
//  Форма - Форма - открываемая форма.
//
Процедура ФормаДокументаПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

#КонецОбласти
