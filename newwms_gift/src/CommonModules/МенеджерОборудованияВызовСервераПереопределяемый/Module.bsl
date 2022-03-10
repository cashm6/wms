#Область ПрограммныйИнтерфейс

// Возвращает список доступных типов оборудования.
// 
// Параметры:
//   СписокТиповОборудования - Массив - Массив доступных типов подключаемого оборудования в конфигурации.
//   СтандартнаяОбработка - Булево - признак выполнения стандартной обработки,
// Пример:
//   СписокТиповОборудования.Добавить(Перечисления.ТипыПодключаемогоОборудования.ККТ).
//
Процедура ДоступныеТипыОборудования(СписокТиповОборудования, СтандартнаяОбработка) Экспорт

КонецПроцедуры

// Возвращает флаг возможности добавления новых драйверов оборудования в справочник.
// Параметры:
//   ДобавлениеНовыхДрайверовДоступно - Булево - флаг возможности добавления новых компонент подключения оборудования.
//   СтандартнаяОбработка - Булево - признак выполнения стандартной обработки,
// Пример:
//   ДобавлениеНовыхДрайверовДоступно = Ложь;
//   СтандартнаяОбработка = Ложь. 
//
Процедура ДоступноДобавлениеНовыхДрайверов(ДобавлениеНовыхДрайверовДоступно, СтандартнаяОбработка) Экспорт

КонецПроцедуры

