
#Область СлужебныйПрограммныйИнтерфейс

// Добавляет в список поставляемые драйверы в составе конфигурации.
//                                 
Процедура ОбновитьПоставляемыеДрайвера(ДрайвераОборудования) Экспорт
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверCASЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'CAS:Электронные весы'");
	Драйвер.ИдентификаторОбъекта = "CasCentreSimpleScale"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверCASЭлектронныеВесы2х";
	Драйвер.Наименование = НСтр("ru = 'CAS:Электронные весы 2.х'");
	Драйвер.ИдентификаторОбъекта = "CAS_Scale_nLP"; 
	Драйвер.ВерсияДрайвера = "2.13"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверАТОЛЭлектронныеВесы8X";
	Драйвер.Наименование = НСтр("ru = 'АТОЛ:Электронные весы 8.Х'");
	Драйвер.ИдентификаторОбъекта = "ATOL_Scale_1CInt"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверМассаКЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'Масса-К:Электронные весы'");
	Драйвер.ИдентификаторОбъекта = "MassaKDriverR1C"; 
	Драйвер.ИмяМакетаДрайвера = "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверШтрихМЭлектронныеВесыPOS2";
	Драйвер.Наименование = НСтр("ru = 'ШТРИХ-М:Электронные весы POS2'");
	Драйвер.ИдентификаторОбъекта = "DrvSM1C"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверСервисПлюсЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'СервисПлюс:Электронные весы'");
	Драйвер.ИдентификаторОбъекта = "Cw100Driver"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "ДрайверМАСЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = 'МАС:Электронные весы'");
	Драйвер.ИдентификаторОбъекта = "ScaleMAS"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ЭлектронныеВесы;
	Драйвер.ИмяДрайвера  = "Драйвер1СЭлектронныеВесы";
	Драйвер.Наименование = НСтр("ru = '1С:Электронные весы (NativeApi)'");
	Драйвер.ИдентификаторОбъекта = "CheckoutScales"; 
	Драйвер.ВерсияДрайвера = "1.1.1.2"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверCASВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'CAS:Весы с печатью этикеток'");
	Драйвер.ИдентификаторОбъекта = "CasCentrePrintingScale"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверМассаКВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Масса-К:Весы с печатью этикеток'");
	Драйвер.ИдентификаторОбъекта = "MassaKDriverR1C"; 
	Драйвер.ИмяМакетаДрайвера = "ДрайверМассаКЭлектронныеВесыИСПечатьюЭтикеток";
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверАТОЛВесыСПечатьюЭтикеток8X";
	Драйвер.Наименование = НСтр("ru = 'АТОЛ:Весы c печатью этикеток 8.X'");
	Драйвер.ИдентификаторОбъекта = "ATOL_ScaleLP_1CInt"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверРБСВесыCПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'РБС:Весы c печатью этикеток'");
	Драйвер.ИдентификаторОбъекта = "Rbs1CDriver"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверШтрихМВесыСПечатьюЭтикетокШтрихПринт";
	Драйвер.Наименование = НСтр("ru = 'ШТРИХ-М:Весы с печатью этикеток ШТРИХ-ПРИНТ'");
	Драйвер.ИдентификаторОбъекта = "DrvLP1C"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверBizerbaВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'Bizerba:Драйвер весов с печатью этикеток'");
	Драйвер.ИдентификаторОбъекта = "BizerbaNative"; 
	
	Драйвер = ДрайвераОборудования.Добавить();
	Драйвер.ТипОборудования = Перечисления.ТипыПодключаемогоОборудования.ВесыСПечатьюЭтикеток;
	Драйвер.ИмяДрайвера  = "ДрайверСервисПлюсВесыСПечатьюЭтикеток";
	Драйвер.Наименование = НСтр("ru = 'СервисПлюс:Весы с печатью этикеток'");
	Драйвер.ИдентификаторОбъекта = "Sm320Driver"; 
	
КонецПроцедуры

#КонецОбласти
