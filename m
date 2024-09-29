Return-Path: <linux-kselftest+bounces-18546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2801989572
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683311F21933
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31061179204;
	Sun, 29 Sep 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EpXb7mLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2042.outbound.protection.outlook.com [40.92.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53E13BC26;
	Sun, 29 Sep 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613855; cv=fail; b=OiRubg4aeCmz53RrYiy1xtWW6gMDydX5hku2sMTPI1CZOBnWTHQUlGP70FLiOpAVIC57uskzccAhBLgdcxVINAfVFpMKHbpPIgtdypUGYWHxrsjZ124PfdsWWQZNd+6B7S0fCYE7MpTDN1MwEMcIOYM5rLh3P56GkBMQNjD00ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613855; c=relaxed/simple;
	bh=VK9pD9dA/UMuLshJX9bm1k+TiVPLjcCvgt2nzEM2On0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=ZlzoIksFtzyolJJL3ckbj3o5Gi13H5pzBTxdUUTXnigpfbZtN/xAP1OSaJWwtEV2BYfE6ZGoBffSLHM52Rgzb+mECEt4LO3voo3UKwZlD9wwScP8uJqDilT3uXcQ6P45k1UCWjRQlgj5vxD1/QeFYnw02+nSATjpCHsa7w46qT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EpXb7mLa; arc=fail smtp.client-ip=40.92.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULcsT/VN3UJAEyJDsSU85kvdAjy/0H/qdb8YDNtD7rN9L7R+D5w0FJ5MhJyG9mpKIK3E+eNhuAa46Tu6trhZkjhj5hfKnWYzn8eV4NaHUv1dxxKVa6TMBkzDfxjGVfALa9WWZ9fWTAJmpBcQ4u0NAbblw64vvLepnCU949aNuwywSfZOTP56AGwgWOWTiLc4fOTAhMXSQfFYLXZMk2G/GywL4kUBwZbELxaSzOe9Ug0L1D7SaSOePML1w9adTISjbQvYQit6sViSBIxf3J8AIrRDvxqDRMyJImzfKtB1JNVXqd2uSUg+EYSLGsgjGmDrJImn797bG/HT4RSg43RhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK9pD9dA/UMuLshJX9bm1k+TiVPLjcCvgt2nzEM2On0=;
 b=w577RBccFo1ZVTiARgu6+d/7YwG4s0tCc8ccxjYGOQaov+5gN5P8dza4uBf2Uid2ewF03nz3zRD/Imz6FlvEOlsV5klf5w0Kijgxa0olXhJ/xpq+zPR7AOiCNx28oLjcBV+Tad3jX+G2Rc+o7aRvqzebZZiSgTzU1GUct5/MHP+jQ8HXSLY3gw3FJ2qtBJ5uJemYOSpnlCSy976IWtHtnCG9mF9RT3GP2qc86GVPOeqwBA8m6J9vLqDKpyRUpq6lLKTcFS65QU3E1FSG1ilc9i/E1+eS1JxNLO3kMyk5id349NApAJMdaiuXn6V1sZrIcMDGqrVr6J/ps+TOSgej5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK9pD9dA/UMuLshJX9bm1k+TiVPLjcCvgt2nzEM2On0=;
 b=EpXb7mLa81BqBXMSwV4FPWggf073TH4yC5/y+SisnuDL47LPIfi8AnYbUujseHGoDgboNuAJWTjtOS/IWmXNb3otfyFht19pOtPE2se1HDplgi/SBcjj68sxySh5dYNcryE5TEHOm93h6DHHOSEOsyrVOnMnB/m+yxVagD48NLWrE+CD6pKcxBz3X+7WrUd4HsJRaPI3Zxvb2ocRJY4fGzZYrpYSxh9NOefovhq7xjYV9tGuO093YB7v7La4rr8938bBx0KHZ9FK5WAuy7vHQTXHvXWEcSeozM9azpgmdIjcmRcOpp/OLOqVVQidAee8aC0DsISl7UPEdRK73o/1uQ==
Received: from CH0PR20MB3932.namprd20.prod.outlook.com (2603:10b6:610:d8::9)
 by IA0PR20MB5705.namprd20.prod.outlook.com (2603:10b6:208:437::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 12:44:08 +0000
Received: from CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13]) by CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 12:44:08 +0000
From: Aoba K <nExp_0x17@outlook.com>
To: "charlie@rivosinc.com" <charlie@rivosinc.com>
CC: "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"andy.chiu@sifive.com" <andy.chiu@sifive.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "conor@kernel.org" <conor@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "evan@rivosinc.com" <evan@rivosinc.com>,
	"guoren@kernel.org" <guoren@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "jrtc27@jrtc27.com"
	<jrtc27@jrtc27.com>, "jszhang@kernel.org" <jszhang@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "robh@kernel.org"
	<robh@kernel.org>, "samuel.holland@sifive.com" <samuel.holland@sifive.com>,
	"samuel@sholland.org" <samuel@sholland.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "wens@csie.org" <wens@csie.org>
