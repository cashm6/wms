
&НаКлиенте
Процедура ВвестиПароль(Команда)
	ОткрытьФорму("Отчет.ит_WMS_МотивационныйОтчет.Форма.ФормаВводаПароляУПР",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	Пароль=ВыбранноеЗначение;
	ВидимостьДоступностьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ВидимостьДоступностьЭлементов();
КонецПроцедуры

&НаКлиенте
Процедура ВидимостьДоступностьЭлементов()
	Если Пароль="4317" Тогда 
		Элементы.ГруппировкаНастроек1.ТолькоПросмотр=Ложь;
		Элементы.ГруппаНастроек2.ТолькоПросмотр=Ложь;
		Элементы.ТаблицаНаценокКА.ТолькоПросмотр=Ложь;
	иначе
		Элементы.ГруппировкаНастроек1.ТолькоПросмотр=Истина;
		Элементы.ГруппаНастроек2.ТолькоПросмотр=Истина;
		Элементы.ТаблицаНаценокКА.ТолькоПросмотр=Истина;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СохранитьНаСервере()
	СтруктураДанных=новый Структура;
	СтруктураДанных.Вставить("ДатаНачала",Отчет.ДатаНачала);
	СтруктураДанных.Вставить("ДатаОкончания",Отчет.ДатаОкончания);
	СтруктураДанных.Вставить("СтоимостьПеремещенияПМУ",Отчет.СтоимостьПеремещенияПМУ);
	СтруктураДанных.Вставить("СтоимостьПеремещения",Отчет.СтоимостьПеремещения);
	//СтруктураДанных.Вставить("СтоимостьЯчейки",Отчет.СтоимостьЯчейки);
	СтруктураДанных.Вставить("СтоимостьПодъема",Отчет.СтоимостьПодъема);
	СтруктураДанных.Вставить("СтоимостьСпуска",Отчет.СтоимостьСпуска);
	СтруктураДанных.Вставить("СтоимостьКоробаПМУ",Отчет.СтоимостьКоробаПМУ);
	СтруктураДанных.Вставить("СтоимостьКороба",Отчет.СтоимостьКороба);
	СтруктураДанных.Вставить("АгрегацияПаллеты",Отчет.АгрегацияПаллеты);
	СтруктураДанных.Вставить("ФизическаяПроверка",Отчет.ФизическаяПроверка);
	СтруктураДанных.Вставить("АгрегацияКоробов",Отчет.АгрегацияКоробов);
	СтруктураДанных.Вставить("Опалечивание",Отчет.Опалечивание);
	СтруктураДанных.Вставить("ТаблицаНаценокПоКАВыгрузка",Отчет.ТаблицаНаценокПоКА.Выгрузить());
	СтруктураДанных.Вставить("СтоимостьЗаНаборку",Отчет.СтоимостьЗаНаборку);
	СтруктураДанных.Вставить("СтоимостьПаллетыНаборки",Отчет.СтоимостьПаллетыНаборки);
	СтруктураДанных.Вставить("СтоимостьОтгрузки",Отчет.СтоимостьОтгрузки);
	СтруктураДанных.Вставить("СтоимостьПаллетыОтгрузки",Отчет.СтоимостьПаллетыОтгрузки);
	СтруктураДанных.Вставить("СтоимостьБутылкиНаборка",Отчет.СтоимостьБутылкиНаборка);
    СтруктураДанных.Вставить("СтоимостьБутылкиПМУНаборка",Отчет.СтоимостьБутылкиПМУНаборка);
    СтруктураДанных.Вставить("СтоимостьБутылкиПроверка",Отчет.СтоимостьБутылкиПроверка);
	СтруктураДанных.Вставить("СтоимостьНаборки",Отчет.СтоимостьНаборки);
	СтруктураДанных.Вставить("СтоимостьНаборкиРозница",Отчет.СтоимостьНаборкиРозница);
	СтруктураДанных.Вставить("СуммаПаллетыПриемки",Отчет.СуммаПаллетыПриемки);
	СтруктураДанных.Вставить("СуммаАкта",Отчет.СуммаАкта);
	СтруктураДанных.Вставить("СтоимостьЗаПосещениеЯчейкиНаборка",Отчет.СтоимостьЗаПосещениеЯчейкиНаборка);
    СтруктураДанных.Вставить("СтоимостьПроверки",Отчет.СтоимостьПроверки);
	СтруктураДанных.Вставить("СтоимостьПроверкиРозница",Отчет.СтоимостьПроверкиРозница);
	СтруктураДанных.Вставить("СтоимостьЗаНаборкуРозница",Отчет.СтоимостьЗаНаборкуРозница);
	СтруктураДанных.Вставить("СуммаПаллетыПриемкиПМУ",Отчет.СуммаПаллетыПриемкиПМУ);
	СтруктураДанных.Вставить("СтоимостьПриемки",Отчет.СтоимостьПриемки);

	//СохранитьЗначение("итWMSМотивационныйОтчет",СтруктураДанных);
	итWMSПривилегированныйМодуль.СохрнаитьНастройкиВХранилищеОбщихНастроек("итWMSМотивационныйОтчет","итWMSМотивационныйОтчет",СтруктураДанных,"итWMSМотивационныйОтчет");

КонецПроцедуры

&НаКлиенте
Процедура Сохранить(Команда)
	СохранитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
Значение=итWMSПривилегированныйМодуль.ЗагрузитьНастройкиИзХранилищаОбщихНастроек("итWMSМотивационныйОтчет","итWMSМотивационныйОтчет","итWMSМотивационныйОтчет");
Если ТипЗнч(Значение)=Тип("Структура") Тогда 
	ЗаполнитьЗначенияСвойств(Отчет,Значение);
	Если Значение.Свойство("ТаблицаНаценокПоКАВыгрузка") Тогда 
		Отчет.ТаблицаНаценокПоКА.Загрузить(Значение.ТаблицаНаценокПоКАВыгрузка);
	КонецЕсли;	
КонецЕсли;	

КонецПроцедуры
