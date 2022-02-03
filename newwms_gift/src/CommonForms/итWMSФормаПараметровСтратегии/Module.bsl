
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Стратегия.Пустая() Тогда 
		Отказ=Истина;
	Возврат;
КонецЕсли;
ЗадатьПараметрыНаФорме();
ЗаполнитьПараметрыВходящимиДанными();
КонецПроцедуры
&НаСервере
Процедура ЗадатьПараметрыНаФорме()
	ДобавляемыеРеквизиты=новый Массив;
	Для Каждого стр из Параметры.Стратегия.ОпределениеПараметровСтрагеии цикл
		Реквизит = Новый РеквизитФормы(СтрЗаменить(стр.Параметр," ",""),ОпределеитьОписаниеТипа(стр.ТипЗначения),,стр.Параметр,Ложь);
		ДобавляемыеРеквизиты.Добавить(Реквизит);
	КонецЦикла;
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	Для Каждого стр из Параметры.Стратегия.ОпределениеПараметровСтрагеии цикл
		Элементы.Добавить(Элементы.ГруппаПараметров.Имя+СтрЗаменить(стр.Параметр," ",""),Тип("ПолеФормы"),Элементы.ГруппаПараметров);
		Элементы[Элементы.ГруппаПараметров.Имя+СтрЗаменить(стр.Параметр," ","")].ПутьКДанным=СтрЗаменить(стр.Параметр," ","");
		Элементы[Элементы.ГруппаПараметров.Имя+СтрЗаменить(стр.Параметр," ","")].Вид=ВидПоляФормы.ПолеВвода;
	КонецЦикла;
	КонецПроцедуры
&НаСервере	
Функция ОпределеитьОписаниеТипа(Типы)
	МассивТипов=новый Массив;
	Если ТипЗнч(Типы)<>Тип("Массив") Тогда 
		МассивТипов.Добавить(Типы);
	иначе
		МассивТипов=Типы;
	КонецЕсли;
	СтрокаТипов="";
	Для Каждого стр из МассивТипов цикл
		Если СтрокаТипов="" Тогда 
			СтрокаТипов=СтрокаТипов+стр;
		иначе
			СтрокаТипов=СтрокаТипов+","+стр;
		КонецЕсли;	
	КонецЦикла;
	Возврат новый ОписаниеТипов(СтрокаТипов,,,новый КвалификаторыЧисла(15,3),новый КвалификаторыСтроки(255),новый КвалификаторыДаты(ЧастиДаты.ДатаВремя));		
КонецФункции

&НаКлиенте
Процедура Применить(Команда)
МассивСтруктурированныхДанных=ПолучитьДанныеПараметров();
ОповеститьОВыборе(МассивСтруктурированныхДанных);
КонецПроцедуры

&НаСервере	
Функция  ПолучитьДанныеПараметров()
	РеквизитыФормы=ПолучитьРеквизиты();
	МассивДанных=новый Массив;
	Для Каждого Рек из РеквизитыФормы цикл
		СтруктураДанных=новый Структура;
		СтруктураДанных.Вставить("Имя",Рек.Имя);
		СтруктураДанных.Вставить("Значение",ЭтаФорма[Рек.Имя]);
		МассивДанных.Добавить(СтруктураДанных);
	КонецЦикла;
	Возврат МассивДанных;
КонецФункции

&НаСервере
Процедура ЗаполнитьПараметрыВходящимиДанными()
	Если не Параметры.Свойство("ДанныеПараметров") Тогда 
		Возврат
	КонецЕсли;
	Если ТипЗнч(Параметры.ДанныеПараметров)<>Тип("Массив") Тогда 
		Возврат
	КонецЕсли;
	СписокРеквизитов=ПолучитьРеквизиты();
	Для Каждого стр из Параметры.ДанныеПараметров цикл
		Если НайтиЗначениеВСтруктурированномМассиве(СписокРеквизитов,"Имя",стр.Имя) <> Неопределено Тогда 
			ЭтаФорма[стр.Имя]=стр.Значение;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция НайтиЗначениеВСтруктурированномМассиве(Массив,Свойство,Значение)
	Индекс=0;
	Для Каждого стр из Массив цикл
		Если стр[Свойство]=Значение Тогда
			Возврат Индекс;
		КонецЕсли;
		Индекс=Индекс+1;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции
