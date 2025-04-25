Return-Path: <linux-kselftest+bounces-31664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B2A9D40C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4210F7B279D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F12236E8;
	Fri, 25 Apr 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bhPpifUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215D52F88;
	Fri, 25 Apr 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615862; cv=fail; b=drI3KlWbogFyVUQMAo/6T1I6NoNIFmQM7f6Oj+Cqazu2hPA6ipMJG/uZROKBBpaOIZm2RyzTfwbUoQXlhFPceKQKQsf8XRkIJ3CxaMUZVoQB1Wlf+48bM855dzTBgDbOfBExRGkobWp5LT6B3c1E7h5EygdSrGko4nk6L4f4zjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615862; c=relaxed/simple;
	bh=YC6daX35lQaygYnwJ6zqnVLdvtgknIW5W0FVeh3kz/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCSwBdGeYLDtHF93v0OPvDHBaj8f6ESQpg/XgLziMDNQ5tYpMbzzHu1AK8RR22Bk/nJPjwPytcD2MBpx81avrBr8iVbSmcAeJQZ0f35N3ymVjSi8whofn2EuXbJ6EVUuVpWAJRcr93OCdWQZVMKuetyUIOkSAyYdBP4aSnCEnrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bhPpifUD; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTxvufcK4oe3/1ZYwp3ZZC076eZ/4xBwQ76gTEgOL4LoMnA1JZ8JUnSo4x0hDuS0sGNyr8M5uWweNDR1QwDbwQz+clPf/fTw9naceiDavQvp0su+ySR6prOuZKKJm1+FaoYbeV1V3m/UrMIT7Qre8/X8Ik/Mqk7b7ImlK5NuyB6tW6YqeZPRpaM7FZ5wGkZ/HumC3Ug3F1gUKZ4Ej2b3nb0wOMhzu8XpWJiMRoTJaeVXySuy7MmOYJUss+mkkABoDrBKPgrXLDyrvFlYvKCj2lgGaeGUhq7+YoBYnXvlnMss0XGIW4SO087q/3cu/MUaUjQJkXezpaVfSeK9/WeYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZRpV6H9rwOrRmroOqz9TBxAzAg1kuKwHt2LAQGToEg=;
 b=kPhOWD6voWy0yNB/2zY/QzCfPXq86gq0Astw+jOO6/74e1+8D/J0Tp/dzb7exGNbFJdOr6ttTFsN6SPaI+TmT5DX0ZaNAoyRZR5cIwn5V4HVf7hsNjI6DNIArxzh62swOwHAgROfmeonyZ5UMXrjsFm1qBZjYIS+zfoYjUlCBYT1aHNpdrEn+T8n7dhfK1+N6Mk+KleqGT9Y6v43Uv4oz4UEQmh5ymKkL+IPddV3IaM0Tfl4w5+yTgz7nwVi3MorO4fOXS9Hwe9ZMrc1uvf6ak9C7E3UL3a4z+4H+sJrVwfetG/94H6CoMG5VAzn259dSRcZ5GOo8fZaEWaKJmXZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZRpV6H9rwOrRmroOqz9TBxAzAg1kuKwHt2LAQGToEg=;
 b=bhPpifUDiG4/ixtPMUG8Oe/s/88HGs84ZbroX5c9faPe1R0yUTnVJHPUpff+ovIVtgB/GZeJcoc79nHxrdI3VlPLS0XkZgjawtOgqItGUrUa/uZLKjBd73YoWcKP7pQsJzvf8MrOskc4hulap5Dmn1kNSEhLplWxRux6gwec3U5z2bODzoriMsETrO2U2ePmKQ2cmD/P5RyfKicpqI7TUXedrn7Ko2kru/wTMLlvXhD7B7pFcPykcjC95DBB+O+u+Xw6B3l4Bq3dHHvK/QK9/OWStV349UDZc5lvQ4CzDQcLSVgLRzU+I3YS4aLZVgnHOr0iVGssI3Ykfi1PQl+/nA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA4PR07MB8414.eurprd07.prod.outlook.com (2603:10a6:102:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Fri, 25 Apr
 2025 21:17:37 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 21:17:35 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v12 net-next 3/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v12 net-next 3/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHbs8NqA3oHuV9B1ECtG+fwBrAfxbOxKjTFgAO54KA=
Date: Fri, 25 Apr 2025 21:17:35 +0000
Message-ID:
 <PAXPR07MB79842D8533AD83205CF744AFA3842@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
	<20250422201602.56368-4-chia-yu.chang@nokia-bell-labs.com>
 <m2ikmvt78v.fsf@gmail.com>
In-Reply-To: <m2ikmvt78v.fsf@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA4PR07MB8414:EE_
x-ms-office365-filtering-correlation-id: d4f248b3-8736-4e42-3959-08dd843e9971
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P4Krx7VzjQ7q3Gcm+sdHy13yNnSEvlUQApWFFpTqGzPAUxwnZUhyd9waTh7w?=
 =?us-ascii?Q?xePpA0lXc58AQ1DOwYNwvK50w+hjJ3faI7L8WzM+PII+3RmExMOLptS0LA+p?=
 =?us-ascii?Q?4or9ot51CB/5hoI5sJCEKl7RQkfMxnDnR15oNxjhrK4a0Dm/DBDYWVhXnEzX?=
 =?us-ascii?Q?XKgknoaBmfXPE0h64qkVnEFWWMc2apNRFaCsGaZY3wM/W5b+41vLzayDOSpe?=
 =?us-ascii?Q?zB1BBnac2dT6pgszdDcf4xP+OFeBCQTHafm3lFXdxjj70HbqnFMH4qGF0Sh+?=
 =?us-ascii?Q?VzALanCLw47pmW8daCEnvo2FN5Ugz7kpbW2ggt8hJUgoUB5ubcBRUM6TBBxS?=
 =?us-ascii?Q?czs8rEu5LMTLLwQDB4+HlsQjlooM0B+Dcngzt46Uyy8plFMbVGCV1PZvRlva?=
 =?us-ascii?Q?juCufAY3U8fYEpmd5soowDOKjJSJGPgXMDerXvX8fZom+FwDFmwJhJ3qrYke?=
 =?us-ascii?Q?RaWssycKgMTq7bscQ/5PYUeYD0X/enwmS0Y4y67ezvLYLddI534TS9i5f4pC?=
 =?us-ascii?Q?M5WUMh7zH5VIfBeepA0YZ/do1xQGs8eJEOmkxB2sP2RONU6O1G3+gEbtZ2Di?=
 =?us-ascii?Q?S6gvOu6JRqyCFkboo3e+0tAgJ1KaSAKVifrV3Ql+puOeyujGsxxq9030ontu?=
 =?us-ascii?Q?SXSlqPbDEU48jyaGIH1YqfPYNZQdXV/pGQnMpNmIEf6t8H+vj9j1VOMzwHif?=
 =?us-ascii?Q?w+psrPAhJZwvt9Rai20xwsSSnP2qfmwqFabWeC9mzmpxPmASreTUxq/fyJcS?=
 =?us-ascii?Q?0wBJx+D5CVJ1iQqNL5QbrKnB4E110hzzygCxODsXaDM1aJKKMau4VLqpvOnK?=
 =?us-ascii?Q?17eOW9cVomUyUkvqGCosx6iRtlYsXxRuw4J2T5UvcCY6qaIE6PlWxn0FMkou?=
 =?us-ascii?Q?uANd9T/735O+iG8PHgR/9vijR8COkkBLB8Zm9D2rWnJPSd4SyXpkc/V8yXEJ?=
 =?us-ascii?Q?7kB1hYuebpi2Ojpy2Ot9WAjdWk+YBq3ZP76tGpQ1d3uWwKFJWANLlq/KY1uC?=
 =?us-ascii?Q?QecWIGa6Wcz0bDcVbhzwvpBVVmPK6y3I+bkEA24cWxaRoNICXEXtv9ogVd7U?=
 =?us-ascii?Q?5MkLkmC5BLNAH/gH34hB7ZTbSZehgLsXZub82v7FE4b8ThEmNgZiH3SsqijT?=
 =?us-ascii?Q?rTfVdUR2sR6G76WvQDBfaRcqJ0qi87SkEWzOk8TPdKJDFRVVP+Xckio3z/N5?=
 =?us-ascii?Q?cHvyC8sNKzcnkLpz5HJSA+PDWgWeS9vaCX0UNSPQmOLh1deLwLLjMDEA9p4o?=
 =?us-ascii?Q?2UDcANIcU1cvHWNaBGXfVhfaLEomHV19tzlIxcDK3SHhni6yklPLEIWgcEIu?=
 =?us-ascii?Q?3AFtdKxKoCVKJVQnwbfFpovfQolc8oUTZG8IitlmtCy0IdWjZiknWfidCHiX?=
 =?us-ascii?Q?C8xxSxM52eIduUrVdSSN4lsjwpEHkLXCz+JVHFxBxNVbDZS73yT3IP/BRuyq?=
 =?us-ascii?Q?FOf9h7sSHI+dX8EgUCirUy1o7uzS032Dk+tHQWOM6s8WtUrl2A0D6s0WmQ2k?=
 =?us-ascii?Q?IucbhLI63FSiF5g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZJftYFFDc7DMcfWp/SUa6iimBYOfzfqsSZEQCV1Wgi/ysp8PNqt0AqQLhlmv?=
 =?us-ascii?Q?yTu6uYZ1yChIoJ/EGORJpImI3Z9aktmeyKOE2Z6TXj8xsj27d1hljRCtGgsc?=
 =?us-ascii?Q?wmrW8wKjm+ynHf7GcMAS7Mt210Cbj3vy2+tT3iEhmTRWrD4SfcGEAuzjKLoY?=
 =?us-ascii?Q?I3k+PrXUzgYsGhVJ8Wf51/xO+2JnwvxflebfJhTkjsirz/irk8nTlnXBCKnY?=
 =?us-ascii?Q?vA/u0l5/ZtCW5y+tR0OUoNjE6NBCGdKGEXL8D404r70k9Wp2DBnZ4gE0VV2h?=
 =?us-ascii?Q?olhXlT5sTr2hJx+AswJ9A8OU8oIe2JzybjlirTgrbrN1cUB9mU+FH8BFJe2s?=
 =?us-ascii?Q?DpRFQKikD2sx5ekj85w9cqkCBm4bQokktUDGoI08GQaZwMoHOvCCE2BCgute?=
 =?us-ascii?Q?xwkmAUjpaurStD4+H5dN+tUKubaLUj4c8FNBJI0h22EEy7Xgj/KhuM4JVlMZ?=
 =?us-ascii?Q?Q+NrNUMXaGkpLzZBkwwEzUvGOUtcBBn7w4DNDap3wsJgGfRandxHoOpauGUb?=
 =?us-ascii?Q?w6dXTjARJaDCpsFhfI8RUkJ66Pod3OE/Fq21N4INugDHLGzQs0Ib5Im12MS9?=
 =?us-ascii?Q?UaTDLLEGJ90+WosgeMJxHqAxvtSThIp37ph+IIZxFiOYABE8P+enu3eRTP4a?=
 =?us-ascii?Q?wxBdXrCfVZhGkeLrJfAeNID8xrt/6+LoKLTELmAxfkjMXyx8nTfsyINx2HfV?=
 =?us-ascii?Q?0o5mGvHRbpO2GxlqYtGPgeiIl+tGwz/mMXxvHbxABedpqfVC5KNG/mivq6Rf?=
 =?us-ascii?Q?fbyw8XBwjk2M6Mu9turHstPN2fS6xdqRerUmmhJtwSARtn+UNp1RvdeoEjmG?=
 =?us-ascii?Q?Rqj3TQMTFAQqyu3PybfCGmQxlayg3UtCCebEFwsPEnP5jBwkkUmGjuvo1pWx?=
 =?us-ascii?Q?1H/FNujRYpVX0qEoh+P5jdGFQyiKwk+fawLEpxXncilfQq1OPB8gu8QjCPso?=
 =?us-ascii?Q?AMAKspavluYTejo/amQ0GxfGaYyr07itmkVXuDWnOfPnIEU+ay5mT+crSKs2?=
 =?us-ascii?Q?alKw6pLLSN/qT13S05B3FRTewYXZU8uLcuzadjU7kY+kGymi2xof++ZJgIYe?=
 =?us-ascii?Q?vBoYG0x6FazaqrGVQgep3cfIM6/f2HtFx+/rBH7se1ztlnb1sAJSEWStQT99?=
 =?us-ascii?Q?Rio6/GRSTtiNJtjEO4AEYNsxUhryMAVyDf1fCFXtt5ZzmUnkfDfcBStIDJsi?=
 =?us-ascii?Q?w60X/TkhQ+k2oBxh2hOikVlXOg+SN56WaRVaoK4LWWmL/RqWp6UBtEjpajSv?=
 =?us-ascii?Q?iTz8y63cBAvfP6tzN8g51oHUQHeM4n9Y0zGfCYuR81/9rFXnsh6rkqXKfVOh?=
 =?us-ascii?Q?bLTf51IEUfW5jTj5oxeOSLs6P3Xu3RJwFjAgdJVQUyh4orB8j+UMlCBxiZhm?=
 =?us-ascii?Q?cvB0XkM4iDowblSIf9/Wi5TY+ixFpNvAoLPg0NGqZz+qF5/T71AgpM/zGPmF?=
 =?us-ascii?Q?jLeTLRpJzLr5259jf0w5usPaqNg8pnMkOZQEs42awLAtOIGOSR0WFIezydnL?=
 =?us-ascii?Q?Grg7BlUMzLibamdoJZHQ1bkTMQPW9AWHYvX5VMKQBSTIVKSJ96oflBu9rdNY?=
 =?us-ascii?Q?jkGkp9Q1MQSBS8jXtUPs0P0Xd8ZTs6yiTkEUTtwXiDPvyKsAoHfkPuMC/i9g?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f248b3-8736-4e42-3959-08dd843e9971
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 21:17:35.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyYOyNwN/dj6uL4p0FkgPib85pkV7B8jQg7TMSUSdvW/K57kOA8229BGjywmwirQRYkieKzf8vKzJS5H5YfCqgJ1G01P5WU73gr0VR34Gx35NTVCAm9W3QEMe99yKRxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8414

> -----Original Message-----
> From: Donald Hunter <donald.hunter@gmail.com>=20
> Sent: Wednesday, April 23, 2025 2:03 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pabe=
ni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaze=
t@google.com; horms@kernel.org; andrew+netdev@lunn.ch; ast@fiberby.net; liu=
hangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@ke=
rnel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@=
nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@=
ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gm=
x.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v12 net-next 3/5] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> chia-yu.chang@nokia-bell-labs.com writes:
>=20
> > +
> > +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] =3D=
 {
> > +     [TCA_DUALPI2_LIMIT]             =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_MEMORY_LIMIT]      =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_TARGET]            =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_TUPDATE]           =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_ALPHA]             =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range)=
,
> > +     [TCA_DUALPI2_BETA]              =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range)=
,
> > +     [TCA_DUALPI2_STEP_THRESH]       =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_STEP_PACKETS]      =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_MIN_QLEN_STEP]     =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_COUPLING]          =3D NLA_POLICY_MIN(NLA_U8, 1),
> > +     [TCA_DUALPI2_DROP_OVERLOAD]     =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_DROP_EARLY]        =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_C_PROTECTION]      =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
> > +     [TCA_DUALPI2_ECN_MASK]          =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_SPLIT_GSO]         =3D {.type =3D NLA_U8},
> > +};
> > +
> > +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> > +                       struct netlink_ext_ack *extack) {
> > +     struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> > +     struct dualpi2_sched_data *q;
> > +     int old_backlog;
> > +     int old_qlen;
> > +     int err;
> > +
> > +     if (!opt)
> > +             return -EINVAL;
> > +     err =3D nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy=
,
> > +                            extack);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     q =3D qdisc_priv(sch);
> > +     sch_tree_lock(sch);
> > +
> > +     if (tb[TCA_DUALPI2_LIMIT]) {
> > +             u32 limit =3D nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
> > +
> > +             WRITE_ONCE(sch->limit, limit);
> > +             WRITE_ONCE(q->memory_limit, get_memory_limit(sch, limit))=
;
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_MEMORY_LIMIT])
> > +             WRITE_ONCE(q->memory_limit,
> > +                        nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> > +
> > +     if (tb[TCA_DUALPI2_TARGET]) {
> > +             u64 target =3D nla_get_u32(tb[TCA_DUALPI2_TARGET]);
> > +
> > +             WRITE_ONCE(q->pi2_target, target * NSEC_PER_USEC);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_TUPDATE]) {
> > +             u64 tupdate =3D nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> > +
> > +             WRITE_ONCE(q->pi2_tupdate, tupdate * NSEC_PER_USEC);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_ALPHA]) {
> > +             u32 alpha =3D nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> > +
> > +             WRITE_ONCE(q->pi2_alpha, dualpi2_scale_alpha_beta(alpha))=
;
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_BETA]) {
> > +             u32 beta =3D nla_get_u32(tb[TCA_DUALPI2_BETA]);
> > +
> > +             WRITE_ONCE(q->pi2_beta, dualpi2_scale_alpha_beta(beta));
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_STEP_PACKETS]) {
> > +             bool step_pkt =3D=20
> > + !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);
>=20
> Would it be better to define TCA_DUALPI2_STEP_PACKETS as type NLA_FLAG to=
 avoid the u8 to bool conversion?

