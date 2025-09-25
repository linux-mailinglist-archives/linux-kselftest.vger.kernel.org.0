Return-Path: <linux-kselftest+bounces-42271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93CB9D7AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267E51BC0D85
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F42E8B71;
	Thu, 25 Sep 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aaH1k/Vb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Uz/ZE2Wl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C42E88BD;
	Thu, 25 Sep 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778765; cv=fail; b=KeV/SCNNNGlPO7PEh2kY9Yu+9qqRhtvOm4xQu+oMrTpUSCJ9zl2E1cRh3DYNwzgZ3JE5mMk1oqjGyt0oNbWnD+mIlSs6tN6GUyvO9Yz/3VxMxs4iXmkee8di4TYjFgG0VsrIoT8PXD5gwQ/v5p0G7Etd3snTKhQvW0Bo0CO3u0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778765; c=relaxed/simple;
	bh=52Iu6lCaHsEt/ZYHWhZgo9op7RkImG6x74DJFGQFBNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UxLQwQK3VHCaij9xCTkjATwerGepwbCopXJdF86W7Y3rA3T2RyJu6ep+FgQRgPUu7cYn5C8Z8OSEWKSlwNXoDml8+gCHD3d6/Uqcxyx0EXs1CaSaNfkZrKivYd3y09Um0uejDL/mg2ttQk/NQjzKfYNDUCrEdixJJismKCJyb2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aaH1k/Vb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Uz/ZE2Wl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758778763; x=1790314763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=52Iu6lCaHsEt/ZYHWhZgo9op7RkImG6x74DJFGQFBNA=;
  b=aaH1k/VbojANXwufpAME6vbtL7o7F6UPkCFOJ3zJHAwV47UmBz04JqbB
   hAVes+dsZbHUs4/GSvBHTt8EXlg6egdk72TaaY6TZv8BC8YJiVcNm6xdZ
   fg+vzNYqehxkAj5zZ9UqSx4soJOkSGFgqf6bylkpBbaJpW+75JCeqWT/P
   720/R0MASgR7tvXtR2XI36617B7j4RJFth49VNUqJJGeMOPR2EJI1S1GI
   TJTZ11sNUOah72V/58x2soADnoJ8I83W/CIRrqDdWARtnHefKx9B9giBp
   tQ5JspPcbaahmfGc57DNE/HgCDhtiDsPlo6fDW5BtmIn+SKXrFRfO7Bf2
   Q==;
X-CSE-ConnectionGUID: YEMr71BURKq2CJzZwoWHZg==
X-CSE-MsgGUID: VLlkAEHmQjmpF5Pq6h2VbQ==
X-IronPort-AV: E=Sophos;i="6.18,291,1751212800"; 
   d="scan'208";a="130039078"
Received: from mail-eastusazon11012009.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.9])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 13:39:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxEdcYqFWdNUdTvxx5Caw/1sV8LOXxUSS+HZa+eZVwSctA1+kOOxluS1ynDzGmIVLJJTjCiO++BXoM8qbcpwaPumH+NlB5xWXriFLfEnX7kCkTrOCUp9B5eOPQQFmuD4m2GOxdR1YTVMeiD0zQxH0XWaKFFt607zjOCwnVBx7AgdhzyBAa/4Ngx16cite+2uKMSx2vQulK/lgW9vAFELvmN3k4p2IvjJY0Lo/2m+5hu9Lj80JHrdVgWzGLsDF9XSYsWrcqT0+l45HaAjNscuh26OaJqeHAhGzwMj+nZGAmUSUs5dHIMJzCpPRu2beWgnU/eln8tc8xr53kR4FYBPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Iu6lCaHsEt/ZYHWhZgo9op7RkImG6x74DJFGQFBNA=;
 b=hbOHLhe4O9drGHOfa78YkWJpxSVkqWEGzHjt0nYxhud54wRraCdRkUbEmbE5XqtmdVcOErRPYcoEQaT+TKP0ywQnXdlaFSGPkZaEO9u1hVBY5EUT/zpFsJ8z2xEOdsGyAMrdV4j4pBdIb3gkZp1PXGTQ6LfcRWwVqJHsKWMYa7iUD6EG5V9FhZC2yHmb3E0yR4pFuHh6wIOVFQi0Fk59pMraE89SapJFzeO1OPsuWYesYcS7P24im+j7YxPiLzIytwKAcufuPdAOLV5m5jeT8BMk5GMwHtIadZJyUlX7JwRedxszWvUHpkRafY18hcbLJSVD/lwU5RiMBZk2hGORaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Iu6lCaHsEt/ZYHWhZgo9op7RkImG6x74DJFGQFBNA=;
 b=Uz/ZE2Wlsv71QC9UbZiXPpKvERc/OJWKnXgLchjsJaYbx9A5xNWEJVgjXStRpxEo1kG+ptZ9muXP5BU9oIGjyHOBxnYKtF5qmwHFtejOsAjrv0aFKBeWImfsfzbceYQ10VXfEJqxi/Uh4Zob089OZOnZoaTmTOiTQ1PPCNRNwrI=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH7PR04MB8663.namprd04.prod.outlook.com (2603:10b6:510:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 05:39:14 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 25 Sep 2025
 05:39:14 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v4 1/2] net/tls: support maximum record size limit