Subject: Re: [PATCH v10 00/14] riscv: Add support for xtheadvector
Thread-Topic: [PATCH v10 00/14] riscv: Add support for xtheadvector
Thread-Index: AQHbEm1FbzdD9GcS4Uub6j6FPFxzJA==
Date: Sun, 29 Sep 2024 12:44:07 +0000
Message-ID: <a1f41f92-6bd0-48b6-a931-e7ad7aba18cc@outlook.com>
In-Reply-To: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB3932:EE_|IA0PR20MB5705:EE_
x-ms-office365-filtering-correlation-id: b444aba2-c96a-44ec-6e4d-08dce08468d3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|38102599003|19110799003|461199028|7092599003|15080799006|102099032|10035399004|440099028|3412199025;
x-microsoft-antispam-message-info:
 G5EoB1JQ1dWx6ULgBfNljYsad2rCscBLQAPtZ9y8dRl3zOWeup8vLHFbOxadvibfzH7todwMsmXajxkcoKBUQ3IWdIHvgtKffRY5+P/rG2S1IChvksaW8UVigeD6iRSNK0ZEv82fCF0a6mLFbsWfYLI6xPWyjdF/9Astp8dAXuokZzXH3xmsvIOWGKefL12lDO7fxBi4Ty61yJaWEk76i4DwKhYV96wf73eLl4n2E2a3pU+f50k8rltHKqX1DNncGo7BPY7qmplpuY/VCFbpIXo0W4R1VpmWjrWLHIjnt+usfTBM+z+qLMwx1OQIYLfQMOkXUwVOVVZjXyFSQaSKG5kzL/Pbnm4sIHo0NXtascFL0OE1ZIMimQj7iCvJB/jN5vF6jfL9glNm3HUdbA69csMOZfudjMPBhh1K/5i6m+1o+BK+PajubBI12FxAEANvF53gBdiOs8A31jY/kip7pvN048d5Roinp74CLr60n6kL/Kj+7qWRJxXCtJYm8Z5bW4t33NUKQ8syfZ4Ygl7cl2v8f1dzF9J78qkHczbHK7c1dc0UBDFGGCZFmfwR0StEhmb13ail43abqGmg4x1KR7+JVGJS128cSASkf/rFFKmspq+N9LtgaXiDI1/iZ6iSUQSI62McDOdwRnao2CS/ON27KYoaA64yUy2Bqo2nia1oNi+xjn1oTCwWTNu8tSRVPKW+sUwKzh8IkTUZhYTCdRwMvNZcbrg/HNduhf8m0x/YjI1wncbTKQ2uqUGiPBwo31ETEv8ZuA9jbHsERLBEA/Bb9weCFmTg8DTVOK7rkxoqphL1MC28YM72HigJEO4EytoflRVQ8oTX1yqBoLm9q42MY7G+oD+U0nZrgVUrUfM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2diaXlPSGdDM3FFV2hjS2ZkaThFcnQ3QW8xR3BXQk55OFZOK01wVTBRK0Zk?=
 =?utf-8?B?Y1hRaFNLNllsNDlyQXhoQ1l6dnhYTmFmSFB2LzltZGRyTUc5ckVRdnFOTi9V?=
 =?utf-8?B?bks4eXZac1gvZHdkcnlsa2xoZ25Sdmk5clNiTlpNaG1EQ095bGRYWFZpa1hj?=
 =?utf-8?B?bXpzd1FONTIzUEtpaDllS2hVYWlJc1RJZkpMZTFKQ2E4RHp2SGtUZlY5amdt?=
 =?utf-8?B?YWNySklTWHlNaTZHTTdNWE1ndVh5N1hhVEdpNjdRQUgxMEZPMk9vZFRrbmZP?=
 =?utf-8?B?N21ZNk90dnNMVUVkQkJ1V2gzVXZYNVVoeHpxVjlibWdnSVViNHVpd3BQa3FW?=
 =?utf-8?B?NzVyYXBLeE1VMElXRkI0b3lPbXA0VmFPQU42azgvcXg0UDBSVTVkN01Ic3Rs?=
 =?utf-8?B?TmJLRGJwY2p1cW5MQlg4aUdHY21aYTBOWWRtbXNCVUxTMDExODZHVDl6Q3F3?=
 =?utf-8?B?QW9YMjFUUWJLUDh6WUJUb3dsY3o5WEF2ZzRVd3FPTG5jQTh1VFVKOStzenJH?=
 =?utf-8?B?aENjRjZmMnljVHkxL1JXRytKS091RHVpdS9NWitOUXV4V3I1QzBweWNwdklS?=
 =?utf-8?B?WC9ENGY5NVF6RGxkdExnR2laVXRvcWNGaXBrV08vVVFyWGlMZWpYMURaQ21C?=
 =?utf-8?B?Sm9PV1hRYVRzbklFVU9mcmJqRVlNNUlDblZadXRKWXZJZzI4bFVBTWpoVWQ0?=
 =?utf-8?B?Z1RlNk5uSTBhL255TURTY0VlOEtGVU5yaGdpeW5mRlFpeFBkNGdwdnZUUWc1?=
 =?utf-8?B?TFNLblc4eC9iaEcvY09ZWWpDelJhQk5VejBva1ZNb0Z4UE1XeDF6WVdyamFr?=
 =?utf-8?B?TkNWVmNLbFZIaXZCczhlWkxuUXpKYURPYzRjTmJFdlFYWGFpS1QxRW9TNDM3?=
 =?utf-8?B?c0RyUy9YejJDN2xJN3prQ0dyNjFVZU1ySWQ4Uy9oWFBIMTQ3aGVuTmZRbDB4?=
 =?utf-8?B?aFV5bWpBMjV1UFpsVENrZmNFWTZ6WFluays3clZ3bWRlMlU2Um9ROURpckJ0?=
 =?utf-8?B?aTF0WDJ2eTRCQWhWTGNSb3QvYTI1UldRY09MSXJ0WnhPQ25rdDJqVHhySm5X?=
 =?utf-8?B?NVFSK3p6bGNEUXdZVUxJZ2NIVTY3QW5CUC9KRVREL3k3S3pKUTBXZ2w2TWpI?=
 =?utf-8?B?UVFrM01mWGZ0ZHB4ZTJ4VUlqSTVWVVBmNm1zcmw1MHRPV25ZNnVzQTE2MmlG?=
 =?utf-8?B?NnFCSEk3a0trZENKbHp6MlhYQkRsT2cvS2RkaXZxUHRsR2dDdTRWekZDZ3ZM?=
 =?utf-8?B?WllHVFAzL0xXL3kvZXh1N0w0WVdMK2IwaFZqWFpzZXBjVFBEU09VenBrSUpI?=
 =?utf-8?B?YUpGemhXR0h1TmFVN3dtRCtyY1JkWFY5ckRybnVyNmNGdlkxSzl2U1lMM2Nw?=
 =?utf-8?B?Y3dzcXhkeGlmdTBYTW8zdUc3K2pYaXFWQzNVTTNuRmNvQVRPRThuTnFyT3Qw?=
 =?utf-8?B?TVJZbVBPSjJGR3lYZGgxYnByTjR1ZXpmQks5QWZxWTdNSmVuQVQ1L3BOakVa?=
 =?utf-8?B?T2pFZVhWblhtb1B4QUp2VSsyMldYaEZiSU1XUnhOVUdkNmtXZTNPVjhZR2Y2?=
 =?utf-8?B?dmNVWmJlY2xkZXZIMHNpeUFHVnVJejNtUjRHMFRmTWNEZ1drdXcwSFdYY2tu?=
 =?utf-8?Q?KMCCtv4TrLFbGeaU9J0DIdce8KSDB2tkxoJKnLZEQfyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6487AC2D11AF5346BFE8F7280100128B@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3932.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b444aba2-c96a-44ec-6e4d-08dce08468d3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 12:44:07.8364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5705

