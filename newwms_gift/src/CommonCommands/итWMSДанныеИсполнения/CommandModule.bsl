
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Если ЗначениеЗаполнено(ПараметрКоманды) Тогда

		ОткрытьФорму("Обработка.итWMSДанныеТекущегоДокумента.Форма.Форма",Новый Структура("СсылкаНаДокумент", ПараметрКоманды),
				ПараметрыВыполненияКоманды.Источник,
				ПараметрыВыполненияКоманды.Источник.УникальныйИдентификатор,
				ПараметрыВыполненияКоманды.Окно);
				
	КонецЕсли;

КонецПроцедуры

