Return-Path: <linux-kselftest+bounces-2923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7082C5A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 19:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B106B2354F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA98156E8;
	Fri, 12 Jan 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciena.com header.i=@ciena.com header.b="g7hU7ooB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00103a01.pphosted.com (mx0b-00103a01.pphosted.com [67.231.152.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E7154BA;
	Fri, 12 Jan 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciena.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciena.com
Received: from pps.filterd (m0222748.ppops.net [127.0.0.1])
	by mx0a-00103a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CGMUA9000474;
	Fri, 12 Jan 2024 13:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciena.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	06252019; bh=CA8k6xDFotwZUDdLRwBvq5Lrcm+/zjLT/DWYWAQ8C0A=; b=g7h
	U7ooBYbzEs8bqx2jt04yVRQDYVUK2mrXiEsA6FwWHkJEMsDiQvZ2m5W5rrzrW73e
	MCQ0g09aewIjIHOQJjCbDQ0vp5vZVjKZwBY8ywqbe6U77KCpZg4RyvL3OgDxE10d
	dXfOni0zklUKA4mYNi/ODXfYlN3xxQ79b/DJskRw6HIJQxsWfcYBg9FuWfQgJjxI
	40oBLTnoEdwf0ENi1tyO7e1SOD9vwl+1gEf0iCirJ8LlW8pEZfJOGUb8t6bOFsB8
	HgwjqS0pcsYgmqg4nO4y5ATcJ9hDVML/tRq1eOMFKEBVUne3h5Nc+cvKrVEV4fu0
	nlHKKDOAJYeaCAtId2w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00103a01.pphosted.com (PPS) with ESMTPS id 3vjydx9vxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 13:57:38 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA3jphrIWzfrGEUzYFda50dbtB1UHfcM0ZMjUikVCL58+liD9X4jVJ84lBUeINjwzy6/o7nvOaymhJ5VkNgg1YWEpsAbkonCYVaac8EOKSw1zXbxISwUcIXctRg337jwH2UWa8qBrWi03yvkFcJLB56MRLATDXqfIyJAqrTcq+ls36ToX0MpZ6NxReP6od2t1fwVZKM4QSiBBpKZrkzO1gGOnQ6oCecjdhcO3HxPKbjFL0G2ukCalQh3swMDYqT1X/TgEbcnxdXFM5pI7rXbPfwMmKHrRqONSLTq3RFbtt7Wy34PedHNTcCg2eiO+bpt3B3VBpkvyd4WJoU38ncNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA8k6xDFotwZUDdLRwBvq5Lrcm+/zjLT/DWYWAQ8C0A=;
 b=QuZcb9VPGwUPa4OiIdRpmrk8WzrwtHZeAgauiXLabLIsOVRrrGPhzmngkmbaulugH+nFMma+uEbG4v/5wiasqyG+J5gD/w7gdaLXS0wkEaU7LkuchTA4nSGXDCMZWG9RfEDnduqaCmDKrc19wwrwDvr3BFhMQeeETGTCPODpxpryXKg8q29VqdkXGl5lw0inHtCoL+5wmb200WWJ8IHJa3gHt0yzrvkmN2Efca1GU5aLLAj34XQ5Te+btITK5e5nyFqOu/INpVBRnN16jDhBrd2XU6fPwXxGlh84znPPVRT/OBW6/PUXOlPHi43HtS6uatUNQoCKjqqTDXoCHtY+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ciena.com; dmarc=pass action=none header.from=ciena.com;
 dkim=pass header.d=ciena.com; arc=none
