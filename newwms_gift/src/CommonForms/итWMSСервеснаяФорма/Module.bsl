
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Параметры.ИмяКоманды="итWMSЗаполнитьЯчейкиРежим1" Тогда 
		ОбработчикитWMSЗаполнитьЯчейкиРежим1();
	КонецЕсли;
	ЭтаФорма.Закрыть();
	КонецПроцедуры
&НаКлиенте	
Процедура ОбработчикитWMSЗаполнитьЯчейкиРежим1()
	Если ПроверкаНаСтатусДокумента(ВладелецФормы.Объект.СтатусДокумента) Тогда 
		Возврат
	КонецЕсли;	
	ЯчейкаПолучатель=Неопределено;
	ЯчейкаПолучатель=ВладелецФормы.Объект.Товары[0].ЯчейкаПолучатель;
	ФиксацияСтроки=Ложь;
	Попытка
		ФиксацияСтроки=ВладелецФормы.Объект.Товары[0].ФиксацияСтроки;
		ФиксацияСтроки=Истина;
	Исключение
		ФиксацияСтроки=Ложь;
	КонецПопытки;
	Для Каждого стр из ВладелецФормы.Объект.Товары цикл
		Если ФиксацияСтроки Тогда 
			Если стр.ФиксацияСтроки Тогда 
				Продолжить;
			КонецЕсли;
		КонецЕсли;	
			стр.ЯчейкаПолучатель=ЯчейкаПолучатель;
		КонецЦикла;
	КонецПроцедуры
&НаСервере	
Функция  ПроверкаНаСтатусДокумента(СтатусДокумента)
		Если СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован Тогда 
			Возврат Ложь;
		КонецЕсли;	
		Если  СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется Тогда 
			Возврат Ложь;
		КонецЕсли;	
		Если  СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан Тогда 
			Возврат Ложь;
		КонецЕсли;	
		Возврат Истина;
КонецФункции
	
	
