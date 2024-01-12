Return-Path: <linux-kselftest+bounces-2922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85C82C551
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 19:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FE7B21596
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D92560B;
	Fri, 12 Jan 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciena.com header.i=@ciena.com header.b="vvjTcRqO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00103a01.pphosted.com (mx0b-00103a01.pphosted.com [67.231.152.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA125605;
	Fri, 12 Jan 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciena.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciena.com
Received: from pps.filterd (m0002317.ppops.net [127.0.0.1])
	by mx0b-00103a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CGHNZ6002642;
	Fri, 12 Jan 2024 13:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciena.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	06252019; bh=OZeYfNHIVIU7FXmQ5yB83aXnrbMEzOUfRim5OMr8VIA=; b=vvj
	TcRqOufmgVHkIPP3VfVdZ68len2b2NtcZuB5kvrFnEcCYfjmoPfEtfMSMAKdBW3p
	UBE5mdctH+AXDRVpvzZweGuCOMWJ09Oeh5cRP1H0c5hUGFunJERkMnL80cg3BCYk
	TA7IlQBtw54S453nPDDwNniv1LmPrpNPo1GLJurIuej6yK6A4/8aIJJ1msCd6XzF
	gyte0EIDXVJdFWC/vSheYEAALK/Aq+BXlFzY1Lh3xCzHpQ4cDcCdB6pojiKnufYK
	m7RaILnkyTuFVMJ0xczvKCuevX4SP+tar5XKZiI/wXeO9NF+GBm1I2snsMUlgk0m
	01+He896hX6zTrkeLDg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-00103a01.pphosted.com (PPS) with ESMTPS id 3vk1fchfas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 13:02:05 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3oDjgE/wPgaqcbd2U8zSLxqT93i4JJEmnM5wcrQK/V+9AGESgL8btu/ZDgdIZ+P9j9W6iDEQ1dQvMDJpss+rqQm+dyO5YYRDVNQoXprU6wWqR1gpTx13TmYLhxzkAT31VUQwUkaA/G6CRafs2NdsLlwPOQnimLXFbf1uK0O16WzGU5VhlLBw5UVpkLabFhCwhCe2W0QCkyWK2kTF1NgPGerF2AvSxo9WAcH34RdKPZNae59IoHP/T51iMLY6MarzRvAcvswGHC+LVaTRZvrPks2k1pyVLFlzWeSkoSYNSvzXbSGxsYHaq0DZoWDQzGFyctG35cxP7KJsJsL2TSktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZeYfNHIVIU7FXmQ5yB83aXnrbMEzOUfRim5OMr8VIA=;
 b=Szv7KdqtAqBEScP4I+tUoqXe7GuVsLwiwuDw8MLolZNyjN0w8Rb1OJF98EWGhDoyxvW4Tu25w1ThDVqcL0xllyb4DGmT0B6ezwooM4OklTru61Tdo2fosKdogSjgXVCk19nFtluTKc7yScJWTd4eoX4MZm5Y7RVao6vt3mIE8VnmaKGHjmkYOyH+XOT+R3rjRYhAI00qA1pcjszHFMAj221Ksc20sAPQ8nK+fyUMnBGSGwluzvBEY18ZNLQK/DxULfZp+Pa17Qvse4G5I9A6jXin/pFSF+7kLxXV2VEM/I8f1QDEsBJLOEU7a5zj4B9ERrhMoph0VP8jbdrqFqU2HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ciena.com; dmarc=pass action=none header.from=ciena.com;
 dkim=pass header.d=ciena.com; arc=none
Received: from DM6PR04MB4202.namprd04.prod.outlook.com (2603:10b6:5:a4::10) by
 MW4PR04MB7219.namprd04.prod.outlook.com (2603:10b6:303:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Fri, 12 Jan 2024 18:02:02 +0000
Received: from DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8183:511:ffe3:3ba8]) by DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8183:511:ffe3:3ba8%4]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 18:02:02 +0000
From: "Nassiri, Mohammad" <mnassiri@ciena.com>
To: Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        David
 Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: Salam Noureddine <noureddine@arista.com>,
        Bob Gilligan
	<gilligan@arista.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: RE: [PATCH 01/12] selftests/net: Add TCP-AO library
Thread-Topic: [PATCH 01/12] selftests/net: Add TCP-AO library
Thread-Index: AQL/yRL07Vz4QUHlRX/OLLvvAKwx3QMfkmljrnJySLA=
Date: Fri, 12 Jan 2024 18:02:02 +0000
Message-ID: 
 <DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-1-f6c08180b985@arista.com>
