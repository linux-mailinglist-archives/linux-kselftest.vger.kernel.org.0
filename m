Return-Path: <linux-kselftest+bounces-2452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9481EB53
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79A282BE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E831FBE;
	Wed, 27 Dec 2023 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sZrGJnT1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF61FA3;
	Wed, 27 Dec 2023 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CleVff1GH+Ahr8Qn9z9voMGG/j0jSfMvggY8iEc5ZQHhvp+eSUMEvRl81vYtfwkcqlt/hVKN5BIXgTjkjitxHrxRzEkW4WUv7NOLM6O4oLcvIKRvJTauc8qdoWWeg2Kj2KDoVWcnWiQRPuWqXKnEIup1s/tX06+hGdVESAI8RPrHusms6kIvXlBw8UAtRxCuWtfSkmuPBZTzrGfbSOQoBu73b0v+R5El2SaE5HcUBG3k68I58XPRDhr45c4bh6t3Iry0xFjZEelAVcJTuVnUK8BfQsszMzBzU+nrW9UMW9NlKR5499g5TFP5bzxrVACEHyLiEmmjEH8+0sI6sjTR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbVrQmadz4vQBTRKrTUPbLvi8gsT/6vGkwifjWXKiQo=;
 b=WSpV4wyNhYeNlVQn36HbenIIb6H+19maMCVlBcK3Rubwjkifd1hN/t2aZy89XQzoyNC+3UPKdN+phIOhHOg76W3WkBbxzhbgNntFdvyy+5ZuL4eJBXoyWg8hBAHYLp5pMGC2gS4BrswjeoSI2Up1D0OLdqeTv53BB7a9DuJBhhkJw7ANifvMcN4mzS8c/Q2b6TVHusr8+xjI8busF1Z37BGB+eiYma+IHnYwS+spUNYtFVB9pN75aLcaXssm5xSDGny5rbdnUtW59qChTlRkBab2C2jW9Mk/4uEacPYcCMpADu4XZD9H46YqFnd6+6CYDTPjjnDEKG7UZ506HTAwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbVrQmadz4vQBTRKrTUPbLvi8gsT/6vGkwifjWXKiQo=;
 b=sZrGJnT1tE+xLXZp3cLmbx2yenYPZqCl8QfMIclRgiebcZgvpNbRRonX6h0Ww7VItu7vNyt/+TsWrbHch8uIggR1mduhnsiLxkZIwXThh1K6bvl2K0iQwm+q5Q0QW7z8vOt9pl7Dkw8Us/ctRXbQlht9CxNpSi3oYiJXrPk690g=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.27; Wed, 27 Dec 2023 01:40:06 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 01:40:06 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
	<Xiaojian.Du@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, Borislav
 Petkov <bp@alien8.de>, Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: RE: [PATCH V12 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Topic: [PATCH V12 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Thread-Index: AQHaJ0WuWo9iSLqM/0qg4FT2xB5FTLCcv2UAgAAECwCACPB0AIAVnU0QgAETMWA=
Date: Wed, 27 Dec 2023 01:40:05 +0000
Message-ID:
 <DM4PR12MB6351C4ADE9E48A06482027B0F79FA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-5-li.meng@amd.com>
 <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
 <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
 <CAJZ5v0gYj6C_-m7dD_aN-FWiuLn6bG9MRTe_c7SryTtJJN7FKA@mail.gmail.com>
 <DM4PR12MB635185821F31AFB0D2655D01F798A@DM4PR12MB6351.namprd12.prod.outlook.com>
In-Reply-To:
 <DM4PR12MB635185821F31AFB0D2655D01F798A@DM4PR12MB6351.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e132bc8-0836-4f40-bb21-ce6178f6c119;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-26T07:48:09Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SJ0PR12MB6855:EE_
x-ms-office365-filtering-correlation-id: 09c4c62a-76e3-45cf-f046-08dc067cc097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bfErxDeuKrQRHT5HdhLSvH8mb58yw9LwMHeZj/DU6S4cBYTlvQ6zonwWHu6PbX4dDmkXAg8W+jG5wBGYQgQnQOeAL8ckfdrVm/hr1NUUEplTNY7ozojvC2dHeBDSgLTqGxDBqrdkOPtjv7mH/CbXFn3rkaKmX8IRWlx+Wb7qiHvGpu0j9a0y2X97U7AMqsScFcB8aV0+iuXhFwejKtEmQEi3SzQssSX0J2rkKYgbhuKBTBKfuSzXEVADa+h5ehsxUyAvjqg323f1cWfIa8Pqd+m5k7nAEObkLndVE0KJasijl9sod25bIyIxF8Olg0beqZyf4Q0oO0Nu0oa5c2K8fxiAiET7yE/NXi5UcjEw7cAp22YbePt2zBC/tlCuyrbDLSAShv3x1VexqYJyJSDiPtj/egtW1qgbRdlbQK+nCzL+B0ComyuPHQcgHf4N/qW+IhTfYCSSpjh6qfOi8JZGQA3HzOwrR/Jq/wpGJ0EwylNKJIgJL3YaiYXXuEuoEFB4MZeXDLFCJAsYFPkcBxRHms2scTS15Hjpr8DvZq/1aBhX0Eg67kE9jttxzi7w2+gcBS2ZAa+vDM7aBB8CVVnhzTPsRNLpmUvyJL9Tiw+E3Y7MhlbMob4EoDh0WDEcxoeiWHwNTcZxsL1ANfe3ONVpXE9juiDn3kbItgJoUJD2pAw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(38100700002)(122000001)(26005)(54906003)(316002)(4326008)(52536014)(8936002)(8676002)(7416002)(2906002)(15650500001)(5660300002)(478600001)(71200400001)(53546011)(6506007)(9686003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(966005)(7696005)(6916009)(86362001)(38070700009)(33656002)(55016003)(226483002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0FyTDBFem1FVVAzaTRyWERwTkg3S1ZnTEVURXRMVTJOdC9qOE1UcXpvUkxW?=
 =?utf-8?B?YkM0R3lCNDFjQStYNkQ2SGloZmNkWWhIZTFuUWtBR21MNEJZOHhCa2c2OUM0?=
 =?utf-8?B?MnIwWHVnK0FVd283bU4rZzhuQll2aDlqYlhOOWJKK2Uyc2hFeHVrTld3MHJ4?=
 =?utf-8?B?OEQ1dm8xWVkxRUJUeXV5ZmZqYnVlK1QrVVJGclZNTjVYWkFRNjJIcVEzVEt2?=
 =?utf-8?B?YzBTUGRGcWgwMFFQVzZJM3NiRUZIaytYblRnOWRnOGx4YkV6bUxBWFQ1eU1w?=
 =?utf-8?B?b2RobVZlTnJFcWIvazM4cElSUkdkQ3NTWFNyWThBNGFnSWVvUWRHbmhSaUtv?=
 =?utf-8?B?L0x1blV2cmgxVGJpRisxYzZ0R1lFcVNWelNLNkh1dHJxV3Y0WTFMRnpNekRz?=
 =?utf-8?B?bEZnL3ZWWm1WMUJleGFpZ2U1L2JGTk5QM0FjUjFXdUV6U29JTkJZWExpUUNM?=
 =?utf-8?B?NHkxc1pVZW04MEZuME9jelYwWG03MWRsWHN4QzZMaDJLQUxjeFRDV1lPbFln?=
 =?utf-8?B?TVVkT2lMRjlwdzZoejVYRDNmN0w5ZXJ2UEdKNDI5c2plV1cvWXJscExUb3lh?=
 =?utf-8?B?VUNMaHlBNzJ3eno4ZkdSOXlSMzR2SEpsa2lNWUtmTldYaC9GVFR1UFhNblpH?=
 =?utf-8?B?dVg5SFNTT0grdlFmc0NTWnh5MjI4TEVxNkczdVBGQ0hoT1pWKzRkbGFDYldL?=
 =?utf-8?B?aFFsZ040Z3FDY0R5ZWo3aFRrcllRejUzbS9nYkRZZ0ZweFpsdFE0anVnV3Nv?=
 =?utf-8?B?eFdhYlBMQm5zYmduY2xvUjRDbTVUeDdXeVNpQWtxVnZCdFIzdGdad244STFl?=
 =?utf-8?B?eWdEU1B0bkVFVFJpR3kySHAvcG8yWjVKNktITU11eHRRY2syU1c1WnpKR1cw?=
 =?utf-8?B?S3FhZmdyWXY3YUFzUW1CZlVuS01RZExsRms4VWhRSDBXRVRERlBPTytnNUJw?=
 =?utf-8?B?V2d0UHpCMzMzeTc0ellocTVLL0ovQndUNU00YzMyMndEcGdGSHd3Z0x5Z0hS?=
 =?utf-8?B?a1JCc0tXbVMvVjhuNXRGUkdJQm1IclViRjRtTmlZT2QvMjRDT3JtNEU1TG5j?=
 =?utf-8?B?OVpVZTNhVUxtVWhoZHdGL0NXcTZtemZNTitPUVhrcGNmbml6N05iSFhRT0tB?=
 =?utf-8?B?VTYvUjdwYm1jRzVaZkpSSm1yMC9sMU1FbHpvQ0hmTkRvaUppaG5LM0dabVht?=
 =?utf-8?B?blpCQ3ZpMUw3NTUrT1YwMUZFRmhuUHhmUGZiazhZVjY0RTNhTzVBb3ZqNGJO?=
 =?utf-8?B?STBYdlk3QzRTek5DMjAzLzhmSWc0a1JNazlYM1ozdVNaU2Z5NVRFeE00bTVX?=
 =?utf-8?B?b04yM2Y1UmV5TWZ1Wk5xMXRxMVlUSWtpbkE0N0l2alk5UEFmVnB3c1l2c1Nt?=
 =?utf-8?B?MEx6aUJKSHlsUmxSSDlvekI0SmtXTW5GVEZRNVZGd1hnYm9yY0ZZYlR2bytS?=
 =?utf-8?B?eEVDQ2RVckdwY1dNZVk0ZDlxV215UU4xU3ZOL2RFMWZZUGtEK2V5ZGtIY2Nu?=
 =?utf-8?B?eFJhL1VJSzZUcmVUbnNzYUxXM3k0VldqN01SZ1o2dk5aZ1hmK3U1NlV2UFBu?=
 =?utf-8?B?WXRYaUhocWR3eTBCVDAxUll5SlZlSzNQWHBFZGp1d2FWUEd0QmxDekQ3dEhJ?=
 =?utf-8?B?ZVc5bzg3ZEd4NjR3K1pVUEdxbTVSTGQ5cXhGRFY1MGJrVkRreStjazFDSk96?=
 =?utf-8?B?MDJEcXhLZHdlMUFzTFNnWTR2bEFGUW1qOThOQk53b3VlajBaZFBselpNWk5L?=
 =?utf-8?B?L0RON1BGR253UjhjUmVJVXFxVmpWNHFQR1o4ajRiS2paU3RRWUhtdE9sVkt5?=
 =?utf-8?B?L1RIMzh0TXd2VlhLNktuRVVMeTFlYnlUbC81dUR6a2MrbU1HZUl5Wm1kUGJr?=
 =?utf-8?B?U3NuUWJhbThhck1tWHRFUHFSRk16WVNHdUZ4TmUranJBL212dnNIT1RpdUJq?=
 =?utf-8?B?ZHlQKzEzVWtTdURZN0h3TVlIbGlEMkpFQ2gxNG5ySjJISkxTanZMQmZzSXQ5?=
 =?utf-8?B?LzBNRFc0NlBVZVVhVnRIY2RQS3Foc1ZCTm5KamhUa29ZK0ROekI3VGZ1OHVt?=
 =?utf-8?B?U3UvWFdzWFFHbGg4U2lkcW9VU1pjekJOMjNRYnpPcldGUjFmeU9zUU1VRlp4?=
 =?utf-8?Q?qGkk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c4c62a-76e3-45cf-f046-08dc067cc097
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 01:40:05.6494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMHZ35An7DcFtzwUVaNCZX6fN4L18oFBQKn3yuLs+2wlLGv/BrBZn4eexAg7t3uJ9iLC9v/Ur9FOdS+Jm8Y+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbDoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNZW5nLCBMaSAoSmFzc21pbmUpDQo+IFNl
bnQ6IFR1ZXNkYXksIERlY2VtYmVyIDI2LCAyMDIzIDQ6MjcgUE0NCj4gVG86IFJhZmFlbCBKLiBX
eXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gQ2M6IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFm
YWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNv
bT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgU2h1YWgN
Cj4gS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29t
PjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJp
bw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGlt
bWVyLkh1YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgRHUs
DQo+IFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gu
a3VtYXJAbGluYXJvLm9yZz47DQo+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgT2xl
a3NhbmRyIE5hdGFsZW5rbw0KPiA8b2xla3NhbmRyQG5hdGFsZW5rby5uYW1lPg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIFYxMiA0LzddIGNwdWZyZXE6IEFkZCBhIG5vdGlmaWNhdGlvbiBtZXNzYWdl
IHRoYXQgdGhlDQo+IGhpZ2hlc3QgcGVyZiBoYXMgY2hhbmdlZA0KPg0KPiBIaSBSYWZhZWw6DQo+
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+ID4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTIs
IDIwMjMgOTo0NCBQTQ0KPiA+IFRvOiBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5j
b20+DQo+ID4gQ2M6IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+OyBIdWFuZywgUmF5DQo+ID4gPFJheS5IdWFuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyB4ODZAa2VybmVs
Lm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gU2h1YWggS2hhbiA8c2toYW5A
bGludXhmb3VuZGF0aW9uLm9yZz47DQo+ID4gbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9y
ZzsgRm9udGVub3QsIE5hdGhhbg0KPiA+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFNoYXJt
YSwgRGVlcGFrDQo+IDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+Ow0KPiA+IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbw0KPiA+
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIu
SHVhbmdAYW1kLmNvbT47DQo+ID4gWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IER1
LCBYaWFvamlhbg0KPiA8WGlhb2ppYW4uRHVAYW1kLmNvbT47DQo+ID4gVmlyZXNoIEt1bWFyIDx2
aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IEJvcmlzbGF2IFBldGtvdg0KPiA+IDxicEBhbGllbjgu
ZGU+OyBPbGVrc2FuZHIgTmF0YWxlbmtvIDxvbGVrc2FuZHJAbmF0YWxlbmtvLm5hbWU+DQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCBWMTIgNC83XSBjcHVmcmVxOiBBZGQgYSBub3RpZmljYXRpb24g
bWVzc2FnZSB0aGF0DQo+ID4gdGhlIGhpZ2hlc3QgcGVyZiBoYXMgY2hhbmdlZA0KPiA+DQo+ID4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXINCj4gPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4NCj4gPg0KPiA+IE9uIFdlZCwgRGVjIDYsIDIw
MjMgYXQgMTA6MTPigK9QTSBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+
ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBEZWMgNiwgMjAyMyBhdCA5OjU44oCvUE0g
UmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBUdWUsIERlYyA1LCAyMDIzIGF0IDc6MzjigK9BTSBNZW5nIExpIDxsaS5t
ZW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQUNQSSA2LjUgc2VjdGlv
biA4LjQuNi4xLjEuMSBzcGVjaWZpZXMgdGhhdCBOb3RpZnkgZXZlbnQgMHg4NQ0KPiA+ID4gPiA+
IGNhbiBiZSBlbW1pdHRlZCB0byBjYXVzZSB0aGUgdGhlIE9TUE0gdG8gcmUtZXZhbHVhdGUgdGhl
IGhpZ2hlc3QNCj4gPiA+ID4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4gPg0KPiA+ID4gPiBUeXBvcyBh
Ym92ZS4gIEdpdmVuIHRoZSBudW1iZXIgb2YgaXRlcmF0aW9ucyBvZiB0aGlzIHBhdGNoLCB0aGlz
DQo+ID4gPiA+IGlzIGtpbmQgb2YgZGlzYXBwb2ludGluZy4NCj4gPiA+ID4NCj4gPiA+ID4gPiBy
ZWdpc3Rlci4gQWRkIHN1cHBvcnQgZm9yIHRoaXMgZXZlbnQuDQo+ID4gPiA+DQo+ID4gPiA+IEFs
c28gaXQgd291bGQgYmUgbmljZSB0byBkZXNjcmliZSBob3cgdGhpcyBpcyBzdXBwb3NlZCB0byB3
b3JrIGF0DQo+ID4gPiA+IGxlYXN0IHJvdWdobHksIHNvIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8g
cmV2ZXJzZS1lbmdpbmVlciB0aGUNCj4gPiA+ID4gcGF0Y2ggdG8gZmluZCBvdXQgdGhhdC4NCj4g
PiA+ID4NCj4gPiA+ID4gPiBUZXN0ZWQtYnk6IE9sZWtzYW5kciBOYXRhbGVua28gPG9sZWtzYW5k
ckBuYXRhbGVua28ubmFtZT4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVs
bG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFBlcnJ5
IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNZW5n
IExpIDxsaS5tZW5nQGFtZC5jb20+DQo+ID4gPiA+ID4gTGluazoNCj4gPiA+ID4gPg0KPiA+IGh0
dHBzOi8vdWVmaS5vcmcvc3BlY3MvQUNQSS82LjUvMDVfQUNQSV9Tb2Z0d2FyZV9Qcm9ncmFtbWlu
Z19Nb2RlbA0KPiA+ID4gPiA+IC5odG1sI3Byb2Nlc3Nvci1kZXZpY2Utbm90aWZpY2F0aW9uLXZh
bHVlcw0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2Ry
aXZlci5jIHwgIDYgKysrKysrDQo+ID4gPiA+ID4gIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLmMg
ICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gPiA+ID4gIGluY2x1ZGUvbGludXgvY3B1ZnJl
cS5oICAgICAgICAgfCAgNSArKysrKw0KPiA+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Fj
cGkvcHJvY2Vzc29yX2RyaXZlci5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29y
X2RyaXZlci5jIGluZGV4DQo+ID4gPiA+ID4gNGJkMTZiM2YwNzgxLi4yOWIyZmI2OGEzNWQNCj4g
PiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2Ry
aXZlci5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9kcml2ZXIuYw0K
PiA+ID4gPiA+IEBAIC0yNyw2ICsyNyw3IEBADQo+ID4gPiA+ID4gICNkZWZpbmUgQUNQSV9QUk9D
RVNTT1JfTk9USUZZX1BFUkZPUk1BTkNFIDB4ODANCj4gPiA+ID4gPiAgI2RlZmluZSBBQ1BJX1BS
T0NFU1NPUl9OT1RJRllfUE9XRVIgICAgMHg4MQ0KPiA+ID4gPiA+ICAjZGVmaW5lIEFDUElfUFJP
Q0VTU09SX05PVElGWV9USFJPVFRMSU5HICAgICAgIDB4ODINCj4gPiA+ID4gPiArI2RlZmluZSBB
Q1BJX1BST0NFU1NPUl9OT1RJRllfSElHRVNUX1BFUkZfQ0hBTkdFRA0KPiAweDg1DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiAgTU9EVUxFX0FVVEhPUigiUGF1bCBEaWVmZW5iYXVnaCIpOw0KPiA+IE1P
RFVMRV9ERVNDUklQVElPTigiQUNQSQ0KPiA+ID4gPiA+IFByb2Nlc3NvciBEcml2ZXIiKTsgQEAg
LTgzLDYgKzg0LDExIEBAIHN0YXRpYyB2b2lkDQo+ID4gPiA+ID4gYWNwaV9wcm9jZXNzb3Jfbm90
aWZ5KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50LCB2b2lkICpkYXRhKQ0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICBhY3BpX2J1c19nZW5lcmF0ZV9uZXRsaW5rX2V2ZW50KGRldmljZS0+
cG5wLmRldmljZV9jbGFzcywNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldl9uYW1lKCZkZXZpY2UtPmRldiksIGV2ZW50LCAwKTsN
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ID4gKyAgICAgICBjYXNl
IEFDUElfUFJPQ0VTU09SX05PVElGWV9ISUdFU1RfUEVSRl9DSEFOR0VEOg0KPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICBjcHVmcmVxX3VwZGF0ZV9oaWdoZXN0X3BlcmYocHItPmlkKTsNCj4gPiA+
ID4NCj4gPiA+ID4gQW5kIHRoZSBkZXNpZ24gYXBwZWFycyB0byBiZSBhIGJpdCBhZC1ob2MgaGVy
ZS4NCj4gPiA+ID4NCj4gPiA+ID4gQmVjYXVzZSB3aHkgZG9lcyBpdCBoYXZlIGFueXRoaW5nIHRv
IGRvIHdpdGggY3B1ZnJlcT8NCj4gPiA+DQo+ID4gPiBXZWxsLCBjbGVhcmx5LCBjcHVmcmVxIGNh
biBiZSBhZmZlY3RlZCBieSB0aGlzLCBidXQgd2h5IHdvdWxkIGl0IGJlDQo+ID4gPiBub3QgYWZm
ZWN0ZWQgdGhlIHNhbWUgd2F5IGFzIGluIHRoZQ0KPiA+IEFDUElfUFJPQ0VTU09SX05PVElGWV9Q
RVJGT1JNQU5DRQ0KPiA+ID4gY2FzZT8NCj4gPiA+DQo+ID4gPiBUaGF0IGlzLCB3aHkgaXNuJ3Qg
Y3B1ZnJlcV91cGRhdGVfbGltaXRzKCkgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvPw0KPiA+DQo+ID4g
U2VyaW91c2x5LCBJJ20gbm90IGdvaW5nIHRvIGFwcGx5IHRoaXMgcGF0Y2ggc28gbG9uZyBhcyBt
eSBjb21tZW50cw0KPiA+IGFib3ZlIGFyZSBub3QgYWRkcmVzc2VkLg0KPiBbTWVuZywgTGkgKEph
c3NtaW5lKV0NCj4gU29ycnkgZm9yIHRoZSBkZWxheWVkIHJlcGx5IHRvIHRoZSBlbWFpbC4NCj4g
QklPUy9BR0VTQSBpcyByZXNwb25zaWJsZSB0byBpc3N1ZSB0aGUgTm90aWZ5IDB4ODUgdG8gT1Mg
dGhhdCB0aGUgcHJlZmVycmVkDQo+IGNvcmUgaGFzIGNoYW5nZWQuDQo+IEl0IHdpbGwgb25seSBh
ZmZlY3QgdGhlIHJhbmtpbmcgb2YgdGhlIHByZWZlcnJlZCBjb3JlLCBub3QgdGhlIGltcGFjdCBw
b2xpY3kNCj4gbGltaXRzLg0KPiBBTUQgUC1zdGF0ZSBkcml2ZXIgd2lsbCBzZXQgdGhlIHByaW9y
aXR5IG9mIHRoZSBjb3JlcyBiYXNlZCBvbiB0aGUgcHJlZmVycmVkDQo+IGNvcmUgcmFua2luZywg
YW5kIHByaW9yaXRpemUgc2VsZWN0aW5nIGhpZ2hlciBwcmlvcml0eSBjb3JlIHRvIHJ1biB0aGUg
dGFzay4NCltNZW5nLCBMaSAoSmFzc21pbmUpXQ0KRnJvbSBBQ1BJIHY2LjUsIFRhYmxlIDUuMTk3
IFByb2Nlc3NvciBEZXZpY2UgTm90aWZpY2F0aW9uIFZhbHVlczoNCkhleCB2YWx1ZSAgICAgICAg
ICAgICAgIERlc2NyaXB0aW9uDQoweDgwICAgICAgICAgICAgICAgICAgICBQZXJmb3JtYW5jZSBQ
cmVzZW50IENhcGFiaWxpdGllcyBDaGFuZ2VkLiBVc2VkIHRvIG5vdGlmeSBPU1BNIHRoYXQgdGhl
IG51bWJlciBvZiBzdXBwb3J0ZWQgcHJvY2Vzc29yIHBlcmZvcm1hbmNlIHN0YXRlcyBoYXMgY2hh
bmdlZC4gVGhpcyBub3RpZmljYXRpb24gY2F1c2VzIE9TUE0gdG8gcmUtZXZhbHVhdGUgdGhlIF9Q
UEMgb2JqZWN0LiBTZWUgU2VjdGlvbiA4LjQuNS4zIGZvciBtb3JlIGluZm9ybWF0aW9uLg0KDQow
eDg1ICAgICAgICAgICAgICAgICAgICBIaWdoZXN0IFBlcmZvcm1hbmNlIENoYW5nZWQuIFVzZWQg
dG8gbm90aWZ5IE9TUE0gdGhhdCB0aGUgdmFsdWUgb2YgdGhlIENQUEMgSGlnaGVzdCBQZXJmb3Jt
YW5jZSBSZWdpc3RlciBoYXMgY2hhbmdlZC4NCg0KSSB0aGluayB0aGV5IGFyZSBkaWZmZXJlbnQg
bm90aWZ5IGV2ZW50cywgc28gdGhleSBuZWVkIGRpZmZlcmVudCBmdW5jdGlvbnMgdG8gaGFuZGxl
IHRoZXNlIGV2ZW50cy4NCg0KQWxzbyBzZWU6IGh0dHBzOi8vdWVmaS5vcmcvc3BlY3MvQUNQSS82
LjUvMDVfQUNQSV9Tb2Z0d2FyZV9Qcm9ncmFtbWluZ19Nb2RlbC5odG1sI3Byb2Nlc3Nvci1kZXZp
Y2Utbm90aWZpY2F0aW9uLXZhbHVlcw0K

