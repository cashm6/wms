
&НаКлиенте
Процедура СписокПередУдалением(Элемент, Отказ)
	// Вставить содержимое обработчика.
	Отказ=ПроверкаНаВозможностьУдаления(Элемент.ТекущиеДанные.ДиапазонС,Элемент.ТекущиеДанные.ДиапазонПо);
	Если  Отказ тогда
		Сообщить("Вы не можите удалить данную настройку,т.к по ней уже имеются SSCC");
	КонецЕсли;	

КонецПроцедуры
&НаСервере
Функция ПроверкаНаВозможностьУдаления(ДиапазонС,ДиапазонПо)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSАрхивSSCC.SSCC
		|ИЗ
		|	РегистрСведений.итWMSАрхивSSCC КАК итWMSАрхивSSCC
		|ГДЕ
		|	итWMSАрхивSSCC.ИдентификаторSSCC МЕЖДУ &ДиапазонС И &ДиапазонПо";
	
	Запрос.УстановитьПараметр("ДиапазонПо", ДиапазонПо);
	Запрос.УстановитьПараметр("ДиапазонС", ДиапазонС);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() тогда
		Возврат Ложь;
	иначе
		Возврат Истина;
	КонецЕсли;	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	КонецФункции