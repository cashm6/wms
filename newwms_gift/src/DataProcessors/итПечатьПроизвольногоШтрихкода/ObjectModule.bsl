Функция Печать(ПараметрыПечати=Неопределено,МассивШтрихКода)Экспорт 
	
	Ответ=ПроверкаПечати(ПараметрыПечати,МассивШтрихКода);
	Если Ответ.Ошибка тогда
		Возврат Ответ;
	КонецЕсли;	
	ПараметрыПечатиПоУмолчанию(ПараметрыПечати);

	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	ТабличныйДокумент= новый ТабличныйДокумент;
	ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
	ТабличныйДокумент.ОриентацияСтраницы=ОриентацияСтраницы[ПараметрыПечати.Ориентация];
	Если МассивШтрихКода.Количество()=0 тогда
		Возврат ТабличныйДокумент;
	КонецЕсли;	
	
	Макет = ПолучитьМакет("Макет");
	//ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	КомпонентШК=Неопределено;
	ПодключитьКомпоненту(КомпонентШК);
	Если КомпонентШК=Неопределено тогда
		Сообщить("Нет компоненты штрихкода");
		Возврат ТабличныйДокумент;
	КонецЕсли;	
	СчетчикКоличествоВСтроке=0;
	для Каждого стр из  МассивШтрихКода Цикл
		ОбластьСтрокаКолонка=Макет.ПолучитьОбласть("Строка|Колонка");
		Если не РольДоступна("WMSПолныйДоступ") Тогда 
			Если не РольДоступна("итWMSПечатьШкQr")  и ПараметрыПечати.ТипКода=16 Тогда 
				ВызватьИсключение "Нет разрешения печатать QR код";
			КонецЕсли;
		КонецЕсли;
		КомпонентШК.ТипКода=ПараметрыПечати.ТипКода;
		КомпонентШК.ЗначениеКода=стр;
		КомпонентШК.ОтображатьТекст=Ложь;
		//КомпонентШК.Ширина=ПараметрыШтрихКода.Ширина;
		//КомпонентШК.Высота=ПараметрыШтрихКода.Высота;
		ПроверкаКартинкиПоМинимальнымПараметрам(КомпонентШК);
		ПроверкаПараметровШириныИВысоты(ПараметрыПечати,КомпонентШК);
		Картинка=КомпонентШК.ПолучитьШтрихкод();
		ОбластьСтрокаКолонка.Параметры.ШтрихкодПараметр=новый Картинка(Картинка);
		//Если ПараметрыПечати.ДублироватьШтрихКод тогда
		//ОбластьДублирующегоКода=Макет.ПолучитьОбласть("ОбластьДублированияШтрихКода");
		//ОбластьДублирующегоКода.Параметры.ДублированиеШтрихКода=новый Картинка(Картинка);
		//КонецЕсли;

		ОбластьСтрокаКолонка.Параметры.ТекстШтрихкода= стр;
		//ОбластьСтрокаКолонка.Параметры.КартинкаКуда=СтрелкаКуда;
		//ОбластьСтрокаКолонка.Области.ОбластьКартинкиКуда.ВысотаСтроки=ПараметрыШтрихКода.Высота/5;
		//ОбластьСтрокаКолонка.Области.ОбластьКартинкиКуда.ШиринаКолонки=ПараметрыПечати.Ширина;
		
		ОбластьСтрокаКолонка.Области.ОбластьКартинкиШтрихКода.ВысотаСтроки=ПараметрыПечати.Высота; 
		ОбластьСтрокаКолонка.Области.ОбластьКартинкиШтрихКода.ШиринаКолонки=ПараметрыПечати.Ширина;
		//Описание шрифта
		ШрифтНадписи=Новый Шрифт(ОбластьСтрокаКолонка.Области.ОбластьТекстаШтрихКода.Шрифт,,ПараметрыПечати.РазмерШрифта, , , , ,) ; 
		////////
		ОбластьСтрокаКолонка.Области.ОбластьТекстаШтрихКода.Шрифт=ШрифтНадписи;
		//ОбластьСтрокаКолонка.АвтоМасштаб=Истина;
		Если СчетчикКоличествоВСтроке=0 тогда
			ТабличныйДокумент.Вывести(ОбластьСтрокаКолонка);
			//Если ПараметрыПечати.ДублироватьШтрихКод тогда
			//	ТабличныйДокумент.Присоединить(ОбластьДублирующегоКода);
			//КонецЕсли;	
		ИначеЕсли СчетчикКоличествоВСтроке<ПараметрыПечати.КоличествоВСтроке тогда
			ТабличныйДокумент.Присоединить(ОбластьСтрокаКолонка);
			//Если ПараметрыПечати.ДублироватьШтрихКод тогда
			//	ТабличныйДокумент.Присоединить(ОбластьДублирующегоКода);
			//КонецЕсли;	
		иначе
			ПроверкаВывода(ТабличныйДокумент,ОбластьСтрокаКолонка);
			ТабличныйДокумент.Вывести(ОбластьСтрокаКолонка);
			//Если ПараметрыПечати.ДублироватьШтрихКод тогда
			//	ТабличныйДокумент.Присоединить(ОбластьДублирующегоКода);
			//КонецЕсли;	
			СчетчикКоличествоВСтроке=0;
		КонецЕсли;
		СчетчикКоличествоВСтроке=СчетчикКоличествоВСтроке+1;
		//ТабличныйДокумент.АвтоМасштаб=Истина;
	КонецЦикла;
	Возврат ТабличныйДокумент;