SGVsbG8gQ2hhcmxpZSwKCkkndmUgYmVlbiB3b3JraW5nIG9uIGJyaW5naW5nIHVwIHRoZSBTaXBl
ZWQgTGljaGVlIFJWIERvY2sKKHdoaWNoIGFsc28gdXNlcyB0aGUgRDEgU29DKSB3aXRoIHRoZSBr
ZXJuZWwgcGF0Y2hlcyB5b3UgcHJvdmlkZWQuClRoZSBwYXRjaGVzIGFwcGxpZWQgY2xlYW5seSB0
byBQYWxtZXIncyBmb3ItbmV4dCBicmFuY2gsCmJ1dCBJJ3ZlIGVuY291bnRlcmVkIGEgY291cGxl
IG9mIGlzc3VlczoKCjEuIFNraWZmb3MgQ29tcGlsYXRpb24gRXJyb3IgZHVyaW5nIHRoZSBjb21w
aWxhdGlvbiBwcm9jZXNzIG9mIGBjZ29gOgpgdW5rbm93biByZWxvY2F0aW9uIHR5cGUgMTc7IGNv
bXBpbGVkIHdpdGhvdXQgLWZwaWM/YApVbmZvcnR1bmF0ZWx5LCBJIGNsb3NlZCB0aGUgdGVybWlu
YWwgYmVmb3JlIHNhdmluZyB0aGUgZnVsbCBsb2csCnNvIEkgZG9uJ3QgaGF2ZSB0aGUgY29tcGxl
dGUgZGV0YWlscywgYnV0IHRoZSByZXN1bHQgc2hvdWxkIGJlIHJlcHJvZHVjaWJsZS4KV2hpbGUg
dGhpcyBzaG91bGQgYmUgYSBTa2lmZk9TIGlzc3VlLCBtZW50aW9uIGl0IGluIGNhc2UgU2tpZmZP
UyBpcyB0aGUgbWV0aG9kCnRoYXQgeW91IG1lbnRpb25lZCBmb3IgYnJpbmdpbmcgdXAgdGhlIGRl
dmljZS4KCjIuIEltYWdlIEJ1aWxkaW5nIHdpdGggc2VocmFmL3Jpc2N2LWFyY2gtaW1hZ2UtYnVp
bGRlcjoKQWZ0ZXIgYnVpbGRpbmcgdGhlIGltYWdlLCB0aGUgZGV2aWNlIGZhaWxlZCB0byBzdGFy
dCBhdCBhbiBlYXJseSBzdGFnZS4KSSBzdXNwZWN0IHRoaXMgbWF5IGJlIHJlbGF0ZWQgdG8gaW5j
b3JyZWN0IFJBTSBzaXplIGRldGVjdGlvbiwKYXMgdGhlIGJvYXJkIG9ubHkgaGFzIDUxMk1CIG9m
IFJBTS4KSW50ZXJlc3RpbmdseSwgdGhlIHZlbmRvciBpbWFnZSByZXBvcnRzIDFHQiwgYW5kIHRo
ZSBTaXBlZWQgd2Vic2l0ZSBhbHNvIHN0YXRlcwp0aGF0IHRoZSBEb2NrIGhhcyAxR0IsIGRlc3Bp
dGUgdGhlcmUgYmVpbmcgbm8gZXh0cmEgbWVtb3J5IGJhbmsgcHJlc2VudC4KCllvdSBjYW4gZmlu
ZCB0aGUgYm9vdCBsb2cgaGVyZTogaHR0cHM6Ly9mYXJzLmVlL2JkWWsubG9nCgpBbnkgaGVscCB3
b3VsZCBiZSBhcHByZWNpYXRlZCwgYW5kIGJpZyB0aGFua3MgdG8geW91ciB3b3JrCnRvIG1ha2Ug
dGhlIGVmZmljaWVudCBwYXJ0IG9mIHRoaXMgYm9hcmQgdG8gd29yayAoYWdhaW4pIQoKQ2hlZXJz
LApBb2JhCg==

