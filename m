Return-Path: <linux-kselftest+bounces-3046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB882E293
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5307B21F80
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE151B5AA;
	Mon, 15 Jan 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciena.com header.i=@ciena.com header.b="KujgO9kC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00103a01.pphosted.com (mx0b-00103a01.pphosted.com [67.231.152.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88B1B598;
	Mon, 15 Jan 2024 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciena.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciena.com
Received: from pps.filterd (m0222748.ppops.net [127.0.0.1])
	by mx0a-00103a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FH1xWf015027;
	Mon, 15 Jan 2024 17:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciena.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	06252019; bh=Cs1hwOLKD0SP4PC9GaR8xTMJti5VZ0vs/+joRT20ym8=; b=Kuj
	gO9kCelWiAce5rQQuzDATGa3XcvADVCEFxpOg31YG4lase0NWUY2rS1udMUmOrtQ
	50RlztRUN73XL3+AqOcT96hXg+vpGVO4yVMr3J15QrLakN4IfWE/m8ykd8rWmhL9
	Q3MtsZGrdA0XXriL8oGkmbu/3jHlb4A09oMJv5L0VJdxPcHJE0N2GIHqNT6oLx8i
	3GxtpwrpyK4TLyuf5FHehHGwkeJ4JEgaEW7WGJsi0aOWCTrPVSQsulRgQtQFNxpH
	PXlIXrQEGIYa59HcGA6VDPRA0VI9sBfRL/F6rmIM9WOscz9ZwrJ2YufCLVO2+KZC
	EfcW6yNPRHmfhjqyE+g==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00103a01.pphosted.com (PPS) with ESMTPS id 3vn8rf8ngf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 17:26:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5D9OmJZ7RvdXCJZHkB44EwY7RmEm2JKMLEE1OjvASJ0Az66sCM/IZC0CZyPjF06gcQWtqPyo4TcSURih1MiPmWkK7JQ+sSghpHsFvwP0hsVEbQqWrnigDBvd9mqP7n7Ysp6xINrsA/wy9FLsKoY2yeth/7z4zR3g+lsyg5GIFEA6hnWpArHEe9v6eU549JKJ3uKp2rCGIiO5v94YcU8qwocqpRs5k5YImu84qj9DQr/mpe8hq3CEKMm/bEkukrosAoJom4lYUxUgJulsWZ5CLwB6jQaeSVCont9xuk25B+7Es6T+N8TyU2UR0q22JPOGhyAY4mbaf4GCMyCioIElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs1hwOLKD0SP4PC9GaR8xTMJti5VZ0vs/+joRT20ym8=;
 b=allBmHVcmbe1EdQewapvjYzd4c1s05SPyBAwVY8QuoL4tcx3tlHW+5ON1Dsmy8lZiUgI7OkW+BwFcKy5oe+KIhXQTAAHqkGkkBGRp7U+c+piXHyH9jxYDhBog9xdbqjCw97Kgr4D642a6wEJZSkQGyYbPu25n5Jbwlg28PibdDYp0DckTRl5ypFlZiPaESN6DnTBKjK4PATvgyjJ62dYo3U/+DjPwBx/Trp5zYpfXy4ANB6TEscs77C8gSc5oLHBdCD4RR5Vi/2uV/FrdpbigIblikUX1neWfA45H2wDP1k4Qi7M2h8t7B/wOISoFFOxmAyUyhTdqVgYaZKewYF3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ciena.com; dmarc=pass action=none header.from=ciena.com;
 dkim=pass header.d=ciena.com; arc=none
Received: from DM6PR04MB4202.namprd04.prod.outlook.com (2603:10b6:5:a4::10) by
 MN2PR04MB6992.namprd04.prod.outlook.com (2603:10b6:208:1e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 22:26:54 +0000
Received: from DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8eb7:a1d1:4c02:b0cc]) by DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8eb7:a1d1:4c02:b0cc%2]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 22:26:54 +0000
From: "Nassiri, Mohammad" <mnassiri@ciena.com>
To: Dmitry Safonov <dima@arista.com>
CC: Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine
	<noureddine@arista.com>,
        Bob Gilligan <gilligan@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dmitry Safonov
	<0x7f454c46@gmail.com>
Subject: RE: [PATCH 12/12] selftests/net: Add TCP-AO key-management test
Thread-Topic: [PATCH 12/12] selftests/net: Add TCP-AO key-management test
Thread-Index: AQHaSAHxqo2ktKsSeEq2JzFnkYj51g==
Date: Mon, 15 Jan 2024 22:26:54 +0000
Message-ID: 
 <DM6PR04MB42025A244BDCA74021B3746DC56C2@DM6PR04MB4202.namprd04.prod.outlook.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-12-f6c08180b985@arista.com>
 <DM6PR04MB4202DA43D14985A28055CE0FC56F2@DM6PR04MB4202.namprd04.prod.outlook.com>
 <934627c5-eebb-4626-be23-cfb134c01d1a@arista.com>
