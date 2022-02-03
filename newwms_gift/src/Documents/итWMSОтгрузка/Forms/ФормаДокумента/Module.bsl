

#Область ОбработчикиСобытий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределен Тогда
		ОбновитьДанныеСТСД();
	КонецЕсли;
	Если Параметры.Ключ.Пустая() тогда
		ТребуетсяОповещениеОткрытыхФормНаборок=Истина;
		ОбщегоНазначения.УстановитьОрганизациюВДокументе(Объект);
		Если не Объект.СозданНаОснованиСерверногоВызова тогда
			Объект.итОснование=Неопределено;
		иначе
			Объект.СозданНаОснованиСерверногоВызова=Ложь;
		КонецЕсли;
		Если Объект.Товары.Количество()>0 тогда
			для Каждого стр из Объект.Товары цикл
				стр.ИдентификаторСтроки=новый УникальныйИдентификатор;
			КонецЦикла;
		КонецЕсли;	
		Если Параметры.Свойство("ПараметрыЗаполненияДанных") тогда
			Если ПроверкаНаИмещийсяДокументРазмещенияПоОснованию(Параметры.ПараметрыЗаполненияДанных) тогда
				Сообщить("У документа уже имеется проведенный документ размещения");
				Отказ=Истина;
				Возврат
			КонецЕсли;
			Данные=РеквизитФормыВЗначение("Объект");
			//@skip-warning
			Данные.ОбработкаЗаполнения(Параметры.ПараметрыЗаполненияДанных,Ложь);
			ЗначениеВРеквизитФормы(Данные,"Объект");
		КонецЕсли;	
		Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан;
		Объект.Ответственный=ПараметрыСеанса.ТекущийПользователь;
		Объект.Дата=ТекущаяДата();
	КонецЕсли;	
	ПроставитьПредставлениеИдентификатора();
КонецПроцедуры
&НаКлиенте
Процедура ТоварыСостояниеЗадачиПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("СостояниеЗадачи",Элемент.Родитель.ТекущиеДанные.СостояниеЗадачи,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки);
КонецПроцедуры
&НаКлиенте
Процедура ТоварыЯчейкаПолучательПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("ЯчейкаПолучатель",Элемент.Родитель.ТекущиеДанные.ЯчейкаПолучатель,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки);
КонецПроцедуры
&НаКлиенте
Процедура ТоварыКомментарийПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("Комментарий",Элемент.Родитель.ТекущиеДанные.Комментарий,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки);
КонецПроцедуры
&НаСервереБезКонтекста
Процедура ТоварыИдентификаторУпаковкиНачалоВыбораНаСервере(Основание,СтруктураДанных,Отказ)
	Если ТипЗнч(Основание)<>Тип("ДокументСсылка.итWMSПриемка") тогда
		Сообщить("не верный формат основания");
		Отказ=Истина;
		Возврат
	КонецЕсли;	
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSПриемкаТовары.ИдентификаторУпаковки
	|ИЗ
	|	Документ.итWMSПриемка.Товары КАК итWMSПриемкаТовары
	|ГДЕ
	|	итWMSПриемкаТовары.Ссылка = &Основание
	|
	|СГРУППИРОВАТЬ ПО
	|	итWMSПриемкаТовары.ИдентификаторУпаковки";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	
	СтруктураДанных.Вставить("СписокИдентификаторУпаковки",РезультатЗапроса.ВыгрузитьКолонку("ИдентификаторУпаковки"));
КонецПроцедуры

&НаКлиенте
Процедура ТоварыИдентификаторУпаковкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	Отказ=ложь;
	СтруктураДанных=новый Структура("СписокИдентификаторУпаковки,Организация,Ответственный",Неопределено,Объект.Организация,ПолучитьТекущегоПользователя());
	ТоварыИдентификаторУпаковкиНачалоВыбораНаСервере(Объект.итОснование,СтруктураДанных,Отказ);
	Если Отказ Тогда 
		Возврат
	КонецЕсли;
	ОткрытьФорму("Документ.итWMSРазмещение.Форма.ФормаЗапросаИдентификатораУпаковки",СтруктураДанных,Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыИдентификаторУпаковкиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки= ВыбранноеЗначение;
	
КонецПроцедуры




&НаКлиенте
Процедура ТоварыСкладПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("Склад",Элемент.Родитель.ТекущиеДанные.Склад,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЯчейкаОтправительПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("ЯчейкаОтправитель",Элемент.Родитель.ТекущиеДанные.ЯчейкаОтправитель,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки)
КонецПроцедуры
&НаКлиенте
Процедура ТоварыКарантинПаллетыПриИзменении(Элемент)
	ГрупповоеИзменениеСпискаПоИдУпаковки("КарантинПаллеты",Элемент.Родитель.ТекущиеДанные.КарантинПаллеты,Элемент.Родитель.ТекущиеДанные.ИдентификаторУпаковки);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Картинка = новый Картинка(ПолучитьКартинкуИзБиблиотеки());
	АдресКартинкиКуба=ПоместитьВоВременноеХранилище(Картинка,ЭтаФорма.УникальныйИдентификатор);
	ВидимостьДоступностьЭлементов();
	ВариантОтображенияПользователя();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоНоменклатураПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоХарактеристикаПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоКачествоПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоДатаРозливаПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);
КонецПроцедуры


&НаКлиенте
Процедура ТоварыДеревоКоличествоПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);
	РассчетКоличестваВУпаковкеПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоСостояниеЗадачиПриИзменении(Элемент)
	СписокЭлементовДерева=Элемент.Родитель.ТекущиеДанные.ПолучитьЭлементы();
	для Каждого  стр из СписокЭлементовДерева цикл
		Строка=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторСтрокиПредставление",стр.ИдентификаторСтрокиПредставление));
		Строка[0].СостояниеЗадачи=Элемент.Родитель.ТекущиеДанные.СостояниеЗадачи;
	КонецЦикла;
	ЭтаФорма.Модифицированность=Истина;
	
КонецПроцедуры




