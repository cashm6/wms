
Процедура ОбновлениеИсторииДанных() Экспорт
	ИсторияДанных.ОбновитьИсторию();
КонецПроцедуры

Процедура ИтWMSПолучениеДанныхТранзита() Экспорт 
	итWMSПривилегированныйМодуль.ИтWMSПолучениеДанныхТранзита();
КонецПроцедуры


Процедура итWMSРазблокировкаЯчеекПослеИнвентаризации() Экспорт 
	итWMSПривилегированныйМодуль.итWMSРазблокировкаЯчеекПослеИнвентаризации();
КонецПроцедуры


Процедура итWMSЗаписьДанныхТранзита() Экспорт 
	итWMSПривилегированныйМодуль.итWMSЗаписьДанныхТранзита();
КонецПроцедуры


Процедура итWMS_ОчискаКОА_ПоИстечениюСрока()Экспорт 
	итWMSПривилегированныйМодуль.итWMS_ОчискаКОА_ПоИстечениюСрока();	
КонецПроцедуры


Процедура ЦентральныйОбработчикПополненияСтока() Экспорт 
	  итWMSПривилегированныйМодуль.ЦентральныйОбработчикПополненияСтока();
  КонецПроцедуры
  
Процедура итWMS_SQLЗаписьМарки() Экспорт 
	    итWMSПривилегированныйМодуль.итWMS_SQLЗаписьМарки();
КонецПроцедуры
	
Процедура ОбменДаннымиМарок() Экспорт 
	МодульПолученияДанныхМарок.ОбменДаннымиМарок();	
КонецПроцедуры

Процедура РегламентныйЗапускРассчетаРасстоянияМеждуЯчейками() Экспорт 
	итWMSПривилегированныйМодуль.РегламентныйЗапускРассчетаРасстоянияМеждуЯчейками();
КонецПроцедуры

Процедура ит_WMS_АнализТоваровВПути() Экспорт 
	итWMSПривилегированныйМодуль.ит_WMS_АнализТоваровВПути();
	КонецПроцедуры
	
Процедура ОчисткаДанныхМарокРегламетноеЗадание() Экспорт 
	итWMSПривилегированныйМодуль.ОчисткаДанныхМарокРегламетноеЗадание();	
		КонецПроцедуры

Процедура ит_WMS_УдалениеУстаревшихДанныхХранилища() Экспорт 
	итWMSПривилегированныйМодуль.ит_WMS_УдалениеУстаревшихДанныхХранилища();
КонецПроцедуры

Процедура ит_WMS_КонтрольПроведенностиДокументов() Экспорт 	
	итWMSПривилегированныйМодуль.ит_WMS_КонтрольПроведенностиДокументов();
	КонецПроцедуры

Процедура ВыгрузкаКА11() Экспорт 
		МодульОбменаУправленчискимиДанными.ВыгрузкаКА11();
	КонецПроцедуры
	
Процедура WMS_ВыгрузкаСервесныйДанных() Экспорт 
		МодульОбменаСервеснымиДаннымиWMS.WMS_ВыгрузкаСервесныйДанных();
	КонецПроцедуры

Процедура ит_WMS_ОбслуживаниеРегистрацииДвиженияМарок() Экспорт
		итWMSПривилегированныйМодуль.ит_WMS_ОбслуживаниеРегистрацииДвиженияМарок();
	КонецПроцедуры

Процедура ЗавершениеПМУПроверки() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаписиПодтвержденияВыгрузкиВЕГАИС.ДокументРегУчета КАК ДокументРегУчета
		|ПОМЕСТИТЬ Вт
		|ИЗ
		|	РегистрСведений.ЗаписиПодтвержденияВыгрузкиВЕГАИС КАК ЗаписиПодтвержденияВыгрузкиВЕГАИС
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МАКСИМУМ(итWMSНаборка.Ссылка) КАК Наборка,
		|	Вт.ДокументРегУчета КАК ДокументРегУчета
		|ПОМЕСТИТЬ Вт2
		|ИЗ
		|	Вт КАК Вт
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.итWMSНаборка КАК итWMSНаборка
		|		ПО Вт.ДокументРегУчета.Основание = итWMSНаборка.Ссылка
		|			И (итWMSНаборка.Проведен)
		|
		|СГРУППИРОВАТЬ ПО
		|	Вт.ДокументРегУчета
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Вт2.Наборка КАК Наборка,
		|	Вт2.ДокументРегУчета КАК ДокументРегУчета,
		|	итWMSПроверкаитОснования.Ссылка КАК Проверка
		|ИЗ
		|	Вт2 КАК Вт2
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.итWMSПроверка.итОснования КАК итWMSПроверкаитОснования
		|		ПО Вт2.Наборка = итWMSПроверкаитОснования.Документ
		|			И (итWMSПроверкаитОснования.Ссылка.СтатусДокумента = ЗНАЧЕНИЕ(Перечисление.итwmsСтатусыСкладскихДокументов.Выполнен)
		|				ИЛИ итWMSПроверкаитОснования.Ссылка.СтатусДокумента = ЗНАЧЕНИЕ(Перечисление.итwmsСтатусыСкладскихДокументов.Завершен)
		|				ИЛИ итWMSПроверкаитОснования.Ссылка.СтатусДокумента = ЗНАЧЕНИЕ(Перечисление.итwmsСтатусыСкладскихДокументов.ВыполненСОшибкой))";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ОбъектПроверки=ВыборкаДетальныеЗаписи.Проверка.ПолучитьОбъект();
		ОбъектПроверки.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Завершен;
		ОбъектПроверки.Записать();
		
		НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
		БлокировкаДанных=новый БлокировкаДанных;
		ЭлементБлокировки=БлокировкаДанных.Добавить("РегистрСведений.ЗаписиПодтвержденияВыгрузкиВЕГАИС");
		ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("ДокументРегУчета",ВыборкаДетальныеЗаписи.ДокументРегУчета);
		БлокировкаДанных.Заблокировать();
		
		Набор=РегистрыСведений.ЗаписиПодтвержденияВыгрузкиВЕГАИС.СоздатьНаборЗаписей();
		Набор.Отбор.ДокументРегУчета.Установить(ВыборкаДетальныеЗаписи.ДокументРегУчета);
		Набор.Прочитать();
		Набор.Очистить();
		Набор.Записать();
		ЗафиксироватьТранзакцию();

	КонецЦикла;
	

