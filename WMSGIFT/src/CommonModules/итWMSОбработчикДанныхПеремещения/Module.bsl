Процедура ЦентральныйОбработчикДанныхПеремещения(ДанныеОбработчика)Экспорт
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ТипОбработкиДанных") тогда
		Возврат
	КонецЕсли;
	Если  итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"КлючИнициализацииДанных") тогда
		Возврат
	КонецЕсли;	
	
	Если  ДанныеОбработчика.ТипОбработкиДанных="ВнесениеИзмененийВДокумент" тогда
		Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"СостояниеИнициализации")   тогда
			Возврат
		КонецЕсли;	
		////////////Транзакция фиксируется псоле инициализации задачи
		НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
		///////
		ВнестиИзмененияВДокумент(ДанныеОбработчика);
		итWMSОбработчикиРегистрации_И_Загрузки.ИнициализацияДанныхНаСервере(ДанныеОбработчика);
		Если ДанныеОбработчика.Свойство("Статус") тогда
			Если ДанныеОбработчика.Статус=404 тогда
				Возврат
			КонецЕсли;
		КонецЕсли;	
		ЗафиксироватьТранзакцию();
	КонецЕсли;
	Если  ДанныеОбработчика.ТипОбработкиДанных="ЗаписьДанныхТСД" тогда
		Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"СостояниеИнициализации")   тогда
			Возврат
		КонецЕсли;	
		////////////Транзакция фиксируется псоле инициализации задачи
		НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
		///////
		ЗаписьДанныхТСД(ДанныеОбработчика);
		итWMSОбработчикиРегистрации_И_Загрузки.ИнициализацияДанныхНаСервере(ДанныеОбработчика);
		Если ДанныеОбработчика.Свойство("Статус") тогда
			Если ДанныеОбработчика.Статус=404 тогда
				Возврат
			КонецЕсли;
		КонецЕсли;	
		ЗафиксироватьТранзакцию();
	КонецЕсли;

	Если ДанныеОбработчика.ТипОбработкиДанных="НовыйSSCC" тогда
		Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ТСДИД")   тогда
			Возврат
		КонецЕсли;		
		ОбработчикРегистрацииНовогоSSCCДляПеремещения(ДанныеОбработчика);
	КонецЕсли;
	
	Если ДанныеОбработчика.ТипОбработкиДанных="РегистрацияНовогоSSCC" тогда
		Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ТСДИД")   тогда
			Возврат
		КонецЕсли;		
		ОбработчикРегистрацииНовогоSSCC(ДанныеОбработчика);
	КонецЕсли;

	
КонецПроцедуры
#Область СтарыйТипВнесенияДанныхВБД
Процедура ОбработчикРегистрацииНовогоSSCCДляПеремещения(ДанныеОбработчика)
	СтруктураХраненияДанныхНастройкиWMS= итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилища();
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(СтруктураХраненияДанныхНастройкиWMS,"Филиал") тогда
		ДанныеОбработчика=СтруктураХраненияДанныхНастройкиWMS;
		Возврат
	КонецЕсли;	
	ДанныеЗадачи=итWMSСлужебныеПроцедурыИФункции.НайтиДанныеЗадачиПоИдЗадачи(ДанныеОбработчика.КлючИнициализацииДанных);
	Если ДанныеЗадачи=Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","не найденно данных по ид задачи");
		Возврат
	КонецЕсли;
	
	ОбъектДокумента=ДанныеЗадачи.ДокументОснование.ПолучитьОбъект();
	ТабличнаяЧастьДокумента=ОбъектДокумента.Товары;
	
	ДанныеТСД=итWMSСлужебныеПроцедурыИФункции.ПолучитьДанныеПоТСДНаТекущийМомент(ДанныеОбработчика.ТСДИД);
	Если ДанныеТСД = Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","нет данных по ТСД");
		Возврат
	КонецЕсли;	
	Если ДанныеТСД.Состояние=Перечисления.итWMSСостоянияТСД.Отключен тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","Закройте программу и авторизуйтесь заново");
		Возврат
	КонецЕсли;	
	
	НаборЗаписей=РегистрыСведений.итWMSСтрокиЗадачТСД.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ИдЗадачи.Установить(ДанныеОбработчика.КлючИнициализацииДанных);
	НаборЗаписей.Прочитать();
	НовыйИдентификатор=итWMSОбработчикSSCC.ПолучитьНовыйSSCC(СтруктураХраненияДанныхНастройкиWMS.Филиал,,ДанныеТСД.РаботникСклада.ФизическоеЛицо);
	Для Каждого стр из НаборЗаписей цикл
		МассивСтрок=ТабличнаяЧастьДокумента.НайтиСтроки(новый Структура("ИдентификаторСтроки",стр.идСтроки));
		для Каждого СтрокаТабличнойЧасти из МассивСтрок цикл
			СтрокаТабличнойЧасти.ИдентификаторУпаковкиПолучатель=НовыйИдентификатор;
		КонецЦикла;
	КонецЦикла;
	Попытка
		ОбъектДокумента.ОбработкаТСД=Истина;
		ОбъектДокумента.СообщениеДляТСД="";
		ОбъектДокумента.Записать();
	Исключение
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки",ОбъектДокумента.СообщениеДляТСД +"  "+ ОписаниеОшибки());
		Возврат
	КонецПопытки;
	ДанныеОбработчика.Вставить("НовыйИдентификатор",НовыйИдентификатор);	
