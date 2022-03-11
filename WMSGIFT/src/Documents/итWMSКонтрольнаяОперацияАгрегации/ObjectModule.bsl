 Перем ИгнорироватьОтказПриПроверках Экспорт ;

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	Если СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется тогда
		РаспределениеДокументаНаЗадачиТСД(Отказ, РежимПроведения);	
	КонецЕсли;
	Если  СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Выполнен
		Или  СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.ВыполненСОшибкой	тогда
		РезервированиеМарокЗаДокументом(Отказ, РежимПроведения);
	КонецЕсли;
	Если СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Завершен тогда
		ОчиститьДанныеРезервированияМарок();
	КонецЕсли;
КонецПроцедуры

Процедура РезервированиеМарокЗаДокументом(Отказ, РежимПроведения)
	БлокировкаДанных = новый БлокировкаДанных;
	ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.итWMS_МаркиВОбработке");
	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
	//ЭлементБлокировки.ИсточникДанных=ДанныеАгрегацииДокумента;
	//ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Марка","Марка");
	ЭлементБлокировки.УстановитьЗначение("ДокументОснование",Ссылка);
	БлокировкаДанных.Заблокировать();
	
	
	НаборЗаписей= РегистрыСведений.итWMS_МаркиВОбработке.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ДокументОснование.Установить(Ссылка);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	для Каждого стр из ДанныеАгрегацииДокумента цикл
		НоваяЗапись=НаборЗаписей.Добавить();
		НоваяЗапись.ДокументОснование=Ссылка;
		НоваяЗапись.Марка=стр.Марка;
	КонецЦикла;
	НаборЗаписей.Записать();
	
КонецПроцедуры
Процедура ОчиститьДанныеРезервированияМарок()
	БлокировкаДанных = новый БлокировкаДанных;
	ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.итWMS_МаркиВОбработке");
	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
	//ЭлементБлокировки.ИсточникДанных=ДанныеАгрегацииДокумента;
	//ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Марка","Марка");
	ЭлементБлокировки.УстановитьЗначение("ДокументОснование",Ссылка);
	БлокировкаДанных.Заблокировать();
	
	
	НаборЗаписей= РегистрыСведений.итWMS_МаркиВОбработке.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ДокументОснование.Установить(Ссылка);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	НаборЗаписей.Записать();
КонецПроцедуры

Процедура РаспределениеДокументаНаЗадачиТСД(Отказ, РежимПроведения)
	БлокировкаДанных = новый БлокировкаДанных;
	ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.итWMSЗадачиТСД");
	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("ДокументОснование",Ссылка);
	БлокировкаДанных.Заблокировать();
	
	НаборЗаписей= РегистрыСведений.итWMSЗадачиТСД.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ДокументОснование.Установить(Ссылка);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	НоваяЗапись = НаборЗаписей.Добавить();
	НоваяЗапись.ДокументОснование=Ссылка;
	НоваяЗапись.ИдЗадачи=новый УникальныйИдентификатор;
	НоваяЗапись.ТипЗадачи=Перечисления.итWMSТипыЗадачТСД.КонтрольнаяАгрегация;
	НоваяЗапись.Состояние=Перечисления.итWMSСостоянияЗадачТСД.КВыполнению;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры
