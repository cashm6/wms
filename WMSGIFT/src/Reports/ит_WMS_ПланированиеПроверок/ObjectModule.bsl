
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
		СтандартнаяОбработка    = Ложь;
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ДатаНачала");
	ЗначениеПараметра.Значение = ДатаНачала;
	ЗначениеПараметра.Использование = Истина;
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ДатаОкончания");
	ЗначениеПараметра.Значение = ДатаОкончания;
	ЗначениеПараметра.Использование = Истина;
	
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("АгрегацияПаллеты");
	ЗначениеПараметра.Значение = АгрегацияПаллеты;
	ЗначениеПараметра.Использование = Истина;
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("ФизическаяПроверка");
	ЗначениеПараметра.Значение = ФизическаяПроверка;
	ЗначениеПараметра.Использование = Истина;
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("АгрегацияКоробов");
	ЗначениеПараметра.Значение = АгрегацияКоробов;
	ЗначениеПараметра.Использование = Истина;
	
	ЗначениеПараметра = КомпоновщикНастроек.Настройки.ПараметрыДанных.Элементы.Найти("Опалечивание");
	ЗначениеПараметра.Значение = Опалечивание;
	ЗначениеПараметра.Использование = Истина;
 
	 
    НаборыДанных    = Новый Структура("ТаблицаНаценокПоКА", ТаблицаНаценокПоКА.Выгрузить());
     
    Схема   = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
     
    КМ      = Новый КомпоновщикМакетаКомпоновкиДанных;
     
    Макет   = КМ.Выполнить(Схема, КомпоновщикНастроек.Настройки,ДанныеРасшифровки);
     
   	
    ПК  = Новый ПроцессорКомпоновкиДанных;
    ПК.Инициализировать(Макет, НаборыДанных,ДанныеРасшифровки);
     
    ПВ  = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
    ПВ.УстановитьДокумент(ДокументРезультат);
    ПВ.Вывести(ПК,Истина);

КонецПроцедуры