&НаКлиенте
Процедура ТоварыДеревоЯчейкаОтправительПриИзменении(Элемент)
	СписокЭлементовДерева=Элемент.Родитель.ТекущиеДанные.ПолучитьЭлементы();
	для Каждого  стр из СписокЭлементовДерева цикл
		Строка=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторСтрокиПредставление",стр.ИдентификаторСтрокиПредставление));
		Строка[0].ЯчейкаОтправитель=Элемент.Родитель.ТекущиеДанные.ЯчейкаОтправитель;
	КонецЦикла;
	ЭтаФорма.Модифицированность=Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоКомментарийПриИзменении(Элемент)
	СписокЭлементовДерева=Элемент.Родитель.ТекущиеДанные.ПолучитьЭлементы();
	для Каждого  стр из СписокЭлементовДерева цикл
		Строка=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторСтрокиПредставление",стр.ИдентификаторСтрокиПредставление));
		Строка[0].Комментарий=Элемент.Родитель.ТекущиеДанные.Комментарий;
	КонецЦикла;
	ЭтаФорма.Модифицированность=Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоСерияНоменклатурыПриИзменении(Элемент)
	ОбработчикТрансляцииПриИзменении(Элемент);
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоПередУдалением(Элемент, Отказ)
	Если Элемент.ВыделенныеСтроки.Количество()>1 тогда
		Сообщить("В режиме дерева можно удалять 1 любую строку за раз");
		Отказ=Истина;
		Возврат
	КонецЕсли;	
	Если Элемент.ТекущиеДанные.СтрокаУпаковки тогда
		Оповещение = новый ОписаниеОповещения("ОбработчикДиалогов",ЭтаФорма," ОбработчикУдалениеУпаковки();");
		ПоказатьВопрос(Оповещение,"Если удалить паллету, то все строки в ней так же будут удалены",РежимДиалогаВопрос.ДаНет);
		Отказ=Истина;
		Возврат
	иначе
		МассивСтроки=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторСтрокиПредставление",Элемент.ТекущиеДанные.ИдентификаторСтрокиПредставление));
		Строка=МассивСтроки[0];
		Объект.Товары.Удалить(Строка);
	КонецЕсли;
	ЭтаФорма.Модифицированность=Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыДеревоПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка, Строка, Поле)
	СтрокаПеретаскиванияКуда=Элементы.ТоварыДерево.ДанныеСтроки(Строка);
	Если не СтрокаПеретаскиванияКуда.СтрокаУпаковки тогда
		пока не СтрокаПеретаскиванияКуда.СтрокаУпаковки цикл
			СтрокаПеретаскиванияКуда=СтрокаПеретаскиванияКуда.ПолучитьРодителя();
		КонецЦикла;
	КонецЕсли;
	СтандартнаяОбработка=Ложь;
	для Каждого стр из ПараметрыПеретаскивания.Значение цикл
		ТекущаяСтрокаОбработки=Элементы.ТоварыДерево.ДанныеСтроки(стр);
		Если ТекущаяСтрокаОбработки.СтрокаУпаковки тогда
			Продолжить;
		КонецЕсли;	
		ТекущаяСтрокаОбработки.ИдентификаторУпаковки=СтрокаПеретаскиванияКуда.ИдентификаторУпаковки;
		НоваяСтрока=СтрокаПеретаскиванияКуда.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ТекущаяСтрокаОбработки);
		НоваяСтрока.ЯчейкаПолучатель=СтрокаПеретаскиванияКуда.ЯчейкаПолучатель;
		НоваяСтрока.ЯчейкаОтправитель=СтрокаПеретаскиванияКуда.ЯчейкаОтправитель;
		СтарыйРодитель=ТекущаяСтрокаОбработки.ПолучитьРодителя();
		СтарыйРодитель.ПолучитьЭлементы().Удалить(ТекущаяСтрокаОбработки);
		
		/////Обработчики Изменения
		СтрукрутраДляИзменения=новый Структура;
		СтрукрутраДляИзменения.Вставить("Имя","ИдентификаторУпаковки");
		СтрукрутраДляИзменения.Вставить("Родитель",новый Структура("ТекущиеДанные",НоваяСтрока));
		ОбработчикТрансляцииПриИзменении(СтрукрутраДляИзменения);
		СтрукрутраДляИзменения.Вставить("Имя","ЯчейкаПолучатель");
		СтрукрутраДляИзменения.Вставить("Родитель",новый Структура("ТекущиеДанные",НоваяСтрока));
		ОбработчикТрансляцииПриИзменении(СтрукрутраДляИзменения);
		
		СтрукрутраДляИзменения.Вставить("Имя","ЯчейкаОтправитель");
		СтрукрутраДляИзменения.Вставить("Родитель",новый Структура("ТекущиеДанные",НоваяСтрока));
		ОбработчикТрансляцииПриИзменении(СтрукрутраДляИзменения);
		
		
		СтрукрутраДляИзменения.Имя="Количество";
		СтрукрутраДляИзменения.Вставить("Родитель",новый Структура("ТекущиеДанные",НоваяСтрока));
		РассчетКоличестваВУпаковкеПриИзменении(СтрукрутраДляИзменения) ;
		
		СтрукрутраДляИзменения.Имя="Количество";
		СтрукрутраДляИзменения.Вставить("Родитель",новый Структура("ТекущиеДанные",СтарыйРодитель));
		РассчетКоличестваВУпаковкеПриИзменении(СтрукрутраДляИзменения) ;
		
	КонецЦикла;
КонецПроцедуры
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ПоследнийРежимЗаписиДокумента=ПараметрыЗаписи.РежимЗаписи;
	ПодключитьОбработчикОжидания("ОбработчикОжиданийПослеЗаписи",0.1,Истина);
	КонецПроцедуры