In-Reply-To: <934627c5-eebb-4626-be23-cfb134c01d1a@arista.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB4202:EE_|MN2PR04MB6992:EE_
x-ms-office365-filtering-correlation-id: 68cca344-91a5-4d07-5749-08dc161913ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Q3eLVxx0rplTNxL56RCoVxusPgV0Jz41+HYhjBrHGlpjvmpwEsn0cOr/e2aYLMs5uvO2m7Wqg8bYXFhiQBpDu4vOvudZ8Kn1xw0/ou1c9+gRCVTObMnv7DEQYJ2QAA2TLk08oYBBXtYQ5nQHPqDrrewuWHnn91EoBCX3BgATeQLovF+sqV3Fw7wnQIi1QcmRczyV9vQHPVExQralXXRJTXRHHZrdDBvP8MYVatEVg8eggA0WbEvqokDdJe1ZNAL63HUeu7Y6HgcczZe5pekN5xss2VJ4f4lX0TtHpW2vuS2cYnmxZp/du4+0fnWfaptOML5QDw0yfb/flNXBHGyBtkMbEjwhWrOS6Hn+Tm0oAG2u/7xGQuH37lJOR6jllWEVSJ3iyt6t4Ud9KQXMKoGh5OnRQX5szAjbZTwPDwKqZKvvqKE+/UYlQ2Px8bjvEzo/S21PiGfRnYWKnntwpdm79W0Gp+DpB9O1MgZYVPRl/3Epem8d/bilYCaxF7RrF/zutJOP4gt6Mpyz+ACNA+Fk+EzFGF1yrt1X1Cgl+pS99K5n6vyW8qz2xwJIq9B2lW5nenFasbV4gu9Q9yFn94g0jrz3PV/PIKTuQPyMZG11gmamfsbjteYSDCuUdnkZ0b++
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4202.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(71200400001)(7696005)(54906003)(316002)(8936002)(66446008)(8676002)(478600001)(64756008)(83380400001)(76116006)(6916009)(55236004)(6506007)(9686003)(26005)(66476007)(66946007)(66556008)(2906002)(5660300002)(52536014)(4326008)(7416002)(41300700001)(33656002)(558084003)(38070700009)(38100700002)(122000001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TTlFWndMR25IS01tV0JqOUVLZXpWbm1vVEpZTVI5cHVOZEZjUmVaeC82aHc2?=
 =?utf-8?B?aVZXbGdQRjNKTldlMzZxVUR4eXR4MDUyK3BvaE0xMzBvTVl2dzlwS2l4Ykpx?=
 =?utf-8?B?Q0hNd1Q5Z0ZYUGlMc3Jib29qYjg2bUJCYlZCQlBKeXJLZXlna2ZVZUdENTJT?=
 =?utf-8?B?Q2V1a0k1Z29OR0xUYmRUUUVTY0RLZUMwemNjWWdlUWhnSzFrS2RZMSt6ajJF?=
 =?utf-8?B?NUxFVEhRY0lNOFEzL1RnUFR0MTZFWWZpZzZMMFB0ZWgvd0FVa3pTbnNTM1dj?=
 =?utf-8?B?RWpxaFJMcC9jc1o3Mnd6U3VzWmh4NHFUVFlSZTIxcEpOVUg2ZmNla0dHSXYr?=
 =?utf-8?B?M3VkSDVRRFBwVTRMRldpeCtYSkd0RklsaFpHa0FVZCsvRmpGWHVLNzEyY3JQ?=
 =?utf-8?B?WnRuT21GWC9CS1U2WmdSdDZTTVFUMUJhMXoxT0t0QmN4ZE8vaU95ZUF2M09t?=
 =?utf-8?B?anpqSXhhRUhJS25QOG1aOElyMkdqTnRYYjI3RXloOHk3VUl2SW5lSUorb2JI?=
 =?utf-8?B?WHJ0Qlp2aWx1SHZpbUgwVVN4S0YrNlFxM3JVS2YzaC9NMVJSR3pxRTI3ZEtr?=
 =?utf-8?B?dHFKQytwR2FSeVE2dGdyTFVra2RjaWp2c2kwNXNzTHdTRG8vN2p1cGpneTRx?=
 =?utf-8?B?cWhoWmtJZHMyOEppSFNVSlFiTG5nZi80T1k3Nm1KODlEcnYrWE8xQnhsOW5u?=
 =?utf-8?B?S1BMa0dMQUZkcjUwVmV4ZHpqczlSZEt1U0orWnZWOS82aGpoSytxZUd6NEF2?=
 =?utf-8?B?NDE4Z3IreURWcmpid3VIZHBVOEROS1ZrZmh1SEZHQVZNcHZaWVVYUDVYSWVr?=
 =?utf-8?B?cFN0Z3B2bFVzR1hNbFU3TWZZNnduWkNxeTdJNWRVMU8rTHdxMlR4ckxBbk1n?=
 =?utf-8?B?a0dmTGk4Ull1TGp3OHVKSXhRV056Tk84cXVFU0hXNUZXaFpRNFh6eWxuQTFK?=
 =?utf-8?B?SGc5aTlWM2QrbzVuNFdrYkhNU0ZjL2hzODdJdFZzd3NlY2cyWUFkSTJKMDlW?=
 =?utf-8?B?UitBNlZHQWhlZHovODg2ZU1JYlREeWVubks5QllxZ1NXUEpMN1huUkdrZTRJ?=
 =?utf-8?B?T0pVNlhDcm5ybEJOaXdiTzgxci93RWNaSEcrTW0xV3RTYjQ2MnprdHFlNVNO?=
 =?utf-8?B?cm1Lb1NnVzIrRXlQRXVtdXFtSjZubzFLYllJZUpJalJyK0hyVExEMmprQ1NJ?=
 =?utf-8?B?bHhVZ3VoZE5QNm5mNWU5UEhTVkxhUXp2blZHbEpvNllQNHU5cTZwdlNzQWF4?=
 =?utf-8?B?WXV0MXVEUjNzSlcwbk5FUU01M0JRWTgyeUNHZ2NMY0hTRVNpOHd2WkV1aUhS?=
 =?utf-8?B?eVFHRVYvTjRic2ZBT2ttMXBab2pPNVZiT0F5NVRUcWFSN0kvaHVWcThHR2hN?=
 =?utf-8?B?K1l3aEZHMmlNL3Racit5N0VJdlBLd2phRDV4QmhlaFRueDUxS0JaZUNTeS8z?=
 =?utf-8?B?dG05WVk2MVJBTFFNdllWRmdQODc0U3pNUjZYem1pL2J5TnUxM2FrdGRwZVR6?=
 =?utf-8?B?TWJSQkl4Y3FJMjUvMVovdlVDaEdiN2NJcGRrRitweTlkWUtlMmN1cmZadW1Z?=
 =?utf-8?B?bU5SL2VtUTVHSmJMZzMzaXNJdzBlOStadDRoMDAvejczU1daRVFOam5HTUt3?=
 =?utf-8?B?U004YzBjQ1VETnlIVXRNZXNSWFoyREcxL2ZhcXpMeG9reDFGVXZ4OGpTa1k5?=
 =?utf-8?B?em45NWhFZElvR1pDUlpQSm1JZXRVSWw1UG4rL0JKclNmNC9PNWZWUGlKS0Y5?=
 =?utf-8?B?UGs3a0lDa3hzNFBLcFZ2TUc3QVRVdjNobW15N3RaaUpjT1ZLdzh1RHY0ZURW?=
 =?utf-8?B?YmZ1YXYveUpZK1NrMW04UjZQRENSbGxRMEI4UytoUVZTV0M3MWJFaDZLVi9j?=
 =?utf-8?B?dzgvUW0rQitLWUwzZlpjMHpHR3ZTb3kyRDhYQ3BOUCtacXhtVnhYSm5qZ044?=
 =?utf-8?B?bmc5cE1OTDFqTUczNlU4a09qV2JiZTBDR2JKeFB1WjN3cDY2WWpjcDNhOWl1?=
 =?utf-8?B?K0dPWFg3UlBaYXZNZVVKQXNTNzQ0TXBlVVFqMExBdWc4OXBBSUh0Wm1NaU1y?=
 =?utf-8?B?ZmpQcS9Wam9IUWluejd4V1ZPWWtOUGhNOG5DMnBhMFVPeGk2K0NRNGUxWnRY?=
 =?utf-8?Q?Uu6jiCfFic0/cXYKEjQMBBHpc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ciena.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4202.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cca344-91a5-4d07-5749-08dc161913ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 22:26:54.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an10Bct/lmtltDpmxC+NUYOGrOFv/ohRHelhlsAv38sxCQi5pfZrVxPnCoCRth/wd6fsCepCjxxwoqZjXCYLHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6992
X-Proofpoint-GUID: OMdEqGEOiJ_6vHD0qeICOU8O41YxZRVd
X-Proofpoint-ORIG-GUID: OMdEqGEOiJ_6vHD0qeICOU8O41YxZRVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02

Pj4gU2hvdWxkbid0IGl0IGJlIHJldmVyc2VkIGluc3RlYWQ/DQo+PiB2ZXJpZnlfY291bnRlcnMo
dHN0X25hbWUsIGZhbHNlLCB0cnVlLCBiZWdpbiwgJmVuZCk7IFRoZSBzayBpcyBhbg0KPj4gYWNj
ZXB0IHNvY2tldCBhbmQgdGhlIGZ1bmN0aW9uIGlzIGNhbGxlZCBieSB0aGUgc2VydmVyLg0KPg0K
Pkdvb2QgY2F0Y2ghDQo+RG8geW91IHdhbnQgdG8gc2VuZCBhIHBhdGNoPyA6LSkNCg0KWWVzLCBJ
IHdvdWxkIGJlIGdsYWQgdG8gc2VuZCB0aGUgZml4LiA6LSkNCg0KVGhhbmtzDQpNb2hhbW1hZA0K
DQo=

