
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	СостоянияРаботниковСклада=Движения.СостоянияРаботниковСклада;
	СостоянияРаботниковСклада.Очистить();
	СостоянияРаботниковСклада.Записать();
	Для Каждого  стр из РаботникиСклада Цикл 
		НоваяСтрока=СостоянияРаботниковСклада.Добавить();
		НоваяСтрока.Период=Дата;
		НоваяСтрока.ВидВремени=ВидВремени;
		НоваяСтрока.Состояние=СостояниеРаботниковСклада;
		НоваяСтрока.Организация=Организация;
		НоваяСтрока.РаботникСклада=стр.РаботникСклада;
		НоваяСтрока.Год=НачалоГода(Дата);
	КонецЦикла;
	СостоянияРаботниковСклада.Записать();
КонецПроцедуры
