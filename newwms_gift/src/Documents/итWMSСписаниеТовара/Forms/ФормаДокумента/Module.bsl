

#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() тогда
		Если не Объект.СозданНаОснованиСерверногоВызова Тогда 
			Объект.итОснование=Неопределено;
		КонецЕсли;
		Если Объект.Товары.Количество()>0 тогда
			для Каждого стр из Объект.Товары цикл
				стр.ИдентификаторСтроки=новый УникальныйИдентификатор;	
			КонецЦикла;
		КонецЕсли;
		Объект.Ответственный=ПараметрыСеанса.ТекущийПользователь;
		Объект.СтатусДокумента=Перечисления.итWMSСтатусыСкладскихДокументов.Создан;
		Объект.Дата=ТекущаяДата();
		Если Параметры.Свойство("ИтОснование") тогда
			Объект.итОснование=Параметры.ИтОснование;
		КонецЕсли;
	    ПроверитьОснованиеНаНесколькоПодчиненныхДокументов(Отказ);
		КонецЕсли;
	Если Объект.СозданНаОснованиСерверногоВызова тогда
	Объект.СозданНаОснованиСерверногоВызова=Ложь;
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	РассчитатьНадписиКоличестваТовара();
	ВидимостьДоступностьЭлементов();
КонецПроцедуры
&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
ВидимостьДоступностьЭлементов();
КонецПроцедуры

#Область СобытияВыборкаЭлементовТчТовары
&НаКлиенте
Процедура ТоварыИдентификаторУпаковкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
КонецПроцедуры
&НаКлиенте
Процедура ТоварыИдентификаторУпаковкиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
КонецПроцедуры



&НаКлиенте
Процедура ТоварыНоменклатураНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
	
КонецПроцедуры
&НаКлиенте
Процедура ТоварыНоменклатураОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ТоварыХарактеристикаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
	
КонецПроцедуры
&НаКлиенте
Процедура ТоварыХарактеристикаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ТоварыСерияНоменклатурыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
	
КонецПроцедуры
&НаКлиенте
Процедура ТоварыСерияНоменклатурыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ТоварыКачествоНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
	
КонецПроцедуры
&НаКлиенте
Процедура ТоварыКачествоОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ТоварыДатаРозливаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
	
КонецПроцедуры
&НаКлиенте
Процедура ТоварыДатаРозливаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыКоличествоНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
КонецПроцедуры
&НаКлиенте
Процедура ТоварыКоличествоОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЯчейкаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	//ОткрытьФорму("Документ.итWMSПеремещение.Форма.ФормаПодбораНоменклатуры",,Элемент);
	ПараметрыФормы=ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент);
	ОткрытьФормуПодбора(Элемент,ПараметрыФормы);
КонецПроцедуры
&НаКлиенте
Процедура ТоварыЯчейкаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	Если ТипЗнч(ВыбранноеЗначение) = тип("Структура") тогда
		СтандартнаяОбработка=Ложь;
		ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,ВыбранноеЗначение);
	КонецЕсли;
КонецПроцедуры






&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
		Если ИсточникВыбора.ИмяФормы="ОбщаяФорма.ФормаПодбораНоменклатуры" Тогда 
			Если ТипЗнч(ВыбранноеЗначение)=Тип("Массив") Тогда
				ЗаполнениеВыбораПодбора(ВыбранноеЗначение)
			КонецЕсли;
		КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнениеВыбораПодбора(ВыбранноеЗначение)
	Для Каждого стр из ВыбранноеЗначение цикл
		НоваяСтрока=Объект.Товары.Добавить();
		НоваяСтрока.ИдентификаторСтроки=новый УникальныйИдентификатор;
		ЗаполнитьЗначенияСвойств(НоваяСтрока,стр);
		НоваяСтрока.Ячейка=стр.Ячейка;
		НоваяСтрока.ДатаРозлива = итWMSСлужебныеПроцедурыИФункции.ПолучитьЭлементДанныхНаСервере(стр.СерияНоменклатуры,"ДатаПроизводства");
	КонецЦикла;
	РассчитатьНадписиКоличестваТовара();
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ТоварыПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	РассчитатьНадписиКоличестваТовара();
КонецПроцедуры
&НаКлиенте
Процедура ТоварыПриАктивизацииСтроки(Элемент)
РассчитатьНадписиКоличестваТовара();
КонецПроцедуры



#КонецОбласти