КонецПроцедуры
#Область ПользовательскиеРегламентныеЗадания

Процедура ПользовательскиеРегламентныеЗадания() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПользовательскиРегламентныеЗадания.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ ВтСписокИспользуемыхЗаданий
		|ИЗ
		|	Справочник.ПользовательскиРегламентныеЗадания КАК ПользовательскиРегламентныеЗадания
		|ГДЕ
		|	ПользовательскиРегламентныеЗадания.Использовать
		|	И НЕ ПользовательскиРегламентныеЗадания.ПометкаУдаления
		|
		|СГРУППИРОВАТЬ ПО
		|	ПользовательскиРегламентныеЗадания.Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЕСТЬNULL(ИсполнениеПользовательскихРегламентныхЗаданий.Задание, ВтСписокИспользуемыхЗаданий.Ссылка) КАК Задание,
		|	ЕСТЬNULL(ИсполнениеПользовательскихРегламентныхЗаданий.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияИсполненияПользовательскихЗаданий.Выполнен)) КАК Состояние,
		|	ЕСТЬNULL(ИсполнениеПользовательскихРегламентныхЗаданий.ДатаПланируемогоПовтора, ДАТАВРЕМЯ(1, 1, 1, 0, 0, 0)) КАК ДатаПланируемогоПовтора
		|ПОМЕСТИТЬ ТаблицаАнализаЗаданий
		|ИЗ
		|	ВтСписокИспользуемыхЗаданий КАК ВтСписокИспользуемыхЗаданий
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ИсполнениеПользовательскихРегламентныхЗаданий КАК ИсполнениеПользовательскихРегламентныхЗаданий
		|		ПО ВтСписокИспользуемыхЗаданий.Ссылка = ИсполнениеПользовательскихРегламентныхЗаданий.Задание
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТаблицаАнализаЗаданий.Задание КАК Задание,
		|	ТаблицаАнализаЗаданий.Состояние КАК Состояние
		|ИЗ
		|	ТаблицаАнализаЗаданий КАК ТаблицаАнализаЗаданий
		|ГДЕ
		|	ТаблицаАнализаЗаданий.Состояние В (ЗНАЧЕНИЕ(Перечисление.СостоянияИсполненияПользовательскихЗаданий.Выполнен), ЗНАЧЕНИЕ(Перечисление.СостоянияИсполненияПользовательскихЗаданий.ВыполненСОшибкой), ЗНАЧЕНИЕ(Перечисление.СостоянияИсполненияПользовательскихЗаданий.Отменен))
		|	И ТаблицаАнализаЗаданий.ДатаПланируемогоПовтора < &ТекущаяДата";
	
	Запрос.УстановитьПараметр("ТекущаяДата", ТекущаяДата());
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		//ЗаписьЖурналаРегистрации("ПерезаписьМарокЕгаисРегламетноеЗадание",УровеньЖурналаРегистрации.Ошибка,,,Строка(ВыборкаДетальныеЗаписи.Состояние)+" "+Строка(ВыборкаДетальныеЗаписи.Задание)+" "+Строка(ТекущаяДата()));

		ЗапускПользовательскогоРегламетногоЗадания(ВыборкаДетальныеЗаписи.Задание);
	КонецЦикла;
	СостояниеФоновогоЗаданияОбслуживания=ПолучитьСостояниеФоновогоЗадания("ОбработкаСостоянияПользовательскихЗаданий");
	Если СостояниеФоновогоЗаданияОбслуживания<>СостояниеФоновогоЗадания.Активно Тогда 
	ФоновыеЗадания.Выполнить("ЗапускРегЗаданияПривилегированный.ОбработкаСостоянияПользовательскихЗаданий",,"ОбработкаСостоянияПользовательскихЗаданий","ОбработкаСостоянияПользовательскихЗаданий");
    КонецЕсли;


КонецПроцедуры

