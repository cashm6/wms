
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если РежимЗаписи=РежимЗаписиДокумента.Проведение Тогда 
		ПередЗаписьПроведение(Отказ, РежимЗаписи, РежимПроведения);
	ИначеЕсли РежимЗаписи=РежимЗаписиДокумента.ОтменаПроведения Тогда 
		ПередЗаписьОтменаПроведения(Отказ, РежимЗаписи, РежимПроведения);
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписьПроведение(Отказ, РежимЗаписи, РежимПроведения)
	Если ДокументПоступления.Проведен Тогда 
		СтатусДокумента=Перечисления.ит_WMS_СтатусыТоваровВПути.Принят;
	иначе
		СтатусДокумента=Перечисления.ит_WMS_СтатусыТоваровВПути.ВПути;
	КонецЕсли;
	Если не ДокументПриемки.Пустая()  Тогда 
		ДатаОприходования=ДокументПриемки.ДатаЗавершенияДокумента;
	ИначеЕсли не ДокументПоступления.Пустая() Тогда 
		ДатаОприходования=ДокументПоступления.Дата;
	КонецЕсли;	
КонецПроцедуры

Процедура ПередЗаписьОтменаПроведения(Отказ, РежимЗаписи, РежимПроведения)
	СтатусДокумента= Перечисления.ит_WMS_СтатусыТоваровВПути.Создан;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	УстановитьБлокировкиДанныхИОчиститьРегистры();
	НаборЗаписей=РегистрыНакопления.итТоварыВПути.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Ссылка);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	Если СтатусДокумента=Перечисления.ит_WMS_СтатусыТоваровВПути.ВПути или СтатусДокумента=Перечисления.ит_WMS_СтатусыТоваровВПути.Принят Тогда
		Для Каждого стр из Товары Цикл 
			НоваяЗапись=НаборЗаписей.Добавить();
			НоваяЗапись.ВидДвижения=ВидДвиженияНакопления.Приход;
			НоваяЗапись.Поставщик=Поставщик;
			НоваяЗапись.Номенклатура= стр.Номенклатура;
			НоваяЗапись.Период=Дата;
			НоваяЗапись.Регистратор=Ссылка;
			НоваяЗапись.ДатаРозлива=стр.ДатаРозлива;
			НоваяЗапись.Количество=стр.Количество;
			НоваяЗапись.Сумма=стр.СуммаВсего;
		КонецЦикла;	
		
	КонецЕсли;
	
	Если СтатусДокумента=Перечисления.ит_WMS_СтатусыТоваровВПути.Принят Тогда
		Для Каждого стр из Товары Цикл 
			НоваяЗапись=НаборЗаписей.Добавить();
			НоваяЗапись.ВидДвижения=ВидДвиженияНакопления.Расход;
			НоваяЗапись.Поставщик=Поставщик;
			НоваяЗапись.Номенклатура= стр.Номенклатура;
			НоваяЗапись.Период=Дата;
			НоваяЗапись.Регистратор=Ссылка;
			НоваяЗапись.ДатаРозлива=стр.ДатаРозлива;
			НоваяЗапись.Количество=стр.Количество;
			НоваяЗапись.Сумма=стр.СуммаВсего;
		КонецЦикла;
	КонецЕсли;
	НаборЗаписей.Записать();


КонецПроцедуры

Процедура УстановитьБлокировкиДанныхИОчиститьРегистры()
	БлокировкаДанных = новый БлокировкаДанных;
	
	СтруктураПараметров=итWMSСлужебныеПроцедурыИФункции.СоздатьСтруктуруПараметровБлокировкиДанных(Товары,БлокировкаДанных);
	СтруктураПараметров.ПолеПространствоБлокировок="Номенклатура,ДатаРозлива";
	СтруктураПараметров.ПолеИсточника="Номенклатура,ДатаРозлива";
	СтруктураПараметров.ПространствоБлокировки="РегистрНакопления.итТоварыВПути";
	итWMSСлужебныеПроцедурыИФункции.УстановкаЭлементаБлокировокДанныхWMS(СтруктураПараметров);
	
	
	БлокировкаДанных.Заблокировать();
		
	НаборЗаписей=РегистрыНакопления.итТоварыВПути.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Ссылка);
	НаборЗаписей.Очистить();
	НаборЗаписей.Записать();
	
	
КонецПроцедуры
