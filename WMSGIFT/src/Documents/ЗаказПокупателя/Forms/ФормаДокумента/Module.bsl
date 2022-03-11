
&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	РежимЗаписи=Неопределено;
	ПараметрыЗаписи.Свойство("РежимЗаписи",РежимЗаписи);
	СтруктураОтвета=ЗаказСозданНаДругомУзле();	
	Если СтруктураОтвета.Ответ Тогда 
		Если ЭтаФорма.Модифицированность Тогда 
			Отказ=Истина;
			Сообщить(СтруктураОтвета.Сообщение);
			Возврат;
		КонецЕсли;
		Если не Объект.Проведен и РежимЗаписи=РежимЗаписиДокумента.Проведение Тогда 
			Отказ=Истина;
			Сообщить(СтруктураОтвета.Сообщение);
			Возврат;
		КонецЕсли;
		Если Объект.Проведен и РежимЗаписи=РежимЗаписиДокумента.ОтменаПроведения Тогда 
			Отказ=Истина;
			Сообщить(СтруктураОтвета.Сообщение);
			Возврат;
		КонецЕсли;
	КонецЕсли;	
КонецПроцедуры
&НаСервере
Функция  ЗаказСозданНаДругомУзле()
	Если Объект.Ссылка.Пустая() Тогда 
		Возврат новый Структура("Ответ,Сообщение",Ложь,"");
	КонецЕсли;	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СоответствиеОбъектовДляОбмена.СсылкаВДругойИБ КАК СсылкаВДругойИБ,
		|	СоответствиеОбъектовДляОбмена.УзелОбмена КАК УзелОбмена
		|ИЗ
		|	РегистрСведений.СоответствиеОбъектовДляОбмена КАК СоответствиеОбъектовДляОбмена
		|ГДЕ
		|	СоответствиеОбъектовДляОбмена.СобственнаяСсылка = &СобственнаяСсылка";
	
	Запрос.УстановитьПараметр("СобственнаяСсылка", Объект.Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат новый Структура("Ответ,Сообщение",Истина,"Не возможно изменить заказ в этой базе ,т.к он создан на узле "+Строка(ВыборкаДетальныеЗаписи.УзелОбмена));
	КонецЦикла;
	Возврат новый Структура("Ответ,Сообщение",Ложь,"");

	
	КонецФункции