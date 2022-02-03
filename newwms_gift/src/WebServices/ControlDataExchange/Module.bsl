

Функция ToGetData(СтруктураДанных)
	Данные=итWMSСлужебныеПроцедурыИФункции.ДесериализаторДанных(СтруктураДанных);
	СтруктураОтвета=МодульОбменаУправленчискимиДанными.ПолучениеДанных(Данные);
	Возврат итWMSСлужебныеПроцедурыИФункции.СериализаторДанных(СтруктураОтвета);
КонецФункции

Функция GetListExchange()
Возврат итWMSСлужебныеПроцедурыИФункции.СериализаторДанных(итWMSПривилегированныйМодуль.ПолучитьСписокПлановОбмена());
КонецФункции

Функция InstallCompliance(СтруктураДанных)
	Данные=итWMSСлужебныеПроцедурыИФункции.ДесериализаторДанных(СтруктураДанных);
	Ответ=итWMSПривилегированныйМодуль.ЗаписатьДанныеСоотвПлановОбмена(Данные);
	Возврат итWMSСлужебныеПроцедурыИФункции.СериализаторДанных(Ответ);
КонецФункции


Функция ToGetDataOnline(СтруктураДанных)
	Данные=итWMSСлужебныеПроцедурыИФункции.ДесериализаторДанных(СтруктураДанных);
	СтруктураОтвета=МодульОбменаУправленчискимиДанными.ПолучитьДанныеОнлайн(Данные);
	Возврат итWMSСлужебныеПроцедурыИФункции.СериализаторДанных(СтруктураОтвета);
КонецФункции

