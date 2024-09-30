Return-Path: <linux-kselftest+bounces-18656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF298A90E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC260283C1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36FF192B7A;
	Mon, 30 Sep 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g2gV9mCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2040.outbound.protection.outlook.com [40.92.19.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20501922ED;
	Mon, 30 Sep 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711459; cv=fail; b=RsVvYTH85zdM+kW/XMQZuWjGRgxs67+r9IDhfOv7EzAtLcR9PQmfLLaHwFMUKoCzeaKfq9teZwsCyLkVE/hbSEC0fHl5vJM6qWzMxUdYrcfUp6NAQRsfdqaKWF+uCGxHbPdEpK3rbBFKrsZ5Wrl1OR83XehytOG1nv6sWjeMLHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711459; c=relaxed/simple;
	bh=yFsywN+6TQGhto9b9o8nzzkkwne691zz2mTSuWm8Mag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXzsI3ZgyHwzvEMsIsxMPa8T0KPXMHuSgmN9mi9DOE8WYviCP0BBcCzEg3mUOIrLAWf1HlRQUFWiSXmL26AmWzj5V5NFE9+knlUdiw9meKp/pjVSxPxyk0V1+97AiLulByJfWVUq2Gq93ESGvsjLKBaaQHp+IrpIGMGEGbSxCIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g2gV9mCm; arc=fail smtp.client-ip=40.92.19.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4vinzZ6MkrDw4okB8bMNn/knJtHsuQaSr3y2wcC0cy1riZCi92xzC+bD2fGM/R1MewdKiey5A4D0I7F695oTF8uyhHZIpzV60NtPuJbqibX/O9M3NuhI47gM58ldUZjTbIjOWdfvyK9mIrxYCuUBoYbl0+HzJhQMolxHz1RTmiXFKL4mfOTYTU1p7MMssfKd/PAcdpTagg0DPW7lO6SThiW9W3S23Q875uRdOdrmHWIesWbhrbPaDhlmYYfvwhLgELDH8tvQd7Obo2ioHEX4ud6fytw4iAArGLsk89rf6GWGu2iOUZlMbwUnvFawpqvz0/C+lV2rbOcbkHLMN8rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFsywN+6TQGhto9b9o8nzzkkwne691zz2mTSuWm8Mag=;
 b=NK4DrIRAjlrzvhMx7z8ZBuXJawRSCa87UvOtjxMDBqXtmwwVZh/ygsrtwurAgq3+sRIA0FdMIpPEGXA5Lr4dVY+9oXqSR+cp+vvx7aVemDKrvd48W1aGym1tVIwBPTfyFFrjcPylpQIM1Rl+ufyW91yKuumJLbTf3dGI8L47Ii+a+RFtS45C/lcGEFRoXUy5Dmj/4Io0bS4OdOElTmcga+HypHUObb9sCsnDm346RVC/ydA303yK7uTGtiovXpYzo4pjLzHFWNWs+vLxsR+ugjy8YmOaUwn9vSBH8IMA2liu5vzyS3LdrvFibuS1Mklb+Mq3tLW3jCYQFOY7t+BWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFsywN+6TQGhto9b9o8nzzkkwne691zz2mTSuWm8Mag=;
 b=g2gV9mCmGWQaYZb8UI93xcxSuvvrJRKvP3J2pAMShAfARjp6d2r0QreW1JGbzOpluVpbSFlVcA/XtO6Z5tQRkSd8TNzuNhrCDfBd/Yd2wA43LjHxDS9X4beK+VzSWVRpB0wvpjzt5usMuQmpHppnd93iD9W17kSSjnct+pFP5+kbbd1RiZ7dr0Gtm/z5oWpW0ww/Eg26Rwk2fEaH9JUNntZOlNFZP+KKSHLjI0/xQHyXq3OOx4DWcFx5UEuNBev4k0f17gVJytkyAntb1XezZ0GhAE368CPw8cVBnp/QDS+dV6zP8tucZHaFFkK07YUgntesxf0SAkMTOm1A3GCgTQ==
Received: from CH0PR20MB3932.namprd20.prod.outlook.com (2603:10b6:610:d8::9)
 by SJ0PR20MB4463.namprd20.prod.outlook.com (2603:10b6:a03:3ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 30 Sep
 2024 15:50:54 +0000
Received: from CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13]) by CH0PR20MB3932.namprd20.prod.outlook.com
 ([fe80::f1b8:f67:339b:8e13%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:50:53 +0000
From: Aoba K <nExp_0x17@outlook.com>
To: Conor Dooley <conor@kernel.org>
CC: "charlie@rivosinc.com" <charlie@rivosinc.com>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "andy.chiu@sifive.com" <andy.chiu@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"evan@rivosinc.com" <evan@rivosinc.com>, "guoren@kernel.org"
	<guoren@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
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
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggdjEwIDAwLzE0XSByaXNjdjogQWRkIHN1cHBvcnQg?=
 =?utf-8?Q?for_xtheadvector?=
Thread-Topic: [PATCH v10 00/14] riscv: Add support for xtheadvector
Thread-Index: AQHbEm1FbzdD9GcS4Uub6j6FPFxzJLJwbCqAgAAQBgA=
Date: Mon, 30 Sep 2024 15:50:53 +0000
Message-ID: <d9eaaf71-dfe7-4bf8-8aee-538ee8ad9f24@outlook.com>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <a1f41f92-6bd0-48b6-a931-e7ad7aba18cc@outlook.com>
 <20240930-reenact-stratus-9d42d7439df4@spud>
In-Reply-To: <20240930-reenact-stratus-9d42d7439df4@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR20MB3932:EE_|SJ0PR20MB4463:EE_
x-ms-office365-filtering-correlation-id: 3c96a203-6b3a-49e8-aaa8-08dce167aa2a
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|38102599003|8062599003|15080799006|461199028|19110799003|7092599003|440099028|3412199025|102099032|10035399004;
x-microsoft-antispam-message-info:
 kOw1clF9R4bERp4fXmhGeCbf5sdrG4nXEdxoQkZsCHt9Wfj53/G+SMaxMcc4Cl8fT7aNgMqYbULEi7EBZG3QhnVFToKqXpH6d28+kTk6JPS3jo+vzdAmi7pl6EOYPkwJOs1NKKTyPOXrzz9dA2lgEIw2fKdaTsP5Vsqymvb385B+6FlHUXoARM47DQgWnN9jXPOFlUX8HQ7qC5DxeFYYn4mr1zMNj0r90lnIeJUp0ehOyF3lt7JUC4/pMTSN1dL8jQriLsgB2chl8ZL/zkwoUBXrPaKPE4MUahUKxK8omds+G+shuAXU9jU8HodtLRZzQq9DAzPj8P05HCze2EfjOg5Y9be587FqCL6R3wuf0P/tu8Vbko/kwgx/I4sbs1oFJUhs4tvhmzFddTuqo2QuWjO6AaG7z6ObPmB+A/DHf4st1tmq6y2E0EQNmsT2KmxhNpAbi7lveF9UjGNcjA8Mp47ZlK450Q80EM21l6nyg0c8w1HQ2L2SzNH0AaFWDSWxLEwRAIDekUDpMYLUQusKbQotvMcUaKCICiG+oNBGJTkGO/q4Css1GL3NwrB5+25WBxMXI+w5d+SYR24ChjvL42EMD+VihOSW4zeRY43qjtAwYvNEKJ8I0q5w38Pn+r11jFSheVgieYw/jmsCH1jhNEBAkjwd8YGsMxn858DPMP+LOw7RC5BtzOmNCyXGmk6XYJdJKeX8jPn9/9Eu1LlnOxVH876AsHYYFBoLu3vY4bY14hlwH0XOgLZu3rEvtULJrjZjRpMAjnbqws89oVNTWIlva1kYacCmhIwoGon96VAv69rK/LHJSzHMmWTDrOXlBgXHW/un+VOcpBzbhFQ9DhpIbxsqc+MVgtehT6DIC0A=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3RveGJ4Zm5NNTRVbHp0bUoxby9YN1lsOTJNSFZNeXdBZW1Cb0pxdWxyYm5x?=
 =?utf-8?B?QWNtM0ZIV1FVaGJqbjRrMlo3TFppTTFNRCtONGdoZkNUakFKMTRnTTBIN0Nv?=
 =?utf-8?B?a3hmWjVKaC9Hb29rc2lNUzZibzYxODViWTNHdnllSTNGTzk0K0kxSHl4a2JR?=
 =?utf-8?B?aldNZEVtcW1CdEdGUFMxKzB2MlcrdjE4MnJPaVNpRTFLbnVMbEVrQkZjMlYw?=
 =?utf-8?B?ekM2aXNSVTNCQzdSTDdTSXBoQVg4K1U1MG1SbWpjWHJGckJIWnhkWGFPbm00?=
 =?utf-8?B?b2RvZk9HL1BTUy83NXBqZmlveHlmMENvTnlsSDRiU3hydVVGcEpTNWw2QTBl?=
 =?utf-8?B?S3pxOGRoKzhkVTdRb0pkbWErVzlmTHZUSGo0Rlh2WU82d0NOalZ2TTdYSE51?=
 =?utf-8?B?Tkk2eWRGKzZnOXdyYzRLZlNIbzEyTG9WaXoyY2prYzhhSE92S3V6SnhXRFZS?=
 =?utf-8?B?aTVtRVZlMWZsaW1taTRxZllhRkhQNE81TEpPaW5TM3BoZVhHc0FUbWhPQitr?=
 =?utf-8?B?UCtwQnBRa2tXOEQvY1IrN1hvYU1iRENwRXNHWWJ5bU9aVFZxV2tpcnI5bVRQ?=
 =?utf-8?B?YTlBVzI4ZHJBRjllUDJQM0hQM1Nib2g1NlljTWI0VTFuNzBlYzB4cjNJeFZ2?=
 =?utf-8?B?NTVwcnNHd0dhVUVTc01SMkIyQ3lBdUxBM28wdlVoMUE4UGIvR3NMalNCTlJZ?=
 =?utf-8?B?UEFYRVFZbTJpZVYyZ0RvaGZ6RmN3dFE4Y2dic3JNeDVFVE1WRjlUSEYwMmpR?=
 =?utf-8?B?ckdGc1BRc0tKSHpTalBTclcyRzZnUTBHYlNWSThEeU1JbjB3RXdXck1TUHVL?=
 =?utf-8?B?c0VEdlFpZ0FHaHlFTHdVLzBzdVh1M0hBc21mYWVHV2FYTXN4VmtiQXBha1Rs?=
 =?utf-8?B?cElnZUEvYW56aGJiS0UxY2VWN2lkczdvdVdCRDNwRkk1UzJJNHptUHF3RzBR?=
 =?utf-8?B?TVJvTVhPVlZWSDNkUk1iK0t0VWNSOWoxalBlN2E2Z3lnZjdPeG4ycVY5VXBk?=
 =?utf-8?B?ZHVZU1hGZExadkh2N3Blc3ZqRzE2WVlhQ0pwT0dzSWpmeDVyWGQyRitJL2ox?=
 =?utf-8?B?OUlDZ2lXNFZ6MHdmTDNSODVwd0E3S2pLYURvaDVyZ1A0bWw1OHh4MTUrY0hq?=
 =?utf-8?B?VmtxMUd2ZXEyRXNnUGFza0hOd1czY3ZVNkYzRGFKWVNHNjNlVmYzSkFQVGcr?=
 =?utf-8?B?Uy9WNSsyb3lZdERob1djT2xIbDdob21wMFB3NVYvNmtsbEFrVDhiVkY4NGJ2?=
 =?utf-8?B?Z0FicmtrSHpoMUliNk5JdnRXeUpXR0dXQllBcmpNNjY2ZG1Lb2xkRXgrNlF6?=
 =?utf-8?B?Nmk0ejZKVCtnSjlqYUZqcitQekE5VVhLelA0N2hsSGE3Qmo3TER6Nk1SWmVi?=
 =?utf-8?B?SklZR1VVMzJHRnlTNFcwOThaN2ZHSVpSa3ltdFY3UVBSOUV5akRDL3NrWkly?=
 =?utf-8?B?TGViS2NkNEV1SEpzVDhMYjhOcHFxK0cyWmtoaTFqTkgyRk0vWjFvSk1hNG1n?=
 =?utf-8?B?REZaejU5Q1VnZyt5d3BxdHk0UGc3NjhoQTRON3dhUzcwK3dHcEZRNkd3a0Z3?=
 =?utf-8?B?SFF0ZjdaU2syT0NjNU5wTXE1WTBDOUg4MnVxa1UvTWlhL054RVlvZnZiY3Np?=
 =?utf-8?Q?6ymTh2k1tNCO24utQfM8HcrusMQXUdEe3n5405PZmpfo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2614A21A2E155146A06A703B4561663F@namprd20.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c96a203-6b3a-49e8-aaa8-08dce167aa2a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 15:50:53.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4463

VGhlIGRldmljZXRyZWUgbmFtZSBzaG93biBpbiBPcGVuU0JJIGlzDQp0aGUgb25lIHBhY2tlZCB3
aXRoIFUtQm9vdCBTUEwuDQpBcyB0aGUgaW1hZ2UgYnVpbGRlciBkaWRuJ3QgcHV0IHRoZSBrZXJu
ZWwNCmRldmljZXRyZWUgd2l0aCB0aGUgaW1hZ2UgdW5kZXIgYm9vdCBwYXJ0aXRpb24sDQpUaGUg
d2hvbGUgYm9vdCBwcm9jZXNzIG9ubHkgdXNlcyB0aGUgVS1Cb290IGRldmljZSB0cmVlLg0KDQpU
aGUgcmVhc29uIHdoeSB0aGUgbG9nIHNob3dzICJOZXpoYSINCmJ1dCBub3QgIkxpY2hlZSBSViIg
aXMgdGhhdCB0aGlzIGxvZyBpcyBwcm9kdWNlZA0Kd2hpY2ggVS1Cb290IHJldmlzaW9uIGlzIGQx
LTIwMjItMTAtMzEgZnJvbSBzYW11ZWwncyByZXBvLg0KQnVpbGQgZnJvbSBkMS13aXAgY2FuIHNo
b3cgIkxpY2hlZSBSViIgY29ycmVjdGx5DQoobWFudWFsbHkgZWRpdCBjb25maWcgdG8gc3BlY2lm
eSBMaWNoZWVSViBkdGIgc2hvdWxkIGhhdmUgc2FtZSBlZmZlY3QgdGhvdWdoKSwNCndoaWxlIHRo
ZSBpc3N1ZSBwZXJzaXN0cyB3aGVuIGtlcm5lbCBsb2FkIHRvDQp0aGUgcHJvY2VkdXJlIHNhbWUg
YXMgdGhlIGRtZXNnIG1lbnRpb25lZCBhYm92ZS4NCg0KDQpDaGVlcnMsDQpBb2JhIEsNCg0KMjAy
NOW5tDnmnIgzMOaXpSDkuIvljYgxMDo1Mzo0MCBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5v
cmc+Og0KDQo+IE9uIFN1biwgU2VwIDI5LCAyMDI0IGF0IDEyOjQ0OjA3UE0gKzAwMDAsIEFvYmEg
SyB3cm90ZToNCj4+IEhlbGxvIENoYXJsaWUsDQo+PiANCj4+IEkndmUgYmVlbiB3b3JraW5nIG9u
IGJyaW5naW5nIHVwIHRoZSBTaXBlZWQgTGljaGVlIFJWIERvY2sNCj4+ICh3aGljaCBhbHNvIHVz
ZXMgdGhlIEQxIFNvQykgd2l0aCB0aGUga2VybmVsIHBhdGNoZXMgeW91IHByb3ZpZGVkLg0KPj4g
VGhlIHBhdGNoZXMgYXBwbGllZCBjbGVhbmx5IHRvIFBhbG1lcidzIGZvci1uZXh0IGJyYW5jaCwN
Cj4+IGJ1dCBJJ3ZlIGVuY291bnRlcmVkIGEgY291cGxlIG9mIGlzc3VlczoNCj4+IA0KPj4gMS4g
U2tpZmZvcyBDb21waWxhdGlvbiBFcnJvciBkdXJpbmcgdGhlIGNvbXBpbGF0aW9uIHByb2Nlc3Mg
b2YgYGNnb2A6DQo+PiBgdW5rbm93biByZWxvY2F0aW9uIHR5cGUgMTc7IGNvbXBpbGVkIHdpdGhv
dXQgLWZwaWM/YA0KPj4gVW5mb3J0dW5hdGVseSwgSSBjbG9zZWQgdGhlIHRlcm1pbmFsIGJlZm9y
ZSBzYXZpbmcgdGhlIGZ1bGwgbG9nLA0KPj4gc28gSSBkb24ndCBoYXZlIHRoZSBjb21wbGV0ZSBk
ZXRhaWxzLCBidXQgdGhlIHJlc3VsdCBzaG91bGQgYmUgcmVwcm9kdWNpYmxlLg0KPj4gV2hpbGUg
dGhpcyBzaG91bGQgYmUgYSBTa2lmZk9TIGlzc3VlLCBtZW50aW9uIGl0IGluIGNhc2UgU2tpZmZP
UyBpcyB0aGUgbWV0aG9kDQo+PiB0aGF0IHlvdSBtZW50aW9uZWQgZm9yIGJyaW5naW5nIHVwIHRo
ZSBkZXZpY2UuDQo+PiANCj4+IDIuIEltYWdlIEJ1aWxkaW5nIHdpdGggc2VocmFmL3Jpc2N2LWFy
Y2gtaW1hZ2UtYnVpbGRlcjoNCj4+IEFmdGVyIGJ1aWxkaW5nIHRoZSBpbWFnZSwgdGhlIGRldmlj
ZSBmYWlsZWQgdG8gc3RhcnQgYXQgYW4gZWFybHkgc3RhZ2UuDQo+PiBJIHN1c3BlY3QgdGhpcyBt
YXkgYmUgcmVsYXRlZCB0byBpbmNvcnJlY3QgUkFNIHNpemUgZGV0ZWN0aW9uLA0KPj4gYXMgdGhl
IGJvYXJkIG9ubHkgaGFzIDUxMk1CIG9mIFJBTS4NCj4+IEludGVyZXN0aW5nbHksIHRoZSB2ZW5k
b3IgaW1hZ2UgcmVwb3J0cyAxR0IsIGFuZCB0aGUgU2lwZWVkIHdlYnNpdGUgYWxzbyBzdGF0ZXMN
Cj4+IHRoYXQgdGhlIERvY2sgaGFzIDFHQiwgZGVzcGl0ZSB0aGVyZSBiZWluZyBubyBleHRyYSBt
ZW1vcnkgYmFuayBwcmVzZW50Lg0KPj4gDQo+PiBZb3UgY2FuIGZpbmQgdGhlIGJvb3QgbG9nIGhl
cmU6IGh0dHBzOi8vZmFycy5lZS9iZFlrLmxvZw0KPj4gDQo+PiBBbnkgaGVscCB3b3VsZCBiZSBh
cHByZWNpYXRlZCwgYW5kIGJpZyB0aGFua3MgdG8geW91ciB3b3JrDQo+PiB0byBtYWtlIHRoZSBl
ZmZpY2llbnQgcGFydCBvZiB0aGlzIGJvYXJkIHRvIHdvcmsgKGFnYWluKSENCj4gDQo+IFRoZSBs
b2cgeW91IHBvc3RlZCBhdCBodHRwczovL2ZhcnMuZWUvWEZ6UiBhcHBlYXJzIHRvIGJlIHVzaW5n
IHRoZQ0KPiBkZXZpY2V0cmVlIG9mIGEgTmV6aGEgbm90IHRoZSBMaWNoZWUgUlYgRG9jay4gV2h5
IGFyZSB5b3UgZG9pbmcgdGhhdCwNCj4gd2hlbiB0aGUgTGljaGVlIFJWIERvY2sgaXMgc3VwcG9y
dGVkIGluIHRoZSBrZXJuZWwgYWxyZWFkeT8NCj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCg==

