
&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	Если ИсточникВыбора.ИмяФормы="Справочник.НаборыУпаковок.ФормаВыбора"	Тогда
		ЗаполнитьSSCCиGTINИзНабораНаСервере(ВыбранноеЗначение)
	КонецЕсли;
КонецПроцедуры
&НаСервере
Процедура ЗаполнитьSSCCиGTINИзНабораНаСервере(СсылкаНаНабор)
	Для Каждого  стр из Объект.АкцизныеМарки Цикл 
		стр.Упаковка= СсылкаНаНабор.GTIN;
	КонецЦикла;
	Объект.Упаковки.Очистить();
	СтрокаУпаковки=Объект.Упаковки.Добавить();
	СтрокаУпаковки.Упаковка=СсылкаНаНабор.GTIN;
	СтрокаУпаковки.ИерархияУпаковки=СсылкаНаНабор.SSCC;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьSSCCиGTINИзНабора(Команда)
	ОткрытьФорму("Справочник.НаборыУпаковок.ФормаВыбора",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДаннымиДокументаОснования(Команда)
	ЗаполнитьДаннымиДокументаОснованияНаСервере();
КонецПроцедуры
&НаСервере
Процедура ЗаполнитьДаннымиДокументаОснованияНаСервере()
	Если ТипЗнч(Объект.ДокументОснование) = тип("ДокументСсылка.итWMSДокументСвободнойАгрегации") тогда
		НаОснованииИтWMSДокументСвободнойАгрегации();
	КонецЕсли;
	Если ТипЗнч(Объект.ДокументОснование) = тип("ДокументСсылка.итWMSКонтрольнаяОперацияАгрегации") тогда
		НаОснованииКОА();
	КонецЕсли;

КонецПроцедуры
&НаСервере	
Процедура НаОснованииИтWMSДокументСвободнойАгрегации()
	Если Объект.ДокументОснование.Пустая() тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("пустая ссылка не может быть основанием");
		Возврат;
	КонецЕсли;
	Если Объект.ДокументОснование.Проведен=Ложь  тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("Документ должен быть проведен");
		Возврат;
	КонецЕсли;

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	алкХранилищеАкцизныхМарокСрезПоследних.Марка КАК Марка,
	|	итWMS_АгрегацияМарокСрезПоследних.SSCC КАК SSCC,
	|	итWMS_АгрегацияМарокСрезПоследних.GTIN КАК Упаковка,
	|	алкХранилищеАкцизныхМарокСрезПоследних.СправкаБ КАК СправкаБ,
	|	алкХранилищеАкцизныхМарокСрезПоследних.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	алкХранилищеАкцизныхМарокСрезПоследних.Организация КАК Организация,
	|	алкХранилищеАкцизныхМарокСрезПоследних.ПунктРазгрузки КАК ПунктРазгрузки,
	|	алкХранилищеАкцизныхМарокСрезПоследних.ОтметкаВыбытия КАК ОтметкаВыбытия
	|ПОМЕСТИТЬ ВтДанныеУчета
	|ИЗ
	|	РегистрСведений.итWMS_АгрегацияМарок.СрезПоследних(
	|			,
	|			ДокументОснование = &Ссылка
	|				И АктивностьЗаписи = ИСТИНА) КАК итWMS_АгрегацияМарокСрезПоследних
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок.СрезПоследних КАК алкХранилищеАкцизныхМарокСрезПоследних
	|		ПО итWMS_АгрегацияМарокСрезПоследних.Марка = алкХранилищеАкцизныхМарокСрезПоследних.Марка
	|			И (НЕ алкХранилищеАкцизныхМарокСрезПоследних.Марка.ПометкаУдаления)
	|
	|СГРУППИРОВАТЬ ПО
	|	итWMS_АгрегацияМарокСрезПоследних.SSCC,
	|	итWMS_АгрегацияМарокСрезПоследних.GTIN,
	|	алкХранилищеАкцизныхМарокСрезПоследних.СправкаБ,
	|	алкХранилищеАкцизныхМарокСрезПоследних.АлкогольнаяПродукция,
	|	алкХранилищеАкцизныхМарокСрезПоследних.Организация,
	|	алкХранилищеАкцизныхМарокСрезПоследних.ПунктРазгрузки,
	|	алкХранилищеАкцизныхМарокСрезПоследних.ОтметкаВыбытия,
	|	алкХранилищеАкцизныхМарокСрезПоследних.Марка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтДанныеУчета.Упаковка КАК Упаковка,
	|	ВтДанныеУчета.SSCC КАК ИерархияУпаковки
	|ИЗ
	|	ВтДанныеУчета КАК ВтДанныеУчета
	|
	|СГРУППИРОВАТЬ ПО
	|	ВтДанныеУчета.Упаковка,
	|	ВтДанныеУчета.SSCC
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтДанныеУчета.Марка КАК Марка,
	|	ВтДанныеУчета.SSCC КАК SSCC,
	|	ВтДанныеУчета.Упаковка КАК Упаковка,
	|	ВтДанныеУчета.СправкаБ КАК СправкаБ,
	|	ВтДанныеУчета.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	ВтДанныеУчета.Организация КАК Организация,
	|	ВтДанныеУчета.ПунктРазгрузки КАК ПунктРазгрузки,
	|	ВтДанныеУчета.ОтметкаВыбытия КАК ОтметкаВыбытия
	|ИЗ
	|	ВтДанныеУчета КАК ВтДанныеУчета";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.ДокументОснование);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	ВыборкаУпаковок=МассивРезультатов[1].Выбрать();
	ВыборкаДетальныхДанных=МассивРезультатов[2].выбрать();
	Объект.АкцизныеМарки.Очистить();
	Объект.Упаковки.Очистить();
	Пока ВыборкаДетальныхДанных.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.АкцизныеМарки.Добавить(),ВыборкаДетальныхДанных);	
	КонецЦикла;
	Пока ВыборкаУпаковок.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.Упаковки.Добавить(),ВыборкаУпаковок);
	КонецЦикла;
	

	