Hi Donald,

Thank you for your feedback.

After reviewing their features, I would think only TCA_DUALPI2_STEP_PACKETS=
 as NLA_FLAGS.

Because the other three attributes will need the ternary-state logic: (1) C=
hange to state A, (2) change to state B, or (3) stay in the current state.

Best regards,
Chia-Yu
>=20
> > +             u32 step_th =3D READ_ONCE(q->step_thresh);
> > +
> > +             WRITE_ONCE(q->step_in_packets, step_pkt);
> > +             WRITE_ONCE(q->step_thresh,
> > +                        step_pkt ? step_th : (step_th * NSEC_PER_USEC)=
);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_STEP_THRESH]) {
> > +             u32 step_th =3D nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> > +             bool step_pkt =3D READ_ONCE(q->step_in_packets);
> > +
> > +             WRITE_ONCE(q->step_thresh,
> > +                        step_pkt ? step_th : (step_th * NSEC_PER_USEC)=
);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
> > +             WRITE_ONCE(q->min_qlen_step,
> > +                        nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
> > +
> > +     if (tb[TCA_DUALPI2_COUPLING]) {
> > +             u8 coupling =3D nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
> > +
> > +             WRITE_ONCE(q->coupling_factor, coupling);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_DROP_OVERLOAD])
> > +             WRITE_ONCE(q->drop_overload,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));
>=20
> Type NLA_FLAG?
>=20
> > +
> > +     if (tb[TCA_DUALPI2_DROP_EARLY])
> > +             WRITE_ONCE(q->drop_early,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));
>=20
> Type NLA_FLAG?
>=20
> > +
> > +     if (tb[TCA_DUALPI2_C_PROTECTION]) {
> > +             u8 wc =3D nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> > +
> > +             dualpi2_calculate_c_protection(sch, q, wc);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_ECN_MASK])
> > +             WRITE_ONCE(q->ecn_mask,
> > +                        nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
> > +
> > +     if (tb[TCA_DUALPI2_SPLIT_GSO])
> > +             WRITE_ONCE(q->split_gso,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));
>=20
> Type NLA_FLAG?
>=20
> > +
> > +     old_qlen =3D qdisc_qlen(sch);
> > +     old_backlog =3D sch->qstats.backlog;
> > +     while (qdisc_qlen(sch) > sch->limit ||
> > +            q->memory_used > q->memory_limit) {
> > +             struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
> > +
> > +             q->memory_used -=3D skb->truesize;
> > +             qdisc_qstats_backlog_dec(sch, skb);
> > +             rtnl_qdisc_drop(skb, sch);
> > +     }
> > +     qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
> > +                               old_backlog - sch->qstats.backlog);
> > +
> > +     sch_tree_unlock(sch);
> > +     return 0;
> > +}