Received: from DM6PR04MB4202.namprd04.prod.outlook.com (2603:10b6:5:a4::10) by
 PH8PR04MB8589.namprd04.prod.outlook.com (2603:10b6:510:258::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 18:57:36 +0000
Received: from DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8183:511:ffe3:3ba8]) by DM6PR04MB4202.namprd04.prod.outlook.com
 ([fe80::8183:511:ffe3:3ba8%4]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 18:57:36 +0000
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
Subject: RE: [PATCH 12/12] selftests/net: Add TCP-AO key-management test
Thread-Topic: [PATCH 12/12] selftests/net: Add TCP-AO key-management test
Thread-Index: AQL/yRL07Vz4QUHlRX/OLLvvAKwx3QJ7u8yPrneeBVA=
Date: Fri, 12 Jan 2024 18:57:36 +0000
Message-ID: 
 <DM6PR04MB4202DA43D14985A28055CE0FC56F2@DM6PR04MB4202.namprd04.prod.outlook.com>
References: <20231215-tcp-ao-selftests-v1-0-f6c08180b985@arista.com>
 <20231215-tcp-ao-selftests-v1-12-f6c08180b985@arista.com>
In-Reply-To: <20231215-tcp-ao-selftests-v1-12-f6c08180b985@arista.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB4202:EE_|PH8PR04MB8589:EE_
x-ms-office365-filtering-correlation-id: 787deb4d-d449-4d4c-7464-08dc13a05771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ucnSR0vJR9W/FGHkh/6KXPzs5dizVLPOFyOF61g7YSzUn1Rvq5hmOYp1MuWFLBdboGied9ZsnwaGn10Mk9glLOhT9ZjTJ8Rb8HRVzLmh89mIm0qDK0AUB+DUp2+oPdTJBs+uPCcy3cl6Y1F98xriQ1QOCs/33SpX5qGKhuiPuyw4j2/mrK0Y8lUhR3lytqgclshoJ7lEAjpi04AfZbKN8VS+wds8sIBlVlGnrUyGWMbVhsH9Qp+VF1P11YdIr7w4JKtvqbmhm0yrGvsRj1oKyo9sxME5HtKdN3LvQiU2uMTP7OuTGG3qfXtXmUI7TiTlzARdj+7ui2uuLdWbUYdU2q7TfKyvy9sVxQ7dXfdxB1gMgKP0/UkKKAHVN4cniXmc/Aw6kXpYAKsiSpMO4awVtVIvgdgNPXPYAFeJJdTXFIm78WdQ6f6jhKhtQKVjHRA93phKWXXUrACM7sxzKhy15y3pedBsY6supRI7PFUSMCeckiCWn6rrQXNKbtI5Ce/7/3ql4HAIzCo9zmA3ITHPwu1vOm6gkeaqhCxqIa6BXq+a5NY7r9psDwWNnxQTtgJEL1joqRFb1I05R7rAV63kHP6l5kOkcf12wXmsHcHh80CdyLNwIvaDBqeuLRh3TM+V
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4202.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(55016003)(33656002)(9686003)(26005)(478600001)(7696005)(6506007)(38070700009)(4744005)(2906002)(5660300002)(7416002)(64756008)(110136005)(66946007)(76116006)(66556008)(66446008)(66476007)(54906003)(38100700002)(71200400001)(52536014)(55236004)(8936002)(8676002)(83380400001)(122000001)(4326008)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SDZsdmQvd1Bqc0lkWkFTVVBCUkc3eVJqeTA4TzJwcVVpVjlNQ2RuUmIwdWsv?=
 =?utf-8?B?d0oxalZQVHBQaXFUUlN5TmJsNVBUbklqUXRKT1gwbWhuRFBYUms3ME9Ec2c4?=
 =?utf-8?B?N1laK0RFUmRkUFAxWU5kMENEcDFsMzZQQ0NFTzQzd2lFWHRIMzFiUDRYS0FV?=
 =?utf-8?B?azdxY0NCNWt0bVVrTlRROWd0Zi9iWW5BU0U2cDdjQzlXcjF3eDVhUDd2VVlJ?=
 =?utf-8?B?SEZZZHJyRHcyV0tCRTVkWmp3ei9jWlVOOFE5eTJ4K3hsU2l4Z1V3bnpCRlU5?=
 =?utf-8?B?UkpDRUl0d3N0d1FuT2NVVlhiNmFQWUJJeFlsRXNwNnp5enZGOXlUQ21YMUM0?=
 =?utf-8?B?bDVacXFhc0RRRFhzUEtBdFRjR0cwWTBycFUrU3YrSG5OYmtLR3NJcW1sMjNQ?=
 =?utf-8?B?bmMvYWNONEdaZjMyUklCQWU4TGJzbXZoSDNLV0lOMW5tNFdmN0RpK1BYZUJD?=
 =?utf-8?B?aXN4WDhtYnZGZThPN2RDV1VzV0Y0S0trdzd5aExBYWhLL2RxbTgzbmQ2TjF5?=
 =?utf-8?B?WGoyNnNrOHRDS0dwQXNmM2REdjhxOUVocGwwdWlDb1JGc2NBa3R6Yjdpbkpw?=
 =?utf-8?B?R09UazdZVDFUUEM4MVNSaDg0cGE0ZU1wZUZFeDBDUEM1SE90M0RjSTlaUGYz?=
 =?utf-8?B?UXBVVWZnWW92SFRvdXVWbEhqakpNbkNOc3QxSUxjQnR2d2pzUWtXcTBMK2Qx?=
 =?utf-8?B?UThWSGN6NWtLMW91LzBsdEdodGxicXJMQ01yN2dFdVpkLzVGRkFZcEJtdXRk?=
 =?utf-8?B?OG02VnNybTcwemZoN2dxL1o3R3hjRnUyVEZYWW9qem80ejNkdm1HNDVPSlhT?=
 =?utf-8?B?Z1VvSnJhWm56b01qNGQ2Y201SFBkZUF6ZTVPNWVmMVZEMXpTWUkwOVpGTWZ5?=
 =?utf-8?B?aklLYXFJWDVkZy9neERHMnNLMWhpL3VyNE1PMEJzb3loMmhoMTNLcDFtVjJD?=
 =?utf-8?B?bkYwdmhQb2pHamNZdVliekVUM2w0dWErTFdEckVxNDVNam5nS3N4MjV1ZEpZ?=
 =?utf-8?B?S1phT2dJbXFKaERnb0dCZFg0VG1Kc09LY0UwUy9Mbm5ydGtNbHZwSjZrQzNX?=
 =?utf-8?B?Ui9UOEQyMG04MmI1Z0lSZitRaUVnQWhGUkFEdG1nakF0ZThDaHFlQjI0UzJx?=
 =?utf-8?B?TUNaVU40VEFSWHZ2ZGJScnFuUE9QYWozVGtKZ0I5bHh2cGdJZXV4U1VseThp?=
 =?utf-8?B?Y3QwTjNvNVVMTUFKcDVEaVVINVBONS94UFZjeFF1MmRKci9mc3lIb2YvSktX?=
 =?utf-8?B?NG9kT3lxWnQrSktNaFJib2p4L1liejJyWHJVejMwWkJMeGdFRVVTVzBSTjJo?=
 =?utf-8?B?TGRxWC95d09QbFU1ZDlkYVZVLzR4MmxWdmZuTVhBSmpRUE1FenFucHNDS052?=
 =?utf-8?B?WldBdWZqUjA3ZEtnQTAzNWVjTGFwbGU2alBZODZvdDB1V2JSSFRqRlRiRVN2?=
 =?utf-8?B?V3RJNXErQWVYWWVkVlN4aHB4MkEzRGNNZ3JOVjhNZGNueVozQ21nTjN5aUtL?=
 =?utf-8?B?VjRrczR0VTNBaVpHL3M0RTJyVzJ5dUhlL1NIeHdjaUM1cjBOR3RVaDkyYWFC?=
 =?utf-8?B?L2RmRmZSV1hRTDFBZTNPN1l4ZDdxTFBFZWN2eWpOQ0ZTb0t2Vk52WGc2V2F6?=
 =?utf-8?B?VkNzdk9TUUhoODFqUFl2Mk5SUWZBRXlJZ3o1bzAyZld6WnJwY0hqQnJ0WW1I?=
 =?utf-8?B?dDhpeDV3N2t1T1FwcmJZV1BDZFF6ak00NU1ubWtoZ0pxM3FvUlRVR254TTlM?=
 =?utf-8?B?LzR1Vis3YWQrWlliMWZ4aE9VaEdWTURzV05VOW11bVZGOGVFekxVdDJjQlE0?=
 =?utf-8?B?bzhCZC9tY0NWa0pCb3BDbjdYOCtnbXBFWWZVWno3aDk5WktISHoydFUyRDY4?=
 =?utf-8?B?NHExVDhETTdzQjNPajcvZG1PYVlxS3kyRU9MY3pRRzhPd0RqdGVtYnRkU3oy?=
 =?utf-8?B?SlN4SEVBa21HT0hxN3hnWWwyNm5MUzltZWVsZHRUcnhJbEpXWUs5alB4czBP?=
 =?utf-8?B?eGJESHBtazJUNVVsNENvcm1nM243QmJJTWNLcysvZytoZUhyOFVDVzlGQTJK?=
 =?utf-8?B?WUZkRk92bTRQcTV0KzNKdFFHRjVzMUV0aDJVQ0tmNWpWQlBXQm5DczJmS25o?=
 =?utf-8?Q?iBG8qjoABUUUfI4DGPCHf15Ry?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 787deb4d-d449-4d4c-7464-08dc13a05771
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 18:57:36.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 457a2b01-0019-42ba-a449-45f99e96b60a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BufulIp4o3SSuPHhSeL3d5D085Oo6TU6i+6aSM/Z94FEz5AL1Qc1secqFc+UGJhcxfLC76nHZj3L/bAYaB8EQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8589
X-Proofpoint-GUID: BWTabGDdq0arVBljmIchhKoSNsWs8-mS
X-Proofpoint-ORIG-GUID: BWTabGDdq0arVBljmIchhKoSNsWs8-mS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRG1pdHJ5IFNhZm9ub3YgPGRpbWFA
YXJpc3RhLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTQsIDIwMjMgOTozNiBQTQ0K
DQo+Kw0KPitzdGF0aWMgdm9pZCBlbmRfc2VydmVyKGNvbnN0IGNoYXIgKnRzdF9uYW1lLCBpbnQg
c2ssDQo+KwkJICAgICAgIHN0cnVjdCB0Y3BfYW9fY291bnRlcnMgKmJlZ2luKSB7DQo+KwlzdHJ1
Y3QgdGNwX2FvX2NvdW50ZXJzIGVuZDsNCj4rDQo+KwlpZiAodGVzdF9nZXRfdGNwX2FvX2NvdW50
ZXJzKHNrLCAmZW5kKSkNCj4rCQl0ZXN0X2Vycm9yKCJ0ZXN0X2dldF90Y3BfYW9fY291bnRlcnMo
KSIpOw0KPisJdmVyaWZ5X2tleXModHN0X25hbWUsIHNrLCBmYWxzZSwgdHJ1ZSk7DQo+Kw0KPisJ
c3luY2hyb25pemVfdGhyZWFkcygpOyAvKiA0OiB2ZXJpZmllZCA9PiBjbG9zZWQgKi8NCj4rCWNs
b3NlKHNrKTsNCj4rDQo+Kwl2ZXJpZnlfY291bnRlcnModHN0X25hbWUsIHRydWUsIGZhbHNlLCBi
ZWdpbiwgJmVuZCk7DQoNClNob3VsZG4ndCBpdCBiZSByZXZlcnNlZCBpbnN0ZWFkPw0KdmVyaWZ5
X2NvdW50ZXJzKHRzdF9uYW1lLCBmYWxzZSwgdHJ1ZSwgYmVnaW4sICZlbmQpOw0KVGhlIHNrIGlz
IGFuIGFjY2VwdCBzb2NrZXQgYW5kIHRoZSBmdW5jdGlvbiBpcyBjYWxsZWQgYnkgdGhlIHNlcnZl
ci4NCg0KPisJc3luY2hyb25pemVfdGhyZWFkcygpOyAvKiA1OiBjb3VudGVycyAqLyB9DQo+Kw0K
PitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KPit7DQo+Kwl0ZXN0X2luaXQoMTIw
LCBzZXJ2ZXJfZm4sIGNsaWVudF9mbik7DQo+KwlyZXR1cm4gMDsNCj4rfQ0KPg0KPi0tDQo+Mi40
My4wDQoNCg==

