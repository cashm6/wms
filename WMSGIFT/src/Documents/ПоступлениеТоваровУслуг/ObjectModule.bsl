
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	Если ТипЗнч(ДанныеЗаполнения)=Тип("ДокументСсылка.итWMSПриемка") Тогда 
		ЗаполнитьПоПриемке(ДанныеЗаполнения)
	КонецЕсли;
КонецПроцедуры

Процедура ЗаполнитьПоПриемке(Приемка)
	
	итОснование=Приемка;
	Организация=Приемка.Организация;
	Контрагент=Приемка.Контрагент;
	НомерВходящегоДокумента=Приемка.НомерВходящегоДокумента;
	ДатаВходящегоДокумента=Приемка.ДатаВходящегоДокумента;
	Склад=Приемка.Склад;
	итКоличествоВозвратнойТары=КоличествоSSCCВПриёмке(Приемка);
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSПриемкаТовары.Номенклатура КАК Номенклатура,
		|	итWMSПриемкаТовары.Характеристика КАК Характеристика,
		|	итWMSПриемкаТовары.Качество КАК Качество,
		|	итWMSПриемкаТовары.СерияНоменклатуры КАК СерияНоменклатуры,
		|	СУММА(итWMSПриемкаТовары.КоличествоФакт) КАК Количество
		|ИЗ
		|	Документ.итWMSПриемка.Товары КАК итWMSПриемкаТовары
		|ГДЕ
		|	итWMSПриемкаТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSПриемкаТовары.Номенклатура,
		|	итWMSПриемкаТовары.Характеристика,
		|	итWMSПриемкаТовары.Качество,
		|	итWMSПриемкаТовары.СерияНоменклатуры";
	
	Запрос.УстановитьПараметр("Ссылка", Приемка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Товары.Очистить();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	НоваяСтрока=Товары.Добавить();	
	ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
	НоваяСтрока.ХарактеристикаНоменклатуры=ВыборкаДетальныеЗаписи.Характеристика;
	НоваяСтрока.Качество=?(ВыборкаДетальныеЗаписи.Качество=Справочники.Качество.ПустаяСсылка(),Справочники.Качество.Новый,ВыборкаДетальныеЗаписи.Качество);
	НоваяСтрока.ЕдиницаИзмерения=ВыборкаДетальныеЗаписи.Номенклатура.ЕдиницаХраненияОстатков;
	НоваяСтрока.Коэффициент =ВыборкаДетальныеЗаписи.Номенклатура.ЕдиницаХраненияОстатков.Коэффициент;
	КонецЦикла;
	
КонецПроцедуры

// Для учета Вторичной тары
Функция КоличествоSSCCВПриёмке(ДанныеЗаполнения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Док.Ссылка КАК Ссылка,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Док.ИдентификаторУпаковки) КАК ИдентификаторУпаковки
		|ИЗ
		|	Документ.итWMSПриемка.Товары КАК Док
		|ГДЕ
		|	Док.Ссылка = &Ссылка
		|СГРУППИРОВАТЬ ПО
		|	Док.Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат 0;
	Иначе	
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Возврат Выборка.ИдентификаторУпаковки;
	КонецЕсли;
	
КонецФункции

//
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если Ответственный.Пустая() Тогда 
		Ответственный =	ПараметрыСеанса.ТекущийПользователь;
	КонецЕсли;
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда 
		ПроверкаНаЗадвоенностьПоОснованию(Отказ);
	КонецЕсли;
КонецПроцедуры


Процедура ПроверкаНаЗадвоенностьПоОснованию(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоступлениеТоваровУслуг.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ПоступлениеТоваровУслуг КАК ПоступлениеТоваровУслуг
		|ГДЕ
		|	ПоступлениеТоваровУслуг.итОснование = &итОснование
		|	И ПоступлениеТоваровУслуг.Ссылка <> &Ссылка
		|	И ПоступлениеТоваровУслуг.Проведен";
	
	Запрос.УстановитьПараметр("итОснование", итОснование);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Отказ=Истина;
		Сообщить("Уже есть документ по текущему основанию "+Строка(итОснование));
	КонецЦикла;
	

	
	КонецПроцедуры