КонецПроцедуры
&НаСервере
Процедура НаОснованииКОА()
	Если Объект.ДокументОснование.Пустая() тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("пустая ссылка не может быть основанием");
		Возврат;
	КонецЕсли;
	Если Объект.ДокументОснование.Проведен=Ложь  тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("Документ должен быть проведен");
		Возврат;
	КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.Марка КАК Марка,
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.SSCC КАК SSCC,
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.GTIN КАК Упаковка
		|ПОМЕСТИТЬ ВтДанныеКОА
		|ИЗ
		|	Документ.итWMSКонтрольнаяОперацияАгрегации.ДанныеАгрегацииДокумента КАК итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента
		|ГДЕ
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.Марка,
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.SSCC,
		|	итWMSКонтрольнаяОперацияАгрегацииДанныеАгрегацииДокумента.GTIN
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	алкХранилищеАкцизныхМарокСрезПоследних.Марка КАК Марка,
		|	ВтДанныеКОА.SSCC КАК SSCC,
		|	ВтДанныеКОА.Упаковка КАК Упаковка,
		|	алкХранилищеАкцизныхМарокСрезПоследних.СправкаБ КАК СправкаБ,
		|	алкХранилищеАкцизныхМарокСрезПоследних.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
		|	алкХранилищеАкцизныхМарокСрезПоследних.Организация КАК Организация,
		|	алкХранилищеАкцизныхМарокСрезПоследних.ПунктРазгрузки КАК ПунктРазгрузки,
		|	алкХранилищеАкцизныхМарокСрезПоследних.ОтметкаВыбытия КАК ОтметкаВыбытия
		|ПОМЕСТИТЬ ВтДвнныеУчета
		|ИЗ
		|	ВтДанныеКОА КАК ВтДанныеКОА
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок.СрезПоследних КАК алкХранилищеАкцизныхМарокСрезПоследних
		|		ПО ВтДанныеКОА.Марка = алкХранилищеАкцизныхМарокСрезПоследних.Марка
		|			И (НЕ алкХранилищеАкцизныхМарокСрезПоследних.Марка.ПометкаУдаления)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВтДвнныеУчета.Упаковка КАК Упаковка,
		|	ВтДвнныеУчета.SSCC КАК ИерархияУпаковки
		|ИЗ
		|	ВтДвнныеУчета КАК ВтДвнныеУчета
		|
		|СГРУППИРОВАТЬ ПО
		|	ВтДвнныеУчета.Упаковка,
		|	ВтДвнныеУчета.SSCC
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВтДвнныеУчета.Марка КАК Марка,
		|	ВтДвнныеУчета.SSCC КАК SSCC,
		|	ВтДвнныеУчета.Упаковка КАК Упаковка,
		|	ВтДвнныеУчета.СправкаБ КАК СправкаБ,
		|	ВтДвнныеУчета.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
		|	ВтДвнныеУчета.Организация КАК Организация,
		|	ВтДвнныеУчета.ПунктРазгрузки КАК ПунктРазгрузки,
		|	ВтДвнныеУчета.ОтметкаВыбытия КАК ОтметкаВыбытия
		|ИЗ
		|	ВтДвнныеУчета КАК ВтДвнныеУчета";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.ДокументОснование);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	ВыборкаУпаковок=МассивРезультатов[2].Выбрать();
	ВыборкаДетальныхДанных=МассивРезультатов[3].выбрать();
	Объект.АкцизныеМарки.Очистить();
	Объект.Упаковки.Очистить();
	Пока ВыборкаДетальныхДанных.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.АкцизныеМарки.Добавить(),ВыборкаДетальныхДанных);	
	КонецЦикла;
	Пока ВыборкаУпаковок.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.Упаковки.Добавить(),ВыборкаУпаковок);
	КонецЦикла;


	КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРазницуМарок(Команда)
		ЗаполнитьРазницуМарокНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРазницуМарокНаСервере()
	Если ТипЗнч(Объект.ДокументОснование) = тип("ДокументСсылка.итWMSДокументСвободнойАгрегации") тогда
		РазницаНаОснованииИтWMSДокументСвободнойАгрегации();
	КонецЕсли;
	