Процедура ОбработкаСостоянияПользовательскихЗаданий() Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ИсполнениеПользовательскихРегламентныхЗаданий.Задание КАК Задание,
		|	ИсполнениеПользовательскихРегламентныхЗаданий.ТекущийКлюч КАК ТекущийКлюч,
		|	ИсполнениеПользовательскихРегламентныхЗаданий.Состояние КАК Состояние,
		|	ИсполнениеПользовательскихРегламентныхЗаданий.ПризнакУдаления КАК ПризнакУдаления
		|ИЗ
		|	РегистрСведений.ИсполнениеПользовательскихРегламентныхЗаданий КАК ИсполнениеПользовательскихРегламентныхЗаданий
		|ГДЕ
		|	(ИсполнениеПользовательскихРегламентныхЗаданий.Состояние = &Состояние
		|			ИЛИ ИсполнениеПользовательскихРегламентныхЗаданий.ПризнакУдаления)";
	
	Запрос.УстановитьПараметр("Состояние", Перечисления.СостоянияИсполненияПользовательскихЗаданий.Выполняется);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Если ВыборкаДетальныеЗаписи.Состояние <> Перечисления.СостоянияИсполненияПользовательскихЗаданий.Выполняется и   ВыборкаДетальныеЗаписи.ПризнакУдаления тогда
			НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
			БлокировкаПоПользовательскомуЗаданию(ВыборкаДетальныеЗаписи.Задание);
			МенеджерЗаписей=РегистрыСведений.ИсполнениеПользовательскихРегламентныхЗаданий.СоздатьМенеджерЗаписи();
			МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
			МенеджерЗаписей.Прочитать();
			Если МенеджерЗаписей.ПризнакУдаления Тогда 
				МенеджерЗаписей.Удалить();
            КонецЕсли;
			ЗафиксироватьТранзакцию();
			Продолжить;
		КонецЕсли;
		Состояние=ПолучитьСостояниеФоновогоЗадания(ВыборкаДетальныеЗаписи.ТекущийКлюч);
		
		Если Состояние = СостояниеФоновогоЗадания.Активно Тогда 
			Продолжить;
		КонецЕсли;
		Если Состояние = СостояниеФоновогоЗадания.Отменено или Состояние=Неопределено Тогда 
			НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
			БлокировкаПоПользовательскомуЗаданию(ВыборкаДетальныеЗаписи.Задание);
			МенеджерЗаписей=РегистрыСведений.ИсполнениеПользовательскихРегламентныхЗаданий.СоздатьМенеджерЗаписи();
			МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
			МенеджерЗаписей.Прочитать();
			Если МенеджерЗаписей.ПризнакУдаления Тогда 
				МенеджерЗаписей.Удалить();
			иначе
				МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
				МенеджерЗаписей.ТекущийКлюч=ВыборкаДетальныеЗаписи.ТекущийКлюч;
				МенеджерЗаписей.Состояние=Перечисления.СостоянияИсполненияПользовательскихЗаданий.Отменен;
				МенеджерЗаписей.ДатаЗавершения=ТекущаяДата();
				МенеджерЗаписей.Записать(Истина);
			КонецЕсли;
			ЗафиксироватьТранзакцию();
			Продолжить;
		КонецЕсли;
		Если Состояние = СостояниеФоновогоЗадания.ЗавершеноАварийно Тогда 
			НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
			БлокировкаПоПользовательскомуЗаданию(ВыборкаДетальныеЗаписи.Задание);
			МенеджерЗаписей=РегистрыСведений.ИсполнениеПользовательскихРегламентныхЗаданий.СоздатьМенеджерЗаписи();
			МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
			МенеджерЗаписей.Прочитать();
			Если МенеджерЗаписей.ПризнакУдаления Тогда 
				МенеджерЗаписей.Удалить();
			иначе
				МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
				МенеджерЗаписей.ТекущийКлюч=ВыборкаДетальныеЗаписи.ТекущийКлюч;
				МенеджерЗаписей.Состояние=Перечисления.СостоянияИсполненияПользовательскихЗаданий.ВыполненСОшибкой;
				МенеджерЗаписей.ДатаЗавершения=ТекущаяДата();
				МенеджерЗаписей.Записать(Истина);
			КонецЕсли;
			ЗафиксироватьТранзакцию();
			Продолжить;
		КонецЕсли;
		Если Состояние = СостояниеФоновогоЗадания.Завершено Тогда 
			НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
			БлокировкаПоПользовательскомуЗаданию(ВыборкаДетальныеЗаписи.Задание);
			МенеджерЗаписей=РегистрыСведений.ИсполнениеПользовательскихРегламентныхЗаданий.СоздатьМенеджерЗаписи();
			МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
			МенеджерЗаписей.Прочитать();
			Если МенеджерЗаписей.ПризнакУдаления Тогда 
				МенеджерЗаписей.Удалить();
			иначе
				
				МенеджерЗаписей.Задание=ВыборкаДетальныеЗаписи.Задание;
				МенеджерЗаписей.ТекущийКлюч=ВыборкаДетальныеЗаписи.ТекущийКлюч;
				МенеджерЗаписей.Состояние=Перечисления.СостоянияИсполненияПользовательскихЗаданий.Выполнен;
				МенеджерЗаписей.ДатаЗавершения=ТекущаяДата();
				МенеджерЗаписей.Записать(Истина);
			КонецЕсли;
			ЗафиксироватьТранзакцию();
			Продолжить;
		КонецЕсли;
		
	КонецЦикла;
	
	
	
КонецПроцедуры


Функция ПолучитьСостояниеФоновогоЗадания(Ключ)
	МассивЗаданий=ФоновыеЗадания.ПолучитьФоновыеЗадания(новый Структура("Ключ",Ключ));
	Для Каждого Задание из МассивЗаданий цикл
		Возврат Задание.Состояние;
	КонецЦикла;
    Возврат Неопределено;
	КонецФункции

	
Процедура БлокировкаПоПользовательскомуЗаданию(ПользовательскоеЗадание)
	БлокировкаДанных=новый БлокировкаДанных;
	ЭлементБлокировки=БлокировкаДанных.Добавить("РегистрСведений.ИсполнениеПользовательскихРегламентныхЗаданий");
	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("Задание",ПользовательскоеЗадание);
	БлокировкаДанных.Заблокировать();

	КонецПроцедуры