КонецПроцедуры
Процедура ВнестиИзмененияВДокумент(ДанныеОбработчика)
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"СтрокиЗадачи") тогда
		Возврат
	КонецЕсли;
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ИдентификаторУпаковкиПолучатель") тогда
		Возврат
	КонецЕсли;
	
	
	ДанныеЗадачи=итWMSСлужебныеПроцедурыИФункции.НайтиДанныеЗадачиПоИдЗадачи(ДанныеОбработчика.КлючИнициализацииДанных);
	Если не итWMSСлужебныеПроцедурыИФункции.ПроверкаНаВозможностьИзменитьЗадачу(ДанныеОбработчика,новый Структура("ТСДИД,ИдЗадачи",ДанныеОбработчика.ТСДИД,ДанныеЗадачи.ИдЗадачи),ДанныеЗадачи) Тогда 
		Возврат
	КонецЕсли;
	Если ДанныеЗадачи=Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","не найденно данных по ид задачи");
		Возврат
	КонецЕсли;
	Если ДанныеЗадачи.ИдентификаторУпаковки<>ДанныеОбработчика.ИдентификаторУпаковкиПолучатель и ДанныеОбработчика.СостояниеИнициализации<>Перечисления.итWMSСостоянияЗадачТСД.Отменена тогда
		Если не ПроверкаНаНаличиеSSCCвЯчейкеПолучатель(ДанныеОбработчика.ИдентификаторУпаковкиПолучатель,ДанныеЗадачи.ДокументОснование,ДанныеЗадачи.ЯчейкаПолучатель) тогда
			ДанныеОбработчика.Вставить("Статус",404);
			ДанныеОбработчика.Вставить("ОписаниеОшибки","По данным системы, такого SSCC в ячейке "+ДанныеЗадачи.ЯчейкаПолучатель.Наименование+" нет");
			Возврат
		КонецЕсли;
	КонецЕсли;
	СостояниеЗадачи=ДанныеОбработчика.СостояниеИнициализации;
	ИдентификаторУпаковки=ДанныеЗадачи.ИдентификаторУпаковки;
	ЯчейкаПолучатель=ДанныеЗадачи.ЯчейкаПолучатель;
	ОбъектДокумента=ДанныеЗадачи.ДокументОснование.ПолучитьОбъект();
	МассивСерий=новый Массив;
	для Каждого стр из ДанныеОбработчика.СтрокиЗадачи цикл
		МассиСтрокКИзменению=ОбъектДокумента.Товары.НайтиСтроки(новый Структура("ИдентификаторСтроки",стр.ИдСтроки));
		для Каждого СтрокаКИзменению из МассиСтрокКИзменению цикл
			СтрокаКИзменению.СостояниеЗадачи=СостояниеЗадачи;
			СтрокаКИзменению.ИдентификаторУпаковкиПолучатель= ДанныеОбработчика.ИдентификаторУпаковкиПолучатель;
			СтрокаКИзменению.КоличествоФакт=стр.КоличествоФакт;
			Если СостояниеЗадачи=Перечисления.итWMSСостоянияЗадачТСД.Отменена Тогда 
				Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ПричинаОтменыЗадачи") тогда
					Возврат
				КонецЕсли;
			СтрокаКИзменению.ПричинаОтменыЗадачи=ДанныеОбработчика.ПричинаОтменыЗадачи;	
		КонецЕсли;
		    СтрокаКИзменению.ДатаИсполнения=ТекущаяДата();
			МассивСерий.Добавить(СтрокаКИзменению.СерияНоменклатуры);
		КонецЦикла;
	КонецЦикла;
	Попытка
		ОбъектДокумента.ОбработкаТСД=Истина;
		ОбъектДокумента.СообщениеДляТСД="";
		ОбъектДокумента.Записать();
	Исключение
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки",ОбъектДокумента.СообщениеДляТСД +"  "+ ОписаниеОшибки());
		Возврат
	КонецПопытки;
	
	/////Область Обработки ПМУ  ++++++++++++++
	Если ДанныеОбработчика.Свойство("ДанныеАгрегации") тогда
		Для Каждого Строка из ДанныеОбработчика.ДанныеАгрегации цикл
			ОбработатьДанныеАгрегации(Строка,ОбъектДокумента.Ссылка,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель);
		КонецЦикла;
	Иначе 
		Если СостояниеЗадачи=Перечисления.итWMSСостоянияЗадачТСД.Отменена Тогда 
			Возврат
		КонецЕсли;	
		МенеджерВременныхТаблиц=новый МенеджерВременныхТаблиц;
		Если ПроверитьУпаковкуНаНаличиеПомарочногоУчета(ИдентификаторУпаковки,МенеджерВременныхТаблиц) тогда
		МассивСправокБ=ПолучитьМассивСправокБ(МассивСерий);
		РезультатЗапроса=ПолучитьДанныеДляЗаписиПМУ(МенеджерВременныхТаблиц,МассивСправокБ);
		Выборка=РезультатЗапроса.Выбрать();
		Если ИдентификаторУпаковки<>ДанныеОбработчика.ИдентификаторУпаковкиПолучатель Тогда 
			Пока  Выборка.Следующий() цикл
				ОбработатьДанныеАгрегации(Выборка,ОбъектДокумента.Ссылка,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель);
			КонецЦикла;
		иначе
			Пока  Выборка.Следующий() цикл
				ОбработатьДанныеАгрегации(Выборка,ОбъектДокумента.Ссылка,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель,Истина);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	КонецЕсли;
////////////////// -----------------------	
КонецПроцедуры