Thread-Index: AQHcLEtzQYYhasLEz0mdPGnzGKCvLLSinvcAgADF5IA=
Date: Thu, 25 Sep 2025 05:39:14 +0000
Message-ID: <4a83e2f526013516e2827a4ff8899b0437d08a25.camel@wdc.com>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
	 <aNQvgD7AvFe7-sAv@krikkit>
In-Reply-To: <aNQvgD7AvFe7-sAv@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH7PR04MB8663:EE_
x-ms-office365-filtering-correlation-id: c6e332b1-ab56-4b96-1a72-08ddfbf5dc82
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmQ1ZE9yMFF4YjFhYVlsd1FhZXlCWFJDa2kybVFoeGlVcFVsSHl6OThOLzNn?=
 =?utf-8?B?NzJJWHlpSExlUnhmUUNUWFZqSzhKUGJtTWdSV0NHYmFWT2dHQVRMMENFc1Qr?=
 =?utf-8?B?RkhlUGFLVGlUL3pTam5xT3pMVFFyYjRoNk91L3ZGalRnRCtiNUdxNGNhN3FQ?=
 =?utf-8?B?ZHZFZHZPMDNmOWp5RUZtS2JUZzRTM2pWbDEzZVlRTVRSOS9aU0IzdDV3cWtr?=
 =?utf-8?B?MGdGVWFUL0xGN0NJNkh6K1E0U2JSbTZySy9hSlA5MmtydVoxNzJUK1ljZjNV?=
 =?utf-8?B?aHhyNEwrMDBQdTRqa1Y0eHVpUk9TbDQ4SC8zUFZtd0lUY3pTd25jVjBrL3Y5?=
 =?utf-8?B?SHdMb255Rm5TRDlENFByRm1TSCtDa1pHYjAyRjltMzhzRzJKSW5MKzZDWVJZ?=
 =?utf-8?B?MEdJbGVNOHdXWGYrdlM4TkttSnFpM3pNWmM3K2ZhbGlqYjh2ZGxZcSt1MWxh?=
 =?utf-8?B?dEIxa3FtOFJhSGpsaW93dER4VTJMdEcvdkVtSWlUK1Jkd1U3SGNyL291b29v?=
 =?utf-8?B?YWF4OVFUUVcrQkFldXIyL0xPVFBZNE9XeUhFSHN3bU9LNUhrM3lOeFcrK3VK?=
 =?utf-8?B?MWllamxRZVUwbTcvLzBBTnVsTjhBdjhLYmZpTU1DUSttZDlMWm9KYjlIWHQ1?=
 =?utf-8?B?bVNFRkpDZWo0WFFWSzlkdFo5b1ZoZDJyd2Exak5COTc1VGpBS1lVQmk5YUw1?=
 =?utf-8?B?Umd0cFB3Q1V1RXk2Rnp2R1hqdDdlOUQ1UmtZK2VSQnhJamlhbGNQd2I0VGNr?=
 =?utf-8?B?SFVzTkpDU3JRaUZpTVpHNllmL085eER2aUdNb3owbFlGWVQvRm1NeWQzczVQ?=
 =?utf-8?B?ZTR0dVFtQWVITEhFemN4cEtra0NGUnNiVTZwemU1aFZ1TjliNjVwVEJFWHlq?=
 =?utf-8?B?OFc2dWpFTExOYWRnUnM5WUkrbGJINzQ2Qit2aFIrc0xEVHBBckgrUVc1cWdQ?=
 =?utf-8?B?c3FRakJRclcvS29oZ1hsUEFadWZ3andZMXdDYjlRUkJUV1B5K05OdkU0YUxy?=
 =?utf-8?B?a1R1aThHNWxiQnRacmk2YUFpQkJKcFA5RFFYNnd6c3VhblM5Y1hpRmdidzlX?=
 =?utf-8?B?eXdwcUZ1cGtFNnJFSllJQ3hxRldWdjhDNWMzNlpHQjdsQzJTdWdVWXErUlNa?=
 =?utf-8?B?dHVHNm5sVTdPZzZRNlcrMWowZWlxdlQwQ0VjTzVVMlpxNWp2L1FVM1VOSlZZ?=
 =?utf-8?B?em5rVEN3WitDMnR6VmFJamZQdlpLKzJsNWZLcjBLQXd3Y25jeEVmelZNMVhq?=
 =?utf-8?B?MUpabkF5QmNLcXJLdWQxVGl3NWxVM28zOUlyWUtzcWZVNDJ5b2dUekEwSmRl?=
 =?utf-8?B?QjdlOFZNU3d0bTc3KzdNNUd1Rzg2enVySWFPazFiWmJUSTBUaXR2RkdqbTFp?=
 =?utf-8?B?Q1FPaERUb0owbTBYbWNsVGc0NXJ0U2FBUVc1bnQ4dXVJRC9DT2Y4cWRUSTFo?=
 =?utf-8?B?Yno1NUhzTXREcUxwVmVIRk9iSlpmQ3ZMTjlsbzNqdmNXMmp6ZVdwMStTcGNY?=
 =?utf-8?B?LzRJK3hTNWNVakV5N3VqOGJvUkU2V013eHcwakNueEVxa2RyaDlwTldTNWpB?=
 =?utf-8?B?WlVIcGU1YkJXdGxONjNrZVc1TkhEL21SOGVJODhLbTQyR1crL1lpQ2kzMlRv?=
 =?utf-8?B?ZFFWOFRaWW5NbVh6bklFUEhPeGovcGUreVFPWFZrNERzOWFPQU1qZzVTeU52?=
 =?utf-8?B?RkY3cTYvN0FtOXlpejJySmpURkx6bXc3RVgvRkk2Y1J0cFZ4L3lGbGNqYWVz?=
 =?utf-8?B?Z1JHR0JxVTFPLzdWeHU4U3RDL0piT00zc3MxdmRXR2VTSWsxNnpab09OSmlT?=
 =?utf-8?B?RHNzSW1maVJkSnVTd09LakpvWnkzWFhyOUVHUU1pUnNKN1AwOHUxcHdYS1Y4?=
 =?utf-8?B?dmlqWVRrM1hDd1ZGVUl3RVdtV3A4dExQb0tYdkM3NDVqem9FM29valBGRFF5?=
 =?utf-8?B?b1dFOXRTenRlQTR2Ym5VMkdBN2VOUXVqbk5rc21hVzN4bTgwMDlmWElMUlly?=
 =?utf-8?Q?bcxl5D1IMSDbi7/apGTjQ+lNiChgho=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjFUbHdJeFF3bzJLNHZ4UEN6UEd3SGVvSkU1cStWaCszY1FINzJqc3hpaWpp?=
 =?utf-8?B?RnU2UGFzRHVKL1F3UkxDZjAyVElLcFRqU1NJc1FpSG11aEtjOVlMcGtWQS9I?=
 =?utf-8?B?bWlsT1RSL0hqRmJ0N01uZFlMaURuMTEyN2lvTWFjRVJTdm84S21GbVB6SWJB?=
 =?utf-8?B?cUplTDRSOE8zd1VEWjlPa2YzTVdhMGVHdEJkUTJPZXdmNXpzUEV3YzNYMjBw?=
 =?utf-8?B?L3YyZkhxS2hhV1FRN2lyTXRtMlBnM3lqdlFVZk5EZE1PYW5OVFdmbzB6Y0FH?=
 =?utf-8?B?enVaakhOSWIxRDM3eWNYS2hScTlzWTcycjYxWkpOejBKRW5qNWcyajFlTkxU?=
 =?utf-8?B?eFc3MHB0NDZjMUh3NUJ6bHNMMTdmTklENkc2TzFUK3BUbVhLQ0pJZFEzT0c5?=
 =?utf-8?B?VlJXTkV2bDlxZjhCOUlTUmwvR01ESGRpQnRiOWF1SXJhWm5SckVEMTErRU5Y?=
 =?utf-8?B?ZWZraHZoOU1yZTJrdzAwUGVjTGwzRG8zMHlFRkROWTdEcUZZTndBVk1NU2xw?=
 =?utf-8?B?eHJDb2tmZUYrUkFxZGJkNWlDWFhISFZuMDJHdG9YS3RKMlRDaklkOFJJQ0w0?=
 =?utf-8?B?Nk5UTm1naU1vNm93WllQdTYvNnk3ZWc3QUNKTzZzeVJGVEZYQmRJWHk0VEM4?=
 =?utf-8?B?UmNpV3dnVmpjUklZOHo0ZWpWZjgzeVNKVENBbVBpb2VVQlpRSUhyQTFwQjN3?=
 =?utf-8?B?MXQrbjVaam1Gdm5HNndScmcxSkZlbnlHNWJDMmhpNDBtWXZUdmoyZ0FNNWNQ?=
 =?utf-8?B?NCtNb2VhOGRFWG4zaHNDQ1ZLd1RGbnQ1RzUySGlYK3JZeTVTejkwV094RVhm?=
 =?utf-8?B?M1hOODJtN2dEMVYwOFRBem44QWNjaW51amNKaGpJcjNIMUtCcDNzM2c4SHZU?=
 =?utf-8?B?R0JIakk2aTNxcFF0SkhmQjVvZEhYWjM1REZSa3hUZ1VsVFVNb1hCQUpIN1Aw?=
 =?utf-8?B?aExJTnc5bjRvWm9PVFVsRlJ1Mmw2bmZLbXVCVnFzeTdJWGhoalBuczZnOXk0?=
 =?utf-8?B?cUFvSExNeXVQcWpsRTArd0Y1RE5NZWErWlQyWGxDeE04Y01ONE85WmtCeGho?=
 =?utf-8?B?QUxublFQbmsxRjBweDZmKzFjSG81cHBWZ3VTTlNsckZoMFN1YlROM3Z6TzVs?=
 =?utf-8?B?cGF2TktTNkc1TXNjQlYraUtOWko3M3UwYm10R01QQ1Q1VW5nZ3VTY29leTFO?=
 =?utf-8?B?bWVYKzc1dHZBV3NRWmNuTzlvMTM5a2huSFVNRSs0RXV4bmYrelFWVzZOQ0Fz?=
 =?utf-8?B?cm8vL1FMV2UzOWZQTVZ0UUJ1aHF5VEZRcmMwSVFaSDF3cUhSTnZZRURJUU9F?=
 =?utf-8?B?c3FtYU1sL0lENTF3aHZwQXZoWEY2T2RMUkxlaDVkZktNNVJYbENFRGJURmtN?=
 =?utf-8?B?b3BvdEFvbnorbzMxQXBRRWRTQTg3alN1U1BxU1Z0ei9tTUkyRm1ldmNyWGRv?=
 =?utf-8?B?QUZYM2VQVWNNNkxEck92bmJyb0luUGtleTlyYldrc1lrZDhqVFZ3REtWV0dT?=
 =?utf-8?B?TEgyMzl5OVdWekpFOXlXYU8vREtHT2JlUWdBdXQxbjYyK0lOaFN1N3ZMOTNy?=
 =?utf-8?B?TVZlMnZuN1cwektFVWtGOGUrNndGOGI5NWVKdFdHOEZYUkZTamV0anNSQ0ZJ?=
 =?utf-8?B?SlJ3YTBCK0d2eHUrLzUvK2tWNXgrZWMwcDZxWVRTUjkrNXA0aWpUZW1KNEVB?=
 =?utf-8?B?QjhFRHhmQVlKb3Z3QVNCQW5zUGpnYVViQUdERjNrT2kxczU0TVY4NStSeHk1?=
 =?utf-8?B?bWZCY0pLOW41d01iMlFNRGcyeTBld1BBa3huWlFmd1FkRkMySDJ5Ym5RYmkx?=
 =?utf-8?B?YzdWa0VQNDJlNWZiNDBHNm00Y2U2WUdGSjd0cHdNb1RFSkE3bHRySWtQeS9u?=
 =?utf-8?B?R3dwampBWStJL2t3SHVBMGpEOG05a3UvNzl5c0pYYnVlUkxzUjNvcXg1M2Qv?=
 =?utf-8?B?U0NTL3BjT25mR1JrRTRrTHk2aE1ZMU1nVVZTZVEwSExqMXZHWGhHYUQ1NDBj?=
 =?utf-8?B?NzM0Z1JHeE5QbHFHSUNYcXNkdDQva2VRMzltdkZyZEszMyswZTlPRVZCbDhW?=
 =?utf-8?B?ZndYMFd6azlRODY1VGgvUUNOVlRuaDlXTlVJVytkcmF6bmQyMm96OFlqY3Js?=
 =?utf-8?B?VGV5cm5BUDhtcjdtNVZrUFUvTk5RQTNNV2wyd05zSHFDNlJ1ZjNSdm4vTGEv?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31E661397413A943B5C14AD046B12E50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2CRBWjZRve5x2rSxKp8fCS8E/88OVYiESVxgwILttEbrsgkFIIqcZ2VOHHFD8dlVGT/yODeA3TfsxwK7fE6xAQJ2/eZgHiTrmMSZVbaRFBDXKR3Bzq6MXAqB30YYnTNqWUBKUhjMgft8TCPJpQlNGnmJbF1ynDy6uN97lqxuC6UcFBAXqpxkHCw7/QiZGa/GRJzLkf8qSdN+Sad7oRfOXufOV8pa/QANWOi+sZLwXYF4qz4sRt3g0banKU1zo8FKklghURk3EkSDOVf8Q5ltnJGX7xSLpopqGE3mTw1cvcZps+M9n60PiU+6YbDk5s9PzYsZYTRujZZ9qn5FO6ZEQ7mCjiKq0gHmNPomfxXsH8rzMTytq2ZLHAkOdgBrRRU/sg2B76I7uWU9SAvEbNDqHvVLXs+UOx/659mER/A2UcLYYw9fzdxMEYj3Yi+/SZ5hLawr+G/54v2ILQGsgfvT2/cmh903xuuKofXSe/FGpNSFbn+pnSUmDIhmYBYHgH8C+beL5yGT1gjI2OBWoQETn7cHXs9ZWPtIsC20d9l1v5uvw5aQkgInNScHmXD5Ph0uAQRXuHoGa+Bn5i7EitFnF79IL+tnjSscuZR8ppCvtvNM/umeQKMH3ROogWu9LGSt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e332b1-ab56-4b96-1a72-08ddfbf5dc82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 05:39:14.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtl6bn8QVn9UkPljICgr0z04aFW9AJx7wdM1D72oD1up9SJMZlgUpA+kBGMYcJX10yobzBr0SdTnCUfRZBj44w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8663