КонецФункции
Функция ПроверкаПечати(ПараметрыПечати,МассивШтрихКода)
Ошибка=ложь;
Сообщение="";
Если ТипЗнч(МассивШтрихКода)<>Тип("Массив") тогда
Ошибка=Истина;
Сообщение=Сообщение+"Исключительная ошика формата передачи данных <МассивШтрихКода>";
КонецЕсли;
Если ТипЗнч(ПараметрыПечати)<> Тип("Структура") тогда
	ПараметрыПечати = новый Структура;
КонецЕсли;

Возврат новый Структура("Ошибка,Сообщение",Ошибка,Сообщение);
		
	КонецФункции
	
Процедура ПроверкаПараметровШириныИВысоты(ПараметрыПечати,КомпонентШК)
	Если ПараметрыПечати.Ширина < КомпонентШК.МинимальнаяШиринаКода/10 Тогда
		ПараметрыПечати.Ширина = КомпонентШК.МинимальнаяШиринаКода/10;
	КонецЕсли;
	// Если установленная нами высота меньше минимально допустимой для этого штрихкода.
	Если ПараметрыПечати.Высота < КомпонентШК.МинимальнаяВысотаКода/10 Тогда
		ПараметрыПечати.Высота = КомпонентШК.МинимальнаяВысотаКода/10;
	КонецЕсли;

КонецПроцедуры
Процедура ПараметрыПечатиПоУмолчанию(ПараметрыПечати)
	Если не ПараметрыПечати.Свойство("Ориентация") тогда
		ПараметрыПечати.Вставить("Ориентация","Портрет");
	КонецЕсли;
	Если не ПараметрыПечати.Свойство("ТипКода") тогда
		ПараметрыПечати.Вставить("ТипКода",16);
	КонецЕсли;
	Если  не ПараметрыПечати.Свойство("Ширина") тогда
		ПараметрыПечати.Вставить("Ширина",0);
	КонецЕсли;	
	Если  не ПараметрыПечати.Свойство("Высота") тогда
		ПараметрыПечати.Вставить("Высота",0);
	КонецЕсли;	
	Если  не ПараметрыПечати.Свойство("РазмерШрифта") тогда
		ПараметрыПечати.Вставить("РазмерШрифта",8);
	КонецЕсли;	
   Если  не ПараметрыПечати.Свойство("КоличествоВСтроке") тогда
		ПараметрыПечати.Вставить("КоличествоВСтроке",1);
	КонецЕсли;