Функция ПроверкаНаНаличиеSSCCвЯчейкеПолучатель(ИдентификаторУпаковкиПолучатель,Документ,Ячейка)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итТоварыВЯчейкахОстатки.ИдентификаторУпаковки КАК ИдентификаторУпаковки
	|ПОМЕСТИТЬ ДанныеИдентификаторовВЯчейке
	|ИЗ
	|	РегистрНакопления.итТоварыВЯчейках.Остатки КАК итТоварыВЯчейкахОстатки
	|ГДЕ
	|	итТоварыВЯчейкахОстатки.Ячейка = &Ячейка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	итWMSПеремещениеТовары.ИдентификаторУпаковкиПолучатель
	|ИЗ
	|	Документ.итWMSПеремещение.Товары КАК итWMSПеремещениеТовары
	|ГДЕ
	|	итWMSПеремещениеТовары.ЯчейкаПолучатель = &Ячейка
	|	И итWMSПеремещениеТовары.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки КАК ИдентификаторУпаковки
	|ИЗ
	|	ДанныеИдентификаторовВЯчейке КАК ДанныеИдентификаторовВЯчейке
	|ГДЕ
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки = &ИдентификаторУпаковки
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки";
	
	Запрос.УстановитьПараметр("ИдентификаторУпаковки", ИдентификаторУпаковкиПолучатель);
	Запрос.УстановитьПараметр("Ссылка", Документ);
	Запрос.УстановитьПараметр("Ячейка", Ячейка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() тогда
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецФункции

#КонецОбласти
Функция ПолучитьДанныеДляЗаписиПМУ(МенеджерВременныхТаблиц,МассивСправокБ)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц=МенеджерВременныхТаблиц;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДанныеМарок.Упаковка КАК GTIN,
		|	ДанныеМарок.ИерархияУпаковки КАК ИерархияУпаковки,
		|	ДанныеМарок.Марка КАК Марка,
		|	ДанныеМарок.СправкаБ КАК СправкаБ,
		|	алкСоответствияСправокАиБЕГАИСИСерий.СерияНоменклатуры КАК СерияНоменклатуры,
		|	алкСоответствияСправокАиБЕГАИСИСерий.СерияНоменклатуры.ДатаПроизводства КАК ДатаРозлива,
		|	алкСоответствияСправокАиБЕГАИСИСерий.СерияНоменклатуры.Владелец КАК Номенклатура
		|ИЗ
		|	ДанныеМарок КАК ДанныеМарок
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкСоответствияСправокАиБЕГАИСИСерий КАК алкСоответствияСправокАиБЕГАИСИСерий
		|		ПО ДанныеМарок.СправкаБ = алкСоответствияСправокАиБЕГАИСИСерий.СправкаБ
		|ГДЕ
		|	ДанныеМарок.СправкаБ В(&МассивСправокБ)";
	Запрос.УстановитьПараметр("МассивСправокБ",МассивСправокБ);
	Возврат Запрос.Выполнить();
	
		//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	КонецФункции
Функция ПроверитьУпаковкуНаНаличиеПомарочногоУчета(ИдентификаторУпаковки,МенеджерВременныхТаблиц)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц=МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	алкХранилищеУпаковокСрезПоследних.Упаковка,
	|	алкХранилищеУпаковокСрезПоследних.ИерархияУпаковки
	|ПОМЕСТИТЬ ДанныеКоробовПаллеты
	|ИЗ
	|	РегистрСведений.алкХранилищеУпаковок.СрезПоследних КАК алкХранилищеУпаковокСрезПоследних
	|ГДЕ
	|	алкХранилищеУпаковокСрезПоследних.ИерархияУпаковки = &ИерархияУпаковки
	|
	|СГРУППИРОВАТЬ ПО
	|	алкХранилищеУпаковокСрезПоследних.Упаковка,
	|	алкХранилищеУпаковокСрезПоследних.ИерархияУпаковки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеКоробовПаллеты.Упаковка,
	|	ДанныеКоробовПаллеты.ИерархияУпаковки,
	|	алкХранилищеАкцизныхМарокСрезПоследних.Марка,
	|	алкХранилищеАкцизныхМарокСрезПоследних.СправкаБ
	|ПОМЕСТИТЬ ДанныеМарок
	|ИЗ
	|	ДанныеКоробовПаллеты КАК ДанныеКоробовПаллеты
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок.СрезПоследних КАК алкХранилищеАкцизныхМарокСрезПоследних
	|		ПО ДанныеКоробовПаллеты.Упаковка = алкХранилищеАкцизныхМарокСрезПоследних.Упаковка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеМарок.Упаковка,
	|	ДанныеМарок.ИерархияУпаковки,
	|	ДанныеМарок.Марка,
	|	ДанныеМарок.СправкаБ
	|ИЗ
	|	ДанныеМарок КАК ДанныеМарок";
	
	Запрос.УстановитьПараметр("ИерархияУпаковки", ИдентификаторУпаковки);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() Тогда 
		Возврат Истина;	
	КонецЕсли;
	
	Возврат Ложь;
	
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецФункции
Процедура ОбработатьДанныеАгрегации(Строка,СсылкаДокумента,ИдентификаторУпаковкиПолучатель,ДвиженияТолькоПоМаркамВОбработке=Ложь)
	Если ТипЗнч(Строка.Марка)=Тип("Строка") Тогда 
		Марка=итWMSСлужебныеПроцедурыИФункции.НайтиСоздатьМаркуСБлокировкой(Строка.Марка);
	иначе
		Марка=Строка.Марка;
	КонецЕсли;
	Если   не ДвиженияТолькоПоМаркамВОбработке Тогда 
		НаборЗаписейКПереупаковки=РегистрыСведений.итWMS_АгрегацияМарок.СоздатьНаборЗаписей();
		НаборЗаписейКПереупаковки.Отбор.Марка.Установить(Марка); 
		НаборЗаписейКПереупаковки.Отбор.ДокументОснование.Установить(СсылкаДокумента);
		НаборЗаписейКПереупаковки.Прочитать();
		НаборЗаписейКПереупаковки.Очистить();
		НоваяЗаписьКПереупаковки=НаборЗаписейКПереупаковки.Добавить();
		НоваяЗаписьКПереупаковки.ДокументОснование=СсылкаДокумента;
		НоваяЗаписьКПереупаковки.Период=ТекущаяДата();
		НоваяЗаписьКПереупаковки.Марка=Марка;
		НоваяЗаписьКПереупаковки.АктивностьЗаписи=Истина;
		НоваяЗаписьКПереупаковки.GTIN=Строка.GTIN;
		НоваяЗаписьКПереупаковки.SSCC=ИдентификаторУпаковкиПолучатель;
		НоваяЗаписьКПереупаковки.ДатаРегистрации=ТекущаяДата();
		Если ТипЗнч(Строка.Номенклатура)=Тип("УникальныйИдентификатор") Тогда 
			НоваяЗаписьКПереупаковки.Номенклатура=итWMSСлужебныеПроцедурыИФункции.НайтиНоменклатуруПоУникальномуИД(Строка.Номенклатура);
		иначе
			НоваяЗаписьКПереупаковки.Номенклатура=Строка.Номенклатура;
		КонецЕсли;
		НоваяЗаписьКПереупаковки.ДатаРозлива=Строка.ДатаРозлива;
		НаборЗаписейКПереупаковки.Записать();
	КонецЕсли;
	
	
	НаборЗаписейМаркиВОбработке=РегистрыСведений.итWMS_МаркиВОбработке.СоздатьНаборЗаписей();
	НаборЗаписейМаркиВОбработке.Отбор.Марка.Установить(Марка);
	НаборЗаписейМаркиВОбработке.Отбор.ДокументОснование.Установить(СсылкаДокумента);
	НаборЗаписейМаркиВОбработке.Прочитать();
	НаборЗаписейМаркиВОбработке.Очистить();
	
	
	
	НоваяЗаписьМаркиВОбработке=НаборЗаписейМаркиВОбработке.Добавить();
	НоваяЗаписьМаркиВОбработке.ДокументОснование=СсылкаДокумента;
	НоваяЗаписьМаркиВОбработке.Марка=Марка;
	НоваяЗаписьМаркиВОбработке.ДатаРегистрации=ТекущаяДата();
	НаборЗаписейМаркиВОбработке.Записать();
КонецПроцедуры

Функция ПолучитьМассивСправокБ(МассивСерий)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	алкСоответствияСправокАиБЕГАИСИСерий.СправкаБ
		|ИЗ
		|	РегистрСведений.алкСоответствияСправокАиБЕГАИСИСерий КАК алкСоответствияСправокАиБЕГАИСИСерий
		|ГДЕ
		|	алкСоответствияСправокАиБЕГАИСИСерий.СерияНоменклатуры В(&МассивСерий)
		|
		|СГРУППИРОВАТЬ ПО
		|	алкСоответствияСправокАиБЕГАИСИСерий.СправкаБ";
	
	Запрос.УстановитьПараметр("МассивСерий", МассивСерий);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	МассивСправокБ=новый Массив;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		МассивСправокБ.Добавить(ВыборкаДетальныеЗаписи.СправкаБ);
	КонецЦикла;
	
	Возврат МассивСправокБ;
	
	КонецФункции

Функция ПроверкаНаНаличиеSSCCвЯчейкеПолучательНоваяВерсия(ИдентификаторУпаковкиПолучатель,Ячейка,ИдЗадачи)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итТоварыВЯчейкахОстатки.ИдентификаторУпаковки КАК ИдентификаторУпаковки
	|ПОМЕСТИТЬ ДанныеИдентификаторовВЯчейке
	|ИЗ
	|	РегистрНакопления.итТоварыВЯчейках.Остатки КАК итТоварыВЯчейкахОстатки
	|ГДЕ
	|	итТоварыВЯчейкахОстатки.Ячейка = &Ячейка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки КАК ИдентификаторУпаковки
	|ИЗ
	|	ДанныеИдентификаторовВЯчейке КАК ДанныеИдентификаторовВЯчейке
	|ГДЕ
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки = &ИдентификаторУпаковки
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеИдентификаторовВЯчейке.ИдентификаторУпаковки";
	
	Запрос.УстановитьПараметр("ИдентификаторУпаковки", ИдентификаторУпаковкиПолучатель);
	Запрос.УстановитьПараметр("Ячейка", Ячейка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() Тогда 
		Возврат Истина;
	иначе
		НаборЗаписей=РегистрыСведений.итWMSЗадачиТСД.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ИдЗадачи.Установить(ИдЗадачи);
		НаборЗаписей.Прочитать();
		Для Каждого стр из НаборЗаписей Цикл
			ДанныеДокументаТСД= стр.ДанныеДокументаТСД.Получить();
			Если ТипЗнч(ДанныеДокументаТСД)=Тип("Структура") Тогда 
				Если ДанныеДокументаТСД.Свойство("НовыйИдентификатор") Тогда
					Если ДанныеДокументаТСД.НовыйИдентификатор=ИдентификаторУпаковкиПолучатель Тогда 
						Возврат Истина;
					КонецЕсли;	
				КонецЕсли;
			КонецЕсли;	
			
		КонецЦикла;
		Возврат Ложь;
	КонецЕсли;
	

	Возврат Ложь;
		КонецФункции
Процедура ЗаписьДанныхТСД(ДанныеОбработчика)
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"СтрокиЗадачи") тогда
		Возврат
	КонецЕсли;
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ИдентификаторУпаковкиПолучатель") тогда
		Возврат
	КонецЕсли;
	ДанныеЗадачи=итWMSСлужебныеПроцедурыИФункции.НайтиДанныеЗадачиПоИдЗадачи(ДанныеОбработчика.КлючИнициализацииДанных);
	Если ДанныеЗадачи=Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","не найденно данных по ид задачи");
		Возврат
	КонецЕсли;
	Если не итWMSСлужебныеПроцедурыИФункции.ПроверкаНаВозможностьИзменитьЗадачу(ДанныеОбработчика,новый Структура("ТСДИД,ИдЗадачи",ДанныеОбработчика.ТСДИД,ДанныеЗадачи.ИдЗадачи),ДанныеЗадачи) Тогда 
		Возврат
	КонецЕсли;
	Если ДанныеЗадачи.ИдентификаторУпаковки<>ДанныеОбработчика.ИдентификаторУпаковкиПолучатель и ДанныеОбработчика.СостояниеИнициализации<>Перечисления.итWMSСостоянияЗадачТСД.Отменена тогда
		Если не ПроверкаНаНаличиеSSCCвЯчейкеПолучательНоваяВерсия(ДанныеОбработчика.ИдентификаторУпаковкиПолучатель,ДанныеЗадачи.ЯчейкаПолучатель,ДанныеОбработчика.КлючИнициализацииДанных) тогда
			ДанныеОбработчика.Вставить("Статус",404);
			ДанныеОбработчика.Вставить("ОписаниеОшибки","По данным системы, такого SSCC в ячейке "+ДанныеЗадачи.ЯчейкаПолучатель.Наименование+" нет");
			Возврат
		КонецЕсли;
	КонецЕсли;
	МассивСерий=новый Массив;
	ДатаИсполнения=ТекущаяДата();
	для Каждого стр из ДанныеОбработчика.СтрокиЗадачи цикл
		СтруктураДанных=новый Структура;
		СтруктураДанных.Вставить("ИдентификаторУпаковкиПолучатель",ДанныеОбработчика.ИдентификаторУпаковкиПолучатель);
		СтруктураДанных.Вставить("КоличествоФакт",стр.КоличествоФакт);
		СтруктураДанных.Вставить("ПричинаОтменыЗадачи",Неопределено);
		СтруктураДанных.Вставить("ДатаИсполнения",ДатаИсполнения);
		Если ДанныеОбработчика.СостояниеИнициализации=Перечисления.итWMSСостоянияЗадачТСД.Отменена Тогда 
			Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ПричинаОтменыЗадачи") тогда
				Возврат
			КонецЕсли;
			СтруктураДанных.ПричинаОтменыЗадачи=ДанныеОбработчика.ПричинаОтменыЗадачи;
		КонецЕсли;

		МенеджерЗаписи=РегистрыСведений.итWMSСтрокиЗадачТСД.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.ИдЗадачи=ДанныеОбработчика.КлючИнициализацииДанных;
		МенеджерЗаписи.идСтроки= стр.ИдСтроки;
		МенеджерЗаписи.Прочитать();
		МенеджерЗаписи.ДанныеДокументаТСД=новый ХранилищеЗначения(СтруктураДанных);
		МассивСерий.Добавить(МенеджерЗаписи.СерияНоменклатуры);
		МенеджерЗаписи.Записать();
КонецЦикла;
	ИдентификаторУпаковки=ДанныеЗадачи.ИдентификаторУпаковки;
	/////Область Обработки ПМУ  ++++++++++++++
	Если ДанныеОбработчика.Свойство("ДанныеАгрегации") тогда
		Для Каждого Строка из ДанныеОбработчика.ДанныеАгрегации цикл
			ОбработатьДанныеАгрегации(Строка,ДанныеЗадачи.ДокументОснование,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель);
		КонецЦикла;
	Иначе 
		Если ДанныеОбработчика.СостояниеИнициализации=Перечисления.итWMSСостоянияЗадачТСД.Отменена Тогда 
			Возврат
		КонецЕсли;	
		МенеджерВременныхТаблиц=новый МенеджерВременныхТаблиц;
		Если ПроверитьУпаковкуНаНаличиеПомарочногоУчета(ИдентификаторУпаковки,МенеджерВременныхТаблиц) тогда
		МассивСправокБ=ПолучитьМассивСправокБ(МассивСерий);
		РезультатЗапроса=ПолучитьДанныеДляЗаписиПМУ(МенеджерВременныхТаблиц,МассивСправокБ);
		Выборка=РезультатЗапроса.Выбрать();
		Если ИдентификаторУпаковки<>ДанныеОбработчика.ИдентификаторУпаковкиПолучатель Тогда 
			Пока  Выборка.Следующий() цикл
				ОбработатьДанныеАгрегации(Выборка,ДанныеЗадачи.ДокументОснование,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель);
			КонецЦикла;
		иначе
			Пока  Выборка.Следующий() цикл
				ОбработатьДанныеАгрегации(Выборка,ДанныеЗадачи.ДокументОснование,ДанныеОбработчика.ИдентификаторУпаковкиПолучатель,Истина);
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	КонецЕсли;
////////////////// -----------------------	
КонецПроцедуры

Процедура ОбработчикРегистрацииНовогоSSCC(ДанныеОбработчика)
	Если не итWMSСлужебныеПроцедурыИФункции.ПроверкаНаВозможностьИзменитьЗадачу(ДанныеОбработчика,новый Структура("ТСДИД,ИдЗадачи",ДанныеОбработчика.ТСДИД,ДанныеОбработчика.КлючИнициализацииДанных)) Тогда 
		Возврат
	КонецЕсли;
	ДанныеЗадачи=итWMSСлужебныеПроцедурыИФункции.НайтиДанныеЗадачиПоИдЗадачи(ДанныеОбработчика.КлючИнициализацииДанных);
    ОрганизацияДокумента=ДанныеЗадачи.ДокументОснование.Организация;
	СтруктураХраненияДанныхНастройкиWMS= итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилищаПоСвойствам("СоответствиеФилиаловИорганизация");
	СтрокаСФилиалом=СтруктураХраненияДанныхНастройкиWMS.СоответствиеФилиаловИорганизация.Найти(ОрганизацияДокумента);
	
	Если СтрокаСФилиалом=Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","не могу найти филиал по организации документа");
		Возврат
	КонецЕсли;	
	Филиал=СтрокаСФилиалом.Филиал;	
	ДанныеТСД=итWMSСлужебныеПроцедурыИФункции.ПолучитьДанныеПоТСДНаТекущийМомент(ДанныеОбработчика.ТСДИД);

	Если ДанныеТСД = Неопределено тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","нет данных по ТСД");
		Возврат
	КонецЕсли;	
	Если ДанныеТСД.Состояние=Перечисления.итWMSСостоянияТСД.Отключен тогда
		ДанныеОбработчика.Вставить("Статус",404);
		ДанныеОбработчика.Вставить("ОписаниеОшибки","Закройте программу и авторизуйтесь заново");
		Возврат
	КонецЕсли;	
    НовыйИдентификатор=итWMSОбработчикSSCC.ПолучитьНовыйSSCC(Филиал,,ДанныеТСД.РаботникСклада.ФизическоеЛицо);

	НаборЗаписей=РегистрыСведений.итWMSЗадачиТСД.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ИдЗадачи.Установить(ДанныеОбработчика.КлючИнициализацииДанных);
	НаборЗаписей.ДополнительныеСвойства.Вставить("НеРегестрироватьИзменения",Истина);
	НаборЗаписей.Прочитать();
	Для Каждого стр из НаборЗаписей Цикл 
		стр.ДанныеДокументаТСД=новый ХранилищеЗначения(новый Структура("НовыйИдентификатор",НовыйИдентификатор));
	КонецЦикла;
    НаборЗаписей.Записать();
	ДанныеОбработчика.Вставить("НовыйИдентификатор",НовыйИдентификатор);	
КонецПроцедуры


Процедура ВнестиИзмененияВДокументПеремещения(Документ) Экспорт 
	РезультатЗапроса=итWMSСлужебныеПроцедурыИФункции.ПолучитьРезультатЗапросаИзмененияДанныхЗадачИСтрокТСД(Документ);
	Выборка=РезультатЗапроса.Выбрать();
	ОбъектДокумента=Документ.ПолучитьОбъект();
	Пока Выборка.Следующий() Цикл 
		ДанныеДокументаТСДСтрока= Выборка.ДанныеДокументаТСДСтрока.Получить();
		МассивСтрок=ОбъектДокумента.Товары.НайтиСтроки(новый Структура("ИдентификаторСтроки",Выборка.идСтроки));	
		Для Каждого стр из МассивСтрок Цикл
			стр.СостояниеЗадачи= Выборка.Состояние;
			Если ТипЗнч(ДанныеДокументаТСДСтрока)=Тип("Структура") Тогда 
				стр.КоличествоФакт=ДанныеДокументаТСДСтрока.КоличествоФакт;
				стр.ИдентификаторУпаковкиПолучатель=ДанныеДокументаТСДСтрока.ИдентификаторУпаковкиПолучатель;
				Если ДанныеДокументаТСДСтрока.ПричинаОтменыЗадачи<>Неопределено Тогда 
					стр.ПричинаОтменыЗадачи=ДанныеДокументаТСДСтрока.ПричинаОтменыЗадачи;
				КонецЕсли;	
				 стр.ДатаИсполнения=ДанныеДокументаТСДСтрока.ДатаИсполнения;
			КонецЕсли;
		КонецЦикла;	
	КонецЦикла;
	ОбъектДокумента.ОбменДанными.Загрузка=Истина;
	ОбъектДокумента.Записать();

	КонецПроцедуры

Процедура ФоновоеОповещениеИзмененияСтатусаДокумента(Параметры) Экспорт
	Данные=итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилища();
	Если ТипЗнч(Данные)<>тип("Структура") тогда
		ЗаписьЖурналаРегистрации("ОповещениеПоПочтеПеремещение",,,,"Ошибка незаполненных данных wms");
		Возврат;
	КонецЕсли;
	Если не Данные.Свойство("АдресаДоставкиПеремещение") тогда
		ЗаписьЖурналаРегистрации("ОповещениеПоПочтеПеремещение",,,,"Ошибка незаполненных данных wms АдресаДоставкиПеремещение");
		Возврат;
	КонецЕсли;
	
	СтруктураДанных=Параметры;
	Тема = "Ручное изменение статуса документа wms перемещения";
	Текст="изменение статуса перемещения №"+СтруктураДанных.Номер+" от "+ Строка(СтруктураДанных.Дата)+ "
	|предыдущий статус: "+СтруктураДанных.ПредыдущийСтатусДокумента + " 
	|текущий статус: "+ СтруктураДанных.ТекущийСтатусДокумента +"
	|Ответственный: "+СтруктураДанных.Ответственный;
	МассивКопияПолучателей=Данные.АдресаДоставкиПеремещение.ВыгрузитьКолонку("Адрес");
	Файлы=новый Массив;
	МассивПолучателей = Данные.АдресаДоставкиПеремещение.ВыгрузитьКолонку("Адрес");
	//УчЗапись = Справочники.УчетныеЗаписиЭлектроннойПочты.СистемнаяУчетнаяЗаписьЭлектроннойПочты; 
	//ДополнительныйМодуль.ВоссоздатьПисьмо(УчЗапись,МассивПолучателей,МассивКопияПолучателей,Тема,Текст,Файлы);
КонецПроцедуры


Процедура ЦентральныйОбработчикДанныхРучногоПеремещения(ДанныеОбработчика) Экспорт
	Если итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"ТипОбработкиДанных") тогда
		Возврат
	КонецЕсли;
	Если  итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"КлючИнициализацииДанных") тогда
		Возврат
	КонецЕсли;	
	Если  ДанныеОбработчика.ТипОбработкиДанных="ПоискДанныхПоSSCC" тогда
		ПоискДанныхПоSSCC(ДанныеОбработчика);	
	КонецЕсли;
	Если  ДанныеОбработчика.ТипОбработкиДанных="ЗавершениеПеремещения" тогда
		ЗавершениеРучногоПеремещения(ДанныеОбработчика);
	КонецЕсли;