&НаКлиенте
Процедура ОбработчикОжиданийПослеЗаписи() Экспорт 
	ВидимостьДоступностьЭлементов();
	ПроставитьПредставлениеИдентификатора();
	Если Объект.Проведен тогда
		Если  ТипЗнч(Объект.итОснование)<>тип("ДокументСсылка.итWMSНаборка")  Тогда
			Возврат
		КонецЕсли;	
		Если ТребуетсяОповещениеОткрытыхФормНаборок тогда
			//ЗавершитьНаборкуНаСервере(Объект.итОснование);
			Для Каждого стр из Объект.итОснования цикл
			Оповестить("WMSПроведениеОтменаПроведенияСвязанныхДокументовНаборки",стр.Документ,Объект.Ссылка);
			КонецЦикла;	
		КонецЕсли;
		Если ПоследнийРежимЗаписиДокумента=РежимЗаписиДокумента.ОтменаПроведения Тогда
			Для Каждого стр из Объект.итОснования цикл
			Оповестить("WMSПроведениеОтменаПроведенияСвязанныхДокументовНаборки",стр.Документ,Объект.Ссылка);
			КонецЦикла;
        КонецЕсли;
	КонецЕсли;
	КонецПроцедуры





#КонецОбласти

#Область ОбработчикиКоманд
&НаКлиенте
Процедура ВВидеДерева(Команда)
	ВВидеДереваНаСервере();
	Элементы.ТоварыДерево.Видимость=Истина;
	Элементы.Товары.Видимость=Ложь;
	ТригерОтображения=Истина;
КонецПроцедуры
&НаСервере
Процедура ВВидеДереваНаСервере()
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	ТоварыДерево.ПолучитьЭлементы().Очистить();
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Товары.ИдентификаторСтрокиПредставление,
	|	Товары.ИдентификаторУпаковки,
	|	Товары.Номенклатура,
	|	Товары.Характеристика,
	|	Товары.Качество,
	|	Товары.ДатаРозлива,
	|	Товары.СостояниеЗадачи,
	|	Товары.ЯчейкаОтправитель,
	|	Товары.Количество,
	|	Товары.СерияНоменклатуры,
	|	Товары.Комментарий
	|ПОМЕСТИТЬ ТчТовары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТчТовары.ИдентификаторСтрокиПредставление,
	|	ТчТовары.ИдентификаторУпаковки КАК ИдентификаторУпаковки,
	|	ТчТовары.Номенклатура,
	|	ТчТовары.Характеристика,
	|	ТчТовары.Качество,
	|	ТчТовары.ДатаРозлива,
	|	ТчТовары.СостояниеЗадачи КАК СостояниеЗадачи,
	|	ТчТовары.ЯчейкаОтправитель КАК ЯчейкаОтправитель,
	|	ТчТовары.Количество КАК Количество,
	|	ТчТовары.СерияНоменклатуры,
	|	ТчТовары.Комментарий КАК Комментарий
	|ИЗ
	|	ТчТовары КАК ТчТовары
	|ИТОГИ
	|	МАКСИМУМ(СостояниеЗадачи),
	|	МАКСИМУМ(ЯчейкаОтправитель),
	|	СУММА(Количество),
	|	МАКСИМУМ(Комментарий)
	|ПО
	|	ИдентификаторУпаковки";
	
	Запрос.УстановитьПараметр("Товары",Объект.Товары.Выгрузить());	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаУпаковка = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	пока ВыборкаУпаковка.Следующий() цикл
		НоваяСтрокаУпаковкаДерево = ТоварыДерево.ПолучитьЭлементы().Добавить();
		НоваяСтрокаУпаковкаДерево.ИдентификаторУпаковки= ВыборкаУпаковка.ИдентификаторУпаковки;
		//НоваяСтрокаУпаковкаДерево.ЯчейкаПолучатель = ВыборкаУпаковка.ЯчейкаПолучатель;
		НоваяСтрокаУпаковкаДерево.ЯчейкаОтправитель = ВыборкаУпаковка.ЯчейкаОтправитель;
		НоваяСтрокаУпаковкаДерево.Количество=ВыборкаУпаковка.Количество;
		НоваяСтрокаУпаковкаДерево.СостояниеЗадачи=ВыборкаУпаковка.СостояниеЗадачи;
		НоваяСтрокаУпаковкаДерево.Картинка=АдресКартинкиКуба;
		НоваяСтрокаУпаковкаДерево.СтрокаУпаковки=Истина;
		//НоваяСтрокаУпаковкаДерево.Склад=ВыборкаУпаковка.Склад;
		НоваяСтрокаУпаковкаДерево.Комментарий=ВыборкаУпаковка.Комментарий;
		//Если ВыборкаУпаковка.КарантинПаллеты>0 тогда
		//	НоваяСтрокаУпаковкаДерево.КарантинПаллеты=Истина;
		//КонецЕсли;	 
		
		ВыборкаДетальныеЗаписи=ВыборкаУпаковка.Выбрать();
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			НоваяСтрокаНоменклатуры = НоваяСтрокаУпаковкаДерево.ПолучитьЭлементы().Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаНоменклатуры,ВыборкаДетальныеЗаписи);
			//НоваяСтрокаНоменклатуры.ЯчейкаПолучатель=Справочники.итСкладскиеЯчейки.ПустаяСсылка();
			НоваяСтрокаНоменклатуры.ЯчейкаОтправитель=Справочники.итСкладскиеЯчейки.ПустаяСсылка();
			//НоваяСтрокаНоменклатуры.Склад=Справочники.Склады.ПустаяСсылка();
			НоваяСтрокаНоменклатуры.Комментарий="";
		КонецЦикла;
	КонецЦикла;
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецПроцедуры
&НаКлиенте
Процедура ВВидеСписка(Команда)
	Элементы.ТоварыДерево.Видимость=Ложь;
	Элементы.Товары.Видимость=Истина;
	ТригерОтображения=Ложь;
