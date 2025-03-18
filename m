Return-Path: <linux-kselftest+bounces-29345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29BA6713C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186B13B547C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD952040B3;
	Tue, 18 Mar 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eiNcMxCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1F133987;
	Tue, 18 Mar 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293690; cv=fail; b=WfjF2i8Fz/hNIMd397zKLRh18VFx4YBkFksGFCS59TPcHwqEOiIFUM++TLZAISSO1QlaXt89Ft8ULoSvwpk+y4NvVI1rCAe7gzrHw+f12BeA2QSGlnt4943YdkknO3zfHEb1uuykZr2MeqZvoPN7fq0VwNrI315Ls/vZ80hQT/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293690; c=relaxed/simple;
	bh=P/4rdgKWqHDRzHGwlnj/VZqOlh8Y7sJsQAjMifjWIfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=im9s6ujwlWVTzxr54pDlojOWMsf2+GLj0pBvaZ4sPSnNzNeRLk/yGv3zB1mnpmrNEv+MU+v9w9Ah3ZAxwAxND+JHHQUc7Lc7xutQIwHfGjxhBAUxoTKVubU+f5nz6c0A7e7ZdZtjtKkiI6GXQ9nQu0bHS66Q84zdreC9MCkgs8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eiNcMxCT; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE7OimTf4elauh5TjWVxD+Ijw/bqtYLrIp1J8oCDASvpa8AycKjconBkw5XxLtAOkvHRAeSgt3kJxa//dU3N7QV26cvJocOxMq7gCFDdcXSNuZLvb3DWomdNccUy3RWLDpJVv7k51hM9Qz62aTcL0IIO4imm2pEDpNL1AvYouzIBHdsPrga+Z8LGOCBjXZPzKBFWIVAMQY9JneKJCXvofTM+4kiFlLNRiUpziS+XxYMwG+viMJDRr+CV7cUSnuH/FPe2E84opDVJHs6iMKCS4U/YbumYmJheNTdWURTaA/DZArVvp+MoqPc1ccAsLi1devdsv92kQe4X/xnRJayNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/4rdgKWqHDRzHGwlnj/VZqOlh8Y7sJsQAjMifjWIfA=;
 b=d0glGD8D7S/Ru3Pm+ATa9jSKQAacU4qgOqyHUfNNRbGjYl7XtZfHF+XAVmK3kbNPAQJEArsNz3kLHvj7R+mfG6/gGDBCkKKcwrAl0TvWHQ2lGDhc13d626kWaeZsYIsrppyLKX8lGRnEGZjyYrh8ASzytVYpdVBq9JuRNqbYG/ECjALG973XW3jVSLerrqbDX3MtYZRHb9U9GTnvzi2cZJ9lniKDJmmhwqEi8ad2meQcuyKCWTSG9sIhgHeCfrBimnR3XmeYz6i64XdzzTdJ706fJTybSeDDuoTc0it4seYJK4j7gQ+T5v5vHkztvg8M2Pi7TSG2PCl+5ceoXdp2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/4rdgKWqHDRzHGwlnj/VZqOlh8Y7sJsQAjMifjWIfA=;
 b=eiNcMxCTvbxyoPCVYKOZSh941BMEzD1gtF4NDDchaj2rxf5idd5vNZLcUeZK6v3fpjdwp0KniK+94VT5ezB5P9n+H2khgyOg5pkmId0NipNtXDScHRMxpwg/OPOUxgPaJfOO8KrpTYqsUIKiKDplAVXzqmjnyRIhuR9amzNrJQgbWqR1nl8gz2NlOIvkdMC0rm9PhQggSBBEaR2nUMwkPuSmcrzdyiaitDKdoOCNPgXPjxZ5Jq25EjceN+45cQHeZhA/U1KveLdDlg1UKXk7qyx/pQBnqIq84r2Pplk35x2RneDPMcNraJ99naN79gJ6hLIX07DU+nAVkbAP4Nwh5Q==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7656.eurprd07.prod.outlook.com (2603:10a6:20b:288::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:28:05 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:28:04 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
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
Subject: RE: [PATCH v2 net-next 00/15] AccECN protocol patch series
Thread-Topic: [PATCH v2 net-next 00/15] AccECN protocol patch series
Thread-Index: AQHbl5yTabQzbSiAvESmQog4+aFW27N4C5SAgACllOA=
Date: Tue, 18 Mar 2025 10:28:04 +0000
Message-ID:
 <PAXPR07MB7984CE4C9F8930870712D7F6A3DE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iLQcVAwgsO-n91j48D30wwcufo72E_uS2CuppFxeUREzg@mail.gmail.com>
In-Reply-To:
 <CANn89iLQcVAwgsO-n91j48D30wwcufo72E_uS2CuppFxeUREzg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7656:EE_
x-ms-office365-filtering-correlation-id: 5cad6136-f8ff-4182-f11c-08dd6607918a
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zmt5THNiMjRzZWpiYzd1b2xHOG5OUFVQZTFYRTA5WW0zTkU0ZnVKT29IVDUy?=
 =?utf-8?B?T1kwK3FxdzM0bXN3ZW9ydlBmZm9ya3lKYWY4bzNMbDQzaS84QjloYjRTdG5r?=
 =?utf-8?B?bmVFMUNlM2RJVFdjT0pvRm9mQjZaa3JGdWxFeWtNN1Q4Y01tUVpLaFBIUHVo?=
 =?utf-8?B?K2tIa25LRWMvQkVlSVdBK0lEL1RLYWR2S3BSOG4wYTdpTnE2UmFZQ0ZsNHNk?=
 =?utf-8?B?dXROM01ob0lOS0prZWZqOHdndmVlK2RRVld4bU4rc1lqZHhJWngvaDRmK3B6?=
 =?utf-8?B?RkdIS0lYMXlOam5uOXdwU2ZyckZ5M0prUFpLS1FqcnRlN2ZVOU9DbWx3Zldm?=
 =?utf-8?B?RGRkeWpGMVBKYjFrN1FaR2JtbFlXWksvNXRtWktPMkI1dVdVb3ZJeHdveWVK?=
 =?utf-8?B?Rll0MHFocXhzOFU1MmxZZkpnQk9iVjhIdTMxcUdXRlNNaXdUOGFNWm1uSWU3?=
 =?utf-8?B?cDVLLy8vVzB5cXhVaVNsUzNaeWRmanJib2VNblNEUXBMcHVSd05RNjVSY3F2?=
 =?utf-8?B?ek1YR1RMUnpiK3dxUDdnTnN3NVp6Q0NZRTVVUkNQY0VaYUtKNE1SYmwvRW5m?=
 =?utf-8?B?MWMxRXZBL1V4STNER202OWM0eThydk1SMDZZNldwalFTUWU2clFPWW1CczMr?=
 =?utf-8?B?d0JRUGl4Ui93WWZMcEdGWVdxckl2bkVEZlpWQnpwS3dVQVZUS0dROXdCVG4r?=
 =?utf-8?B?YmdVWUZMTVU3aE1iZElsWmdUZXVtaGNTVENIYmJ5R1NXQUdxeE1BWFVpaER1?=
 =?utf-8?B?YmNSNSsrbDJmKzdPTE95aGpwTVpVZThqbEUvdzJKTDlydDBKK0twYWd3Smo0?=
 =?utf-8?B?cUJrR05OTUxZNnhrTWM3WTIrZzlhYXdkaFNyczlSUy9FY3pWelg0WlZHc05P?=
 =?utf-8?B?aVVuelZCQldISDZ4N2hxZG5KYzZia1B2VTBRcHlLWjVDRTRmbllPQmRjRWNL?=
 =?utf-8?B?WUlhSXBWM3RJM3ZLMzRwcUJuZ2FzSDErYmMveENVL21IdWVEN3JhQ1FWbnQz?=
 =?utf-8?B?RGY2SUo2UDdJbzVoTkFKeXg1eU9xcTl0ZW92TkJjS0JOemhmV0dOOE1MT1By?=
 =?utf-8?B?UmpOVGdQbFFvM00zT2ZCeUtHS1dZQkFLOHpNaUdscE9yMGpFbnV0d29NeW8r?=
 =?utf-8?B?Rmh1MEV4QkpqaVhodTNmcDhjdU14NFp2UW83V1VwTGs3bkhIUWRVL1dldHlS?=
 =?utf-8?B?TmNqaXRVUThIVDd6bEtIQXBPT3V2dEpERncrSEdhbUUxSzROVmFOSXNZajVp?=
 =?utf-8?B?UC8vZWp1VGVpWW44U1cxb1NKVHFXQVl2Y1dMTURpOUFybFpsTkphR3JvVm5H?=
 =?utf-8?B?R0FUeDZPZ2VzNzlVWjJ6Y3BHM3dSbzRoYUNCdHJyMXZqZnk2RkNjN1kxYkRi?=
 =?utf-8?B?b2NYSTZ4VXZRcXFweFk0WExLRVFTRmhaV3ZZUldyVlFZdlFUQVYrd01EVHF3?=
 =?utf-8?B?ZG5OcFMyM2poMXV2RzdSRVJtWU5pU1haTEdwNUwwNUxPdWJiOHVnWkNXa2Z2?=
 =?utf-8?B?Q0ZCcEQ4eXhDdGczSDJOK3VGblNPODE1V0I5UzVaVnovYU9HMDZNUFJrNmN5?=
 =?utf-8?B?SWpGZ3N0NkRCOEVLVGMrQXFvQy9iTjBrTnFzYXhnZkF1YjBETjRoRlcyMDV2?=
 =?utf-8?B?dlZnekVQYWNPZnd2RGRWVWc0QzlNcHRuWTR0TGNzMHVjVHN5WEdNbTJmNEk4?=
 =?utf-8?B?ZHlSM2tQLzMrNEZlUkN2TURTakgrZElWY0dKdUJyVWtzZkx5SmszaGNKc2NQ?=
 =?utf-8?B?cTNWbExQWC9aYUc4L2t6blEwR2VxSjFpaTVaWTVHK243aGpGa0hKaWw5V3dO?=
 =?utf-8?B?ZTdkTWNjc3hQc2NOMkRBZUZPWHJ5Ri9wNURtQVdlQURPNzd2amZzbmpIQjlJ?=
 =?utf-8?B?UU9mbDcwSGVFSCs4YXVxNy9YTng2blR4bS9xUEllVW1ITTZycldlRXhMNk1X?=
 =?utf-8?Q?3ppBkYg0N39C/uJe3V1YTCG+TQdv500j?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUZ3VUgyRWJsOFRHb0FwaWNMeUdqTiswd2QyYkx0Tlk5Rm1pM1FhRHd4NlBp?=
 =?utf-8?B?Q0JONTRQZHFld0NzZFZQUE9SVDdjRk9hQ1ptY1dTNndUMUpOK0FVeHdFNXhC?=
 =?utf-8?B?dG1CQklDVEoxMk9rM0ZtaldxUkU3SXJqOFZzNDBIdjAycnYxV1QyY2VJVkRO?=
 =?utf-8?B?a3pOZ2svVWh5RFF5RmI4NTlFbVI4YlFSYmM2SWpMbVd6SGhua3pKd0p3bjU4?=
 =?utf-8?B?UzdZVWNreXoyRHRVcmRkVUlHYkFiWCszVmpTaExCVDBVUTQzQVdsQjRGKzVI?=
 =?utf-8?B?VnR0TWRyTXAxMEo1YkFRcXptaUl6d2MvQk13bGdoUzl3Y1NWMkZMdG9YWDd4?=
 =?utf-8?B?anBSMHBjbEN1YzMzMGVTb0VLVmUranMxK3V4cDhVTzN6VURsSjJWUlhhTE5v?=
 =?utf-8?B?cWJjVXkzNW9Dem9uZzZGWXZQNlVkUkFNUWRQRTRWZ01Ea01UeVV6RW5OSFFn?=
 =?utf-8?B?T3lFZlhqdkVYci8xY2JVK2dFbG0rVVFzQzRtVjhFZkpQc09pYjJjZU9LZWxT?=
 =?utf-8?B?YS9yY0NiWDF0b3dTTVpUNS9XM1lnWnVkR0JxbkptYnhiRzRSQnFNYzNVMXpQ?=
 =?utf-8?B?b1dwTldLZnVlWUwxSlFxU3JsNE5yUHhKeE9ieXVtcXVMTWpwYkN2d3NZVEZH?=
 =?utf-8?B?S001MzA3RDVqbDdWeTRSQllpMUlVQkp5Y2kwdk5xdDFiN0F1Q3habGh5akFm?=
 =?utf-8?B?Zzg3c3RsQ3JwTStBNFllQ1JoOEJqYnN6djh5a0RDaUhnYzlYZWZlZFZFbVly?=
 =?utf-8?B?V042dExIR2xoVS9YTUpxc004cFpTMDJOdHhZcXA5bjE2aG9KZU5VOTRldmlO?=
 =?utf-8?B?bTZPY3o5UStLWGJUb210K0ljMzVTeTI1NEx0VjBDbkxvVEZ0VnhXQlIyRWNN?=
 =?utf-8?B?cGJobXVsSy9ZNnd6T3lkajlrUzlnaEJ4aDVidHZYWmhHSkFOci9lR3NwV2ZH?=
 =?utf-8?B?dzZTRXN2MUZBZnlqLzJsckVKaTY3VnJlSTNoN1pxMzJjamszMDlXUFljRGlR?=
 =?utf-8?B?ZkVVWHRaUlhjMTFTNExxTHBPSGtWMUFSQ1RkYisyTlppVVIvc29QOFoyZTJM?=
 =?utf-8?B?cHFTaFNsTnQxZEp4UUl2Nm41dFJyVUxrdmYyS3B5bFN5dEM4YkR1SWJvQW51?=
 =?utf-8?B?VFB6bFdLVWE0RGE4VXhhdm5IWUR2T2ZiTnE4Mnk2S3dwaUNURlF1bDNMeEVm?=
 =?utf-8?B?NHpDcXVGSHFsdzJrU2MwY3Y1OUxvckZITGhJVWRBZFluc3BSWUk0eG1SRlFU?=
 =?utf-8?B?SmpTRkIyTThkTWdSOVB4UWtrV0djSjFuWFJFN01JV2pFU1Z0aEY5Z2I0U3Z0?=
 =?utf-8?B?SGJERTgwNitJUC9DSm03anVQbWVURlYxNHRCdmU1RWt2T2dlSGlRZmNxOFdv?=
 =?utf-8?B?NW8yRCs0Z1pHUEFvWE4zb21KUUdNQTV0NExlUm1nRHpRcmNhVWUwZHJXSW8w?=
 =?utf-8?B?RkRMci9MNVlQeWg0WDcwYkhJaUJyZkNBS3BDZEd4U1FYZHRMYnZLSk9qY3dl?=
 =?utf-8?B?bGliKzdTYkN6QjU3a3psNTNnT0ZkenZpM2ZlREJGMVBnd0JMcGVzV3FlTCtT?=
 =?utf-8?B?NEtwMEZqNkRDSlJKT2JXa0swaHdWbi9IS0IvYWluTWdoZWhpdmlyYjBEOUp2?=
 =?utf-8?B?UXVuNEVNeEM4cEM2ZVlveVZNaGl2eG9PZy9iVGxJcjl4RExjQUViRFRZMFRW?=
 =?utf-8?B?YjQ2aVZIeUxBTzd1RnIzVXA0alM0SHoyMDJTc2tyWVRJYm5UbVFIQTFkWkl1?=
 =?utf-8?B?d2JaUVBtQzZFSDhhaW9NTlBvdjYwL1lzUUdWcDd6UVRtVVhOMzcwMDE1TEpM?=
 =?utf-8?B?REJtd0Uyclo4dGJqanJwMHlJelB6QWUwV1hlMmY0bzdyeEVYZlgyM0hta28y?=
 =?utf-8?B?c2VKUjZvZS83YkoySXp4WHV3VXAyUm9nK09abk5uNzJacUVtQ292dWRBYy9v?=
 =?utf-8?B?WWV3M3A3R051Tk5IbkVDcFlUTzlydkhXS2tmQ1A4ZDI1N2RMRVRpVXdxd1ZD?=
 =?utf-8?B?ekd4bTIxL3RzQ1RFQjJWSXgyR1FyeXN0aHhLOXNUUC9BQk5Ncno2VnNlSXRK?=
 =?utf-8?B?Vy82alRaWklFMmIzdEl6MFBLNjNSUDJIWUUxclhDSXNNV1lhWnpPeDVqOUpo?=
 =?utf-8?B?ZEtIWUNxUVZ6dUdUQVVaRm5QdEtUMzQzK3JVMFZyYUJwRHIrSzg4ODlrc21t?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cad6136-f8ff-4182-f11c-08dd6607918a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 10:28:04.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6f2kUnTjB3K8h52BsV2eUH7z3DBfiN9EWnqZm14uP11hM9wIXSS8PfTLYfTC78syJvYU9XuVTemZ+pGk7x+OOUDjJDg0Vej4FMEgu5nu7ZYAQqMzqUbSZmpW8OEOV3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7656

UGxlYXNlIHNlZSBiZWxvdy4NCg0KPiBPbiBUdWUsIE1hciAxOCwgMjAyNSBhdCAxOjI34oCvQU0g
PGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4N
Cj4gPiBIZWxsbywNCj4gPg0KPiA+IFBsZXNlIGZpbmQgdjI6DQo+ID4NCj4gPiB2MiAoMTgtMDMt
MjAyNSkNCj4gPiAtIEFkZCBvbmUgbWlzc2luZyBwYXRjaCBmcm9tIHByZXZpb3VzIEFjY0VDTiBw
cm90b2NvbCBwcmVwYXJhdGlvbiBwYXRjaCBzZXJpZXMgdG8gdGhpcyBwYXRjaCBzZXJpZXMNCj4g
Pg0KPiA+IFRoZSBmdWxsIHBhdGNoIHNlcmllcyBjYW4gYmUgZm91bmQgaW4NCj4gPiBodHRwczov
L2dpdGh1Yi5jb20vTDRTVGVhbS9saW51eC1uZXQtbmV4dC9jb21taXRzL3Vwc3RyZWFtX2w0c3Rl
YW0vDQo+ID4NCj4gPiBUaGUgQWNjdXJhdGUgRUNOIGRyYWZ0IGNhbiBiZSBmb3VuZCBpbg0KPiA+
IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwvZHJhZnQtaWV0Zi10Y3BtLWFj
Y3VyYXRlLWVjbi0yOA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IENoaWEtWXUNCj4gPg0K
PiA+IENoaWEtWXUgQ2hhbmcgKDEpOg0KPiA+ICAgdGNwOiBhY2NlY246IEFjY0VDTiBvcHRpb24g
ZmFpbHVyZSBoYW5kbGluZw0KPg0KPg0KPiBJIGRvIG5vdCBzZWUgYW55IHRlc3RzLCBob3cgY2Fu
IHRoaXMgYmUgdGVzdGVkID8NCj4NCj4gSSBhbSBleHRyZW1lbHkgd29ycmllZC4NCg0KVGhhbmtz
IGZvciB0aGUgZmVlZGJhY2suDQoNCkFuZCBJIHdvdWxkIGRvIHRoZSBwYWNrZXRkcmlsbCBBY2NF
Q04gdGVzdHMgKGh0dHBzOi8vZ2l0aHViLmNvbS9taW51c2NhdC9wYWNrZXRkcmlsbF9hY2NlY24v
dHJlZS9tYWluL2d0ZXN0cy9uZXQvdGNwL2FjY2VjbikgdG8gdmVyaWZ5IGl0Lg0KDQpJJ3ZlIHRl
c3RlZCB0aGUgbGF0ZXN0IG5ldC1uZXh0ICg2LjE0LXJjNiBjb21taXQgNzAyZTNmYTE2Y2Q0MmJh
NzEyODI1ZThkNjE3MWVhNDc1NWJjMDQ5MSkgd2l0aCBhbGwgNDEgQWNjRUNOIHBhdGNoZXMgKDEx
IHBhdGNoZXMgYXJlIGluIG5ldC1uZXh0IGFuZCAzMCBwYXRjaGVzIHdpbGwgYmUgc3VibWl0dGVk
IHNlcmllcy1ieS1zZXJpZXMpLg0KDQpBbGwgMTg5IGNhc2VzIGFyZSBwYXNzZWQsIGRvZXMgdGhp
cyBsb29rIG9rIGZvciB5b3U/DQoNCg==