КонецПроцедуры
&НаСервере
Процедура РазницаНаОснованииИтWMSДокументСвободнойАгрегации()

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSДокументСвободнойАгрегации.Ссылка КАК ДокументОснование
	|ПОМЕСТИТЬ ТаблицаОснования
	|ИЗ
	|	Документ.итWMSДокументСвободнойАгрегации КАК итWMSДокументСвободнойАгрегации
	|ГДЕ
	|	итWMSДокументСвободнойАгрегации.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВложенныйЗапрос.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения,
	|	ВложенныйЗапрос.ДокументОснование КАК ДокументОснование,
	|	МИНИМУМ(ЕСТЬNULL(алкПереупаковка.Ссылка, ЗНАЧЕНИЕ(Документ.алкПереупаковка.ПустаяСсылка))) КАК ДокументПереупаковки
	|ПОМЕСТИТЬ ДанныеДляОтбораДанныхМарок
	|ИЗ
	|	(ВЫБРАТЬ
	|		МИНИМУМ(ЕСТЬNULL(алкПереупаковка.Дата, &ТекущаяДата)) КАК МинимальнаяДатаИзменения,
	|		ТаблицаОснования.ДокументОснование КАК ДокументОснование
	|	ИЗ
	|		ТаблицаОснования КАК ТаблицаОснования
	|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.алкПереупаковка КАК алкПереупаковка
	|			ПО ТаблицаОснования.ДокументОснование = алкПереупаковка.ДокументОснование
	|				И (алкПереупаковка.Проведен = ИСТИНА)
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ТаблицаОснования.ДокументОснование) КАК ВложенныйЗапрос
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.алкПереупаковка КАК алкПереупаковка
	|		ПО ВложенныйЗапрос.МинимальнаяДатаИзменения = алкПереупаковка.Дата
	|			И ВложенныйЗапрос.ДокументОснование = алкПереупаковка.ДокументОснование
	|			И (алкПереупаковка.Проведен = ИСТИНА)
	|
	|СГРУППИРОВАТЬ ПО
	|	ВложенныйЗапрос.ДокументОснование,
	|	ВложенныйЗапрос.МинимальнаяДатаИзменения
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	итWMS_АгрегацияМарокСрезПоследних.Марка КАК Марка,
	|	ДанныеДляОтбораДанныхМарок.ДокументОснование КАК ДокументОснование,
	|	ДанныеДляОтбораДанныхМарок.ДокументПереупаковки КАК ДокументПереупаковки,
	|	ДанныеДляОтбораДанныхМарок.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения
	|ПОМЕСТИТЬ МаркиДокументаСвободнойАгрегации
	|ИЗ
	|	ДанныеДляОтбораДанныхМарок КАК ДанныеДляОтбораДанныхМарок
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.итWMS_АгрегацияМарок.СрезПоследних(, ДокументОснование = &Ссылка) КАК итWMS_АгрегацияМарокСрезПоследних
	|		ПО ДанныеДляОтбораДанныхМарок.ДокументОснование = итWMS_АгрегацияМарокСрезПоследних.ДокументОснование
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	алкХранилищеАкцизныхМарок.Период КАК Период,
	|	алкХранилищеАкцизныхМарок.Регистратор КАК Регистратор,
	|	алкХранилищеАкцизныхМарок.Активность КАК Активность,
	|	алкХранилищеАкцизныхМарок.Марка КАК Марка,
	|	алкХранилищеАкцизныхМарок.Упаковка КАК Упаковка,
	|	алкХранилищеАкцизныхМарок.СправкаБ КАК СправкаБ,
	|	алкХранилищеАкцизныхМарок.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	алкХранилищеАкцизныхМарок.Организация КАК Организация,
	|	алкХранилищеАкцизныхМарок.ПунктРазгрузки КАК ПунктРазгрузки,
	|	алкХранилищеАкцизныхМарок.ОтметкаВыбытия КАК ОтметкаВыбытия,
	|	ВложенныйЗапрос.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения,
	|	ВложенныйЗапрос.ДокументПереупаковки КАК ДокументПереупаковки
	|ПОМЕСТИТЬ ДанныеМарокДоПереупаковки
	|ИЗ
	|	(ВЫБРАТЬ
	|		МаркиДокументаСвободнойАгрегации.Марка КАК Марка,
	|		МаркиДокументаСвободнойАгрегации.ДокументОснование КАК ДокументОснование,
	|		МаркиДокументаСвободнойАгрегации.ДокументПереупаковки КАК ДокументПереупаковки,
	|		МаркиДокументаСвободнойАгрегации.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения,
	|		МАКСИМУМ(алкХранилищеАкцизныхМарок.Период) КАК Период
	|	ИЗ
	|		МаркиДокументаСвободнойАгрегации КАК МаркиДокументаСвободнойАгрегации
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
	|			ПО МаркиДокументаСвободнойАгрегации.Марка = алкХранилищеАкцизныхМарок.Марка
	|				И МаркиДокументаСвободнойАгрегации.МинимальнаяДатаИзменения >= алкХранилищеАкцизныхМарок.Период
	|				И МаркиДокументаСвободнойАгрегации.ДокументПереупаковки <> алкХранилищеАкцизныхМарок.Регистратор
	|	
	|	СГРУППИРОВАТЬ ПО
	|		МаркиДокументаСвободнойАгрегации.Марка,
	|		МаркиДокументаСвободнойАгрегации.ДокументОснование,
	|		МаркиДокументаСвободнойАгрегации.ДокументПереупаковки,
	|		МаркиДокументаСвободнойАгрегации.МинимальнаяДатаИзменения) КАК ВложенныйЗапрос
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
	|		ПО ВложенныйЗапрос.Марка = алкХранилищеАкцизныхМарок.Марка
	|			И ВложенныйЗапрос.ДокументПереупаковки <> алкХранилищеАкцизныхМарок.Регистратор
	|			И ВложенныйЗапрос.Период = алкХранилищеАкцизныхМарок.Период
	|
	|СГРУППИРОВАТЬ ПО
	|	алкХранилищеАкцизныхМарок.Период,
	|	алкХранилищеАкцизныхМарок.Регистратор,
	|	алкХранилищеАкцизныхМарок.Активность,
	|	алкХранилищеАкцизныхМарок.Марка,
	|	алкХранилищеАкцизныхМарок.Упаковка,
	|	алкХранилищеАкцизныхМарок.СправкаБ,
	|	алкХранилищеАкцизныхМарок.АлкогольнаяПродукция,
	|	алкХранилищеАкцизныхМарок.Организация,
	|	алкХранилищеАкцизныхМарок.ПунктРазгрузки,
	|	алкХранилищеАкцизныхМарок.ОтметкаВыбытия,
	|	ВложенныйЗапрос.МинимальнаяДатаИзменения,
	|	ВложенныйЗапрос.ДокументПереупаковки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеМарокДоПереупаковки.Упаковка КАК Упаковка,
	|	ДанныеМарокДоПереупаковки.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения,
	|	ДанныеМарокДоПереупаковки.ДокументПереупаковки КАК ДокументПереупаковки
	|ПОМЕСТИТЬ УпаковкиКОтбору
	|ИЗ
	|	ДанныеМарокДоПереупаковки КАК ДанныеМарокДоПереупаковки
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеМарокДоПереупаковки.Упаковка,
	|	ДанныеМарокДоПереупаковки.МинимальнаяДатаИзменения,
	|	ДанныеМарокДоПереупаковки.ДокументПереупаковки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	алкХранилищеАкцизныхМарок.Период КАК Период,
	|	алкХранилищеАкцизныхМарок.Регистратор КАК Регистратор,
	|	алкХранилищеАкцизныхМарок.НомерСтроки КАК НомерСтроки,
	|	алкХранилищеАкцизныхМарок.Активность КАК Активность,
	|	алкХранилищеАкцизныхМарок.Марка КАК Марка,
	|	алкХранилищеАкцизныхМарок.Упаковка КАК Упаковка,
	|	алкХранилищеАкцизныхМарок.СправкаБ КАК СправкаБ,
	|	алкХранилищеАкцизныхМарок.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	алкХранилищеАкцизныхМарок.Организация КАК Организация,
	|	алкХранилищеАкцизныхМарок.ПунктРазгрузки КАК ПунктРазгрузки,
	|	алкХранилищеАкцизныхМарок.ОтметкаВыбытия КАК ОтметкаВыбытия
	|ПОМЕСТИТЬ МаркиУпаковок
	|ИЗ
	|	(ВЫБРАТЬ
	|		МАКСИМУМ(алкХранилищеАкцизныхМарок.Период) КАК Период,
	|		УпаковкиКОтбору.Упаковка КАК Упаковка,
	|		УпаковкиКОтбору.МинимальнаяДатаИзменения КАК МинимальнаяДатаИзменения,
	|		УпаковкиКОтбору.ДокументПереупаковки КАК ДокументПереупаковки
	|	ИЗ
	|		УпаковкиКОтбору КАК УпаковкиКОтбору
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
	|			ПО УпаковкиКОтбору.Упаковка = алкХранилищеАкцизныхМарок.Упаковка
	|				И УпаковкиКОтбору.МинимальнаяДатаИзменения >= алкХранилищеАкцизныхМарок.Период
	|				И УпаковкиКОтбору.ДокументПереупаковки <> алкХранилищеАкцизныхМарок.Регистратор
	|	
	|	СГРУППИРОВАТЬ ПО
	|		УпаковкиКОтбору.Упаковка,
	|		УпаковкиКОтбору.МинимальнаяДатаИзменения,
	|		УпаковкиКОтбору.ДокументПереупаковки) КАК ВложенныйЗапрос
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
	|		ПО ВложенныйЗапрос.Период = алкХранилищеАкцизныхМарок.Период
	|			И ВложенныйЗапрос.ДокументПереупаковки <> алкХранилищеАкцизныхМарок.Регистратор
	|			И ВложенныйЗапрос.Упаковка = алкХранилищеАкцизныхМарок.Упаковка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	МаркиУпаковок.Период КАК Период,
	|	МаркиУпаковок.Регистратор КАК Регистратор,
	|	МаркиУпаковок.НомерСтроки КАК НомерСтроки,
	|	МаркиУпаковок.Активность КАК Активность,
	|	МаркиУпаковок.Марка КАК Марка,
	|	МаркиУпаковок.Упаковка КАК Упаковка,
	|	МаркиУпаковок.СправкаБ КАК СправкаБ,
	|	МаркиУпаковок.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	МаркиУпаковок.Организация КАК Организация,
	|	МаркиУпаковок.ПунктРазгрузки КАК ПунктРазгрузки,
	|	МаркиУпаковок.ОтметкаВыбытия КАК ОтметкаВыбытия
	|ПОМЕСТИТЬ ПотерянныеМаркиУпаковок
	|ИЗ
	|	МаркиУпаковок КАК МаркиУпаковок
	|		ЛЕВОЕ СОЕДИНЕНИЕ МаркиДокументаСвободнойАгрегации КАК МаркиДокументаСвободнойАгрегации
	|		ПО МаркиУпаковок.Марка = МаркиДокументаСвободнойАгрегации.Марка
	|ГДЕ
	|	ВЫБОР
	|			КОГДА МаркиДокументаСвободнойАгрегации.Марка ЕСТЬ NULL
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ ЛОЖЬ
	|		КОНЕЦ
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПотерянныеМаркиУпаковок.Марка КАК Марка,
	|	ПотерянныеМаркиУпаковок.Упаковка КАК Упаковка,
	|	ПотерянныеМаркиУпаковок.СправкаБ КАК СправкаБ,
	|	ПотерянныеМаркиУпаковок.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
	|	ПотерянныеМаркиУпаковок.Организация КАК Организация,
	|	ПотерянныеМаркиУпаковок.ПунктРазгрузки КАК ПунктРазгрузки,
	|	ПотерянныеМаркиУпаковок.ОтметкаВыбытия КАК ОтметкаВыбытия
	|ИЗ
	|	ПотерянныеМаркиУпаковок КАК ПотерянныеМаркиУпаковок
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПотерянныеМаркиУпаковок.Упаковка КАК Упаковка,
	|	алкХранилищеУпаковокСрезПоследних.ИерархияУпаковки КАК ИерархияУпаковки
	|ИЗ
	|	ПотерянныеМаркиУпаковок КАК ПотерянныеМаркиУпаковок
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеУпаковок.СрезПоследних КАК алкХранилищеУпаковокСрезПоследних
	|		ПО ПотерянныеМаркиУпаковок.Упаковка = алкХранилищеУпаковокСрезПоследних.Упаковка
	|
	|СГРУППИРОВАТЬ ПО
	|	ПотерянныеМаркиУпаковок.Упаковка,
	|	алкХранилищеУпаковокСрезПоследних.ИерархияУпаковки";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.ДокументОснование);
	Запрос.УстановитьПараметр("ТекущаяДата",ТекущаяДатаСеанса());
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	ВыборкаУпаковок=МассивРезультатов[8].Выбрать();
	ВыборкаДетальныхДанных=МассивРезультатов[7].выбрать();
	Объект.АкцизныеМарки.Очистить();
	Объект.Упаковки.Очистить();
	Пока ВыборкаДетальныхДанных.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.АкцизныеМарки.Добавить(),ВыборкаДетальныхДанных);	
	КонецЦикла;
	Пока ВыборкаУпаковок.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Объект.Упаковки.Добавить(),ВыборкаУпаковок);
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	
КонецПроцедуры



