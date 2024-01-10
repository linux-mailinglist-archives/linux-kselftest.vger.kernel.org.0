Return-Path: <linux-kselftest+bounces-2793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E39768293E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 07:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C62D1F26F48
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5D36AE3;
	Wed, 10 Jan 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ST/sDs+O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04136364A9;
	Wed, 10 Jan 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeQcnNVHi/PFlc8rxz823p5fPqRQnyeamRvCAavUeh2aBbqW2TkKlUpsSsG+tXgJvKYnsNid1dwnWJ04vZC1j0u8KsRofguH60av3Q7Hwu3yRUmVp7xL+c7pL/9XNtaGryMC8M2XedTBwb1PaZBPfWzJ71VU6OekJGjnHlB7XBOfo5IU2+/q0H2R5RC7dg2FBJ3SlBTPF9WVTFY7jKEBB9UQUs4iiSIwIdfGYawHrsUMWty0Kuo/M5/JsTXT637PJl1QotcNpd1hb9Xo+eZM21xCHjZlSbvX4xG4t8U7WM2n8lnWm4gzyncIHSpFAxKxeRJ+gug1aICJC42K5RZqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beyR14eBQHKGqlHewu6MCH+BRA1BLWMX/bDMrNvTDF0=;
 b=mn1bY0Mrt1NPYgtpYOjUjX6yHqrtkyNs2ANLiF0mxkSFmWlYgG8bsdjzPOYs9xCQ9k0AHACsCIlytGzVRjRmSaJYpMtxLoYEi+gQ7Xkx0zseNp3Bs4cqikc31YQOIATDr1etMzfnaEdGrua7AYpN9g9zYwyW5n47sjUTCZMeufKVQoMVOy3W3kodA0QKO0SZb3IMSa4RCqlgTnjS/Oj1xkCq6tcgV/Td/Hz3hC7h0JWW2iY60J5SHENyIq3DLywPvxYfIbiWMdp8Z8foEyzBpmjcecRMyiKRcHDA9+S69s8I48I747ghF1/eI93j1wYz+vlTHrsD9YQ6WhzCNXvhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beyR14eBQHKGqlHewu6MCH+BRA1BLWMX/bDMrNvTDF0=;
 b=ST/sDs+O9UvjqJXc6NbEBbcTl2PfBjcqr7k2UtTJIroXjbqUr2QX+8SKMYfyj9/VeTboS+XUTerzOI28K9gcBolB9b7ab8OvSE+PPpynQZqHFwcx6LbOG72wWGQwO5bqBmLnvs+TdP5w30v/e1xxmDZrntshDLacWAfc7YsMyU0=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Wed, 10 Jan 2024 06:59:25 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 06:59:25 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Huang, Ray"
	<Ray.Huang@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "Sharma, Deepak"
	<Deepak.Sharma@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, Oleksandr
 Natalenko <oleksandr@natalenko.name>
Subject: RE: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Thread-Topic: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Thread-Index: AQHaJ0WXc70+j+UhMEyCzlQ5Z3CFtLDRg0wAgAFSCWA=
Date: Wed, 10 Jan 2024 06:59:25 +0000
Message-ID:
 <DM4PR12MB63515E818A5B4D5E512F5234F7692@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-2-li.meng@amd.com>
 <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