КонецПроцедуры
&НаКлиенте
Процедура СкопироватьТовары(Команда)
	Если  Элементы.ГруппаТовары.ТолькоПросмотр тогда
		Возврат
	КонецЕсли;	
	Если ТекущийЭлемент.Имя="Товары" тогда
		НоваяСтрока=Объект.Товары.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ТекущийЭлемент.ТекущиеДанные);
		НоваяСтрока.ИдентификаторСтроки=новый УникальныйИдентификатор;
		НоваяСтрока.ИдентификаторСтрокиПредставление=Строка(НоваяСтрока.ИдентификаторСтроки);
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ДобавитьТовары(Команда)
	Если  Элементы.ГруппаТовары.ТолькоПросмотр тогда
		Возврат
	КонецЕсли;	
	НоваяСтрока=Объект.Товары.Добавить();
	НоваяСтрока.ИдентификаторСтроки=новый УникальныйИдентификатор;
	НоваяСтрока.ИдентификаторСтрокиПредставление= Строка(НоваяСтрока.ИдентификаторСтроки);
КонецПроцедуры
&НаКлиенте
Процедура Развернуть(Команда)
	//СтрокиПаллет=ПаллетМеста.ПолучитьЭлементы();
	//для Каждого Паллета из СтрокиПаллет цикл
	//	Элементы.ПаллетМеста.Развернуть(Паллета.ПолучитьИдентификатор());
	//КонецЦикла;
	Строки=ТоварыДерево.ПолучитьЭлементы();
	Если Строки.Количество()>0 тогда
		РазвернутьДанные(Строки);
	КонецЕсли;	
КонецПроцедуры
&НаКлиенте
Процедура РазвернутьДанные(Строки)
	для Каждого Строка из Строки цикл
		Элементы.ТоварыДерево.Развернуть(Строка.ПолучитьИдентификатор());
		ПодчиненныеСтроки= Строка.ПолучитьЭлементы();
		Если ПодчиненныеСтроки.Количество()>0 тогда
			РазвернутьДанные(ПодчиненныеСтроки);
		КонецЕсли;	
	КонецЦикла;