Процедура ЗапускПользовательскогоРегламетногоЗадания(ПользовательскоеЗадание)
    КлючЗадания =новый УникальныйИдентификатор;
	НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
	БлокировкаПоПользовательскомуЗаданию(ПользовательскоеЗадание);
	МенеджерЗаписей=РегистрыСведений.ИсполнениеПользовательскихРегламентныхЗаданий.СоздатьМенеджерЗаписи();
	МенеджерЗаписей.Задание=ПользовательскоеЗадание;
	МенеджерЗаписей.Прочитать();
	МенеджерЗаписей.Задание=ПользовательскоеЗадание;
	МенеджерЗаписей.ТекущийКлюч=КлючЗадания;
	МенеджерЗаписей.Состояние=Перечисления.СостоянияИсполненияПользовательскихЗаданий.Выполняется;
	МенеджерЗаписей.ДатаНачала=ТекущаяДата();
	МенеджерЗаписей.ДатаЗавершения='00010101';
	МенеджерЗаписей.ДатаПланируемогоПовтора=МенеджерЗаписей.ДатаНачала+ПользовательскоеЗадание.ВремяПовтораВСекундах;
	МенеджерЗаписей.Записать(Истина);
	ЗафиксироватьТранзакцию();
	ФоновыеЗадания.Выполнить(ПользовательскоеЗадание.Метод,,КлючЗадания,ПользовательскоеЗадание.ТехническоеНазвание);
КонецПроцедуры
#КонецОбласти

#Область ПерезаписьМарокНаНовыйРегистр

Процедура ЗапусПерезаписиМарокЕгаис()Экспорт 
МассивНаименований=новый Массив;
МассивНаименований.Добавить("ПерезаписьМарокЕгаис");
МассивНаименований.Добавить("СозданиеМаркиСервисное");
итWMSСлужебныеПроцедурыИФункции.ОжиданиеВыполненияЗаданийНаименование(МассивНаименований,60);
Узел=ПланыОбмена.WMSОбменМарками.НайтиПоКоду("ГИФТ");
СчетчикЗаданий=0;
СчетчикМарок=0;
МассивКлючей=новый Массив;
МассивНомеров=новый Массив;
МинимальныйНомерСообщенияПерезаписи=МинимальныйНомерСообщенияПерезаписи(Узел,МассивНомеров);
Если МинимальныйНомерСообщенияПерезаписи=0 Тогда 
	Возврат
КонецЕсли;
Пока СчетчикЗаданий< 200 Цикл
	МассивМарок=ПолучитьМаркиДокументОбработки(МинимальныйНомерСообщенияПерезаписи,Узел);
	КоличествоМарок= МассивМарок.Количество();
	Если КоличествоМарок=0 Тогда
		МассивНомеров.Добавить(МинимальныйНомерСообщенияПерезаписи);
		МинимальныйНомерСообщенияПерезаписи=МинимальныйНомерСообщенияПерезаписи(Узел,МассивНомеров);
		Если МинимальныйНомерСообщенияПерезаписи=0 Тогда 
			Прервать;
		КонецЕсли;
		СчетчикЗаданий=СчетчикЗаданий+1;
		Продолжить;
	КонецЕсли;
	СчетчикМарок=СчетчикМарок+КоличествоМарок;
	КлючЗадания=новый УникальныйИдентификатор;
	МассивПараметров=новый Массив;
	МассивПараметров.Добавить(МассивМарок);
	ФоновыеЗадания.Выполнить("итWMSПривилегированныйМодуль.СервесныйСоздатьМаркиСБлокировкой",МассивПараметров,КлючЗадания,"СозданиеМаркиСервисное");
	МассивКлючей.Добавить(КлючЗадания);	
	МассивНомеров.Добавить(МинимальныйНомерСообщенияПерезаписи);
	МинимальныйНомерСообщенияПерезаписи=МинимальныйНомерСообщенияПерезаписи(Узел,МассивНомеров);
	Если МинимальныйНомерСообщенияПерезаписи=0 Тогда 
		Прервать;
	КонецЕсли;
	СчетчикЗаданий=СчетчикЗаданий+1;
	Если СчетчикМарок>=300000 Тогда 
		Прервать;
	КонецЕсли;
КонецЦикла;
итWMSСлужебныеПроцедурыИФункции.ОжиданиеВыполненияЗаданий(МассивКлючей,60);
МассивКлючей.Очистить();
СчетчикЗаданий=0;
Для Каждого стр из МассивНомеров Цикл 
	МассивПараметров=новый Массив;
	СтруктураПараметров=новый Структура;
	СтруктураПараметров.Вставить("НомерСообщения",стр);
	СтруктураПараметров.Вставить("Узел",Узел);
	МассивПараметров.Добавить(СтруктураПараметров);
	Ключ=новый УникальныйИдентификатор;
	МассивКлючей.Добавить(Ключ);
	ФоновыеЗадания.Выполнить("ЗапускРегЗаданияПривилегированный.ПерезаписьМарокДокументаЕгаис",МассивПараметров,Ключ,"ПерезаписьМарокЕгаис");
	СчетчикЗаданий=СчетчикЗаданий+1;
	Если СчетчикЗаданий>=15 Тогда 
		итWMSСлужебныеПроцедурыИФункции.ОжиданиеВыполненияЗаданий(МассивКлючей,60);
		МассивКлючей.Очистить();
        СчетчикЗаданий=0;
	КонецЕсли;