In-Reply-To: <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9c987c83-9179-4efc-b879-a5b0d2216805;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-10T06:55:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|DM4PR12MB5793:EE_
x-ms-office365-filtering-correlation-id: c16f000d-565d-43ce-55db-08dc11a9ae5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +mUJV5mG6Cm2EjnOeiGvah+TcJIxjRH4iC+o++ze6QHhW9Ur2wL8GnHwwGb8wJC+BxFhgnm+Z1w4rBkKnjLnFqrWvAEcFPeJbhBNmRsrO+6d+W2Php4gl48s15eK8PX5Ptxfjf31RlzmvNmwVW1esBiu8Gt4nV+KW9gsf75A97xepufTLerIOwIpKKwGqXMuGau12QLGGoBk99Yx15DvrIekEBUXiVtoGHBcAcMsEks8VJ3efSFhk4PLL4VzsG07SxLDnCYcFvtYGh0xmagQ+7cHSaW6MLzsPNA7ldW1zIKmmjobB4hJmv5FukRb2/PIjQGnusANeEc1L0QMJ/x2FRdsQeAFv6DIcE3eCiDXaNJIh1lHhBAH4Bg0NYMhPaO/iCzjN3Ziv2TGjYn7Ms4DrN9bDLSeqMcR8k+8NChMYkkyS0WY4Sm5lbT603fYzl0qpYA/marh85COZo2OovHKP4fK85n9nHksttrlGVb7N+LhuobLxUuDDuLoskKiDVV7tKnokXxwv/xrRsjc4io8snOCQwBQgk8yC5e4mCO7vYez98Q2aR8RQc4so0M53HN3D8iyS3GmxabZACBdEkcH8zMV1eGpV4b1FC7sobA8BEbEpVruZERai47ock6s3Z+bJ+C9oJHUkqw/xul1fzbDAg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(2906002)(7416002)(5660300002)(38070700009)(41300700001)(478600001)(38100700002)(966005)(122000001)(52536014)(83380400001)(71200400001)(55016003)(9686003)(26005)(53546011)(33656002)(6506007)(7696005)(86362001)(66556008)(4326008)(8936002)(8676002)(66476007)(66446008)(66946007)(64756008)(54906003)(316002)(76116006)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmM4Yk5HVEdmQ1A5Zm1McXI2MmQ5Q1NDSVl6MFo5VGFSaG5uRWRXUkhoYSs3?=
 =?utf-8?B?OUpNSGNPc1p5ekNtZUJMeDdNTWdEOUtjYW5YN1Jjai9wdFZ0M3BEQkpaa2tI?=
 =?utf-8?B?N0FFNFByQnNlUzMzZzlSV0hVMGJ0Y2ZVYUhnT3A1d3IzMit4amVOTFRZNm56?=
 =?utf-8?B?SmNMS2NQTVdrSGp6NTNCNlYwNDBGdFR4a1VzZkpTYUNpUURCUy9YRUIwb3Qz?=
 =?utf-8?B?S1JKL1l2YUs3SEtZb1RwZVZQUzd6ZjBCWWl4U3NTcUZtVnh2QmluRENyMmIx?=
 =?utf-8?B?K1BSbS94MjlyVUc3cWdsM1Y1S2tLYWJIQWlkVVhLMFZYbVZFL2oyVSsvZmxo?=
 =?utf-8?B?TEFWTXVTalMxMnZkVnNsWWpDYUUwZFFWNk9pcnV3RVdTalVqQ1JUWFhFTjZZ?=
 =?utf-8?B?ODhKSHZuVFUxKzNmNXdJUmlhMStjUmRPVGZQbkhoWWVpQ3ZkeSt2a2ZPY05y?=
 =?utf-8?B?NlpKdG5MV0k1cEJTUmx1b1FubEZ2bVNFQjZ2TjVCQ25xd21FeWlLaTFpYWpv?=
 =?utf-8?B?NmkvNGVGWXRNdTNQdS8reE5IMGNab25xbmp6UEdrYTNkdEhiemhWNFY4c1dS?=
 =?utf-8?B?cW5rT2M0ZmVaMHVMVlZjT3B1YWlmVTRTaHBpTHRoVjNSY1FrL2tpQThVUm8y?=
 =?utf-8?B?MjY0KzdZYk5EV1N4U1N5NjM3NUlWbzZmODRvSlhwV0xYMzdZa0RPdDNqZmhN?=
 =?utf-8?B?NkVyMjhhQXd5eXVpcm5LU1I1V0xBK2JZbXB6ckFwR1ZHQjMzeW0zbG5wT2RS?=
 =?utf-8?B?ZDVhcGxCL2tZOW9OMUNHRmlycDY1Y2dPanpqRnZ0Mzl3SVp0UWRlSldoU3Bw?=
 =?utf-8?B?Qk5IUTlPYXF6MVNBTjY3MUVkMXdaclc5VVZVYjFEZDgwMXhqNWxJM3JIaVNx?=
 =?utf-8?B?QllwSFpSTy9wRkVsVG9KQys4YnFDUmZVeTllOG54bjNyanM1eHpTeFM4NjV3?=
 =?utf-8?B?VTNoZk83OWtFbDUxK1prTzRVMjlOaUNNSnNtb2FmWG9SY2wyWE5nZVAwcmhH?=
 =?utf-8?B?VmRyNmdicDdyVU1kUWJ4ejhJR1Jhd0g2KytvV0tVNEFkOC91YU1aNk5ZVlhn?=
 =?utf-8?B?WEtUc2FoZzlnYzJKdzVZblNNTDRUQkw2QnA4SGVoMnI2bHdZWlNSYmVXcDho?=
 =?utf-8?B?ZSsxRE9IOWhBZGQxRWtVcG42R25wS1VVUWVyY3RtZForYlNCeG5OYzdiVzJh?=
 =?utf-8?B?cSs0U0NhUHNiVnMwLzA4Ymt1SXN2NG1mYnJXdGxQT2pFbC83Q1dEYWlRV3Jh?=
 =?utf-8?B?bEltcGFPT09CUXc3SVo1N0IrSGRMbTUrbEg3VzFiKzFGYWU4VjY1Mmd2WE9U?=
 =?utf-8?B?UVRMaTRIU2RjaDBRSXhDZmxDbjVrQjFROXk0ZDBpOXRsQUdYT3JJVHdzblVt?=
 =?utf-8?B?eG50bFowOVV4NVdzYTdvL3Q5M3hVMEYzWEdZanprZ3lzTjl6WjVVNm5lcXh3?=
 =?utf-8?B?My92N0FzNGN6U21FdUdUWVU5WWtObTBvY1k4YTd5eTJ1V0NXUlZoYkttMmFC?=
 =?utf-8?B?Ym5lTGJhbU4zbzlSL0FPZHlvSkJKWjFpK1lIYUZmd3BTeGxjTUQ1MmRPT09U?=
 =?utf-8?B?bkV2RldyVTFxOGVCRU1iWUFRN3lpYVFkTmxHYWJpMDR0WjhsVHB2YUp6VFFV?=
 =?utf-8?B?L2RVa2VBMjdoWWpBM0VnS3loVGFPcjlwN0s5bmVjTURqTkQvVngvL0xZOHFz?=
 =?utf-8?B?czZDMkk0d3FRbWd6S3J2dE45V2EyMVFITVR3VTNNY2hFbVJkM1R1YTZGUEh2?=
 =?utf-8?B?bHo4ekxpV3cvbHY1Y1lhNnBTUXNCemRtM0Ezd0RPM2c1WUVvb3MrUGlzclhs?=
 =?utf-8?B?QXY2cm4ySXBRL2VFelB6VHJpSjFoQWttVTY3NUdzU04rSG9BS0RSaC9JYklK?=
 =?utf-8?B?WkE2ZG1UQVA3SzZGNkR1cVdCL1FyWnpCM2cyNGxRMTJSaFhXRk1SWVFDWHhm?=
 =?utf-8?B?cDd3dURyM1UwNExBYnVtSmFUUmppTXh3Z3M2aDQ1T2tuS2ZXQ0w2eG9xZ3p5?=
 =?utf-8?B?TUF6bEFoemJwQXM1dkhPbEV0TGJVVnFpelJ2cmo4cVB5Z2dIWXFhR3lpdDk5?=
 =?utf-8?B?N281SW5pMlBML2k4dlFEUm9sUWFGb2c2SlAwTW5RM1ozTERxTVZLMEZQU0VU?=
 =?utf-8?Q?7Zm4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16f000d-565d-43ce-55db-08dc11a9ae5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 06:59:25.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBWRKZZmrSPagrh6Dq/fRzxZVLjSUaPz9o2U4bz97nL1wN6pxyx4uJ10FkzZtlSDBxGlCn9QECEuldXJ+ooZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBldGtvdjoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA5LCAyMDI0IDY6NDUgUE0NCj4gVG86IE1l
bmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKIC4gV3lz
b2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXkuSHVh
bmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsgU2h1YWgNCj4gS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LWtzZWxm
dGVzdEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhhbi5Gb250ZW5v
dEBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2ll
bGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEh1YW5nLCBTaGltbWVy
DQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQu
Y29tPjsgRHUsDQo+IFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgVmlyZXNoIEt1bWFy
IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47DQo+IE9sZWtzYW5kciBOYXRhbGVua28gPG9sZWtz
YW5kckBuYXRhbGVua28ubmFtZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMTIgMS83XSB4ODY6
IERyb3AgQ1BVX1NVUF9JTlRFTCBmcm9tDQo+IFNDSEVEX01DX1BSSU8gZm9yIHRoZSBleHBhbnNp
b24uDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJu
YWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRz
LCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVHVlLCBEZWMgMDUs
IDIwMjMgYXQgMDI6MzU6MzFQTSArMDgwMCwgTWVuZyBMaSB3cm90ZToNCj4gPiBhbWQtcHN0YXRl
IGRyaXZlciBhbHNvIHVzZXMgU0NIRURfTUNfUFJJTywgc28gZGVjb3VwbGUgdGhlDQo+IHJlcXVp
cmVtZW50DQo+ID4gb2YgQ1BVX1NVUF9JTlRFTCBmcm9tIHRoZSBkZXBlbmRlbmNpZXMgdG8gYWxs
b3cgY29tcGlsYXRpb24gaW4ga2VybmVscw0KPiA+IHdpdGhvdXQgSW50ZWwgQ1BVIHN1cHBvcnQu
DQo+ID4NCj4gPiBUZXN0ZWQtYnk6IE9sZWtzYW5kciBOYXRhbGVua28gPG9sZWtzYW5kckBuYXRh
bGVua28ubmFtZT4NCj4gPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxsaS5tZW5nQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gveDg2L0tjb25maWcgfCA1ICsrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvS2NvbmZpZyBiL2FyY2gveDg2L0tjb25maWcgaW5kZXgNCj4gPiAzNzYyZjQxYmIwOTIu
LjNlNTc3NzNmOTQ2YSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnDQo+ID4gKysr
IGIvYXJjaC94ODYvS2NvbmZpZw0KPiA+IEBAIC0xMDU0LDggKzEwNTQsOSBAQCBjb25maWcgU0NI
RURfTUMNCj4gPg0KPiA+ICBjb25maWcgU0NIRURfTUNfUFJJTw0KPiA+ICAgICAgIGJvb2wgIkNQ
VSBjb3JlIHByaW9yaXRpZXMgc2NoZWR1bGVyIHN1cHBvcnQiDQo+ID4gLSAgICAgZGVwZW5kcyBv
biBTQ0hFRF9NQyAmJiBDUFVfU1VQX0lOVEVMDQo+ID4gLSAgICAgc2VsZWN0IFg4Nl9JTlRFTF9Q
U1RBVEUNCj4gPiArICAgICBkZXBlbmRzIG9uIFNDSEVEX01DDQo+ID4gKyAgICAgc2VsZWN0IFg4
Nl9JTlRFTF9QU1RBVEUgaWYgQ1BVX1NVUF9JTlRFTA0KPiA+ICsgICAgIHNlbGVjdCBYODZfQU1E
X1BTVEFURSBpZiBDUFVfU1VQX0FNRCAmJiBBQ1BJDQo+ID4gICAgICAgc2VsZWN0IENQVV9GUkVR
DQo+ID4gICAgICAgZGVmYXVsdCB5DQo+ID4gICAgICAgaGVscA0KPiA+IC0tDQo+DQo+IEkgd2Fz
IGdvbm5hIGFzayB3aHkgdGhlIHNlbGVjdHMgYnV0IGFwcGFyZW50bHkgbWluZ28gd2FudHMNCj4g
U0NIRURfTUNfUFJJTyB0byBiZSBzZWxlY3RhYmxlIGVhc2llcjoNCj4NCj4gMGEyMWZjMTIxNGEy
ICgic2NoZWQveDg2OiBNYWtlIENPTkZJR19TQ0hFRF9NQ19QUklPPXkgZWFzaWVyIHRvDQo+IGVu
YWJsZSIpDQo+DQpbTWVuZywgTGkgKEphc3NtaW5lKV0gVGhhbmsgeW91IGZvciB5b3VyIGZlZWRi
YWNrLg0KVGhlIHJlYXNvbiB3aHkgSSBhZGRlZCB0aGUgc2VsZWN0cyBpcyBqdXN0IHRvIGRpc3Rp
bmd1aXNoIGRpZmZlcmVudCBwc3RhdGUgZHJpdmVycy4NClRoZXNlIHR3byBkcml2ZXJzIGNhbm5v
dCBiZSBzdXBwb3J0ZWQgc2ltdWx0YW5lb3VzbHkgaW4gdGhlIHNhbWUgcHJvamVjdC4NCj4gU28s
DQo+DQo+IEFja2VkLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgKEFNRCkgPGJwQGFsaWVuOC5kZT4NCj4N
Cj4gVGh4Lg0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+DQo+IGh0
dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