T24gV2VkLCAyMDI1LTA5LTI0IGF0IDE5OjUwICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IA0KWy4uLl0NCj4gPiArDQo+ID4gwqBzdGF0aWMgaW50IGRvX3Rsc19zZXRzb2Nrb3B0KHN0
cnVjdCBzb2NrICpzaywgaW50IG9wdG5hbWUsDQo+ID4gc29ja3B0cl90IG9wdHZhbCwNCj4gPiDC
oAkJCcKgwqDCoMKgIHVuc2lnbmVkIGludCBvcHRsZW4pDQo+ID4gwqB7DQo+ID4gQEAgLTgzMyw2
ICs4OTgsOSBAQCBzdGF0aWMgaW50IGRvX3Rsc19zZXRzb2Nrb3B0KHN0cnVjdCBzb2NrICpzaywN
Cj4gPiBpbnQgb3B0bmFtZSwgc29ja3B0cl90IG9wdHZhbCwNCj4gPiDCoAljYXNlIFRMU19SWF9F
WFBFQ1RfTk9fUEFEOg0KPiA+IMKgCQlyYyA9IGRvX3Rsc19zZXRzb2Nrb3B0X25vX3BhZChzaywg
b3B0dmFsLCBvcHRsZW4pOw0KPiA+IMKgCQlicmVhazsNCj4gPiArCWNhc2UgVExTX1RYX1JFQ09S
RF9TSVpFX0xJTToNCj4gPiArCQlyYyA9IGRvX3Rsc19zZXRzb2Nrb3B0X3R4X3JlY29yZF9zaXpl
KHNrLCBvcHR2YWwsDQo+ID4gb3B0bGVuKTsNCj4gDQo+IEkgdGhpbmsgd2Ugd2FudCB0byBsb2Nr
IHRoZSBzb2NrZXQgaGVyZSwgdG8gYXZvaWQgYW55IGNvbmN1cnJlbnQNCj4gc2VuZCgpPw0KPiBF
c3BlY2lhbGx5IG5vdyB3aXRoIHRoZSAtPm9wZW5fcmVjIGNoZWNrLg0KPiANClllYWggdGhhdCdz
IGEgZ29vZCBwb2ludCwgd2lsbCBmaXh1cCENCj4gDQo+ID4gQEAgLTExMTEsNiArMTE4MCwxMSBA
QCBzdGF0aWMgaW50IHRsc19nZXRfaW5mbyhzdHJ1Y3Qgc29jayAqc2ssDQo+ID4gc3RydWN0IHNr
X2J1ZmYgKnNrYiwgYm9vbCBuZXRfYWRtaW4pDQo+ID4gwqAJCQlnb3RvIG5sYV9mYWlsdXJlOw0K
PiA+IMKgCX0NCj4gPiDCoA0KPiA+ICsJZXJyID0gbmxhX3B1dF91MTYoc2tiLCBUTFNfSU5GT19U
WF9SRUNPUkRfU0laRV9MSU0sDQo+ID4gKwkJCcKgIGN0eC0+dHhfcmVjb3JkX3NpemVfbGltaXQp
Ow0KPiANCj4gSSdtIG5vdCBzdXJlIGhlcmU6IGlmIHdlIGRvIHRoZSArMSBhZGp1c3RtZW50IHdl
J2QgYmUgY29uc2lzdGVudCB3aXRoDQo+IHRoZSB2YWx1ZSByZXBvcnRlZCBieSBnZXRzb2Nrb3B0
LCBidXQgT1RPSCB1c2VycyBtYXkgZ2V0IGNvbmZ1c2VkDQo+IGFib3V0IHNlZWluZyBhIHZhbHVl
IGxhcmdlciB0aGFuIFRMU19NQVhfUEFZTE9BRF9TSVpFLg0KTWFrZXMgc2Vuc2UgdG8ga2VlcCB0
aGUgYmVoYXZpb3VyIHRoZSBzYW1lIGFzIGdldHNvY2tvcHQoKSByaWdodD8gU28NCmFkZCB0aGUg
KzEgY2hhbmdlcyBoZXJlIGJhc2VkIG9uIHZlcnNpb24gKHNhbWUgYXMgZ2V0c29ja29wdCgpKS4g
SW4NCndoaWNoIGNhc2UsIGl0IHNob3VsZCBuZXZlciBleGNlZWQgVExTX01BWF9QQVlMT0FEX1NJ
WkUuDQoNClJlZ2FyZHMsDQpXaWxmcmVkDQo=