КонецЦикла;

итWMSСлужебныеПроцедурыИФункции.ОжиданиеВыполненияЗаданий(МассивКлючей,60);
КонецПроцедуры


Функция ПолучитьДокументПоНомеруСообщенияЕгаис(НомерСообщения,Узел)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ит_WMS_РегистрацияДвиженияМарок.Ссылка КАК Ссылка
		|ИЗ
		|	РегистрСведений.ит_WMS_РегистрацияДвиженияМарок КАК ит_WMS_РегистрацияДвиженияМарок
		|ГДЕ
		|	ит_WMS_РегистрацияДвиженияМарок.УзелОбмена = &УзелОбмена
		|	И ит_WMS_РегистрацияДвиженияМарок.НомерСообщения = &НомерСообщения";
	
	Запрос.УстановитьПараметр("НомерСообщения", НомерСообщения);
	Запрос.УстановитьПараметр("УзелОбмена", Узел);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	    Возврат Неопределено;
	
КонецФункции

Функция  ПолучитьМаркиДокументОбработки (НомерСообщения,Узел) 
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ит_WMS_РегистрацияДвиженияМарок.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ Вт
		|ИЗ
		|	РегистрСведений.ит_WMS_РегистрацияДвиженияМарок КАК ит_WMS_РегистрацияДвиженияМарок
		|ГДЕ
		|	ит_WMS_РегистрацияДвиженияМарок.УзелОбмена = &УзелОбмена
		|	И ит_WMS_РегистрацияДвиженияМарок.НомерСообщения = &НомерСообщения
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	алкХранилищеАкцизныхМарок.Марка.ЗначениеШтрихКода КАК МаркаЗначениеШтрихКода
		|ПОМЕСТИТЬ Вт2
		|ИЗ
		|	Вт КАК Вт
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
		|		ПО Вт.Ссылка = алкХранилищеАкцизныхМарок.Регистратор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Вт2.МаркаЗначениеШтрихКода КАК Марка
		|ИЗ
		|	Вт2 КАК Вт2
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Марки1 КАК Марки1
		|		ПО Вт2.МаркаЗначениеШтрихКода = Марки1.ЗначениеШтрихКода
		|ГДЕ
		|	Марки1.Ссылка ЕСТЬ NULL";
	
	Запрос.УстановитьПараметр("НомерСообщения", НомерСообщения);
	Запрос.УстановитьПараметр("УзелОбмена", Узел);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	МассивМарок=новый Массив;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		МассивМарок.Добавить(ВыборкаДетальныеЗаписи.Марка);
	КонецЦикла;
	
	Возврат МассивМарок;
	
	КонецФункции

Процедура ПерезаписьМарокДокументаЕгаис(Параметры) Экспорт 
	Узел=Параметры.Узел;
	НомерСообщения=Параметры.НомерСообщения;
	Документ=ПолучитьДокументПоНомеруСообщенияЕгаис(НомерСообщения,Узел);
	//ЗаписьЖурналаРегистрации("ДокументМарокЕгаис",УровеньЖурналаРегистрации.Ошибка,Метаданные.Документы.ДокументДвиженияМарок,,Строка(НомерСообщения)+" "+Строка(Документ)+" "+Строка(ТекущаяДата()));

	Если Документ=Неопределено Тогда 
		Возврат
	КонецЕсли;	
	Попытка
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	алкХранилищеАкцизныхМарок.Период КАК Период,
		|	алкХранилищеАкцизныхМарок.Регистратор КАК Регистратор,
		|	алкХранилищеАкцизныхМарок.НомерСтроки КАК НомерСтроки,
		|	алкХранилищеАкцизныхМарок.Активность КАК Активность,
		|	алкХранилищеАкцизныхМарок.Упаковка КАК Упаковка,
		|	алкХранилищеАкцизныхМарок.СправкаБ КАК СправкаБ,
		|	алкХранилищеАкцизныхМарок.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
		|	алкХранилищеАкцизныхМарок.Организация КАК Организация,
		|	алкХранилищеАкцизныхМарок.ОтметкаВыбытия КАК ОтметкаВыбытия,
		|	алкХранилищеАкцизныхМарок.ПунктРазгрузки КАК ПунктРазгрузки,
		|	алкХранилищеАкцизныхМарок.Марка.ЗначениеШтрихКода КАК Марка
		|ПОМЕСТИТЬ Вт1
		|ИЗ
		|	РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
		|ГДЕ
		|	алкХранилищеАкцизныхМарок.Регистратор = &Регистратор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Вт1.Период КАК Период,
		|	Вт1.Регистратор КАК Регистратор,
		|	Вт1.НомерСтроки КАК НомерСтроки,
		|	Вт1.Активность КАК Активность,
		|	Вт1.Упаковка КАК Упаковка,
		|	Вт1.СправкаБ КАК СправкаБ,
		|	Вт1.АлкогольнаяПродукция КАК АлкогольнаяПродукция,
		|	Вт1.Организация КАК Организация,
		|	Вт1.ОтметкаВыбытия КАК ОтметкаВыбытия,
		|	Вт1.ПунктРазгрузки КАК ПунктРазгрузки,
		|	Вт1.Марка КАК Марка,
		|	ЕСТЬNULL(Марки1.Ссылка, ЗНАЧЕНИЕ(Справочник.Марки1.ПустаяСсылка)) КАК МаркаСсылка
		|ИЗ
		|	Вт1 КАК Вт1
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Марки1 КАК Марки1
		|		ПО Вт1.Марка = Марки1.ЗначениеШтрихКода";
		
		Запрос.УстановитьПараметр("Регистратор", Документ);
		
		Результат = Запрос.Выполнить();
		
		//МаркиВыборка=МассивРезультатов[1].Выбрать();
		//МассивМарок=новый Массив;
		//Пока МаркиВыборка.Следующий() Цикл 
		//	МассивМарок.Добавить(МаркиВыборка.Марка);
		//КонецЦикла;
		//Если МассивМарок.Количество()>0 Тогда 
		//	итWMSСлужебныеПроцедурыИФункции.СервиснаяСозданиеМарокМассивом(МассивМарок);
		//КонецЕсли;
		НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
		ВыборкаДетальныеЗаписи = Результат.Выбрать();
		БлокировкаДанных=новый БлокировкаДанных;
		ЭлементБлокировки=БлокировкаДанных.Добавить("РегистрСведений.алкХранилищеАкцизныхМарок1.НаборЗаписей");
		ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("Регистратор",Документ);
		БлокировкаДанных.Заблокировать();
		
		НаборЗаписей=РегистрыСведений.алкХранилищеАкцизныхМарок1.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Установить(Документ);
		НаборЗаписей.Прочитать();
		НаборЗаписей.Очистить();
		НаборЗаписей.Записать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			НоваяЗапись=НаборЗаписей.Добавить();
			НоваяЗапись.Период=ВыборкаДетальныеЗаписи.Период;
			НоваяЗапись.Регистратор=ВыборкаДетальныеЗаписи.Регистратор;
			//НоваяЗапись.НомерСтроки=ВыборкаДетальныеЗаписи.НомерСтроки;
			НоваяЗапись.Активность=ВыборкаДетальныеЗаписи.Активность;
			Если ВыборкаДетальныеЗаписи.МаркаСсылка.Пустая() Тогда 
				НоваяЗапись.Марка=итWMSСлужебныеПроцедурыИФункции.СервиснаяНайтиСоздатьМаркуСБлокировкой(ВыборкаДетальныеЗаписи.Марка);
			иначе
				НоваяЗапись.Марка=ВыборкаДетальныеЗаписи.МаркаСсылка;
			КонецЕсли;
			НоваяЗапись.Упаковка=ВыборкаДетальныеЗаписи.Упаковка;
			НоваяЗапись.СправкаБ=ВыборкаДетальныеЗаписи.СправкаБ;
			НоваяЗапись.АлкогольнаяПродукция=ВыборкаДетальныеЗаписи.АлкогольнаяПродукция;
			НоваяЗапись.Организация=ВыборкаДетальныеЗаписи.Организация;
			НоваяЗапись.ОтметкаВыбытия=ВыборкаДетальныеЗаписи.ОтметкаВыбытия;
			НоваяЗапись.ПунктРазгрузки=ВыборкаДетальныеЗаписи.ПунктРазгрузки;
		КонецЦикла;
		НаборЗаписей.Записать();
	Исключение
		ОтменитьТранзакцию();
		ЗаписьЖурналаРегистрации("ПерезаписьМарокЕгаис",УровеньЖурналаРегистрации.Ошибка,Метаданные.Документы.ДокументДвиженияМарок,,Строка(НомерСообщения)+" "+Строка(Документ)+" "+ОписаниеОшибки());
		Возврат;
	КонецПопытки;
	ЗафиксироватьТранзакцию();


    итWMSПривилегированныйМодуль.УдалитьРегистрациюИзмененийДвжиенияМарок(Узел,НомерСообщения);

	КонецПроцедуры

Функция МинимальныйНомерСообщенияПерезаписи(Узел,МассивНомеров=Неопределено)
	Если МассивНомеров=Неопределено Тогда 
		МассивНомеров=новый Массив;
	КонецЕсли;	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ит_WMS_РегистрацияДвиженияМарок.УзелОбмена КАК УзелОбмена,
		|	МИНИМУМ(ит_WMS_РегистрацияДвиженияМарок.НомерСообщения) КАК НомерСообщения
		|ИЗ
		|	РегистрСведений.ит_WMS_РегистрацияДвиженияМарок КАК ит_WMS_РегистрацияДвиженияМарок
		|ГДЕ
		|	ит_WMS_РегистрацияДвиженияМарок.УзелОбмена = &УзелОбмена
		|	И ит_WMS_РегистрацияДвиженияМарок.НомерСообщения <> 0
		|	И НЕ ит_WMS_РегистрацияДвиженияМарок.НомерСообщения В (&МассивНомеров)
		|
		|СГРУППИРОВАТЬ ПО
		|	ит_WMS_РегистрацияДвиженияМарок.УзелОбмена";
	
	Запрос.УстановитьПараметр("УзелОбмена",Узел);
	Запрос.УстановитьПараметр("МассивНомеров",МассивНомеров);

	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Если ВыборкаДетальныеЗаписи.НомерСообщения=null или ВыборкаДетальныеЗаписи.НомерСообщения=Неопределено Тогда 
			Возврат 0;
		КонецЕсли;
		Возврат ВыборкаДетальныеЗаписи.НомерСообщения;
	КонецЦикла;
	    Возврат 0;
	КонецФункции
#КонецОбласти


#Область СветофорДляГенДира
Процедура СформироватьСветофорНаборкаИОтправить()  Экспорт 
	Обработка=Обработки.ФормированиеДанныхСветофора.Создать();
	ТабличныйДокумент=новый ТабличныйДокумент;
	Обработка.СформироватьТабличныйДокументСветофораНаборка(ТабличныйДокумент);
	ИмяфАЙЛА=ПолучитьИмяВременногоФайла("html");
	ТабличныйДокумент.Записать(ИмяфАЙЛА,ТипФайлаТабличногоДокумента.HTML5);
	МассивАдресов=новый Массив;
	МассивАдресов.Добавить("kiryanov@gift58.ru");
	//МассивАдресов.Добавить("zavskladom@gift58.ru");
	МассивФайлов=новый Массив;
	МассивФайлов.Добавить(ИмяфАЙЛА);
	итWMSПривилегированныйМодуль.РазослатьПисьмаСистемнойПочтой(МассивАдресов,,"Данные светофора Наборка",МассивФайлов);
	Для Каждого стр из МассивФайлов Цикл 
		УдалитьФайлы(стр);
	КонецЦикла;
	КонецПроцедуры

Процедура СформироватьСветофорОтгрузкаИОтправить() Экспорт 
	Обработка=Обработки.ФормированиеДанныхСветофора.Создать();
	ТабличныйДокумент=новый ТабличныйДокумент;
	КоличествоОтгрузок=0;
	Обработка.СформироватьТабличныйДокументСветофораОтгрузка(КоличествоОтгрузок,ТабличныйДокумент);
	Если КоличествоОтгрузок=0 Тогда 
		Возврат
	КонецЕсли;	
	ИмяфАЙЛА=ПолучитьИмяВременногоФайла("html");
	ТабличныйДокумент.Записать(ИмяфАЙЛА,ТипФайлаТабличногоДокумента.HTML5);
	МассивАдресов=новый Массив;
	МассивАдресов.Добавить("kiryanov@gift58.ru");
	МассивАдресов.Добавить("seniormanager@gift58.ru");
	МассивФайлов=новый Массив;
	МассивФайлов.Добавить(ИмяфАЙЛА);
	итWMSПривилегированныйМодуль.РазослатьПисьмаСистемнойПочтой(МассивАдресов,,"Данные светофора Отгрузка",МассивФайлов);
	Для Каждого стр из МассивФайлов Цикл 
		УдалитьФайлы(стр);
	КонецЦикла;

	КонецПроцедуры
	
#КонецОбласти

#Область ЗаменаМарокВДвижениях
Процедура НачатьУдалениеПомеченныйМарок()Экспорт 
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 10
		|	Марки.Ссылка КАК МаркаДляЗамены
		|ПОМЕСТИТЬ ЗаменяемаяМарка
		|ИЗ
		|	Справочник.Марки КАК Марки
		|ГДЕ
		|	Марки.ПометкаУдаления
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	Марки.Ссылка КАК Основная,
		|	ЗаменяемаяМарка.МаркаДляЗамены КАК МаркаДляЗамены
		|ИЗ
		|	ЗаменяемаяМарка КАК ЗаменяемаяМарка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Марки КАК Марки
		|		ПО (НЕ Марки.ПометкаУдаления)
		|			И ЗаменяемаяМарка.МаркаДляЗамены.ЗначениеШтрихКода = Марки.ЗначениеШтрихКода";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	МассивКлючейЗадания=новый Массив;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		//МассивПараметров=новый Массив;
		//Структура=новый Структура("МаркаДляЗамены,Основная",ВыборкаДетальныеЗаписи.МаркаДляЗамены,ВыборкаДетальныеЗаписи.Основная);
		//МассивПараметров.Добавить(Структура);
		//Ключ=новый УникальныйИдентификатор;
		//МассивКлючейЗадания.Добавить(Ключ);
		//ФоновыеЗадания.Выполнить("ЗапускРегЗаданияПривилегированный.НачатьЗаменуМаркиАсинхронно",МассивПараметров,Ключ,"НачатьЗаменуМаркиАсинхронно");
		Если ВыборкаДетальныеЗаписи.Основная=null Тогда 
			ОбъектМарки=ВыборкаДетальныеЗаписи.МаркаДляЗамены.ПолучитьОбъект();
			ОбъектМарки.ПометкаУдаления=Ложь;
			ОбъектМарки.Записать();
			Продолжить;
			КонецЕсли;
		НачатьЗаменуМарки(ВыборкаДетальныеЗаписи.МаркаДляЗамены,ВыборкаДетальныеЗаписи.Основная);
	КонецЦикла;
	//итWMSСлужебныеПроцедурыИФункции.ОжиданиеВыполненияЗаданий(МассивКлючейЗадания,60);
КонецПроцедуры

Процедура НачатьЗаменуМарки(ЗаменяемаяМарка,ОснованяМарка)Экспорт 
	НачатьТранзакцию(РежимУправленияБлокировкойДанных.Управляемый);
	БлокировкаДанных=новый БлокировкаДанных;
	ЭлементБлокировки=БлокировкаДанных.Добавить("РегистрСведений.ТаблицаДляБлокировкиСозданияМарки");
	ЭлементБлокировки.Режим=РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.УстановитьЗначение("ЗначениеШтрихКода",ЗаменяемаяМарка.ЗначениеШтрихКода);
	БлокировкаДанных.Заблокировать();
	ЗаменаМаркиВПереупаковки(ЗаменяемаяМарка,ОснованяМарка);
	ЗаменитьМаркуВДвиженияхХранилищаАкцизныхМарок(ЗаменяемаяМарка,ОснованяМарка);
	ЗаменитьМаркиВобработке(ЗаменяемаяМарка,ОснованяМарка);
	ЗаменаМаркиВАгрегации(ЗаменяемаяМарка,ОснованяМарка);
	ЗаменаМаркиВДанныхМаркиЕГАИС(ЗаменяемаяМарка,ОснованяМарка);
	ЗаменяемаяМаркаОбъект=ЗаменяемаяМарка.ПолучитьОбъект();
	ЗаменяемаяМаркаОбъект.Удалить();
	ЗафиксироватьТранзакцию();
КонецПроцедуры

Процедура ЗаменаМаркиВПереупаковки(ЗаменяемаяМарка,ОснованяМарка)Экспорт 

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	алкПереупаковкаАкцизныеМарки.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.алкПереупаковка.АкцизныеМарки КАК алкПереупаковкаАкцизныеМарки
		|ГДЕ
		|	алкПереупаковкаАкцизныеМарки.Марка = &Марка";
	
	Запрос.УстановитьПараметр("Марка", ЗаменяемаяМарка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	ОбъектПереупаковки=ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
	Для Каждого стр из ОбъектПереупаковки.АкцизныеМарки Цикл 
		Если стр.Марка=ЗаменяемаяМарка Тогда 
				стр.Марка= ОснованяМарка;
		КонецЕсли;	
	КонецЦикла;
	ОбъектПереупаковки.ОбменДанными.Загрузка=Истина;
	ОбъектПереупаковки.Записать();
	КонецЦикла;
	
	
	КонецПроцедуры

Процедура ЗаменитьМаркуВДвиженияхХранилищаАкцизныхМарок(ЗаменяемаяМарка,ОснованяМарка) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	алкХранилищеАкцизныхМарок.Регистратор КАК Регистратор
		|ИЗ
		|	РегистрСведений.алкХранилищеАкцизныхМарок КАК алкХранилищеАкцизныхМарок
		|ГДЕ
		|	алкХранилищеАкцизныхМарок.Марка = &Марка";
	
	Запрос.УстановитьПараметр("Марка", ЗаменяемаяМарка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НаборЗаписей=РегистрыСведений.алкХранилищеАкцизныхМарок.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Установить(ВыборкаДетальныеЗаписи.Регистратор);
		НаборЗаписей.Прочитать();
		Для Каждого стр из НаборЗаписей Цикл 
			Если стр.Марка=ЗаменяемаяМарка Тогда 
				стр.Марка= ОснованяМарка;
			КонецЕсли;	
		КонецЦикла;
		НаборЗаписей.Записать();
	КонецЦикла;
	

	
	КонецПроцедуры

Процедура ЗаменитьМаркиВобработке(ЗаменяемаяМарка,ОснованяМарка) Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMS_МаркиВОбработке.ДокументОснование КАК ДокументОснование
		|ИЗ
		|	РегистрСведений.итWMS_МаркиВОбработке КАК итWMS_МаркиВОбработке
		|ГДЕ
		|	итWMS_МаркиВОбработке.Марка = &Марка";
	
	Запрос.УстановитьПараметр("Марка", ЗаменяемаяМарка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НаборЗаписей=РегистрыСведений.итWMS_МаркиВОбработке.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ДокументОснование.Установить(ВыборкаДетальныеЗаписи.ДокументОснование);
		НаборЗаписей.Прочитать();
		Для Каждого стр из НаборЗаписей Цикл 
			Если стр.Марка=ЗаменяемаяМарка Тогда 
				стр.Марка=ОснованяМарка;
			КонецЕсли;	
		КонецЦикла;
		НаборЗаписей.Записать();
	КонецЦикла;
	

КонецПроцедуры

Процедура  ЗаменаМаркиВАгрегации(ЗаменяемаяМарка,ОснованяМарка)
		Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	итWMS_АгрегацияМарок.ДокументОснование КАК ДокументОснование
		|ИЗ
		|	РегистрСведений.итWMS_АгрегацияМарок КАК итWMS_АгрегацияМарок
		|ГДЕ
		|	итWMS_АгрегацияМарок.Марка = &Марка";
	
	Запрос.УстановитьПараметр("Марка", ЗаменяемаяМарка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НаборЗаписей=РегистрыСведений.итWMS_АгрегацияМарок.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ДокументОснование.Установить(ВыборкаДетальныеЗаписи.ДокументОснование);
		НаборЗаписей.Прочитать();
		Для Каждого стр из НаборЗаписей Цикл 
			Если стр.Марка=ЗаменяемаяМарка Тогда 
				стр.Марка=ОснованяМарка;
			КонецЕсли;	
		КонецЦикла;
		НаборЗаписей.Записать();
	КонецЦикла;
	

	КонецПроцедуры
	
Процедура ЗаменаМаркиВДанныхМаркиЕГАИС(ЗаменяемаяМарка,ОснованяМарка)

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДанныеМарокЕГАИСМарки.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ДанныеМарокЕГАИС.Марки КАК ДанныеМарокЕГАИСМарки
		|ГДЕ
		|	ДанныеМарокЕГАИСМарки.Марка = &Марка";
	
	Запрос.УстановитьПараметр("Марка", ЗаменяемаяМарка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	ОбъектИзменения=ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
	Для Каждого стр из ОбъектИзменения.Марки Цикл 
		Если стр.Марка=ЗаменяемаяМарка Тогда 
			стр.Марка=ОснованяМарка;
		КонецЕсли;
	КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры
#КонецОбласти