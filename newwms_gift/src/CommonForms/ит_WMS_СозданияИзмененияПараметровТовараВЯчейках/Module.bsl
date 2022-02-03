
&НаКлиенте
Процедура СоздатьДокумент(Команда)
	Если Основание.Пустая() Тогда 
		Сообщить("Документ должен быть проведен");
		Возврат
	КонецЕсли;
	Если не  ПроверкаНаНаличиеПроведеннойПереупаковки() Тогда 
		Сообщить("Нет ни одного документа Переупаковки КТ-2000, создайте в начале переупаковку по маркам");
		Возврат
	КонецЕсли;
	ОткрытьФорму("Документ.итWMSИзменениеПараметровТовараВЯчейках.Форма.ФормаДокумента",новый Структура("ИтОснование,ЯчейкаАнализа",Основание,ЯчейкаАнализа),ЭтаФорма.ВладелецФормы);
	ЭтаФорма.Закрыть();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если не Параметры.Свойство("Основание") Тогда 
		Отказ=Истина;
		Возврат
	КонецЕсли;
	Основание=Параметры.Основание;
КонецПроцедуры
&НаСервере
Функция ПроверкаНаНаличиеПроведеннойПереупаковки()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	алкПереупаковка.Ссылка
	|ИЗ
	|	Документ.алкПереупаковка КАК алкПереупаковка
	|ГДЕ
	|	алкПереупаковка.Проведен = ИСТИНА
	|	И алкПереупаковка.ДокументОснование = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Основание);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() Тогда 
		Возврат Истина;	
	КонецЕсли;
	Возврат Ложь;
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецФункции