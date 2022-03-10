
&НаКлиенте
Процедура ПосмотретьДополнительнуюИнфомарцию(Команда)
	Если ТипЗнч(ТекущийЭлемент.ТекущиеДанные.Документ)=Тип("УникальныйИдентификатор") тогда
		ОткрытьФорму("РегистрСведений.итWMS_ДанныеДокументов.Форма.ФормаДополнительнойИнформации_бетаВерсия",новый Структура("Документ",ТекущийЭлемент.ТекущиеДанные.Документ),ЭтаФорма);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Филиал")тогда
		СписокВыбора.Параметры.УстановитьЗначениеПараметра("Филиал",Параметры.Филиал);
	иначе
		СписокВыбора.Параметры.УстановитьЗначениеПараметра("Филиал",Справочники.итФилиалыWMS.ПустаяСсылка());
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбораВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ОповеститьОВыборе(ТекущийЭлемент.ТекущиеДанные.Документ);
КонецПроцедуры
