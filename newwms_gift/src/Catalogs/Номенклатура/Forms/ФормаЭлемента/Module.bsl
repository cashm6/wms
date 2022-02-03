

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
ЗаполнитьТаблицуШк();
КонецПроцедуры

&НаКлиенте
Процедура ШтрихКодыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, ЭтоГруппа, Параметр)
	Если Объект.Ссылка.Пустая() Тогда
		Сообщить("Для добавление шк, необходимо записать объект");
		Отказ=Истина;
		Возврат;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуШк()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	Штрихкоды.Штрихкод,
		|	Штрихкоды.Владелец,
		|	Штрихкоды.ТипШтрихкода,
		|	Штрихкоды.ЕдиницаИзмерения,
		|	Штрихкоды.ХарактеристикаНоменклатуры,
		|	Штрихкоды.СерияНоменклатуры,
		|	Штрихкоды.Качество
		|ИЗ
		|	РегистрСведений.Штрихкоды КАК Штрихкоды
		|ГДЕ
		|	Штрихкоды.Владелец = &Владелец";
	
	Запрос.УстановитьПараметр("Владелец", Объект.Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ШтрихКоды.Очистить();
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	НоваяСтрока=ШтрихКоды.Добавить();
	НоваяСтрока.ШтрихКод=ВыборкаДетальныеЗаписи.Штрихкод;
	НоваяСтрока.ТипШтрихКода=ВыборкаДетальныеЗаписи.ТипШтрихкода;
	НоваяСтрока.ЕдИзм=ВыборкаДетальныеЗаписи.ЕдиницаИзмерения;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ШтрихКодыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	Оповещение=новый ОписаниеОповещения("ЗаписатьШкВРегистр",ЭтаФорма);
	ПоказатьВопрос(Оповещение,"Записать изменения?",РежимДиалогаВопрос.ДаНет );
КонецПроцедуры

&НаКлиенте
Процедура ШтрихКодыПослеУдаления(Элемент)
	Оповещение=новый ОписаниеОповещения("ЗаписатьШкВРегистр",ЭтаФорма);
	ПоказатьВопрос(Оповещение,"Записать изменения?",РежимДиалогаВопрос.ДаНет );
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьШкВРегистр(Результат,Параметры) Экспорт
	Если Результат=КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	ЗаписатьВРегистрСведенийШк();
	ЗаполнитьТаблицуШк();
КонецПроцедуры
&НаСервере
Процедура ЗаписатьВРегистрСведенийШк()
НаборЗаписей=РегистрыСведений.Штрихкоды.СоздатьНаборЗаписей();
НаборЗаписей.Отбор.Владелец.Установить(объект.Ссылка);
НаборЗаписей.Прочитать();
НаборЗаписей.Очистить();
НаборЗаписей.Записать();
Для Каждого стр Из ШтрихКоды Цикл
НоваяСтрока=НаборЗаписей.Добавить();	
НоваяСтрока.Владелец=объект.Ссылка;
НоваяСтрока.ЕдиницаИзмерения=стр.ЕдИзм;
НоваяСтрока.Штрихкод=стр.ШтрихКод;
НоваяСтрока.ТипШтрихкода=стр.ТипШтрихКода;
КонецЦикла;
НаборЗаписей.Записать();	
КонецПроцедуры