//Процедура ЗаполнитьСтрокиЗадачиТСД(Отказ, РежимПроведения,ИдЗадачи,ВыборкаДетальныеЗаписи)
//	БлокировкаДанных = новый БлокировкаДанных;
//	ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.итWMSСтрокиЗадачТСД");
//	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
//	ЭлементБлокировки.УстановитьЗначение("ИдЗадачи",ИдЗадачи);
//	БлокировкаДанных.Заблокировать();
//	НаборЗаписей= РегистрыСведений.итWMSСтрокиЗадачТСД.СоздатьНаборЗаписей();
//	НаборЗаписей.Отбор.ИдЗадачи.Установить(ИдЗадачи);
//	НаборЗаписей.Прочитать();
//	НаборЗаписей.Очистить();
//	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
//		// Вставить обработку выборки ВыборкаДетальныеЗаписи
//		НоваяЗапись=НаборЗаписей.Добавить();
//		НоваяЗапись.ИдЗадачи=ИдЗадачи;
//		НоваяЗапись.идСтроки=ВыборкаДетальныеЗаписи.ИдентификаторСтроки;
//		НоваяЗапись.ДатаРозлива= ВыборкаДетальныеЗаписи.ДатаРозлива;
//		НоваяЗапись.Номенклатура=ВыборкаДетальныеЗаписи.Номенклатура;
//		НоваяЗапись.Количество=ВыборкаДетальныеЗаписи.Количество;
//	КонецЦикла;
//	НаборЗаписей.Записать();
//КонецПроцедуры
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	итWMSСлужебныеПроцедурыИФункции.УстановитьРежимПроведенияЗавершенногоДокумента(СтатусДокумента,РежимПроведения);
	Если ЭтотОбъект.Проведен и РежимЗаписи=РежимЗаписиДокумента.Запись тогда
		РежимЗаписи=РежимЗаписиДокумента.Проведение;
	КонецЕсли;	
	Если РежимЗаписи=РежимЗаписиДокумента.ОтменаПроведения тогда
		ПередЗаписьюОтменаПроведения(Отказ, РежимЗаписи, РежимПроведения);
	ИначеЕсли  РежимЗаписи= РежимЗаписиДокумента.Проведение тогда
		ПередЗаписьюПроведение(Отказ, РежимЗаписи, РежимПроведения);
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписьюОтменаПроведения(Отказ, РежимЗаписи, РежимПроведения)
	Если СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется или  СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован  тогда
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан;
		БлокировкаДанных = новый БлокировкаДанных;
		ЭлементБлокировки = БлокировкаДанных.Добавить("РегистрСведений.итWMSЗадачиТСД");
		ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ДокументОснование",Ссылка);
		БлокировкаДанных.Заблокировать();
		
		НаборЗаписей= РегистрыСведений.итWMSЗадачиТСД.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ДокументОснование.Установить(Ссылка);
		НаборЗаписей.Прочитать();
		//Если  ПриемкаИзТранзита тогда
		для Каждого стр из НаборЗаписей цикл
			НаборЗаписей_2=РегистрыСведений.итWMSСтрокиЗадачТСД.СоздатьНаборЗаписей();
			НаборЗаписей_2.Отбор.ИдЗадачи.Установить(стр.ИдЗадачи);
			НаборЗаписей_2.Прочитать();
			НаборЗаписей_2.Очистить();
			НаборЗаписей_2.Записать();
		КонецЦикла;
		//КонецЕсли;
		НаборЗаписей.Очистить();
		НаборЗаписей.Записать();
		ОчиститьДанныеРезервированияМарок();
		
	ИначеЕсли СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределен тогда
		Отказ = Истина;
		Сообщить("Документ распределен на тсд и не может быть распроведен ");
	ИначеЕсли СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Выполнен или   СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.ВыполненСОшибкой Тогда 
       ОчиститьДанныеРезервированияМарок();	
	КонецЕсли;	
КонецПроцедуры
Процедура ПередЗаписьюПроведение(Отказ, РежимЗаписи, РежимПроведения)
	ПроверкаНаНаличиеПроведенныхДокументовПоОснованию(Отказ);
	Если Отказ Тогда 
		Возврат
	КонецЕсли;	
	Если СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан и НеРаспределятьНаТСД тогда
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован;
	ИначеЕсли СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан и не НеРаспределятьНаТСД  тогда
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется;
		для Каждого стр из Товары цикл
			стр.СостояниеЗадачи=Перечисления.итWMSСостоянияЗадачТСД.КВыполнению;
		КонецЦикла;
		Хранилище=новый ХранилищеЗначения(Товары.Выгрузить(),новый СжатиеДанных(9));
		СнимокТабличнойЧастиДоРаспределения=Хранилище;
	ИначеЕсли СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован и не НеРаспределятьНаТСД  тогда
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется;
		для Каждого стр из Товары цикл
			стр.СостояниеЗадачи=Перечисления.итWMSСостоянияЗадачТСД.КВыполнению;
		КонецЦикла;
		Хранилище=новый ХранилищеЗначения(Товары.Выгрузить(),новый СжатиеДанных(9));
		СнимокТабличнойЧастиДоРаспределения=Хранилище;
	КонецЕсли;
КонецПроцедуры
Процедура ПроверкаНаНаличиеПроведенныхДокументовПоОснованию(Отказ)
	Если итОснование=Неопределено  Тогда 
		Возврат
	КонецЕсли;
	
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSКонтрольнаяОперацияАгрегации.Ссылка
	|ИЗ
	|	Документ.итWMSКонтрольнаяОперацияАгрегации КАК итWMSКонтрольнаяОперацияАгрегации
	|ГДЕ
	|	итWMSКонтрольнаяОперацияАгрегации.итОснование = &итОснование
	|	И итWMSКонтрольнаяОперацияАгрегации.Ссылка <> &Ссылка
	|	И итWMSКонтрольнаяОперацияАгрегации.Проведен = ИСТИНА
	|
	|СГРУППИРОВАТЬ ПО
	|	итWMSКонтрольнаяОперацияАгрегации.Ссылка";
	
	Запрос.УстановитьПараметр("итОснование", итОснование);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Отказ=Истина;
		Сообщить("по текущему основанию уже есть проведенный документ КОА "+ВыборкаДетальныеЗаписи.Ссылка+" для проведения нового, пометьте на удаление предыдущий");  
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	ЭтотОбъект.ДанныеАгрегацииДокумента.Очистить();
	ЭтотОбъект.итОснование=Неопределено;
	ЭтотОбъект.Товары.Очистить();