// Возвращает доступность сетевого оборудования.
//
// Параметры:
//  СетевоеОборудованиеДоступно - Булево - Сетевое оборудование доступно.
//  СтандартнаяОбработка - Булево - Стандартная обработка.
//
Процедура ДоступноСетевоеОборудование(СетевоеОборудованиеДоступно, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Возвращает доступность распределенной фискализации.
//  
// Параметры:
//  РаспределеннаяФискализацииДоступна - Булево - Доступность распределенной фискализации.
//  СтандартнаяОбработка - Булево - Стандартная обработка.
//
Процедура ДоступноРаспределеннаяФискализация(РаспределеннаяФискализацииДоступна, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Переопределяемая процедура для подсистемы управление доступом СтандартныеПодсистемы
// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
//
// Параметры:
//  Менеджер - Строка 
//  Ограничение - Структура:
//    * Текст                             - Строка - ограничение доступа для пользователей.
//                                          Если пустая строка, значит, доступ разрешен.
//    * ТекстДляВнешнихПользователей      - Строка - ограничение доступа для внешних пользователей.
//                                          Если пустая строка, значит, доступ запрещен.
//    * ПоВладельцуБезЗаписиКлючейДоступа - Неопределено - определить автоматически.
//                                        - Булево - если Ложь, то всегда записывать ключи доступа,
//                                          если Истина, тогда не записывать ключи доступа,
//                                          а использовать ключи доступа владельца (требуется,
//                                          чтобы ограничение было строго по объекту-владельцу).
//   * ПоВладельцуБезЗаписиКлючейДоступаДляВнешнихПользователей - Неопределено, Булево - также
//                                          как у параметра ПоВладельцуБезЗаписиКлючейДоступа.
//
Процедура ПриЗаполненииОграниченияДоступа(Менеджер, Ограничение) Экспорт
	
КонецПроцедуры

#Область Обновление

// Переопределяемая часть процедуры обновления с БПО 3
//  
// Параметры:
//  СсылкаПодключаемоеОборудование - СправочникСсылка.ПодключаемоеОборудование - оборудование для обновления перехода с БПО 3
//
Процедура ОбновитьСправочникПодключаемогоОборудования(СсылкаПодключаемоеОборудование) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область ОборудованиеККТ

// Процедура заполняет реквизиты организации для регистрации ФН.
//  
// Параметры:
//  Организация - ОпределяемыйТип.ОрганизацияБПО - организация для заполнения реквизитов.
//  ПараметрыРегистрации - Структура - параметры регистрации ФН.
//
Процедура ЗаполнитьРеквизитыОрганизацииДляРегистрацииФН(Организация, ПараметрыРегистрации) Экспорт
	
КонецПроцедуры

// Переопределяет формируемый шаблон чека.
//
// Параметры:
//  ОбщиеПараметры - Структура - см.ОборудованиеЧекопечатающиеУстройстваКлиентСервер.ПараметрыОперацииФискализацииЧека().
//  ДополнительныйТекст - Строка - дополнительный текст шаблона чека.
//  СтандартнаяОбработка - Булево - признак стандартной обработки.
//  ТипОборудования - Строка - типы оборудования строкой.
//
// Возвращаемое Значение:
//  Булево
Функция СформироватьШаблонЧека(ОбщиеПараметры, ДополнительныйТекст, СтандартнаяОбработка, ТипОборудования = "") Экспорт

КонецФункции

// Переопределяет доступное ККТ для фискализации чека
//
// Параметры:
//  РеквизитыЧека - Структура - реквизиты фискального чека
//  СписокУстройств - Массив - Список доступных ККТ для фискализации
//  ИдентификаторУстройстваККТ - СправочникСсылка.ПодключаемоеОборудование - выбранное ККТ для фискализации
//
Процедура ДоступноеККТДляФискализации(РеквизитыЧека, СписокУстройств, ИдентификаторУстройстваККТ) Экспорт

КонецПроцедуры

// Возвращает для каких типов идентификаторов будет заполняться тег 1162 (код товара).
//
// Параметры:
//  ТипыИдентификаторов - Массив - Типы идентификаторов, Массив значений  Перечисления.ТипыИдентификаторовТовараККТ.
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура КодТовараЗаполняетсяДляТиповИдентификаторов(ТипыИдентификаторов, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Ведется учет ИСМП в конфигурации
// Параметры:
//  УчетПродукцииИСМП - Булево - Ведется учет ИСМП в конфигурации 
//  СтандартнаяОбработка - Булево - Выполнение стандартной обработки
//
Процедура ВедетсяУчетПродукцииИСМП(УчетПродукцииИСМП, СтандартнаяОбработка) Экспорт

КонецПроцедуры

#КонецОбласти

#Область РаботаСЭлементомФормы

// Дополнительные переопределяемые действия с элементом формы 
// служит для учета специфики визуального отображения в зависимости от типа клиента.
//
// Параметры:
//  ЭлементУправления - ЭлементУправленияИнтерфейсом - элемент управления.
//  СтандартнаяОбработка - Булево - Стандартная обработка.
//
Процедура ПодготовитьЭлементУправления(ЭлементУправления, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСФормойЭкземпляраОборудования

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриСозданииНаСервере".
//
// Параметры:
//  Объект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ЭтаФорма - ФормаКлиентскогоПриложения - Форма настройки оборудования
//  Отказ - Булево - Отказ создания
//  Параметры - Структура - Параметры операции
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура ЭкземплярОборудованияПриСозданииНаСервере(Объект, ЭтаФорма, Отказ, Параметры, СтандартнаяОбработка) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриЧтенииНаСервере".
//
// Параметры:
//  ТекущийОбъект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ЭтаФорма - ФормаКлиентскогоПриложения - Форма настройки оборудования
//
Процедура ЭкземплярОборудованияПриЧтенииНаСервере(ТекущийОбъект, ЭтаФорма) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПередЗаписьюНаСервере".
//
// Параметры:
//  Отказ - Булево - Отказ операции
//  ТекущийОбъект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ПараметрыЗаписи - Структура - Параметры операции
//
Процедура ЭкземплярОборудованияПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПриЗаписиНаСервере".
//
// Параметры:
//  Отказ - Булево - Отказ операции
//  ТекущийОбъект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ПараметрыЗаписи - Структура - Параметры операции
//
Процедура ЭкземплярОборудованияПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ПослеЗаписиНаСервере".
//
// Параметры:
//  ТекущийОбъект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ПараметрыЗаписи - Структура - Параметры операции
//
Процедура ЭкземплярОборудованияПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи) Экспорт

КонецПроцедуры

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре оборудования
// при событии "ОбработкаПроверкиЗаполненияНаСервере".
//
// Параметры:
//  Объект - СправочникОбъект.ПодключаемоеОборудование - Объект подключаемого оборудования.
//  ЭтаФорма - ФормаКлиентскогоПриложения - Форма настройки оборудования
//  Отказ - Булево - Отказ создания
//  ПроверяемыеРеквизиты - Структура - Проверяемые реквизиты
//
Процедура ЭкземплярОборудованияОбработкаПроверкиЗаполненияНаСервере(Объект, ЭтаФорма, Отказ, ПроверяемыеРеквизиты) Экспорт

КонецПроцедуры

#КонецОбласти

#Область РаботаСФормойЭкземпляраФискальныеОперации

// Дополнительные переопределяемые действия с управляемой формой в Экземпляре Фискальные операции
// при событии "ПриСозданииНаСервере".
//
// Параметры:
//  Запись - РегистрСведенийЗапись.ФискальныеОперации - Запись фискальные операции.
//  ЭтаФорма - ФормаКлиентскогоПриложения - Форма настройки оборудования
//  Отказ - Булево - Отказ создания
//  Параметры - Структура - Параметры операции
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура ЭкземплярФискальныеОперацииПриСозданииНаСервере(Запись, ЭтаФорма, Отказ, Параметры, СтандартнаяОбработка) Экспорт

КонецПроцедуры

#КонецОбласти

#Область РаботаСФормойСпискаФискальныеОперации

// Дополнительные переопределяемые действия с управляемой формой в Список Фискальные операции
// при событии "ПриСозданииНаСервере".
//
// Параметры:
//  ЭтаФорма - ФормаКлиентскогоПриложения - Форма настройки оборудования
//  Отказ - Булево - Отказ создания
//  Параметры - Структура - Параметры операции
//  СтандартнаяОбработка - Булево - Стандартная обработка
//
Процедура СписокФискальныеОперацииПриСозданииНаСервере(ЭтаФорма, Отказ, Параметры, СтандартнаяОбработка) Экспорт

КонецПроцедуры

#КонецОбласти

#Область ОчередьФискальныхЧеков

// Завершение фискализация чека в очереди
//
// Параметры:
//  ИдентификаторФискальнойЗаписи - Строка - Идентификатор фискальной записи
//  ПараметрыФискализации - Структура - Параметры операции
//  ОборудованиеККТ - СправочникСсылка.ПодключаемоеОборудование -
//  РезультатФискализации - Структура - Результат Фискализации
//
Процедура ФискализацияЧекаВОчереди(ИдентификаторФискальнойЗаписи, ПараметрыФискализации, ОборудованиеККТ, РезультатФискализации) Экспорт

КонецПроцедуры

// Завершение фискализация чека в очереди
//
// Параметры:
//  РеквизитыЧека - Структура - Данные документа основания.
//  СтатусДокументаИзменен - Булево - признак изменения статуса документа.
//
Процедура ПроверитьСтатусДокументаОснования(РеквизитыЧека, СтатусДокументаИзменен) Экспорт
	
КонецПроцедуры

#КонецОбласти

// Обработчик события заполнения персональных данных.
//
// Параметры:
//  ПерсональныеДанные - Структура - Возвращаемый параметр, персональные данные.
//  СубъектПерсональныхДанных - ОпределяемыйТип.СубъектПерсональныхДанныхБПО - субъект персональных данных. 
//  ТипПерсональныхДанных - ПеречислениеСсылка.ТипыПерсональныхДанныхККТ - Тип персональных данных
//  НаДату - Дата - Дата, на которую необходимо получать персональные данные
//
Процедура ОбработкаЗаполненияПерсональныхДанных(ПерсональныеДанные, СубъектПерсональныхДанных, ТипПерсональныхДанных, НаДату) Экспорт
	
КонецПроцедуры

#КонецОбласти
