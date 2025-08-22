Return-Path: <linux-kselftest+bounces-39671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C235AB314BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92112567B0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF12296BB5;
	Fri, 22 Aug 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mscUGdYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288281724;
	Fri, 22 Aug 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857316; cv=fail; b=JLmbMk3QpmO+g3D+L9+T2TAcb98Se9u4C2h+UMvpl8sp8+HwLbc2m9a02DpJvoXUZsbFVDdjosvjYY+dQKVF83aQ98p5GVSyES12Wd7qp/gYG39OdGzwyJ/FMGT5fnL3j5tf5qxZdF0At2e8UFuotrY/Lpiib6/MbcEMB/bXz2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857316; c=relaxed/simple;
	bh=O2yVT6F7PaWb/5ImOZpFd5UAUQ4agUL5DZpZ1VCeTQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=idoErK/zM/AoHEk/9+58hPwayVmRPB29xTkti80q7uQMtT4eU4bPqXxg22OuEy09kLyzCV6jl4ANUEeP/E5SsCmyuP1ZSiCB6IVWjhQHbtNjNbuumuJxXJ9ov5GDSvG63wgUx58yadZCr+DEunTQjwDbe6V7ifnNOlaGdx9CdY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mscUGdYE; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukv8bkSoTW0Ltp1jYM8il7s74lnSyLfi5TxOKFfmy7jctajY8nynlnitutvTaJoLCe9kdLOVlaRAo/4i66W/Roo8xftNKL6Cw0OTwQ3nN6AjMY+fOlugTzKsGcqTvJTImNhiFFhReXzd5MkEv57I5SvA8W/w4tQiHk6KaISxxRucZCVWT3NKRF8jHi1FedFqguWyeISjvIzFQrftvdDDDNLKQ/+cIJoOfTtnE/+WaDA6HGK3ZDdc27sd4esePps03f6fhjyYT0rLSwkzdXvheeIZocMcIUUGaESA7GPQcTRWibIQInjKzAn+OEA61hzJuN6bnKADiRivbIPd1JeLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2yVT6F7PaWb/5ImOZpFd5UAUQ4agUL5DZpZ1VCeTQs=;
 b=PwSgAUsw7f5BjqN0S0Xhn04JaCjE8rJXAf0kciXV5awJGcftziQ6H14O/0eZ+cZqQgbteiXszKGrAWHDY76PoKtR/1gqen/N+XkqhGNWQhdUvWLpQZ1HyMFTX5FwPGCgRoPhu0mvnRdNPmGPnEeUhj8bU3lAhbw538Ip93PEhc0vyRizbaN4n6op269Kvqgg25AnTDIOKeA6lHlyWUZ6RXcdbL/di++fMMBKxFyzyYMCSPF4b7Y1Qf26O3X+1E3K7txXbgemumZ1EVvDi8a8+lAUTv67tt/M0a/cLugGtSelJ84jIisYVWGY6XQlW3gpn0innZ883BFT2Hn7z3mRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2yVT6F7PaWb/5ImOZpFd5UAUQ4agUL5DZpZ1VCeTQs=;
 b=mscUGdYETRkOwLhwiHZQth5pDbLgUZCb1I36efwbEfWm+GXOGndMteqw1cjsi1WhrH2U8YQ6ozpJ6M0sL76Vkb7bf2bAZf+QJt5oE+dLTwGb0AYyi4TzO9IBplblnM4LGg8ZfSFUyBJ3TLG4U1p1c4R459kKPzwNbUTy5ZV1vC+KacssW5qVaiXPksDDtlpZUrLV3jEmwa6BPERaw1SJ+nk/HiwbW9vsqS1qBL5wu0LOWq3lJf4GS+e4mmNZsGZXdWqmLjKnVFiuLugA73vVeJ0ITnQyo697dE4qeaoEC8E11lDRpGbbOAhfmSRqN3ceUoXPzH/fmTCxkNNXO8LPeQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB9203.eurprd07.prod.outlook.com (2603:10a6:102:2e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 10:08:31 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:08:31 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
Thread-Topic: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
Thread-Index: AQHcDcA2AIwBPxWnqkOwSfa4J0QbTbRtHLYAgAFfEwA=
Date: Fri, 22 Aug 2025 10:08:31 +0000
Message-ID:
 <PAXPR07MB798400D4AC41A3347A52283EA33DA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iLFEM+mbU2d0AEH3O+3zg5Cwm7pdmaadUxXifUqLuaQLg@mail.gmail.com>
In-Reply-To:
 <CANn89iLFEM+mbU2d0AEH3O+3zg5Cwm7pdmaadUxXifUqLuaQLg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB9203:EE_
x-ms-office365-filtering-correlation-id: 2011b7ce-738d-4311-8fee-08dde163d8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STVBajVlNUdhVHlzTzg5T0hML0N0UW0xdUhDVnFLZW5hQW56TkxaVndld3lp?=
 =?utf-8?B?V3JOZXN2UXAzZStCUnVPeGRlYzN1VitJRXB0S0tySEphSFRSQVJHR21rSXBq?=
 =?utf-8?B?a1FLMkg4d01NdklIbmIzSnFsamQ0RWRIcDU4RFpwbDdCbUhhZldmU01yR0Zp?=
 =?utf-8?B?V0xKS1ZaaUtXcjlMOGpxY3Nza3VPcjVueURNUnFvNGc3WWNpZURmOFJ2Mlpj?=
 =?utf-8?B?V3I2TXNORlQ3MXY3QzNHWmQzOEZnSENTY3pkTWgvb0loemp6RFlONlh2NTlH?=
 =?utf-8?B?RWU1ZDZaSTVoZFdncUgwYTdtbHBncnpIV2loQXlZOStFSk9RUVNlRjZOaWdl?=
 =?utf-8?B?N3MrL2VQS043cHQyVUVjSjJQVXh2STNqUlZjN0ZSYmlLNE1nUUFhK0toeDdr?=
 =?utf-8?B?eWN1OUxlNEM3Z09ybm1IdTRUUUYyZWdGNUl4clpmSFNPUXNGWEFNTkwxaFBV?=
 =?utf-8?B?WUlVWXV1NzE5MTRQU2xSbGJLUlB5ZDJGUU9YK3ZSeHA2Q1ZiZndwTE45N0g3?=
 =?utf-8?B?SzZqQmszRFNGNHpPZ3I5bDN4SWlOenI0TGVpWjA1RlU5djZmUEMrYzBxZXd1?=
 =?utf-8?B?TExvZWFMd21wMDBnc0RFVy95cllLSlNDNVdvTU1VcXBNTzFhUW0vT3NiUkZo?=
 =?utf-8?B?blpnZk1nYjEvQmVYeXNRcGhqdWd5aXUvVXRTV0JTb0ZLT2k5SEFzSW5iMUc5?=
 =?utf-8?B?bG40R0svMHVxWHVvZ0FEU3hrUngvMjY0UUhCd0Jzc1BnUUFRa2RrQXptaDJC?=
 =?utf-8?B?Rmdtb2Q0bzk4SkVZZjZSdThxaWlHcTR1Z0lMV3Iwa2lKZEkyeDVhbGRPc0p0?=
 =?utf-8?B?L2dFak9RZ25BM1ZPQ3d6c1lTSjNFeVR6cmc4aGRmblRIWkdLWldBMzJqZlBH?=
 =?utf-8?B?T0N1UjVKRzdNYUJmZEdlb3daZUV6YXVWdHVvdm9rVEJkc1MzOEhWYXJrbzVp?=
 =?utf-8?B?aWJaUGxvSHNwRFdKSmI1MVZlMGVTM0dEdFRCYnFCNld2aVdHZ0l1Rkt3bVM3?=
 =?utf-8?B?QWVkb1VtdUV6dWwyUDJJMmtGQ1RWdys3STM2WUlscUpUZUJkS3dJTDVnS1pt?=
 =?utf-8?B?Uk96aWFOaVlpakY1aUVGQ0pOU0tnZnBLM2ZpK2dVSTB2S1BDb2grdmMyNUFi?=
 =?utf-8?B?bGtyQnFPSDYzYWVRcmNwRTVFekRsM3J0Zy9VU3ViQWgvK1JvbjdYYXVQV3hF?=
 =?utf-8?B?YVhDQUI4UC8vd0svYmdYU1YvN0tnRW5KdHZ3VXVlV0lkbTJaS2phRlBzbUlO?=
 =?utf-8?B?ZURHSW44Z1RDZy90bG5wMkRYWElqUGMyTmx4dW4ydGlOSnVYb1pmaXd3R0RN?=
 =?utf-8?B?SVF6azlRVnZITlRKUS9vTnQ1VFl6VUR3eXVuMkNLUHVrNXBGTGExcEpNM0JX?=
 =?utf-8?B?c3Y1bldGS2U0V08rK3FZY3czNEdESWp0K2poMVQxYlA5M2hyRG4wWVJobXNx?=
 =?utf-8?B?MFFGMVcwcVZHMUREbExlRXJZQlEzUmpIODdzaGIzbm81NUVyQ1U2UHVEQ0h4?=
 =?utf-8?B?OGxKd1pxdEhMTS9mcVhQT1pVL3pzaWIvR2FjQ0VqRWYrVitBNkloQUhnMXlq?=
 =?utf-8?B?aWdRSnFXbGt6ZWtPcW4rd282ZWtyNElubHEramhlVXZ0MVRaUExhYnNXUGVI?=
 =?utf-8?B?K3pWNlFNMmt1c1cxMi9jNjlPdlJhNUpiWVBkc0w5Q0UxaGdEdGhrQmMzcG5E?=
 =?utf-8?B?ODExaUZMSk8vY0UrV1dpZVg3bm1ZK2w4cjFXbHEyOTNJdFM0MnBIVk53MTlV?=
 =?utf-8?B?Tk9oODMzTDRZMXZNc0xJcVlUekdXZ3lVOXdscTRjZjM3RFBSeVZwbXRjbitK?=
 =?utf-8?B?UHVZeHIzNC9FYURZYnBWL2FYYmVmWWFCcHNPSFVxVkFFNGozclJ2T0lJSEh4?=
 =?utf-8?B?dVJnaU9NcC9TSkFNY2VCUUlNbDNGb29saHZhL3B0L0czMGRqNkFVeis0ODNx?=
 =?utf-8?B?cUwweWRwS0p0T09kY0NRNDRiRGNlZ20vdGhCSDF2ZExndlZQamJEbzl4OFVU?=
 =?utf-8?Q?qxobA9IQz5OCWpFoosoDBl4S+VAPqE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDhoME4yOEZLTTBQWTc0VEcvZUUvcjVMUTVtaE9BbGM2ZjZPUGhYV3hjUWRp?=
 =?utf-8?B?TjY3b0JPSDJGY3ljbWIwYmFTcVEwTm5FZHRxQnI5TkFwZTl0cHp0TkJpZ012?=
 =?utf-8?B?K29iN05Pd29OREszMS9qSW91N3NDSzlQc292cXo2Ni9ySDRoN3ZxamxIYTl4?=
 =?utf-8?B?bG4zaUJhemFWa1lZZkk2Ujk2bWN1cTJOaDJkU3Y3VTBPOFIvRmFQdVpmUC9v?=
 =?utf-8?B?MEtXdm44VnRtVWpIQWFabzRzWjRNYTVSQmZobWFYZ0duS1AvVE5Od0dJQ2Iz?=
 =?utf-8?B?Smo5dkdOUWs3a08zRVlTekhtVFBIbXg3cGluSStVNGNNWXZTNko1WkNXMkpp?=
 =?utf-8?B?U2JoeTlISzluT1pOVEFyS05ta09tTWtvZnRZRCs1ZnNSSVUwNUNJRytCampO?=
 =?utf-8?B?cXZjZjR1bFQ4MjdEZExDazVkcEd6OU1HMEtJODU2dkdMaENMakFnWC9DZ2dC?=
 =?utf-8?B?VGlzSHJpN01DVS83REpOS1BEMTVXNUI5dzllMEJPOStHL3k1bEVCeFUvSCtV?=
 =?utf-8?B?T0VLRm1uUFF3YkNaOWtGVjBaS1JIaGNMVHg3bzJRbGVRVXR6amE0QW0wSUJQ?=
 =?utf-8?B?QW1iY3ZFT3FMODVJUUVORk9MQklRSTYrQ3FJN0VpYkFWV1BHU0p2UkFXNk5h?=
 =?utf-8?B?TDZOcWtOaExmTnBTWmhuSjRmYWhqV05Ya1pkY0xNOGRoUlZIbGcyTmhudUtz?=
 =?utf-8?B?Ni9rS256WlZrb3RvWmljNGtBMmE4N0VrUGU2S0NiVzBmMHhzRDRNWDhJV2Qv?=
 =?utf-8?B?ZjYwZ0xMcXNsdVA4MHJyVWd6alVxdHdkQkZ1Qk5vZXQxa3l5UDRjUUNYZFVC?=
 =?utf-8?B?bUlnY05tb2pJMUJnYmkwd0dRQWUrRjZkTFJJWDdLRXptcXV4V3Foa2ZXL2pY?=
 =?utf-8?B?Q1dBWHBjUklRUXozakhEeEFsRHBCZjcwNXpmRDV2YlFjNFBVL0tKNEhLOSsy?=
 =?utf-8?B?SmM5QTJGTEsrUWkyYUpFRlV0MjlMWXljRENRbGhMajRqZ0VQNmh0a2Jpbk1u?=
 =?utf-8?B?cm0zTTVER0tsdzNMckU1bDEzOThPWXRQT0wrVzNQTVY3QWxhemRUMEVtMHkx?=
 =?utf-8?B?Z29LTUpDbkJLclBlcWZRdGYzR1F1M3FEeGlVbnJIMEU2SkIyN2dRR2p4NXFJ?=
 =?utf-8?B?K2wzUHN2T01vbUpjMzVWUEJISmNtQSsyRGNwSkFiTzQ5SmJVMWxWa1podWtp?=
 =?utf-8?B?T3pwMlNYL3h1WFROcE4yZm9sVHY1K2FmL21EV0tEM2YxL1VLUmVXUG9EejVN?=
 =?utf-8?B?cXFUTDlFUzdXYUVUemlYdXY4OHZsSmdrOFJyb0ZrV09TblBnZXhNQ29MQkV1?=
 =?utf-8?B?dk5nWFJPbzNScE0wQVR0dW8wTU5GRzVnbk52OEs5cEloWUFmMytQaTdib3My?=
 =?utf-8?B?Q2xxOUh4WDYzSkUzMXkya1BEVkpwUlFXYXdKN1B6WUdHY0o2dGt1MjVLSDY2?=
 =?utf-8?B?ajcydkJIL3c2SFV0WW5uZTgwVGtRVDBIRmJrS2lESnV3Y3pCQ3ZRWkh5WjlW?=
 =?utf-8?B?Y29OSUtYMzRLeTYvUmYxNEdKSHRtOUR4Mm50WWxWM2JuMkwvTjliZHljTkMy?=
 =?utf-8?B?bUc4K0FQMjBaMGwxTnU0dEpqTjJJOEdaRVc5M0VobWVyNFVrVHZteS91dSs0?=
 =?utf-8?B?T1pweENOQlhXNlA2aVRCQ1NRMzFjZmhYVXlkN0g4WTJoejIxTytrOGducGpz?=
 =?utf-8?B?RWJWQ1IybWdRQ3lPcCs3L1VHM0gydThLcm92Wmh4NmpobTVxQ1M4bFlBaDho?=
 =?utf-8?B?ZERIbDRpQ0NRMXRPQXNHU2tKTnZXQnlMSEV4dUVYT1llTFYxSkZub0M4Y1BJ?=
 =?utf-8?B?cWZBN2lHK2VPOGJDU2FRVDdvWGYzNEM0cEFQTkZJNnY3bFhiMFpJa1VXNDFX?=
 =?utf-8?B?OGJUZ2NzWlArRWdYOFFDOTVNb2NWUG91VTBZbWpUa3VIY0xTc0xSdm5jalV2?=
 =?utf-8?B?SldYTkg1Yng4Sy9McUFQREwyM24vUW85b1YyaHlzOUZrSzBrY1RiVjBUbmFL?=
 =?utf-8?B?eUViVm85Y1Nza2ppeFR6MElkTjQyamszaHFOQTduY3M3K3YvWE4wZzdtVk83?=
 =?utf-8?B?ZDFxQzJtaGt1SzNOYzdsUUliT3hPVTc4NmZDdkc4TTcxTHdYaTcxZEVpYTlx?=
 =?utf-8?B?TlAxLzYzUUsyanFFZGxjRkxIZ2RaVm5XdW9VOENqSzMvWGNvU1MydDNlSGw4?=
 =?utf-8?B?WlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2011b7ce-738d-4311-8fee-08dde163d8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:08:31.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/u/lTew7GYfJeYw3nxkUt0NuNo8OXUwyRMI9lY72JUVHYHaXHFLGONygfeds+Ds/5JSuYmT8YnbkNS9YMHEaxe/412ok6MdkDMHdI5BFgZ86qVfamhMnXGrFRLQe2SB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9203

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDM6MDQg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5v
cmc7IGt1bml5dUBhbWF6b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtl
cm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFp
bC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRk
ZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1
aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERl
IFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47
IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207
IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmll
dGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE1IG5ldC1uZXh0IDE0LzE0XSB0Y3A6IGFjY2Vj
bjogdHJ5IHRvIGZpdCBBY2NFQ04gb3B0aW9uIHdpdGggU0FDSw0KPiANCj4gDQo+IENBVVRJT046
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBj
bGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQv
ZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBGcmksIEF1
ZyAxNSwgMjAyNSBhdCAxOjQw4oCvQU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5v
a2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBBcyBTQUNLIGJsb2NrcyB0ZW5kIHRvIGVhdCBh
bGwgb3B0aW9uIHNwYWNlIHdoZW4gdGhlcmUgYXJlIG1hbnkgaG9sZXMsIA0KPiA+IGl0IGlzIHVz
ZWZ1bCB0byBjb21wcm9taXNlIG9uIHNlbmRpbmcgbWFueSBTQUNLIGJsb2NrcyBpbiBldmVyeSBB
Q0sgDQo+ID4gYW5kIGF0dGVtcHQgdG8gZml0IHRoZSBBY2NFQ04gb3B0aW9uIHRoZXJlIGJ5IHJl
ZHVjaW5nIHRoZSBudW1iZXIgb2YgDQo+ID4gU0FDSyBibG9ja3MuIEhvd2V2ZXIsIGl0IHdpbGwg
bmV2ZXIgZ28gYmVsb3cgdHdvIFNBQ0sgYmxvY2tzIGJlY2F1c2UgDQo+ID4gb2YgdGhlIEFjY0VD
TiBvcHRpb24uDQo+ID4NCj4gPiBBcyB0aGUgQWNjRUNOIG9wdGlvbiBpcyBvZnRlbiBub3QgcHV0
IHRvIGV2ZXJ5IEFDSywgdGhlIHNwYWNlIGhpamFjayANCj4gPiBpcyB1c3VhbGx5IG9ubHkgdGVt
cG9yYXJ5LiBEZXBlbmRpbmcgb24gdGhlIHJldXFpcmVkIEFjY0VDTiBmaWVsZHMgDQo+ID4gKGNh
biBiZSBlaXRoZXIgMywgMiwgMSwgb3IgMCwgY2YuIFRhYmxlIDUgaW4gQWNjRUNOIHNwZWMpIGFu
ZCB0aGUgTk9QcyANCj4gPiB1c2VkIGZvciBhbGlnbm1lbnQgb2Ygb3RoZXIgVENQIG9wdGlvbnMs
IHVwIHRvIHR3byBTQUNLIGJsb2NrcyB3aWxsIGJlIA0KPiA+IHJlZHVjZWQuIFBsZWFzZSBmaW5k
IGJlbG93IHRhYmxlcyBmb3IgbW9yZSBkZXRhaWxzOg0KPiA+DQo+ID4gKz09PT09PT09PT09PT09
PT09PT09Kz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Kw0KPiA+IHwg
TnVtYmVyIG9mIHwgUmVxdWlyZWQgfCBSZW1haW5pbmcgfCAgTnVtYmVyIG9mICB8ICAgIEZpbmFs
ICAgIHwNCj4gPiB8ICAgU0FDSyAgICB8ICBBY2NFQ04gIHwgIG9wdGlvbiAgIHwgIHJlZHVjZWQg
ICAgfCAgbnVtYmVyIG9mICB8DQo+ID4gfCAgYmxvY2tzICAgfCAgZmllbGRzICB8ICBzcGFjZXMg
ICB8IFNBQ0sgYmxvY2tzIHwgU0FDSyBibG9ja3MgfA0KPiA+ICs9PT09PT09PT09PSs9PT09PT09
PT09Kz09PT09PT09PT09Kz09PT09PT09PT09PT0rPT09PT09PT09PT09PSsNCj4gPiB8ICB4ICg8
PTIpICB8ICAwIHRvIDMgIHwgICAgYW55ICAgIHwgICAgICAwICAgICAgfCAgICAgIHggICAgICB8
DQo+ID4gKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tKw0KPiA+IHwgICAgIDMgICAgIHwgICAgMCAgICAgfCAgICBhbnkgICAgfCAg
ICAgIDAgICAgICB8ICAgICAgMyAgICAgIHwNCj4gPiB8ICAgICAzICAgICB8ICAgIDEgICAgIHwg
ICAgPDQgICAgIHwgICAgICAxICAgICAgfCAgICAgIDIgICAgICB8DQo+ID4gfCAgICAgMyAgICAg
fCAgICAxICAgICB8ICAgID49NCAgICB8ICAgICAgMCAgICAgIHwgICAgICAzICAgICAgfA0KPiA+
IHwgICAgIDMgICAgIHwgICAgMiAgICAgfCAgICA8OCAgICAgfCAgICAgIDEgICAgICB8ICAgICAg
MiAgICAgIHwNCj4gPiB8ICAgICAzICAgICB8ICAgIDIgICAgIHwgICAgPj04ICAgIHwgICAgICAw
ICAgICAgfCAgICAgIDMgICAgICB8DQo+ID4gfCAgICAgMyAgICAgfCAgICAzICAgICB8ICAgIDwx
MiAgICB8ICAgICAgMSAgICAgIHwgICAgICAyICAgICAgfA0KPiA+IHwgICAgIDMgICAgIHwgICAg
MyAgICAgfCAgICA+PTEyICAgfCAgICAgIDAgICAgICB8ICAgICAgMyAgICAgIHwNCj4gPiArLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0rDQo+ID4gfCAgeSAoPj00KSAgfCAgICAwICAgICB8ICAgIGFueSAgICB8ICAgICAgMCAgICAg
IHwgICAgICB5ICAgICAgfA0KPiA+IHwgIHkgKD49NCkgIHwgICAgMSAgICAgfCAgICA8NCAgICAg
fCAgICAgIDEgICAgICB8ICAgICB5LTEgICAgIHwNCj4gPiB8ICB5ICg+PTQpICB8ICAgIDEgICAg
IHwgICAgPj00ICAgIHwgICAgICAwICAgICAgfCAgICAgIHkgICAgICB8DQo+ID4gfCAgeSAoPj00
KSAgfCAgICAyICAgICB8ICAgIDw4ICAgICB8ICAgICAgMSAgICAgIHwgICAgIHktMSAgICAgfA0K
PiA+IHwgIHkgKD49NCkgIHwgICAgMiAgICAgfCAgICA+PTggICAgfCAgICAgIDAgICAgICB8ICAg
ICAgeSAgICAgIHwNCj4gPiB8ICB5ICg+PTQpICB8ICAgIDMgICAgIHwgICAgPDQgICAgIHwgICAg
ICAyICAgICAgfCAgICAgeS0yICAgICB8DQo+ID4gfCAgeSAoPj00KSAgfCAgICAzICAgICB8ICAg
IDwxMiAgICB8ICAgICAgMSAgICAgIHwgICAgIHktMSAgICAgfA0KPiA+IHwgIHkgKD49NCkgIHwg
ICAgMyAgICAgfCAgICA+PTEyICAgfCAgICAgIDAgICAgICB8ICAgICAgeSAgICAgIHwNCj4gPiAr
PT09PT09PT09PT0rPT09PT09PT09PSs9PT09PT09PT09PSs9PT09PT09PT09PT09Kz09PT09PT09
PT09PT0rDQo+ID4NCj4gDQo+IEl0IGlzIHVuY2xlYXIgaWYgdGhpcyBjaGFydCB0YWtlcyBpbnRv
IGFjY291bnQgdGhlIFRDUCBUUyBvcHRpb24gPw0KPiANCj4gQ2FuIHlvdSBjbGFyaWZ5IHRoaXMg
cG9pbnQgPw0KDQpIaSBFcmljLA0KDQpBYm92ZSB0YWJsZSBkb2VzIE5PVCB0YWtlIHRoYXQgaW50
byBhY2NvdW50LCBhbmQgdGNwX29wdGlvbnNfZml0X2FjY2VjbigpIGlzIGRvbmUgYXQgdGhlIGVu
ZCB3aGVuIGJ1aWxkaW5nIHRoZSBUQ1Agb3B0aW9uLg0KDQpXaGlsZSB0aGUgVFMgb3B0aW9uIGlz
IGFkZGVkIGJlZm9yZSB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCwgc28gdGhlIGltcGFjdCBpcyB0
aGF0ICJyZW1haW5pbmcgb3B0aW9uIHNwYWNlcyIgb2YgdGhlIGFib3ZlIHRhYmxlIHdpbGwgYmUg
cmVkdWNlZCBkdWUgdG8gVFMgb3B0aW9uLg0KDQpEbyB5b3UgdGhpbmsgYW55dGhpbmcgc2hhbGwg
YmUgYWRkZWQgaW4gdGhhdCB0YWJsZT8NCg0KQ2hpYS1ZdQ0K