#Область ОбработчикиКоманд
&НаКлиенте
Процедура ДобавитьТовары(Команда)
	Если  Элементы.ТоварыГруппа.ТолькоПросмотр тогда
		Возврат
	КонецЕсли;	
	НоваяСтрока=Объект.Товары.Добавить();
	НоваяСтрока.ИдентификаторСтроки=новый УникальныйИдентификатор;
	НоваяСтрока.ИдентификаторСтрокиПредставление= Строка(НоваяСтрока.ИдентификаторСтроки);
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьТовары(Команда)
	Если  Элементы.ТоварыГруппа.ТолькоПросмотр тогда
		Возврат
	КонецЕсли;		
	Если ТекущийЭлемент.Имя="Товары" тогда
		НоваяСтрока=Объект.Товары.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока,ТекущийЭлемент.ТекущиеДанные);
		НоваяСтрока.ИдентификаторСтроки=новый УникальныйИдентификатор;
		НоваяСтрока.ИдентификаторСтрокиПредставление=Строка(НоваяСтрока.ИдентификаторСтроки);
		НоваяСтрока.Количество=0;
		НоваяСтрока.КоличествоИзменения=0;
     	НоваяСтрока.Ячейка=ЯчейкаПустаяССылка();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	ПараметрыФормы=ПараметрыФормыМножественногоПодбораНоменклатуры();
	ОткрытьФормуПодбора(ЭтаФорма,ПараметрыФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьСписаниеТоваров(Команда)
	Если ПроверкаНаСозданиеСписания() Тогда 
		ОткрытьФорму("Документ.СписаниеТоваров.Форма.ФормаДокумента",новый Структура("Основание",Объект.Ссылка));
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура СоздатьПеремещение(Команда)
	Если ПроверкаНаСозданиеСписания() Тогда 
		ОткрытьФорму("Документ.ПеремещениеТоваров.Форма.ФормаДокумента",новый Структура("Основание",Объект.Ссылка));
	КонецЕсли;
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаКлиенте
Процедура ВидимостьДоступностьЭлементов()
Элементы.ФормаСоздатьСписаниеТоваров.Видимость=Объект.Проведен;	
Элементы.ФормаСоздатьПеремещение.Видимость=Объект.Проведен;	
КонецПроцедуры
&НаКлиенте
Функция ПараметрыФормыОдиночногоОтбораНоменклатуры(Элемент)
	Если ТипЗнч(Элемент.Родитель)=Тип("ГруппаФормы") тогда
		ИсточникДанных=Элемент.Родитель.Родитель;
	иначе
		ИсточникДанных=Элемент.Родитель;
	КонецЕсли;
	
	ПараметрыФормы=новый Структура;
	ПараметрыФормы.Вставить("Склад",Объект.Склад);
	ПараметрыФормы.Вставить("ОдиночныйВыбор",Истина);
	ПараметрыФормы.Вставить("ОтборПоНоменклатуре",Истина);
	ПараметрыФормы.Вставить("ПараметрПоискаНоменклатура",ИсточникДанных.ТекущиеДанные.Номенклатура);
	ПараметрыФормы.Вставить("ИдентификаторСтроки",ИсточникДанных.ТекущиеДанные.ИдентификаторСтроки);
	ПараметрыФормы.Вставить("ИдентификаторФормы",ЭтаФорма.УникальныйИдентификатор);
	ПараметрыФормы.Вставить("Документ",Объект.Ссылка);
	ПараметрыФормы.Вставить("Организация",Объект.Организация);

	Возврат  ПараметрыФормы;
КонецФункции
&НаКлиенте
Процедура ОткрытьФормуПодбора(ЭлементОповещенияВыбора,ПараметрыФормы=Неопределено)
	Если ПараметрыФормы = Неопределено тогда
		ПараметрыФормы=новый Структура;
	КонецЕсли;
	СделатьСнимокТабличнойЧастиДляДинамическогоПодбора();	
	ОткрытьФорму("ОбщаяФорма.ФормаПодбораНоменклатуры",ПараметрыФормы,ЭлементОповещенияВыбора);
	
КонецПроцедуры
&НаСервере
Процедура СделатьСнимокТабличнойЧастиДляДинамическогоПодбора()
	НовыйНабораЗаписей= РегистрыСведений.итWMSКорзинаНоменклатуры.СоздатьНаборЗаписей();
	НовыйНабораЗаписей.Отбор.КлючДанных.Установить(ЭтаФорма.УникальныйИдентификатор);
	НовыйНабораЗаписей.Прочитать();
	НовыйНабораЗаписей.Очистить();
	для Каждого стр из Объект.Товары цикл
		НоваяЗапись=НовыйНабораЗаписей.Добавить();
		НоваяЗапись.ДатаЗаписи=ТекущаяДата();
		НоваяЗапись.Номенклатура=стр.Номенклатура;
		НоваяЗапись.СерияНоменклатуры=стр.СерияНоменклатуры;
		НоваяЗапись.КлючДанных=ЭтаФорма.УникальныйИдентификатор;
		НоваяЗапись.Ячейка = стр.Ячейка;
		НоваяЗапись.Качество=стр.Качество;
		НоваяЗапись.ИдентификаторСтроки=стр.ИдентификаторСтроки;
		НоваяЗапись.Количество=стр.Количество;
		НоваяЗапись.ИдентификаторУпаковки=стр.ИдентификаторУпаковки;
	КонецЦикла;
	НовыйНабораЗаписей.Записать();
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнениеПриОдиночномПодбореПоНоменклатуре(Элемент,Структура)
	ЗаполнитьЗначенияСвойств(Элемент.Родитель.ТекущиеДанные,Структура);
	Элемент.Родитель.ТекущиеДанные.Ячейка=Структура.Ячейка;
	Элемент.Родитель.ТекущиеДанные.ДатаРозлива = итWMSСлужебныеПроцедурыИФункции.ПолучитьЭлементДанныхНаСервере(Структура.СерияНоменклатуры,"ДатаПроизводства");
	РассчитатьНадписиКоличестваТовара();
КонецПроцедуры

&НаКлиенте
Функция ПараметрыФормыМножественногоПодбораНоменклатуры()
	ПараметрыФормы=новый Структура;
	ПараметрыФормы.Вставить("Склад",Объект.Склад);
	ПараметрыФормы.Вставить("ОдиночныйВыбор",Ложь);
	ПараметрыФормы.Вставить("Организация",Объект.Организация);
	ПараметрыФормы.Вставить("ОтборПоНоменклатуре",Истина);
	ПараметрыФормы.Вставить("ИдентификаторФормы",ЭтаФорма.УникальныйИдентификатор);
	ПараметрыФормы.Вставить("Документ",Объект.Ссылка);
	Возврат  ПараметрыФормы;
КонецФункции

&НаКлиенте
Процедура РассчитатьНадписиКоличестваТовара()
	Если Элементы.Товары.ТекущиеДанные<>Неопределено  Тогда 
		НМ=Элементы.Товары.ТекущиеДанные.Номенклатура;
		МассивСтрок=Объект.Товары.НайтиСтроки(новый Структура("Номенклатура",НМ));
		КоличествоНм=0;
		для Каждого Строка из МассивСтрок цикл
			КоличествоНМ=КоличествоНМ+Строка.Количество;	
		КонецЦикла;
		Элементы.ДекорацияВыбраннойНМДанные.Заголовок= Строка(КоличествоНМ);	
	КонецЕсли;
	
	КоличествоВсего=0;
	для Каждого стр из Объект.Товары Цикл 
		КоличествоВсего=КоличествоВсего+стр.Количество;	
	КонецЦикла;
	Элементы.ДекорацияКоличествоВсегоДанные.Заголовок=Строка(КоличествоВсего);
КонецПроцедуры


&НаСервере	
Процедура ПроверитьОснованиеНаНесколькоПодчиненныхДокументов(Отказ)
	Если Объект.итОснование=Неопределено Тогда 
		Возврат
	КонецЕсли;	
	Данные=РеквизитФормыВЗначение("Объект");
	Данные.ПроверитьОснованиеНаНесколькоПодчиненныхДокументов(Отказ);	
КонецПроцедуры
&НаСервере
Функция ПроверкаНаСозданиеСписания()
	Если ТипЗнч(Объект.итОснование)=Тип("ДокументСсылка.СписаниеТоваров") Тогда 
		Сообщить("Документ создан на основании списания, создать списание не возможно");
	Возврат Ложь;
КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СписаниеТоваров.Ссылка
		|ИЗ
		|	Документ.СписаниеТоваров КАК СписаниеТоваров
		|ГДЕ
		|	СписаниеТоваров.Основание = &Основание
		|	И СписаниеТоваров.Проведен";
	
	Запрос.УстановитьПараметр("Основание", Объект.Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если  ВыборкаДетальныеЗаписи.Следующий() Тогда 
	Сообщить("у документа уже есть <<Списание товаров>> "+ ВыборкаДетальныеЗаписи.Ссылка);
	Возврат Ложь;
	КонецЕсли;
	
    Возврат Истина;
	КонецФункции
&НаСервереБезКонтекста
Функция ЯчейкаПустаяССылка()
	Возврат Справочники.итСкладскиеЯчейки.ПустаяСсылка();	
КонецФункции
#КонецОбласти
