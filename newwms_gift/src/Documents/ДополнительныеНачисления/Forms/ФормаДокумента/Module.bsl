
#Область ОбработчикиСобытий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() Тогда 
		Объект.Ответственный=ПараметрыСеанса.ТекущийПользователь;
		ОбщегоНазначения.УстановитьОрганизациюВДокументе(Объект);
	КонецЕсли;	
	РассчетВсегоПоДокументу();
	ВидимостьДоступностьСервер();
КонецПроцедуры

&НаКлиенте
Процедура НачисленияПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
		НачисленияПриОкончанииРедактированияНаСервере();
КонецПроцедуры

&НаСервере
Процедура НачисленияПриОкончанииРедактированияНаСервере()
Начисления=Объект.Начисления.Выгрузить();	
Начисления.Свернуть("РаботникСклада","НачисленоФакт");
Объект.РаботникиСклада.Очистить();
Всего=0;
Для Каждого стр из Начисления Цикл 
	НоваяСтрока=Объект.РаботникиСклада.Добавить();
	НоваяСтрока.РаботникСклада=стр.РаботникСклада;
	НоваяСтрока.Начислено=стр.НачисленоФакт;
	Всего=Всего+НоваяСтрока.Начислено;
КонецЦикла;
Элементы.ВсегоПоДокументу.Заголовок="Всего по документу "+Строка(Всего);
КонецПроцедуры



&НаКлиенте
Процедура НачисленияВидДополнительныхРаботПриИзменении(Элемент)
ВидДополнительныхРабот=ТекущийЭлемент.ТекущиеДанные.ВидДополнительныхРабот;
ШаблонКомментария=ВернутьШаблонКомментария(ВидДополнительныхРабот);
Если ШаблонКомментария="" Тогда 
	Возврат
КонецЕсли;
ТекущийЭлемент.ТекущиеДанные.ОписаниеРаботы= ШаблонКомментария;
ОткрытьФорму("Справочник.ВидыДополнительныхРабот.Форма.ФормаУстановкиПараметров",новый Структура("Ссылка",ВидДополнительныхРабот),ЭтаФорма);

КонецПроцедуры


&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	Если ИсточникВыбора.ИмяФормы="Справочник.ВидыДополнительныхРабот.Форма.ФормаУстановкиПараметров" Тогда
		ТекДанные=ТекущийЭлемент.ТекущиеДанные;
		Для Каждого стр из 	ВыбранноеЗначение.МассивСтруктурированныхДанных Цикл 
			Поле="["+стр.имя+"]";
			ТекДанные.ОписаниеРаботы=СтрЗаменить(ТекДанные.ОписаниеРаботы,Поле,Строка(стр.Значение));
		КонецЦикла;	
		ТекДанные.НачисленоФакт=ВыбранноеЗначение.НачисленоФакт;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКоманд
&НаСервере
Процедура ЗаполнитьНаСервере()

	
	//Запрос = Новый Запрос;
	//Запрос.Текст = 
	//	"ВЫБРАТЬ
	//	|	ИсполненныеДополнительныеРаботы.ТСД КАК ТСД,
	//	|	ИсполненныеДополнительныеРаботы.ВидДополнительныхРабот КАК ВидДополнительныхРабот,
	//	|	ИсполненныеДополнительныеРаботы.ДатаНачалаРабот КАК ДатаНачалаРабот,
	//	|	ИсполненныеДополнительныеРаботы.ДатаОкончанияРабот КАК ДатаОкончанияРабот,
	//	|	ИсполненныеДополнительныеРаботы.ДокументОбработки КАК ДокументОбработки
	//	|ИЗ
	//	|	РегистрСведений.ИсполненныеДополнительныеРаботы КАК ИсполненныеДополнительныеРаботы
	//	|ГДЕ
	//	|	ИсполненныеДополнительныеРаботы.ДокументОбработки = ЗНАЧЕНИЕ(Документ.ДополнительныеНачисления.ПустаяСсылка)";
	//
	//РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	//
	//БлокировкаДанных=новый БлокировкаДанных;
	//Элемент=БлокировкаДанных.Добавить("ИсполненныеДополнительныеРаботы");
	//Элемент.ИсточникДанных=РезультатЗапроса;
	//Элемент.ИспользоватьИзИсточникаДанных("ТСД","ТСД");
	//Элемент.ИспользоватьИзИсточникаДанных("ВидДополнительныхРабот","ВидДополнительныхРабот");
	//Элемент.ИспользоватьИзИсточникаДанных("ДатаНачалаРабот","ДатаНачалаРабот");
	//Элемент.ИспользоватьИзИсточникаДанных("ДатаОкончанияРабот","ДатаОкончанияРабот");
	//Элемент.ИспользоватьИзИсточникаДанных("ДокументОбработки","ДокументОбработки");
	//Элемент.Режим=РежимБлокировкиДанных.Исключительный;
	//БлокировкаДанных.Заблокировать();

КонецПроцедуры

&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры
&НаКлиенте
Процедура Согласовать(Команда)
СогласоватьНаСервере();	
КонецПроцедуры
&НаСервере
Процедура СогласоватьНаСервере()
Если Объект.Согласованно Тогда 
		Объект.Согласованно=Ложь;
		Объект.ДатаСогласования='00010101';
		Объект.Согласовал=Справочники.Пользователи.ПустаяСсылка();
		Элементы.ФормаСогласовать.Заголовок="Согласованно";
		Элементы.Начисления.ТолькоПросмотр=Ложь;
		Элементы.Смена.ТолькоПросмотр=Ложь;
		Элементы.ДатаНачисления.ТолькоПросмотр=Ложь;
		Элементы.Организация.ТолькоПросмотр=Ложь;
	иначе
		Объект.Согласованно=Истина;
		Объект.ДатаСогласования=ТекущаяДата();
		Объект.Согласовал=ПараметрыСеанса.ТекущийПользователь;
		Элементы.ФормаСогласовать.Заголовок="Отменить согласование";
		Элементы.Начисления.ТолькоПросмотр=Истина;
		Элементы.Смена.ТолькоПросмотр=Истина;
		Элементы.ДатаНачисления.ТолькоПросмотр=Истина;
		Элементы.Организация.ТолькоПросмотр=Истина;
	КонецЕсли;

	КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВидимостьДоступностьКлиент()
	 ВидимостьДоступностьСервер();
КонецПроцедуры


&НаСервере
Процедура ВидимостьДоступностьСервер()
	Если ВидимостьСогласованияДляПользователя() Тогда 
		Элементы.ФормаСогласовать.Видимость=Истина;
	иначе
		Элементы.ФормаСогласовать.Видимость=Ложь;
    КонецЕсли;
	Если Объект.Согласованно Тогда
		Элементы.Смена.ТолькоПросмотр=Истина;
		Элементы.ДатаНачисления.ТолькоПросмотр=Истина;
		Элементы.Организация.ТолькоПросмотр=Истина;
		Элементы.Начисления.ТолькоПросмотр=Истина;
		Элементы.ФормаСогласовать.Заголовок="Отменить согласование";
	иначе
		Элементы.Смена.ТолькоПросмотр=Ложь;
		Элементы.ДатаНачисления.ТолькоПросмотр=Ложь;
		Элементы.Организация.ТолькоПросмотр=Ложь;
		Элементы.ФормаСогласовать.Заголовок="Согласованно";	
		Элементы.Начисления.ТолькоПросмотр=Ложь;
	КонецЕсли;
КонецПроцедуры


&НаСервере
Функция ВидимостьСогласованияДляПользователя()
	ТипДокумента=Строка(ТипЗнч(Объект.Ссылка));
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПраваНаСогласованияПоДокументамСрезПоследних.СогласованиеРазрешено КАК СогласованиеРазрешено
		|ИЗ
		|	РегистрСведений.ПраваНаСогласованияПоДокументам.СрезПоследних КАК ПраваНаСогласованияПоДокументамСрезПоследних
		|ГДЕ
		|	ПраваНаСогласованияПоДокументамСрезПоследних.Пользователь = &Пользователь
		|	И ПраваНаСогласованияПоДокументамСрезПоследних.ТипДокумента = &ТипДокумента";
	
	Запрос.УстановитьПараметр("Пользователь", ПараметрыСеанса.ТекущийПользователь);
	Запрос.УстановитьПараметр("ТипДокумента", ТипДокумента);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		 Возврат  ВыборкаДетальныеЗаписи.СогласованиеРазрешено;
	КонецЦикла;
	     Возврат Ложь;
	КонецФункции

&НаСервере
Процедура РассчетВсегоПоДокументу()
	Всего=0;
	Для Каждого стр из Объект.РаботникиСклада Цикл 
		Всего=Всего+стр.Начислено;
	КонецЦикла;
	Элементы.ВсегоПоДокументу.Заголовок="Всего по документу: "+Строка(Всего);
	КонецПроцедуры


&НаСервереБезКонтекста
Функция ВернутьШаблонКомментария(ВидДополнительныхРабот)
	Возврат ВидДополнительныхРабот.ШаблонКомментария;
КонецФункции

#КонецОбласти


	
	
	