КонецПроцедуры
&НаКлиенте
Процедура Свернуть(Команда)
	Строки=ТоварыДерево.ПолучитьЭлементы();
	Если Строки.Количество()>0 тогда
		СвернутьДанные(Строки);
	КонецЕсли;	
КонецПроцедуры
&НаКлиенте	
Процедура СвернутьДанные(Строки)
	для Каждого Строка из Строки цикл
		ПодчиненныеСтроки= Строка.ПолучитьЭлементы();
		Если ПодчиненныеСтроки.Количество()>0 тогда
			СвернутьДанные(ПодчиненныеСтроки);
		КонецЕсли;	
		Элементы.ТоварыДерево.Свернуть(Строка.ПолучитьИдентификатор());
	КонецЦикла;	
КонецПроцедуры


&НаСервере
Процедура ПечатьШкДокументаНаСервере(ТаблиныйДокумент)
	ОбъектОбработки=Обработки.итПечатьПроизвольногоШтрихкода.Создать();
	ПараметрыПечати = новый Структура;
	ПараметрыПечати.Вставить("Ширина",20);
	ПараметрыПечати.Вставить("Высота",30);
	ПараметрыПечати.Вставить("ТипКода",16);
	Массив = новый Массив;
	Массив.Добавить(Строка(Объект.Ссылка.УникальныйИдентификатор()));
	ТаблиныйДокумент=ОбъектОбработки.Печать(ПараметрыПечати,Массив);
КонецПроцедуры

&НаКлиенте
Процедура ПечатьШкДокумента(Команда)
	ТаблиныйДокумент=новый ТабличныйДокумент;
	ПечатьШкДокументаНаСервере(ТаблиныйДокумент);
	ТаблиныйДокумент.Показать();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Функция ПолучитьКартинкуИзБиблиотеки()
Возврат	БиблиотекаКартинок.ВнешнийИсточникДанныхКуб.ПолучитьДвоичныеДанные();
	КонецФункции

&НаСервере
Процедура ПроставитьПредставлениеИдентификатора()
	для Каждого  стр из Объект.Товары цикл
		стр.ИдентификаторСтрокиПредставление=Строка(стр.ИдентификаторСтроки);
	КонецЦикла;
КонецПроцедуры
&НаКлиенте
Процедура ВариантОтображенияПользователя()
	Если ТригерОтображения тогда
		ВВидеДерева("");
	иначе
		ВВидеСписка("");
	КонецЕсли;
КонецПроцедуры
&НаСервере
Функция ПолучитьТекущегоПользователя()
	Возврат	ПараметрыСеанса.ТекущийПользователь;
КонецФункции
&НаКлиенте
Процедура ОбработчикДиалогов(Результат,Параметры)Экспорт 
	Если Результат=КодВозвратаДиалога.Да тогда
		Выполнить(Параметры);
	иначе
		Возврат
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВидимостьДоступностьЭлементов()
	//Элементы.Филиал.Видимость=Объект.ПриемкаИзТранзита;
	//Элементы.НомерВходящегоДокумента.Видимость=Объект.ПриемкаИзТранзита;
	//Элементы.ДатаВходящегоДокумента.Видимость=Объект.ПриемкаИзТранзита;
	//Элементы.ГруппаДанныеФизическогоНосителя.Видимость=не Объект.ПриемкаИзТранзита;
	ВидимостьДоступностьЭлементовНаСервере();
