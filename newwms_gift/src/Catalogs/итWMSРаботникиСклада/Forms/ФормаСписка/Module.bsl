
&НаКлиенте
Процедура Печать(Команда)
	МассивРаботников=новый Массив;
	для Каждого Строка из Элементы.Список.ВыделенныеСтроки цикл
		МассивРаботников.Добавить(Строка);
	КонецЦикла;
	ТабличныйДокумент=новый ТабличныйДокумент;
	ПечатьНаСервере(МассивРаботников, ТабличныйДокумент);
	ТабличныйДокумент.Показать();
КонецПроцедуры


&НаСервере
Процедура ПечатьНаСервере(МассивРаботников, ТабличныйДокумент)
	Справочники.итWMSРаботникиСклада.ПечатьШкРаботниковСклада(МассивРаботников,ТабличныйДокумент);
КонецПроцедуры