КонецПроцедуры


Процедура ЗавершениеРучногоПеремещения(ДанныеОбработчика)
	Если  итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика,"Данные") тогда
		Возврат
	КонецЕсли;
	Если  итWMSСлужебныеПроцедурыИФункции.ТиповойОбработчикВыявленияОшибок(ДанныеОбработчика.КлючИнициализацииДанных,"Склад") тогда
		Возврат
	КонецЕсли;
	Склад=Справочники.Склады.ПолучитьСсылку(ДанныеОбработчика.КлючИнициализацииДанных.Склад);
    ДокументручногоПеремещения=Документы.итWMSРучноеПеремещение.СоздатьДокумент();
	ДокументручногоПеремещения.СкладОтправитель=Склад;
	ДокументручногоПеремещения.СкладПолучатель=Склад;
	ДокументручногоПеремещения.Дата=ТекущаяДата();
	ДанныеПоСотруднику=итWMSСлужебныеПроцедурыИФункции.ПолучитьДанныеПоТСДНаТекущийМомент(ДанныеОбработчика.ТСДИД);
	Если ДанныеПоСотруднику<>Неопределено Тогда 
	ДокументручногоПеремещения.Исполнитель=ДанныеПоСотруднику.РаботникСклада.ФизическоеЛицо;	
	КонецЕсли;
	Для Каждого стр из ДанныеОбработчика.Данные цикл
		НоваяСтрока=ДокументручногоПеремещения.Товары.Добавить();
		НоваяСтрока.ИдентификаторСтроки=стр.ИдентификаторСтроки;
		НоваяСтрока.ИдентификаторУпаковки=стр.ИдентификаторУпаковки;
		НоваяСтрока.ИдентификаторУпаковкиПолучатель=стр.ИдентификаторУпаковкиПолучатель;
		НоваяСтрока.Количество=стр.Количество;
		НоваяСтрока.Номенклатура=итWMSСлужебныеПроцедурыИФункции.НайтиНоменклатуруПоУникальномуИД(стр.Номенклатура);
		НоваяСтрока.СерияНоменклатуры=итWMSСлужебныеПроцедурыИФункции.НайтиСериюПоУникальномуИд(стр.СерияНоменклатуры);
		НоваяСтрока.ЯчейкаОтправитель=итWMSСлужебныеПроцедурыИФункции.НайтиЯчейкуПоУникальномуИд(стр.ЯчейкаОтправитель);
		НоваяСтрока.ЯчейкаПолучатель=итWMSСлужебныеПроцедурыИФункции.НайтиЯчейкуПоУникальномуИд(стр.ЯчейкаПолучатель);
		НоваяСтрока.Качество= итWMSСлужебныеПроцедурыИФункции.НайтиКачествоПоУникальномуИд(стр.Качество);
		НоваяСтрока.ДатаРозлива= стр.ДатаРозлива;
    КонецЦикла;
  
	ДокументручногоПеремещения.Записать();
	ДанныеОбработчика.Вставить("СозданДокумент",Истина);

	
	КонецПроцедуры