КонецПроцедуры
Процедура ПроверкаВывода(ТабличныйДокумент,МассивОбластей)
	Если не ТабличныйДокумент.ПроверитьВывод(МассивОбластей) тогда
		ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
	КонецЕсли;
КонецПроцедуры

Процедура ПроверкаКартинкиПоМинимальнымПараметрам(КомпонентШК)Экспорт 
	Если КомпонентШК.Ширина < КомпонентШК.МинимальнаяШиринаКода Тогда
		КомпонентШК.Ширина = КомпонентШК.МинимальнаяШиринаКода;
	КонецЕсли;
	// Если установленная нами высота меньше минимально допустимой для этого штрихкода.
	Если КомпонентШК.Высота < КомпонентШК.МинимальнаяВысотаКода Тогда
		КомпонентШК.Высота = КомпонентШК.МинимальнаяВысотаКода;
	КонецЕсли;
	
КонецПроцедуры
Процедура ПодключитьКомпоненту(КомпонентШК) Экспорт 
	МакетКомпаненты=ПолучитьМакет("КомпонентаПечатиШтрихкодов");
	Адрес=ПоместитьВоВременноеХранилище(МакетКомпаненты);
	ИмяКомпоненты=ПолучитьИмяКомпоненты();
	
	ПодключениеВыполнено = ПодключитьВнешнююКомпоненту(Адрес, ИмяКомпоненты, ТипВнешнейКомпоненты.Native);

	Если ПодключениеВыполнено Тогда
		Попытка
			КомпонентШК = Новый("AddIn."+ИмяКомпоненты+".Barcode");
		Исключение
			КомпонентШК= Неопределено;
			Возврат;
		КонецПопытки;	
	Иначе
		Возврат;
	КонецЕсли;
	Если НЕ КомпонентШК.ГрафикаУстановлена Тогда
		// То картинку сформировать не сможем.
		Возврат 
	Иначе
		// Установим основные параметры компоненты.
		// Если в системе установлен шрифт Tahoma.
		Если КомпонентШК.НайтиШрифт("Tahoma") Тогда
			// Выбираем его как шрифт для формирования картинки.
			КомпонентШК.Шрифт = "Tahoma";
		Иначе
			// Шрифт Tahoma в системе отсутствует.
			// Обойдем все доступные компоненте шрифты.
			Для Сч = 0 По КомпонентШК.КоличествоШрифтов -1 Цикл
				// Получим очередной шрифт, доступный компоненте.
				ТекущийШрифт = КомпонентШК.ШрифтПоИндексу(Сч);
				// Если шрифт доступен
				Если ТекущийШрифт <> Неопределено Тогда
					// Они и будет шрифтом для формирования штрихкода.
					КомпонентШК.Шрифт = ТекущийШрифт;
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		// Установим размер шрифта
		КомпонентШК.РазмерШрифта = 12;
	КонецЕсли;
	
	
КонецПроцедуры


Функция ПолучитьИмяКомпоненты()
	ИмяКомпоненты=Строка(новый УникальныйИдентификатор);
	ИмяКомпоненты=СтрЗаменить(ИмяКомпоненты,"-","");
	ПервыйСимвол= Лев(ИмяКомпоненты,1);
	Если ПервыйСимвол="1" или
		ПервыйСимвол="2"  или
		ПервыйСимвол ="3" или
		ПервыйСимвол="4" или
		ПервыйСимвол="5"  или
		ПервыйСимвол ="6" или
		ПервыйСимвол="7" или
		ПервыйСимвол="8"  или
		ПервыйСимвол ="9" или
		ПервыйСимвол ="0" тогда
		ИмяКомпоненты=ПолучитьИмяКомпоненты();
	КонецЕсли;	
	Возврат ИмяКомпоненты;
	КонецФункции