КонецПроцедуры

Процедура ЗаполнитьДокументИзДанныхОснования(Основание) Экспорт 
	Если Метаданные.Документы.Найти(Основание.Метаданные().Имя)= Неопределено тогда
		Сообщить("не верный тип данных основания");
		Возврат	
	КонецЕсли;
	//аа=Документы.СведенияОВзносахИСтраховомСтажеСПВ1.СоздатьДокумент().Ссылка;
	////аа.Метаданные().Имя
	//аа.Метаданные().Реквизиты.Найти
	//аа.Метаданные().ТабличныеЧасти.РаботникиОрганизации.Реквизиты.
	итОснование=Основание;
	Если  Основание.Метаданные().Реквизиты.Найти("Организация") <> Неопределено тогда
		Организация=Основание.Организация;
	КонецЕсли;
	Если  Основание.Метаданные().Реквизиты.Найти("Контрагент") <> Неопределено тогда
		Контрагент=Основание.Контрагент;
	КонецЕсли;
	Если  Основание.Метаданные().ТабличныеЧасти.Найти("Товары")<>Неопределено тогда
		ТчТоварыМетаданные=Основание.Метаданные().ТабличныеЧасти.Товары;
		ПроверкаНаВозможностьКопированияТаблицы=Истина;
		НетЕдиницыИзмерения=Ложь;
		ПолеХарактеристики="";
		Если  ТчТоварыМетаданные.Реквизиты.найти("Номенклатура")=Неопределено тогда
			ПроверкаНаВозможностьКопированияТаблицы = Ложь;
		КонецЕсли;
		
		Если  ТчТоварыМетаданные.Реквизиты.найти("ХарактеристикаНоменклатуры")<>Неопределено тогда
			ПолеХарактеристики="ХарактеристикаНоменклатуры";
		КонецЕсли;
		Если  ТчТоварыМетаданные.Реквизиты.найти("Характеристика")<>Неопределено тогда
			ПолеХарактеристики="Характеристика";
		КонецЕсли;
		Если ПолеХарактеристики="" тогда
			ПроверкаНаВозможностьКопированияТаблицы=Ложь;
		КонецЕсли;	 
		
		Если  ТчТоварыМетаданные.Реквизиты.найти("СерияНоменклатуры")=Неопределено тогда
			ПроверкаНаВозможностьКопированияТаблицы = Ложь;
		КонецЕсли;
		
		Если  ТчТоварыМетаданные.Реквизиты.найти("Количество")=Неопределено тогда
			ПроверкаНаВозможностьКопированияТаблицы = Ложь;
		КонецЕсли;
		Если  ТчТоварыМетаданные.Реквизиты.найти("ЕдиницаИзмерения")=Неопределено тогда
			НетЕдиницыИзмерения=Истина;
		КонецЕсли;
		Если ПроверкаНаВозможностьКопированияТаблицы тогда
			//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
			// Данный фрагмент построен конструктором.
			// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
			ИмяДокумента=Основание.Метаданные().Имя;
			Запрос = Новый Запрос;
			Запрос.Текст = 
			"ВЫБРАТЬ
			|	ТаблицаДанныхТовара.Номенклатура,
			|	МАКСИМУМ(ВЫБОР
			|			КОГДА &НетЕдиницыИзмерения
			|				ТОГДА 1
			|			ИНАЧЕ ТаблицаДанныхТовара.ЕдиницаИзмерения.Коэффициент
			|		КОНЕЦ) КАК Коэффициент,
			|	СУММА(ЕСТЬNULL(ТаблицаДанныхТовара.Количество, 0) * ЕСТЬNULL(ВЫБОР
			|				КОГДА &НетЕдиницыИзмерения
			|					ТОГДА 1
			|				ИНАЧЕ ТаблицаДанныхТовара.ЕдиницаИзмерения.Коэффициент
			|			КОНЕЦ, 0)) КАК Количество,
			|	ТаблицаДанныхТовара."+ПолеХарактеристики+" КАК Характеристика,
			|	ТаблицаДанныхТовара.СерияНоменклатуры
			|ИЗ
			|	Документ."+ИмяДокумента+".Товары КАК ТаблицаДанныхТовара
			|ГДЕ
			|	ТаблицаДанныхТовара.Ссылка = &Ссылка
			|	И ТаблицаДанныхТовара.СерияНоменклатуры.итПризнакПомарочногоУчета
			|
			|СГРУППИРОВАТЬ ПО
			|	ТаблицаДанныхТовара.Номенклатура,
			|	ТаблицаДанныхТовара.ХарактеристикаНоменклатуры,
			|	ТаблицаДанныхТовара.СерияНоменклатуры";
			
			Запрос.УстановитьПараметр("НетЕдиницыИзмерения", НетЕдиницыИзмерения);
			Запрос.УстановитьПараметр("Ссылка",Основание);
			РезультатЗапроса = Запрос.Выполнить();
			
			ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
			
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				НоваяСтрока=ДанныеДляАгрегацииДокумента.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока,ВыборкаДетальныеЗаписи);
				Если Метаданные.Справочники.СерииНоменклатуры.Реквизиты.Найти("алкДатаНачалаРозлива") <> Неопределено тогда
					НоваяСтрока.ДатаРозлива=НоваяСтрока.СерияНоменклатуры.ДатаПроизводства;
				КонецЕсли;
			КонецЦикла;
			
			//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
			
		КонецЕсли;
		
		
	КонецЕсли;
	
КонецПроцедуры
Функция ЕстьРасхождения()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента.Номенклатура КАК Номенклатура,
	|	итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента.Характиристика КАК Характиристика,
	|	итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента.СерияНоменклатуры КАК СерияНоменклатуры,
	|	итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента.Количество КАК КоличествоПлан,
	|	NULL КАК КоличествоФакт
	|ПОМЕСТИТЬ ВтДанныеПроверки
	|ИЗ
	|	Документ.итWMSКонтрольнаяОперацияАгрегации.ДанныеДляАгрегацииДокумента КАК итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента
	|ГДЕ
	|	итWMSКонтрольнаяОперацияАгрегацииДанныеДляАгрегацииДокумента.Ссылка = &Ссылка
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	итWMSКонтрольнаяОперацияАгрегацииТовары.Номенклатура,
	|	итWMSКонтрольнаяОперацияАгрегацииТовары.Характеристика,
	|	итWMSКонтрольнаяОперацияАгрегацииТовары.СерияНоменклатуры,
	|	NULL,
	|	итWMSКонтрольнаяОперацияАгрегацииТовары.Количество
	|ИЗ
	|	Документ.итWMSКонтрольнаяОперацияАгрегации.Товары КАК итWMSКонтрольнаяОперацияАгрегацииТовары
	|ГДЕ
	|	итWMSКонтрольнаяОперацияАгрегацииТовары.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтДанныеПроверки.Номенклатура,
	|	ВтДанныеПроверки.Характиристика,
	|	ВтДанныеПроверки.СерияНоменклатуры,
	|	СУММА(ЕСТЬNULL(ВтДанныеПроверки.КоличествоПлан, 0)) КАК КоличествоПлан,
	|	СУММА(ЕСТЬNULL(ВтДанныеПроверки.КоличествоФакт, 0)) КАК КоличествоФакт
	|ПОМЕСТИТЬ ВтДанныеПроверкиГруппировка
	|ИЗ
	|	ВтДанныеПроверки КАК ВтДанныеПроверки
	|
	|СГРУППИРОВАТЬ ПО
	|	ВтДанныеПроверки.Номенклатура,
	|	ВтДанныеПроверки.Характиристика,
	|	ВтДанныеПроверки.СерияНоменклатуры
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВтДанныеПроверкиГруппировка.Номенклатура,
	|	ВтДанныеПроверкиГруппировка.Характиристика,
	|	ВтДанныеПроверкиГруппировка.СерияНоменклатуры,
	|	ВтДанныеПроверкиГруппировка.КоличествоПлан,
	|	ВтДанныеПроверкиГруппировка.КоличествоФакт
	|ИЗ
	|	ВтДанныеПроверкиГруппировка КАК ВтДанныеПроверкиГруппировка
	|ГДЕ
	|	ВтДанныеПроверкиГруппировка.КоличествоПлан <> ВтДанныеПроверкиГруппировка.КоличествоФакт";
	
	
	Запрос.УстановитьПараметр("Ссылка",Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() Тогда 
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецФункции

#Область ОбязательныеПроцедурыИФункции

Процедура ДействияПриОтказеОтИсполненияДокумента()Экспорт 
	ЭтотОбъект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется;
	СнимокТовары=СнимокТабличнойЧастиДоРаспределения.Получить();
	Если ТипЗнч(СнимокТовары)=тип("ТаблицаЗначений") тогда
		Товары.Очистить();
		Товары.Загрузить(СнимокТовары);
	КонецЕсли;	
	ДанныеАгрегацииДокумента.Очистить();
КонецПроцедуры

Процедура ДействияПриФиксацииЗадачДокумента() Экспорт 
	ДатаЗавершенияДокумента=ТекущаяДата();
	Если ЕстьРасхождения() тогда
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.ВыполненСОшибкой;
	иначе
		СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Выполнен;
	КонецЕсли;
КонецПроцедуры


#КонецОбласти