In-Reply-To: <20231215-tcp-ao-selftests-v1-1-f6c08180b985@arista.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB4202:EE_|MW4PR04MB7219:EE_
x-ms-office365-filtering-correlation-id: 1e2ce3db-3212-4ed9-ba48-08dc1398949e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h9a5Azks1eNhdQdqseATojJ8KIueQ5EBwr71lBdbpC7d0dzyrwjbK9FpyBu1MXPRyypVUpIy5Fx7/BcjCR+HoBa7MtMUdrtozh9ZiK0amJeMpKzO0WCPAhHDW03sRvHVrg/JmskhdU04oIRH9xtleQ3IUOMAiJDyeKGgUl/iMtFCmpLjvdGHtxEAjZIt91LGRXo5p7d5Ij15sMVHwchcQWGm2X1DYuh3YBMEWrf4bqSI9S3t3CtySQ1X5ltj4IadGacXR6mGdgika2U0DQv2h6GMhox8pcxPxgLLbtR/lzeFjmPYPdNam02z9kjk4Ek0heVzZ7YbjPq/v2zD7SLOMU8PPXttCRtRJDOBq3ycSalTIRpEKnDGVnI8nMbREBWy6P9ZXiKePRsWHprnjAGsN4nT78MtMwlthG8U270X5VidKifmLr3Jg5hlRAX/3INLPIuhVvcOzRqbJTZMS29MQ7R0Y8nljN4pdojDFneXZnSOfkhGOMrlt+Rf8cy68IHr4bL5EJ34Snv8Uts5JU6F3BTUwgL2T+3m9K8zgzpDLaSY0kmto9ZbvDOlqdziZNh/EC0fesPWeoCdWJf5/zQwNDSZl989DD/ERCGequqMTwDpNh6DY1fDFJPB5rj33Vq2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4202.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66476007)(26005)(2906002)(52536014)(6506007)(7696005)(83380400001)(71200400001)(55236004)(9686003)(5660300002)(7416002)(4326008)(41300700001)(478600001)(66556008)(8936002)(316002)(8676002)(66946007)(76116006)(66446008)(64756008)(54906003)(110136005)(122000001)(86362001)(38100700002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a3R1aWRRYUIxNUVoL1NCRXFpcHVxS1ErVXdMQ09rRHF6d1Zmc0QvcFdGaHlk?=
 =?utf-8?B?RUhUS2lINE16QVRXT0dQQkJHUFVTSkNpSnBidDdyRElTZzVjMksreXhRd1lE?=
 =?utf-8?B?Ym5rczBSZmZrSE05RTJYcWQ5ZGs3MmNXb3lXLyszYzJsYUtmQmRyWk81T1ZV?=
 =?utf-8?B?enNhMGxBeE9DTWhzb0IwN2RLUjdNZ1JBcE5oYU1LK0s4U0FTdDBDYjAwNWlo?=
 =?utf-8?B?ekZyQ2Q0YVhUV1c3VXljWEtKUzFYYitSbk01QjN3WVFENVRNWHNUMmExNTBm?=
 =?utf-8?B?U0NoSC9GaUR3QmRnelRZVmRpVlVFQVUyeHhLZ1lvblhRbnJWejR2a2VHTEMw?=
 =?utf-8?B?QS84Um4zRWRqSXZ5REVSM201Q285UnhuVDVqaEY1TWJwSEdTcEtpWWZUT0I1?=
 =?utf-8?B?Y1RTWHFjNENMTkllVHZMMkpacWdRUzk0TFZ4aHlsUkNzWFViSytLYUI5UTgy?=
 =?utf-8?B?aDZpRzE0Mm5jOTBHS3M1eWZEUVRNbm1CcUt2Z21laDJwNHJaVW5oWWFhNk1v?=
 =?utf-8?B?U1JXN0NUQWszWkVzRjJtdE9McnRuNEJNSzNXQzVPWnBmUU5zZktSTFdKcmdl?=
 =?utf-8?B?UUljd2NpcytZalpkSDB5MkI4b1A1Q3RtTEhtQ3U5cjQwS2JrR21OaGRUcnJ0?=
 =?utf-8?B?QmpnSmZ4TGlINnlONDVxSWtpY1lUSDdkZUptWEVYUCtXZWZJRmJsRG9kUzla?=
 =?utf-8?B?RGVjM09tR09DS1QxMm1ZY1BJT21nY1BuVE9aL3VMalQxVGZENHFVNnpZN3A0?=
 =?utf-8?B?ZThiRVlsT3NyS04wbkFLQ0dhejNDazRXaWtqTFZ6N2QrTHZubGhGdWtCazNP?=
 =?utf-8?B?WEw0WnZXSUY2QldMa3RPSkhjbE1FVmlEVkpLZ0hKZy9pTzgxSTUyUUVQd2NN?=
 =?utf-8?B?bnpiKzNRR1NSKzh3S2hkNjZ6M2tISXNMYUFtbUUyYmpURGVici9RTDUzY3NQ?=
 =?utf-8?B?M3FKRmVIbzdGcWlMT09leGhaM3NFQXc3Z3ZvZncvK0lnL3QyK1R2eVkwa1RD?=
 =?utf-8?B?bXB4ZXVKK3M5ZnNTZmJ5cWM3bEs1NVhWK1dMK1U5R05kVU8vKzF6VVNaQkdH?=
 =?utf-8?B?clMwUU5jSW5vdWhyeVBPaGdheXgxNDBxbVlrM0FGRDNaWThCYjZmUXp0VkFx?=
 =?utf-8?B?a3lrL1B4U0ZiN2RTRXc3YzZHT0EvekJmU0w2QkwwWXhlaTBPUTV3bnNYOG1S?=
 =?utf-8?B?VTVVWFNUa25EYk5nTkZoOTBpRzVkcEdic21BbE9rV1ltRU9NbWNvRzZDSjRP?=
 =?utf-8?B?T0JTQVNBaXAzZ0FHbEI4WUkyTnpwVzZqWk9qZTkxeVE0RkhSVjZwa29ZRzNt?=
 =?utf-8?B?bWpmdjhIaFNyVmwrbHRGTWtzVUlFZnNCNzMzOWFyWjR5c09aL1NLdjdCbXV6?=
 =?utf-8?B?NEh0OXFqVXI3OVJMTVpxSUZmekFpU29ydVFkTWtGWWgzRGlRa1I1c2RFME0y?=
 =?utf-8?B?cGZFenA3dlNkS00zSGdTUWMvNWFqYWNiOS9YcG1NcUJOeVlhbmh3ZDRXaVd1?=
 =?utf-8?B?L0dUci8rQjM5L082Y2NBdEplamxDRTA5MHJ2b2dLU1dvMlRQbDBaNWc4dzFx?=
 =?utf-8?B?QlhSOUtQbHUxZ1dTc0FXQWFaSmFiZlYyT3BFbEhHYmxwdnhZSkRyMnIzQWZV?=
 =?utf-8?B?TTRNa1VnWEhKdHFnMms4eVZsM3lzSko2Ym5mMU1JUkdaQ0U0ZDRQZkhTTm1n?=
 =?utf-8?B?Z250eXR2TTlhVm8rZWVBYzNJVlZYZDdxRGhnK1hXUnlxWE0zTkRNUTdHTnUw?=
 =?utf-8?B?dTlVQUxxSVp3azNjRDB4S00weVBpNXZOV3pUTm0rVVJBVnFWRVF5TmwxcHlu?=
 =?utf-8?B?SXk5MUIzT1FyenBQZEhQU1hwRE1oZkVFcWk2T2kvb2tSYVFOcFJHRDR2ZUtZ?=
 =?utf-8?B?MTEya3piNXpJQjIwbUJDTUVlSTU4WGM2WHQ4Z1crNGUvMURaeGRJYkFNUGRt?=
 =?utf-8?B?ZGRWbEF3RGlVV25sTFZhZ2dtQk5QS2loRTNBcysyVWtTWitXUmk0S2FMaXRO?=
 =?utf-8?B?YytCUTAxMTRxSjV0VE9DaXdSaHQ2YThIUlpzbnJkTDdoZVdsTitGQXdkV3gw?=
 =?utf-8?B?dWJxeVJGWmRxbTlrRm93V3pHdDFYMkRmM3NLbCtneUoxMkQ5M3VoRzhMSTBI?=
 =?utf-8?Q?CqXc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2ce3db-3212-4ed9-ba48-08dc1398949e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 18:02:02.9028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15mqjoPDAB409jeuvvclYVsM2GUD2BlSvrqwq7oDXXYMhwtRn08FrakKI3841+4DrfMN+GF+XoD7eTL4XgUxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7219
X-Proofpoint-ORIG-GUID: we0dvuhgVfexm-twx9470NKKNbLIkRnW
X-Proofpoint-GUID: we0dvuhgVfexm-twx9470NKKNbLIkRnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02

SGkgRG1pdHJ5LA0KDQpGaXJzdCwgdGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoaXMgdmVyeSBo
ZWxwZnVsIHNldCBvZiB0Y3AtYW8gc2VsZnRlc3RzIQ0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj5Gcm9tOiBEbWl0cnkgU2Fmb25vdiA8ZGltYUBhcmlzdGEuY29tPg0KPlNlbnQ6IFRo
dXJzZGF5LCBEZWNlbWJlciAxNCwgMjAyMyA5OjM2IFBNDQo+VG86IFNodWFoIEtoYW4gPHNodWFo
QGtlcm5lbC5vcmc+OyBEYXZpZCBBaGVybiA8ZHNhaGVybkBrZXJuZWwub3JnPjsNCj5EYXZpZCBT
LiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj48ZWR1bWF6ZXRA
Z29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVu
aQ0KPjxwYWJlbmlAcmVkaGF0LmNvbT4NCj5DYzogRG1pdHJ5IFNhZm9ub3YgPGRpbWFAYXJpc3Rh
LmNvbT47IFNhbGFtIE5vdXJlZGRpbmUNCj48bm91cmVkZGluZUBhcmlzdGEuY29tPjsgQm9iIEdp
bGxpZ2FuIDxnaWxsaWdhbkBhcmlzdGEuY29tPjsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsNCj5uZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBEbWl0cnkgU2Fmb25vdiA8MHg3ZjQ1NGM0NkBnbWFpbC5jb20+DQo+U3ViamVjdDog
W1BBVENIIDAxLzEyXSBzZWxmdGVzdHMvbmV0OiBBZGQgVENQLUFPIGxpYnJhcnkNCj4NCj5Qcm92
aWRlIGZ1bmN0aW9ucyB0byBjcmVhdGUgc2VsZnRlc3RzIGRlZGljYXRlZCB0byBUQ1AtQU8uDQo+
VGhleSBjYW4gcnVuIGluIHBhcmFsbGVsLCBhcyB0aGV5IHVzZSB0ZW1wb3JhcnkgbmV0IG5hbWVz
cGFjZXMuDQo+VGhleSBjYW4gYmUgdmVyeSBzcGVjaWZpYyB0byB0aGUgZmVhdHVyZSBiZWluZyB0
ZXN0ZWQuDQo+VGhpcyB3aWxsIGFsbG93IHRvIGNyZWF0ZSBhIGxvdCBvZiBUQ1AtQU8gdGVzdHMs
IHdpdGhvdXQgY29tcGxpY2F0aW5nDQo+b25lIGJpbmFyeSB3aXRoIG1hbnkgLS1vcHRpb25zIGFu
ZCB0byBjcmVhdGUgc2NlbmFyaW9zLCB0aGF0IGFyZQ0KPmhhcmQgdG8gcHV0IGluIGJhc2ggc2Ny
aXB0IHRoYXQgdXNlcyBvbmUgYmluYXJ5Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IERtaXRyeSBTYWZv
bm92IDxkaW1hQGFyaXN0YS5jb20+DQoNCg0KPisJa2V5X2R1bXBbMF0ubmtleXMgPSBucl9rZXlz
Ow0KPisJa2V5X2R1bXBbMF0uZ2V0X2FsbCA9IDE7DQo+KwlrZXlfZHVtcFswXS5nZXRfYWxsID0g
MTsNCg0KRHVwbGljYXRlIGFzc2lnbm1lbnQgb2YgZ2V0X2FsbC4NCg0KPisJZXJyID0gZ2V0c29j
a29wdChzaywgSVBQUk9UT19UQ1AsIFRDUF9BT19HRVRfS0VZUywNCj4rCQkJIGtleV9kdW1wLCAm
a2V5X2R1bXBfc3opOw0KPisJaWYgKGVycikgew0KPisJCWZyZWUoa2V5X2R1bXApOw0KPisJCXJl
dHVybiAtZXJybm87DQo+Kwl9DQo+K30NCj4rDQo+K2NvbnN0IHN0cnVjdCBzb2NrYWRkcl9pbjYg
YWRkcl9hbnk2ID0gew0KPisJLnNpbjZfZmFtaWx5CT0gQUZfSU5FVDYsDQo+K307DQo+Kw0KPitj
b25zdCBzdHJ1Y3Qgc29ja2FkZHJfaW4gYWRkcl9hbnk0ID0gew0KPisJLnNpbl9mYW1pbHkJPSBB
Rl9JTkVULA0KPit9Ow0KPg0KPi0tDQo+Mi40My4wDQoNCk1vaGFtbWFkDQo=

