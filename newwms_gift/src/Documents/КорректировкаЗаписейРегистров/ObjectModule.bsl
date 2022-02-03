
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;


Если НЕ ЭтоНовый() И ЗначениеРеквизитаОбъекта(Ссылка, "ПометкаУдаления") <> ПометкаУдаления Тогда
		// Изменился признак ПометкаУдаления у документа, надо синхронизировать свойство Активность у его движений.
		УстановитьАктивностьДвижений(НЕ ПометкаУдаления);
	ИначеЕсли ПометкаУдаления Тогда
		// У помеченного на удаление документа не должно быть движений со свойством Активность = Истина.
		УстановитьАктивностьДвижений(Ложь);
	КонецЕсли;

КонецПроцедуры

Функция ЗначениеРеквизитаОбъекта(Ссылка,Реквизит)
	ОбъектИзменения=Ссылка.ПолучитьОбъект();
	Если ОбъектИзменения=Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	Возврат ОбъектИзменения[Реквизит];
КонецФункции

Процедура УстановитьАктивностьДвижений(ФлагАктивности)
	
	// При записи из формы документа его движения уже прочитаны.
	НеобходимоПрочитатьДвижения = НЕ ДополнительныеСвойства.Свойство("ЗаписьДокументаИзФормы");
	
	Для Каждого Движение Из Движения Цикл
		
		Если НеобходимоПрочитатьДвижения Тогда
			Движение.Прочитать();
		КонецЕсли;
		
		Движение.УстановитьАктивность(ФлагАктивности);
		
	КонецЦикла;
	
КонецПроцедуры
