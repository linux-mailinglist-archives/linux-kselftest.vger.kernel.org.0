Return-Path: <linux-kselftest+bounces-33732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE580AC2CFC
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED733AF279
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862F174EE4;
	Sat, 24 May 2025 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ekQLLjIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09251BA50;
	Sat, 24 May 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748051818; cv=fail; b=sG4spoF2244e+UWa8/mf8OuckDg7cjFCApznNFYbd95oMFsjKie6wMDh8IWkO76ZvSBiBS4V5aO/0EmAxHoNG/N5Mcw9bfTee54JkaqIdWXl4dka/cN2MedXVOx0+Gkt9b4KvQbMMU+kFDsPD7VItaZ27GmudgsvZA7lx3MnE9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748051818; c=relaxed/simple;
	bh=8pbJDDCzUDxyg6SZMbZO3N3A0xo+5gHg34mGS36d6/g=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQC1yV/vYBTEWczOj0FeiMzdCKxsCbs6IhXj74EcIdLm7S1FAfBu1VMESIzxRjnM5cL8C582EvTq2g/jrB+yvMV6PXnZfTLryoL71STv5T2r/7X4lHJK/wx02/p3Bmn4+3yNIJA0STkMgPAGe911Ft+ft5tVRFSRnVHbz4tZGeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ekQLLjIw; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkVFh1e3pveG5mF1IfH/w1qJuqA3RW/La/wyQ+BDoKTnlddmweW660tY7LU2WWnlAumFkjhTOnnH9fyW+FFdGFRwE4bQrkNCWVneI2uJmoS6B8wBnX75Hv+/JnZ8zpqsBRTFMB2vLw7FuLXNlJDRBjFkOOhQ1nzkiNm4ThSvkVsMSRJH4qBrVWW3NvNR3ZDGp7Ere+iOyOh5zvHThec9ZMnM/xoCQcjQj3XWXMaRGrIpMi0cmYy1EW2h/IYbck8kMpD0gFfSLOJzUm8Owyea25AXPNtrb13HfSxxxlcjKatPPtl3dReIHi/hUY9Wolu7Ep64YFUwK3XIitqxRTyxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pbJDDCzUDxyg6SZMbZO3N3A0xo+5gHg34mGS36d6/g=;
 b=hKVT4mIWZKoXayHkCgiVsHRdZtq1wefQGn9VtbObJUZkFaQie2ZQG++fQQ+56KRblyrL9a35FgXmkaicUs+Tbh/HH/Z/RkY0/aFC0mLPiTkGtXORfopb/QdPuxA/GveJ5d6a7Uk5r/3/g5lsjEBS4/PRXyCllNOH8kuWNbNYzsZsEO4iBrtU71l00GbGVZVSUUneY8ruqZBkHmBRlKezBUBoPbbO+WSpzL970UzjlGKTm3afwYdIDceQ4AHQY1kG9BkkC+1mfh4+Epd/OlJv28e6iGjPKwFnVt0IXPHTmaX5pMA+08JC2/Prs2/+PgP7p/Ck1UURGjJEjuhGvdf13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbJDDCzUDxyg6SZMbZO3N3A0xo+5gHg34mGS36d6/g=;
 b=ekQLLjIwie6TM94SbE7frFfckEjMgOMqCK2+qzy2l45k9hbN3K5xPwsMEpE7toO+87oHHBhnrw1W6ktnjB3xMCMZzhAn+S2RVHSHMbpCZUgjIeX2/QHSm5YKyiUgoqPQXoAzWbBiNh8Q5Qu2xXsAsAVmlwFmvAepOLGkj5UqYN+BX9oBam9oUheHU71mxlWgrZE1MCiYBb7zFjX3Adlf2COwdRAUG4Dz9S/H75Q7QrM1AhCGoLCEDEssEPkwWb/A/YrKU8WLU4I9gaxyqcMuboF+uCr+34aYcyT2si5zItYenZtnE+CfJTzSDagi421tzolpqp4kihPsuJgt5EcDRg==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by PAVPR07MB9383.eurprd07.prod.outlook.com (2603:10a6:102:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 01:56:52 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8699.022; Sat, 24 May 2025
 01:56:52 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v16 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v16 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHbxfXIKcg0Ywy87Eqrd9/2jltForPbbkKAgAWTU2A=
Date: Sat, 24 May 2025 01:56:51 +0000
Message-ID:
 <AS8PR07MB7973FA10E5A3C8AE3364471BA39BA@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
 <20250516000201.18008-2-chia-yu.chang@nokia-bell-labs.com>
 <468e63af-7049-4c1e-a64d-fdbfa2b45855@redhat.com>
In-Reply-To: <468e63af-7049-4c1e-a64d-fdbfa2b45855@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|PAVPR07MB9383:EE_
x-ms-office365-filtering-correlation-id: 61de7337-62a2-46cc-f30f-08dd9a6640c1
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHo3cnNHVWJ5OC9IaHB5VHM5RktlbzZRYVRpZCtrdDlOWnpscHhyaStVS1Zp?=
 =?utf-8?B?djU1Nitvbit6SGVhNUJZU294ZHdOQ2did08wMzZSK3M1Z1dNdHF6ckgyaGdt?=
 =?utf-8?B?N25GNStQMVRZMkh3eTlEM2gvK1pCMWJrK1BrbTNuSndaTnpUVXViVW9yTFRO?=
 =?utf-8?B?ak1tZnROdnVKeW5tQVVMdGVlMklHaU8rMlRqZmw4NVhqcUx0ZVhyWjdxdGs1?=
 =?utf-8?B?ZkNrYkRkYjlwOUZ1WElUd2FTMnNGQ1h2TmhMd2tMWFRicXVHcW85K2E2V2Zs?=
 =?utf-8?B?M21vb3pOWnVvZkxRQXpMbW01SlNLRU9IVDNIQmtpWlZJN2dsREZOaWdWZmM0?=
 =?utf-8?B?azdzdzVpaklEOU1Oam9ZTWZ5MnppTnFqNHVnN0lZY1pTVG5kenpzZGNOanJJ?=
 =?utf-8?B?aFdNazFRSWdXMmxVNi9VdHJ2WDlmaE5icllpL0ZKMnlFY0dCWWNpczE3TVd1?=
 =?utf-8?B?YkY4N3JleTNFTUdYK2N2SFlQeVh5b2ptN1JRMkdiVEozekdnSERrcXgyYWhk?=
 =?utf-8?B?UTY0R01zcUwxQmFNem5KOGx5TnczTjBrSkhyM3had1cxck9zcXM1NmJQcXhw?=
 =?utf-8?B?NnRkTDEwTGVwVXUzaENJYTJvZWZoK01OY2MrMyszdzRCYjhGQWFEeTBXWitr?=
 =?utf-8?B?cjNuZ3prM1Vsb21UUk1pYnVrWEF0N25jM0dNODJlc0laaWlPYThkcXMxb1Jy?=
 =?utf-8?B?allDRjMwN01tTytGY29lQVVLN1laYXJYKzRaclI3NEZIZTZxVTVoaSt1WWpW?=
 =?utf-8?B?RkcwZUo1b05lbnFoNlJhUm16SnFLSGlEYzd0OTRTaDRodDVsY0gvNlZxcnBE?=
 =?utf-8?B?ZUlyUWZ6UC84eCs1UlZPQTRPQUFSc0xmWGdqVG5XWWZoTTV1bVJJcUp5RCtJ?=
 =?utf-8?B?d3R3NGkrZ3c5aU1tMEJlMjI0VC9qaVFqdTJ4OHliVG1oM0NRRmd6eHBFdWJH?=
 =?utf-8?B?VjlmK0t1Q3lGb0tKRmd4N1JoZWRjMlI1dDVFMHFZUzVjK3dxRkt0TzNSaThQ?=
 =?utf-8?B?SlJzZGhxM25Sd1lBekxyRnM5bmVlaVdGMTYvWnBadVY4OWwya1lQMFNOWTJG?=
 =?utf-8?B?MEZPSnU1cEZxN09uL2RQbFhLWllyYUMxekxoQ1lRS0Jrbm1IcnRpYXdwcjI1?=
 =?utf-8?B?MFEvM3F3WWlyY1BmUUxPRktUTUlLYjZJMUdiZkI4dGJRbGcxL3BIWXI4S2o3?=
 =?utf-8?B?WVF3NmNtTmxVd29zTGxnbFNNODdSdTNkR3VWTkdMQjArTmFqREx3aFdZMUR0?=
 =?utf-8?B?UHZnaVlYdUhoOENIcDdtWFYxOUxjSUJ0VlFJcC9mVGRQR0V5cGtVVWtXaFp5?=
 =?utf-8?B?LzVhRFR4T0t2NXl1RlVOc1k2UjZwRURNZ1lwZzErQVJibG0yb2RodXVsZlln?=
 =?utf-8?B?cjJENXQ5MjBGY1lZNzVOUkN4L05HbWc4Q3pkOFRpMXI4U3pZZnhUZENQSlJZ?=
 =?utf-8?B?eFNoVkRDVWRZeGRBNW5vN2h1aENodU12dWhnSFZ0dStGYm1SbVhMZjVKbjJm?=
 =?utf-8?B?d0k1bGRTNkdxSmxtYWdESmJPNUJpVk1hVWlxbFYvUHZvcXhlTTgya2RzSHln?=
 =?utf-8?B?Ylo5TXk1MW9DOVcxWHRSQWoza1lIUTBWMmxLbi83RFVZdytnd3FxbndSUlUz?=
 =?utf-8?B?WG9MdnlCK2UxSEJyVEJ5RFd5aFUrNVNReWhWTk5Wa21DcE5pSjV6WnhodnhU?=
 =?utf-8?B?clpGT1M3T0lHbVg4cTk1YWhVVmxFemZLYzRNOStQcDF2aXZGTnZMNzhPM3h0?=
 =?utf-8?B?NEphNUFxQldGWEEvNlNLbjRzckdYMElHWElNempoS004d21KRml0KzdabTRx?=
 =?utf-8?B?dmx0ek9IMGlRTmxWdXpBcHJFT05JY3pPR2dlMjdmV3E3WktNVXkwOW5nME9y?=
 =?utf-8?B?bkNGWUhMNTNZS1pFcDlUVnhVNE9JOWd4bmhZbTNaVUE3ZnNpTFZqYnE5a1FY?=
 =?utf-8?Q?ktuJojj0TqiTKNtnVIAF1GvkI9HhGQ3C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckg4MHNYMW5OQ3BQWmo1ZHF6TmJkY2ZrUDMzL0JndXlEZHpLbVdhQmM3Tk9O?=
 =?utf-8?B?SjJpL3J5cmJoMUE4MVpoTDhqU3RUOFRVenNSZ3o3d0ppR1ZiSjV1QVNBNkZm?=
 =?utf-8?B?TTRMbDVYQ1FITXdXVDNQaklndnkxbUJrd1pETzFWTkU3OFcxelc1WWFaN285?=
 =?utf-8?B?aDlwRHYrQTZXNDlIekE1clVOY2kxNXdDeFprcGJ1SExDQ2J2YldHSWlKL1U3?=
 =?utf-8?B?OC8zSUNMcUh4ZUh2eUdudTRJdFhqamxicVFWV2FBVEFDR0g3OEZ3VW8yRFRo?=
 =?utf-8?B?a2ZZMGpacStYbzRHRWJEK0kzOHFZaG1FRVk2MWlNS0NKSlZDVUJpY3J2RllN?=
 =?utf-8?B?WkRUVlVhNTFDRzRNQlA1aTN3a1pTMnRFeHBlVlRVR25oMnB0eXdVVXFoZHBm?=
 =?utf-8?B?SUJwZFdzMUdDc204YjFFSUVOb1V6ajBDRE14aG96ZXR2L1FkbThMVVV4M2F4?=
 =?utf-8?B?bHV3RFd3c1gydTY5M01tbk13Z1lxT3FjZDhoMnBETFpqa1d1bHJzSXhRLzNj?=
 =?utf-8?B?bU44SXdiQWlLWU9paXlWVkpXM0VBWVppcy9FdjNHN0syeTBVdXpMVEpaSjdL?=
 =?utf-8?B?dGJEQTJraHEvYllIZmxUd0g3QVUwcmlBeDFSTVVLWUF6bHhyaGRlWVNZVzBi?=
 =?utf-8?B?djhsTmRRQjU0WTJYVGhidHIzVi9LemIrWVFHemFQNUVoUStYSzdqUlhoemVu?=
 =?utf-8?B?LzNLaGZVL1A4b09IWGM5RFpYdmtiLzgyYk9QRFlZb0FkOEVJeXVsSy9vc0JV?=
 =?utf-8?B?QXlKV3pWN1ZBYk0yQ2lubjJMY0U5cXg4aW85TU1Wd3VXRVdFVHhLQW1xYkFW?=
 =?utf-8?B?RkZ2UzUwKzBOL0lKeXpMN0hDTHAzdHFIbHFNSUVSdEtuNVFUVXVLenUrNEZX?=
 =?utf-8?B?NEFKMCt3dXg2QnhFN2h3QlpicnVqeVQzelI1WEdxMzFqM1ZZNmE2cTVGQkt0?=
 =?utf-8?B?NWR4QXNzRlJMNndFempHVERoY0g2V3ZrbWhWYXhoMS8rdDk0dXlSU0tGQnFV?=
 =?utf-8?B?R2V0Wk0yci9LeWx4TUxtMEltMXUvOEkxTUU3akhyWTdSSnpRN3hXZlFyNzB0?=
 =?utf-8?B?QlZDdHh1SXlDc0JVMnNCSWlQSjdxYjcwMXg1YXUrcGF6WWJUWnZjTGFDMjFD?=
 =?utf-8?B?L05pS0JGUElLNTlhVjZnbHlhVlhUUUYzRGdRTVRldUpYeTh2Z2xIVXFzUkxR?=
 =?utf-8?B?STJYdEJEdnVmdmhKWm9VU3pwbjNpeDYzbjBBMURqdEFHSzg1UnIwajJlZllv?=
 =?utf-8?B?VVBkOUZoV040MGdTdnpNZXlUTnEvdVVrdThzb3VobXVKZXdEamd3TzU0TVBz?=
 =?utf-8?B?UGp0aDdNL0VaMGIzZFI1UnE2ajVwMUVuREM2cFAwbU5GUlhNeUNRVjdnZXBa?=
 =?utf-8?B?N1o1MXByVUdwandDcXNPR2JVbGgvZjc3ekNXTUFYcUpIRUtINExIZ3RHMXBn?=
 =?utf-8?B?bnNOdGgyeTgrcDArQ0RGOUpoS3JxV0U5WHo0bHhQVFhSdkpGZTdxd0VLc1Bp?=
 =?utf-8?B?cHZkVzlkeTR5dVUra09oczl2dE4yTmJlVEkyOUFXVkc0a3BKd3VuSGY5WEFY?=
 =?utf-8?B?bWtoQStZdzJRbmRwYnNrSHU3eENKTlo2VFhoM1A0bGkvL2dlRFBtL2xybjF6?=
 =?utf-8?B?UUdXMytDTjMyNy9UeXM0eUJyN0hrRUpOS2ppQVhpUmVSRE1aUkFvaW9xT3E2?=
 =?utf-8?B?MkZnU09PSHBjR1h6TGlBWFI0Q0ZFOXRGZHd3UnBwTWM4MW1LQ1pUQ3d3cU9B?=
 =?utf-8?B?eXgvajZLZXdKOFVkeHF3bzRVSGJKeCt0b2xzQTAvNGNXUGlZZ2tQK0MxMC9y?=
 =?utf-8?B?aHU1bDY5bjBMSUZQZ2VFUXJ4YUc5S1Iyc0toWFk2RTlBbjREWHNiQkxDNGNQ?=
 =?utf-8?B?dFFVYVdoM0FodjRTOUhrM3A5UzI4dm9pa0lWZ2gwaEpIamxWUHpPcXZNL09X?=
 =?utf-8?B?cjQyNmt2blVxcUpsTWRCSHlJVlFDSzFCYldWazJwQ2h3cDY1NnBabHd3OW1o?=
 =?utf-8?B?ZHhCUVFNeml6a2cvZS9zclB2MWRIR1hRa3RKZlJuQkxSMVgzSW9SbnVldUF1?=
 =?utf-8?B?eXV0ajhzTHVzNDd1OWJnODUwWEtNM0hDcm94Y0NKRGdLZHVQdVVMeVhpUXp6?=
 =?utf-8?B?TkIrd1cyazB5WUlWL3d2TGtjVHNTVUVEckJ4aWNZUnhNU01UTEFjamlseFlp?=
 =?utf-8?B?b3c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61de7337-62a2-46cc-f30f-08dd9a6640c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 01:56:52.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ul+0ZxBeKTxrE4lxjSrfaevnFeJ+Ri9o47rGARUaLDacv9hdX5zVWrfndHh/hwcsXXEzCREM/XrVhUgJFNLyCsaBb1nwhISuq3KMFY+oGTWAT4S+zb5qnV5pMJADtHso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9383

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjAsIDIwMjUgMTo0OCBQTQ0KPiBU
bzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+OyBob3Jtc0BrZXJuZWwub3JnOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgeGFuZGZ1cnlA
Z21haWwuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBq
aHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
YXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsg
bGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxs
QGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBu
b2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZSA8Zy53aGl0ZUBjYWJsZWxhYnMuY29tPjsgaW5n
ZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24u
Y29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RA
Y29tY2FzdC5jb207IHZpZGhpX2dvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxNiBuZXQtbmV4dCAxLzVdIHNjaGVkOiBTdHJ1Y3QgZGVmaW5pdGlvbiBh
bmQgcGFyc2luZyBvZiBkdWFscGkyIHFkaXNjDQo+IA0KPiANCj4gQ0FVVElPTjogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIDUvMTYvMjUgMjowMSBBTSwg
Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+ICtzdGF0aWMgdTMy
IGNhbGN1bGF0ZV9wcm9iYWJpbGl0eShzdHJ1Y3QgUWRpc2MgKnNjaCkgew0KPiA+ICsgICAgIHN0
cnVjdCBkdWFscGkyX3NjaGVkX2RhdGEgKnEgPSBxZGlzY19wcml2KHNjaCk7DQo+ID4gKyAgICAg
dTMyIG5ld19wcm9iOw0KPiA+ICsgICAgIHU2NCBxZGVsYXlfYzsNCj4gPiArICAgICB1NjQgcWRl
bGF5X2w7DQo+ID4gKyAgICAgdTY0IHFkZWxheTsNCj4gPiArICAgICBzNjQgZGVsdGE7DQo+ID4g
Kw0KPiA+ICsgICAgIGdldF9xdWV1ZV9kZWxheXMocSwgJnFkZWxheV9jLCAmcWRlbGF5X2wpOw0K
PiA+ICsgICAgIHFkZWxheSA9IG1heChxZGVsYXlfbCwgcWRlbGF5X2MpOw0KPiA+ICsgICAgIC8q
IEFscGhhIGFuZCBiZXRhIHRha2UgYXQgbW9zdCAzMmIsIGkuZSwgdGhlIGRlbGF5IGRpZmZlcmVu
Y2Ugd291bGQNCj4gPiArICAgICAgKiBvdmVyZmxvdyBmb3IgcXVldWluZyBkZWxheSBkaWZmZXJl
bmNlcyA+IH40LjJzZWMuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgZGVsdGEgPSAoKHM2NClx
ZGVsYXkgLSBxLT5waTJfdGFyZ2V0KSAqIHEtPnBpMl9hbHBoYTsNCj4gPiArICAgICBkZWx0YSAr
PSAoKHM2NClxZGVsYXkgLSBxLT5sYXN0X3FkZWxheSkgKiBxLT5waTJfYmV0YTsNCj4gDQo+IFRo
ZSBhYm92IGNvZGUgaXMgY29uZnVzaW5nLiBXaGF0IGRvIHlvdSBpbnRlbmQgdG8gb2J0YWluIHdp
dGggdGhlIGV4cGxpY2l0IGNhc3Q/IHRoZSAnKycgbGVmdCBvcGVyYW5kIHdpbGwgYmUgY29udmVy
dGVkIGltcGxpY2l0bHkgdG8gdW5zaWduZWQgYXMgQyBpbnRlZ2VyIGltcGxpY2l0IGNvbnZlcnNp
b24gcnVsZXMuDQo+IA0KDQpIaSBQYW9sbywNCg0KSSBkb24ndCBmdWxseSBnZXQgdGhlICcrJyBv
cGVyYXRvciB5b3UgcG9pbnRlZCBhdCwgZG8geW91IG1lYW4gJy0nIG9wZXJhdG9yPw0KSWYgdGhp
cyBpcyB3aGF0IHlvdSBtZWFuLCBJIHdhcyB0aGlua2luZyB0byBjaGFuZ2UgaXQgaW50byBiZWxv
dywgYXMgcGkyX2FscGhhIGFuZCBwaTJfYmV0YSBhcmUgdTMyOg0KDQpkZWx0YSA9ICgoczY0KXFk
ZWxheSAtIChzNjQpcS0+cGkyX3RhcmdldCkgKiBxLT5waTJfYWxwaGE7DQpkZWx0YSArPSAoKHM2
NClxZGVsYXkgLSAoczY0KXEtPmxhc3RfcWRlbGF5KSAqIHEtPnBpMl9iZXRhOw0KDQpCUnMsDQpD
aGlhLVl1DQo+ID4gKyAgICAgaWYgKGRlbHRhID4gMCkgew0KPiA+ICsgICAgICAgICAgICAgbmV3
X3Byb2IgPSBfX3NjYWxlX2RlbHRhKGRlbHRhKSArIHEtPnBpMl9wcm9iOw0KPiA+ICsgICAgICAg
ICAgICAgaWYgKG5ld19wcm9iIDwgcS0+cGkyX3Byb2IpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIG5ld19wcm9iID0gTUFYX1BST0I7DQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiArICAgICAg
ICAgICAgIG5ld19wcm9iID0gcS0+cGkyX3Byb2IgLSBfX3NjYWxlX2RlbHRhKH5kZWx0YSArIDEp
Ow0KPiA+ICsgICAgICAgICAgICAgaWYgKG5ld19wcm9iID4gcS0+cGkyX3Byb2IpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIG5ld19wcm9iID0gMDsNCj4gPiArICAgICB9DQo+ID4gKyAgICAg
cS0+bGFzdF9xZGVsYXkgPSBxZGVsYXk7DQo+ID4gKyAgICAgLyogSWYgd2UgZG8gbm90IGRyb3Ag
b24gb3ZlcmxvYWQsIGVuc3VyZSB3ZSBjYXAgdGhlIEw0UyBwcm9iYWJpbGl0eSB0bw0KPiA+ICsg
ICAgICAqIDEwMCUgdG8ga2VlcCB3aW5kb3cgZmFpcm5lc3Mgd2hlbiBvdmVyZmxvd2luZy4NCj4g
PiArICAgICAgKi8NCj4gPiArICAgICBpZiAoIXEtPmRyb3Bfb3ZlcmxvYWQpDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gbWluX3QodTMyLCBuZXdfcHJvYiwgTUFYX1BST0IgLyBxLT5jb3VwbGlu
Z19mYWN0b3IpOw0KPiA+ICsgICAgIHJldHVybiBuZXdfcHJvYjsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIHUzMiBnZXRfbWVtb3J5X2xpbWl0KHN0cnVjdCBRZGlzYyAqc2NoLCB1MzIgbGlt
aXQpIHsNCj4gPiArICAgICAvKiBBcHBseSBydWxlIG9mIHRodW1iLCBpLmUuLCBkb3VibGluZyB0
aGUgcGFja2V0IGxlbmd0aCwNCj4gPiArICAgICAgKiB0byBmdXJ0aGVyIGluY2x1ZGUgcGVyIHBh
Y2tldCBvdmVyaGVhZCBpbiBtZW1vcnlfbGltaXQuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAg
dTY0IG1lbWxpbSA9IG11bF91MzJfdTMyKGxpbWl0LCAyICogcHNjaGVkX210dShxZGlzY19kZXYo
c2NoKSkpOw0KPiA+ICsNCj4gPiArICAgICBpZiAodXBwZXJfMzJfYml0cyhtZW1saW0pKQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIDB4ZmZmZmZmZmY7DQo+IA0KPiBQbGVhcyB1c2UgVTMyX01B
WC4NCj4gDQo+IFsuLi5dDQo+ID4gK3N0YXRpYyBpbnQgZHVhbHBpMl9jaGFuZ2Uoc3RydWN0IFFk
aXNjICpzY2gsIHN0cnVjdCBubGF0dHIgKm9wdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spIHsNCj4gPiArICAgICBzdHJ1Y3Qgbmxh
dHRyICp0YltUQ0FfRFVBTFBJMl9NQVggKyAxXTsNCj4gPiArICAgICBzdHJ1Y3QgZHVhbHBpMl9z
Y2hlZF9kYXRhICpxOw0KPiA+ICsgICAgIGludCBvbGRfYmFja2xvZzsNCj4gPiArICAgICBpbnQg
b2xkX3FsZW47DQo+ID4gKyAgICAgaW50IGVycjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFvcHQp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICBlcnIgPSBubGFf
cGFyc2VfbmVzdGVkKHRiLCBUQ0FfRFVBTFBJMl9NQVgsIG9wdCwgZHVhbHBpMl9wb2xpY3ksDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBleHRhY2spOw0KPiA+ICsgICAgIGlmIChl
cnIgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKyAgICAg
cSA9IHFkaXNjX3ByaXYoc2NoKTsNCj4gPiArICAgICBzY2hfdHJlZV9sb2NrKHNjaCk7DQo+ID4g
Kw0KPiA+ICsgICAgIGlmICh0YltUQ0FfRFVBTFBJMl9MSU1JVF0pIHsNCj4gPiArICAgICAgICAg
ICAgIHUzMiBsaW1pdCA9IG5sYV9nZXRfdTMyKHRiW1RDQV9EVUFMUEkyX0xJTUlUXSk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgV1JJVEVfT05DRShzY2gtPmxpbWl0LCBsaW1pdCk7DQo+ID4g
KyAgICAgICAgICAgICBXUklURV9PTkNFKHEtPm1lbW9yeV9saW1pdCwgZ2V0X21lbW9yeV9saW1p
dChzY2gsIGxpbWl0KSk7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICBpZiAodGJbVENB
X0RVQUxQSTJfTUVNT1JZX0xJTUlUXSkNCj4gPiArICAgICAgICAgICAgIFdSSVRFX09OQ0UocS0+
bWVtb3J5X2xpbWl0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBubGFfZ2V0X3UzMih0
YltUQ0FfRFVBTFBJMl9NRU1PUllfTElNSVRdKSk7DQo+ID4gKw0KPiA+ICsgICAgIGlmICh0YltU
Q0FfRFVBTFBJMl9UQVJHRVRdKSB7DQo+ID4gKyAgICAgICAgICAgICB1NjQgdGFyZ2V0ID0gbmxh
X2dldF91MzIodGJbVENBX0RVQUxQSTJfVEFSR0VUXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgV1JJVEVfT05DRShxLT5waTJfdGFyZ2V0LCB0YXJnZXQgKiBOU0VDX1BFUl9VU0VDKTsNCj4g
PiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGlmICh0YltUQ0FfRFVBTFBJMl9UVVBEQVRFXSkg
ew0KPiA+ICsgICAgICAgICAgICAgdTY0IHR1cGRhdGUgPSBubGFfZ2V0X3UzMih0YltUQ0FfRFVB
TFBJMl9UVVBEQVRFXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgV1JJVEVfT05DRShxLT5w
aTJfdHVwZGF0ZSwgY29udmVydF91c190b19uc2VjKHR1cGRhdGUpKTsNCj4gPiArICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgIGlmICh0YltUQ0FfRFVBTFBJMl9BTFBIQV0pIHsNCj4gPiArICAgICAg
ICAgICAgIHUzMiBhbHBoYSA9IG5sYV9nZXRfdTMyKHRiW1RDQV9EVUFMUEkyX0FMUEhBXSk7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgV1JJVEVfT05DRShxLT5waTJfYWxwaGEsIGR1YWxwaTJf
c2NhbGVfYWxwaGFfYmV0YShhbHBoYSkpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAg
aWYgKHRiW1RDQV9EVUFMUEkyX0JFVEFdKSB7DQo+ID4gKyAgICAgICAgICAgICB1MzIgYmV0YSA9
IG5sYV9nZXRfdTMyKHRiW1RDQV9EVUFMUEkyX0JFVEFdKTsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICBXUklURV9PTkNFKHEtPnBpMl9iZXRhLCBkdWFscGkyX3NjYWxlX2FscGhhX2JldGEoYmV0
YSkpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaWYgKHRiW1RDQV9EVUFMUEkyX1NU
RVBfVEhSRVNIXSkgew0KPiA+ICsgICAgICAgICAgICAgdTMyIHN0ZXBfdGggPSBubGFfZ2V0X3Uz
Mih0YltUQ0FfRFVBTFBJMl9TVEVQX1RIUkVTSF0pOw0KPiA+ICsgICAgICAgICAgICAgYm9vbCBz
dGVwX3BrdCA9IA0KPiA+ICsgbmxhX2dldF9mbGFnKHRiW1RDQV9EVUFMUEkyX1NURVBfUEFDS0VU
U10pOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIFdSSVRFX09OQ0UocS0+c3RlcF9pbl9wYWNr
ZXRzLCBzdGVwX3BrdCk7DQo+ID4gKyAgICAgICAgICAgICBXUklURV9PTkNFKHEtPnN0ZXBfdGhy
ZXNoLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdGVwX3BrdCA/IHN0ZXBfdGggOiBj
b252ZXJ0X3VzX3RvX25zZWMoc3RlcF90aCkpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgaWYgKHRiW1RDQV9EVUFMUEkyX01JTl9RTEVOX1NURVBdKQ0KPiA+ICsgICAgICAgICAgICAg
V1JJVEVfT05DRShxLT5taW5fcWxlbl9zdGVwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICBubGFfZ2V0X3UzMih0YltUQ0FfRFVBTFBJMl9NSU5fUUxFTl9TVEVQXSkpOw0KPiA+ICsNCj4g
PiArICAgICBpZiAodGJbVENBX0RVQUxQSTJfQ09VUExJTkddKSB7DQo+ID4gKyAgICAgICAgICAg
ICB1OCBjb3VwbGluZyA9IG5sYV9nZXRfdTgodGJbVENBX0RVQUxQSTJfQ09VUExJTkddKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICBXUklURV9PTkNFKHEtPmNvdXBsaW5nX2ZhY3RvciwgY291
cGxpbmcpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaWYgKHRiW1RDQV9EVUFMUEky
X0RST1BfT1ZFUkxPQURdKSB7DQo+ID4gKyAgICAgICAgICAgICB1OCBkcm9wX292ZXJsb2FkID0g
DQo+ID4gKyBubGFfZ2V0X3U4KHRiW1RDQV9EVUFMUEkyX0RST1BfT1ZFUkxPQURdKTsNCj4gPiAr
DQo+ID4gKyAgICAgICAgICAgICBXUklURV9PTkNFKHEtPmRyb3Bfb3ZlcmxvYWQsIChib29sKWRy
b3Bfb3ZlcmxvYWQpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaWYgKHRiW1RDQV9E
VUFMUEkyX0RST1BfRUFSTFldKSB7DQo+ID4gKyAgICAgICAgICAgICB1OCBkcm9wX2Vhcmx5ID0g
bmxhX2dldF91OCh0YltUQ0FfRFVBTFBJMl9EUk9QX0VBUkxZXSk7DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgV1JJVEVfT05DRShxLT5kcm9wX2Vhcmx5LCAoYm9vbClkcm9wX2Vhcmx5KTsNCj4g
PiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGlmICh0YltUQ0FfRFVBTFBJMl9DX1BST1RFQ1RJ
T05dKSB7DQo+ID4gKyAgICAgICAgICAgICB1OCB3YyA9IG5sYV9nZXRfdTgodGJbVENBX0RVQUxQ
STJfQ19QUk9URUNUSU9OXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgZHVhbHBpMl9jYWxj
dWxhdGVfY19wcm90ZWN0aW9uKHNjaCwgcSwgd2MpOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4g
KyAgICAgaWYgKHRiW1RDQV9EVUFMUEkyX0VDTl9NQVNLXSkgew0KPiA+ICsgICAgICAgICAgICAg
dTggZWNuX21hc2sgPSBubGFfZ2V0X3U4KHRiW1RDQV9EVUFMUEkyX0VDTl9NQVNLXSk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgV1JJVEVfT05DRShxLT5lY25fbWFzaywgZWNuX21hc2spOw0K
PiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgaWYgKHRiW1RDQV9EVUFMUEkyX1NQTElUX0dT
T10pIHsNCj4gPiArICAgICAgICAgICAgIHU4IHNwbGl0X2dzbyA9IG5sYV9nZXRfdTgodGJbVENB
X0RVQUxQSTJfU1BMSVRfR1NPXSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgV1JJVEVfT05D
RShxLT5zcGxpdF9nc28sIChib29sKXNwbGl0X2dzbyk7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICBvbGRfcWxlbiA9IHFkaXNjX3FsZW4oc2NoKTsNCj4gPiArICAgICBvbGRfYmFja2xv
ZyA9IHNjaC0+cXN0YXRzLmJhY2tsb2c7DQo+ID4gKyAgICAgd2hpbGUgKHFkaXNjX3FsZW4oc2No
KSA+IHNjaC0+bGltaXQgfHwNCj4gPiArICAgICAgICAgICAgcS0+bWVtb3J5X3VzZWQgPiBxLT5t
ZW1vcnlfbGltaXQpIHsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IgPSBf
X3FkaXNjX2RlcXVldWVfaGVhZCgmc2NoLT5xKTsNCj4gDQo+IEFzIHBlciBjb21taXQgMmQzY2Jm
ZDZkNTRhMmMzOWNlMzI0NGYzM2Y4NWM1OTU4NDRiZDdiOCwgdGhlIGFib3ZlIHNob3VsZCBiZToN
Cj4gDQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gcWRpc2NfZGVxdWV1
ZV9pbnRlcm5hbChzY2gsIHRydWUpOw0KPiANCj4gL1ANCg0K