КонецПроцедуры
&НаСервере
Процедура ВидимостьДоступностьЭлементовНаСервере()
	Если  Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределен или Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Распределяется тогда
		Элементы.ГруппаТовары.ТолькоПросмотр=Истина;
		//Элементы.ГруппаДанныеФизическогоНосителя.ТолькоПросмотр=Истина;
	иначе
		Элементы.ГруппаТовары.ТолькоПросмотр=Ложь;
		//Элементы.ГруппаДанныеФизическогоНосителя.ТолькоПросмотр=Ложь;
	КонецЕсли;
	//Элементы.ТоварыРазместитьПаллеты.Видимость=(Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан);
	//Элементы.ТоварыДеревоРазместитьПаллеты.Видимость=(Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан);
	Если Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан или Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Зарезервирован тогда
		Элементы.НеРаспределятьНаТСД.Видимость=Истина;
	иначе
		Элементы.НеРаспределятьНаТСД.Видимость=Ложь;
	КонецЕсли;
	
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикТрансляцииПриИзменении(Элемент)
	СтрокаДерева=Элемент.Родитель.ТекущиеДанные;
	ПолеИзменения=СтрЗаменить(Элемент.Имя,"ТоварыДерево","");
	Если ЗначениеЗаполнено(СтрокаДерева.ИдентификаторСтрокиПредставление) тогда
		Строка=Объект.Товары.НайтиСтроки(новый Структура("ИдентификаторСтрокиПредставление",СтрокаДерева.ИдентификаторСтрокиПредставление));
		Строка[0][ПолеИзменения]=Элемент.Родитель.ТекущиеДанные[ПолеИзменения];
		ЭтаФорма.Модифицированность=Истина;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура РассчетКоличестваВУпаковкеПриИзменении(Элемент)
	СтрокаИзменения=Элемент.Родитель.ТекущиеДанные;
	ПолеИзменения=СтрЗаменить(Элемент.Имя,"ТоварыДерево","");
	Если не СтрокаИзменения.СтрокаУпаковки тогда
		РодительСтрокиИзменения=СтрокаИзменения.ПолучитьРодителя();
	иначе
		РодительСтрокиИзменения=СтрокаИзменения;
	КонецЕсли;
	РодительСтрокиИзменения[ПолеИзменения]=0;
	СтрокиДляПересчета=РодительСтрокиИзменения.ПолучитьЭлементы();
	для Каждого стр из СтрокиДляПересчета цикл
		РодительСтрокиИзменения[ПолеИзменения]=РодительСтрокиИзменения[ПолеИзменения]+ стр[ПолеИзменения];
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ГрупповоеИзменениеСпискаПоИдУпаковки(ПолеИзменения,Значение,ИдентификаторУпаковки)
	МассивСтрок=Объект.Товары.НайтиСтроки(Новый Структура("ИдентификаторУпаковки",ИдентификаторУпаковки));
	для Каждого стр из МассивСтрок цикл
		стр[ПолеИзменения]=Значение;
	КонецЦикла;	
КонецПроцедуры
&НаСервере
Функция ПроверкаНаИмещийсяДокументРазмещенияПоОснованию(Ссылка)
	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	итWMSРазмещение.Ссылка
	|ИЗ
	|	Документ.итWMSРазмещение КАК итWMSРазмещение
	|ГДЕ
	|	итWMSРазмещение.итОснование = &Ссылка
	|	И итWMSРазмещение.Проведен = ИСТИНА";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() тогда
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	
КонецФункции

&НаСервере
Процедура ОбновитьДанныеСТСД()
Документы.итWMSОтгрузка.ВнестиИзменениеДанныхТСДВДокумент(Объект.Ссылка);
Данные=Объект.Ссылка.ПолучитьОбъект();
Если итWMSСлужебныеПроцедурыИФункции.ВсеЗадачиДокументаЗафиксированны(Объект.Ссылка) Тогда
	Данные.ДействияПриФиксацииЗадачДокумента();
	Данные.ОбменДанными.Загрузка=Истина;
	//Данные.ОтложенноеПроведение=Истина;
	Данные.Записать();
	итWMSСлужебныеПроцедурыИФункции.СделатьЗаписьДопОбработкиОтложенногоПроведения(Данные.Ссылка);
КонецЕсли;
ЗначениеВРеквизитФормы(Данные,"Объект");
КонецПроцедуры

#КонецОбласти

#Область ГИФТ
#КонецОбласти