Процедура ПоискДанныхПоSSCC(ДанныеОбработчика)
Склады=новый Массив;
Если ДанныеОбработчика.Свойство("Склад") Тогда 
Склад=Справочники.Склады.ПолучитьСсылку(ДанныеОбработчика.Склад);
Склады.Добавить(Склад);
иначе
Склады=СписокВсехСкладов();
КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итТоварыВЯчейкахОстатки.Номенклатура,
		|	итТоварыВЯчейкахОстатки.СерияНоменклатуры,
		|	итТоварыВЯчейкахОстатки.ДатаРозлива,
		|	итТоварыВЯчейкахОстатки.КоличествоОстаток,
		|	итТоварыВЯчейкахОстатки.Ячейка,
		|	итТоварыВЯчейкахОстатки.ИдентификаторУпаковки,
		|	итТоварыВЯчейкахОстатки.Склад,
		|	итТоварыВЯчейкахОстатки.Качество
		|ПОМЕСТИТЬ ВтДанныеПоSSCC
		|ИЗ
		|	РегистрНакопления.итТоварыВЯчейках.Остатки(
		|			,
		|			Склад В (&Склад)
		|				И ИдентификаторУпаковки = &ИдентификаторУпаковки) КАК итТоварыВЯчейкахОстатки
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	итТоварыВЯчейкахРезервОстатки.Номенклатура,
		|	итТоварыВЯчейкахРезервОстатки.СерияНоменклатуры,
		|	итТоварыВЯчейкахРезервОстатки.ДатаРозлива,
		|	-итТоварыВЯчейкахРезервОстатки.КоличествоОстаток,
		|	итТоварыВЯчейкахРезервОстатки.ЯчейкаОтправитель,
		|	итТоварыВЯчейкахРезервОстатки.ИдентификаторУпаковки,
		|	итТоварыВЯчейкахРезервОстатки.Склад,
		|	итТоварыВЯчейкахРезервОстатки.Качество
		|ИЗ
		|	РегистрНакопления.итТоварыВЯчейкахРезерв.Остатки(
		|			,
		|			Склад В (&Склад)
		|				И ИдентификаторУпаковки = &ИдентификаторУпаковки) КАК итТоварыВЯчейкахРезервОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВтДанныеПоSSCC.Номенклатура,
		|	ВтДанныеПоSSCC.СерияНоменклатуры,
		|	ВтДанныеПоSSCC.ДатаРозлива,
		|	СУММА(ВтДанныеПоSSCC.КоличествоОстаток) КАК Количество,
		|	ВтДанныеПоSSCC.Ячейка,
		|	ВтДанныеПоSSCC.ИдентификаторУпаковки,
		|	ВтДанныеПоSSCC.Склад КАК Склад,
		|	ВтДанныеПоSSCC.Качество
		|ИЗ
		|	ВтДанныеПоSSCC КАК ВтДанныеПоSSCC
		|
		|СГРУППИРОВАТЬ ПО
		|	ВтДанныеПоSSCC.Номенклатура,
		|	ВтДанныеПоSSCC.СерияНоменклатуры,
		|	ВтДанныеПоSSCC.ДатаРозлива,
		|	ВтДанныеПоSSCC.Ячейка,
		|	ВтДанныеПоSSCC.ИдентификаторУпаковки,
		|	ВтДанныеПоSSCC.Склад,
		|	ВтДанныеПоSSCC.Качество
		|ИТОГИ ПО
		|	Склад";
	
	Запрос.УстановитьПараметр("ИдентификаторУпаковки", ДанныеОбработчика.КлючИнициализацииДанных);
	Запрос.УстановитьПараметр("Склад", Склады);
	
	РезультатЗапроса = Запрос.Выполнить();
	МассивДанных=новый Массив;
	ВыборкаПоСкладам=РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаПоСкладам.Следующий() цикл
		ДанныеОбработчика.Вставить("СкладИдентификатора",ВыборкаПоСкладам.Склад.УникальныйИдентификатор());
		ДанныеОбработчика.Вставить("СкладИдентификатораПредставление",ВыборкаПоСкладам.Склад.Наименование);
		ВыборкаДетальныеЗаписи = ВыборкаПоСкладам.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			СтруктураДанных=новый Структура;
			СтруктураДанных.Вставить("Номенклатура",ВыборкаДетальныеЗаписи.Номенклатура.УникальныйИдентификатор());
			СтруктураДанных.Вставить("НоменклатураПредставление",ВыборкаДетальныеЗаписи.Номенклатура.Наименование);
			СтруктураДанных.Вставить("СерияНоменклатуры",ВыборкаДетальныеЗаписи.СерияНоменклатуры.УникальныйИдентификатор());
			СтруктураДанных.Вставить("СерияНоменклатурыПредставление",ВыборкаДетальныеЗаписи.СерияНоменклатуры.Наименование);
			СтруктураДанных.Вставить("ДатаРозлива",ВыборкаДетальныеЗаписи.ДатаРозлива);
			СтруктураДанных.Вставить("ЯчейкаОтправитель",ВыборкаДетальныеЗаписи.Ячейка.УникальныйИдентификатор());
			СтруктураДанных.Вставить("ЯчейкаОтправительПредставление",ВыборкаДетальныеЗаписи.Ячейка.Наименование);
			СтруктураДанных.Вставить("ИдентификаторУпаковки",ВыборкаДетальныеЗаписи.ИдентификаторУпаковки);                 
			СтруктураДанных.Вставить("Количество",ВыборкаДетальныеЗаписи.Количество);
			СтруктураДанных.Вставить("Качество",ВыборкаДетальныеЗаписи.Качество.УникальныйИдентификатор());
			МассивДанных.Добавить(СтруктураДанных);
		КонецЦикла;
		Прервать;
		
	КонецЦикла;
	ДанныеОбработчика.Вставить("МассивДанных",МассивДанных);
	


КонецПроцедуры

Функция СписокВсехСкладов()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Склады.Ссылка
		|ИЗ
		|	Справочник.Склады КАК Склады";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	МассивСкладов=новый Массив;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		МассивСкладов.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
	КонецЦикла;
	Возврат МассивСкладов;
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	КонецФункции

