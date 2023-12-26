Return-Path: <linux-kselftest+bounces-2434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939881E5E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 09:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD11C2092D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FC4CB41;
	Tue, 26 Dec 2023 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1qMvt2ZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659194CB20;
	Tue, 26 Dec 2023 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKIHGAAtZ+giM+uBGHH58GvjcN4+MmkNb1Ob4SMhdOgEtXSkzt29QHaFJFYO+4AczqKn3VVWxfBq+hDO8aMiAsbrqjabmevOmTbIGpM1c7Uh3iSakOSJTdwBFUNqupK1VVDDfA6l2VzYhKcHq2W7Lyd5Z8H8TOoZR8D6+ftHi5rxvgoiB20xod8vB/2is/p5U8dET1fg7BLkArHXXFoSJEulNs+BYTerfnUD+eNHb9vzKHRex1ywiS587nnmB95YC9qdt/8CbnK9a26K4rNVydNvHznqaTdqEDLCe0IhvBGzoaGA5hFoJcsTO7LM65MqyzotzUgrUHh0FAZLYEIzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzIdO7qFRkg+XptifVAGvI8R+4a04eS5drt6kbYqP3g=;
 b=LG2kKQybXc8c4fVMOEHwSP8ySjAak2Gel0yABQrG2S9UFET5wEdOXY7yvLSqPnmi9jYX9xhNtPpAPouwfmO72unEv7tTQs1/ZXIPM4HIeJKw4D/fQvj+o8aCTecBcUZsF0g7+a3w4UHvpypnVZFC7+Zk9J858jGh1JID38Pv5XhMWTrjC2yS2SJ0LCpKaATBcc8TSr/dY/lZc8fo9jqHIO5KJDJ+ypfhPdm22EksC1Tfpds+sWCUkj4fwcJTWKnrOXs8PIFkBNonFX4YUUbOmrvO3n+lublocL66BiiErI0tBzemOPCHT69tvBYDrJ1QVh4G7EPyudf4xJNbxPUsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzIdO7qFRkg+XptifVAGvI8R+4a04eS5drt6kbYqP3g=;
 b=1qMvt2ZCgdf1hCFSIBjV7stNQ2qIJc74SVWiaTVMqJU2L1PUVEaDofqtYhUSPbFrDUJHeu+EJD+6J9XF5AR2NRQuYF3APP9KMKNnV2VSwePzURWxqOLkmUmVjJu8s09L5lLCod84TBQG6REKsjx8CFMBnMw/TuxBgxuLwbhAIOE=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:26:37 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:26:37 +0000
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
Thread-Index: AQHaJ0WuWo9iSLqM/0qg4FT2xB5FTLCcv2UAgAAECwCACPB0AIAVnU0Q
Date: Tue, 26 Dec 2023 08:26:37 +0000
Message-ID:
 <DM4PR12MB635185821F31AFB0D2655D01F798A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-5-li.meng@amd.com>
 <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
 <CAJZ5v0hMAZxvuMWK3dNeOL9FRTrVW7j7PzCFwcp9+0K87y-L0A@mail.gmail.com>
 <CAJZ5v0gYj6C_-m7dD_aN-FWiuLn6bG9MRTe_c7SryTtJJN7FKA@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0gYj6C_-m7dD_aN-FWiuLn6bG9MRTe_c7SryTtJJN7FKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e132bc8-0836-4f40-bb21-ce6178f6c119;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-26T07:48:09Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|BL0PR12MB4900:EE_
x-ms-office365-filtering-correlation-id: 4c709dea-f863-4a7c-3583-08dc05ec6098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 39s6wTO896nXvyeAT4SaWjaRj45u0TjSxtKHB36Og/c5E/27zI5Jv2jL4zWAgtwOcWV5sPlBbXFjqduiSB22ogzuRxkDiJ+poqcMOCe+VFCdty7ULlUMdjxzWwn/NnAqOBWr2RixuLOewwWtxKVIVwd/m0JVQcvOD+NUWwctZCjl1jKHQx3NZO7Jo3KpFqjlZxH0W+c9OCEqaD59tMrzla3bCdUwTZdjhpWiRmIAyUp4fiGAhwF4YxE7SrHdPsr8ScyNlgYSTYXiGDr2TgEk3AK5HpFWUNiVTzxbVR4u+PjzxCySbtTZrrReE+/JD+ew6pbSX/W0rtBcGmrOA31sDUXVindG6D0xmoUp3tGPOLa7ZkuYFJ+OmN+w41uDdGfYViAcqozTI/hW6FsfbNiAtr1zNjYM24LBAdksfXh3Xd4azmP8ox2c7L/HOY6+oRD6lswMUwXOmhUKoN+jScQj231ygb5CWCMBWd2cWzIAip+ImkMVPsyOT+c0atEZClWfmGz/F66rY4XePvXziv2rKMF87BfIrQThBV+jHtJWNAsL77oYGVSEX1lxJX7kA2RMQeduCgZHfM32j8KAA04pQrca9ywYh7j0Sv2swah3w5+qeQWDO+L6Xq3fjmYXPSK4MJ6FTV6hesPxpoBZRHz/acq0A0eGuQAopFVhsXZrV4YvfqfKOyc8JoN4NIgCPiZf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(346002)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(8936002)(8676002)(71200400001)(33656002)(7696005)(478600001)(86362001)(6506007)(966005)(26005)(53546011)(9686003)(38070700009)(122000001)(38100700002)(83380400001)(41300700001)(54906003)(6916009)(64756008)(66556008)(66446008)(76116006)(66946007)(66476007)(15650500001)(5660300002)(2906002)(7416002)(55016003)(52536014)(4326008)(226483002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlIyb05KZHJiMlJyQ3pJUGVhZ0h0Wm1PTWpFenVjR21DanFHQ0cvd0ZTaUEr?=
 =?utf-8?B?Qmk0VHYyOGNabnpablIzQ3d3Ym43S1EzcFZyaDA3ZTdycHVtVi9SRkNGVWJ4?=
 =?utf-8?B?K0Foc0krWUtleEJYM2V2UFhqYTdYZm1ZNFgxL3pmSFNVRWJXOVZBQmNUQVQ2?=
 =?utf-8?B?eHorQW9QdlRKQ1lqOTB2VGhZNlU0d21mVFZGTzFSeTQ0QkRMT055ODdLMXl3?=
 =?utf-8?B?MVZjSkdaRmlBd2wwcmhEUXF3WUF1dHB4ZFRueUFjOUR0OStNbnRKK1Yxb1I1?=
 =?utf-8?B?K3BkRW8xNnY1WU96SWtmM3hpSmFYUnpMVFZJeUorZ3RlOEJpakhjbFA3U04z?=
 =?utf-8?B?ZUJER0dwanNGVE1tUzNzTlVuS0g1dWFZTlhGYkZEbU8rcDNNZ1htZW9FWVcw?=
 =?utf-8?B?enltbGJUbUlqZWZXZHJvR3FNM1ZJamdjbldoM0tLWGRYTlhsdSt1cHc4TXpP?=
 =?utf-8?B?RlBhZVc4MWhsSXFOTFc1d0I4K1dwbHRTbUljbGNTOGx0RzNvQnBLbVc3emNQ?=
 =?utf-8?B?T1dWUG5JNGpJTFhJSEhIdi8zaStHK0ZZY1hwRWhuTWE2c08ydG01YWpMcTlS?=
 =?utf-8?B?NzRhQUJ2Ny81dWxWb1dIeit6MWM2TmhnNkZXdjRlb25MNUtjb3ZibEc5MDkr?=
 =?utf-8?B?dG1CdzRUQ010Nk9TT3doT3lJWTZDRUFmUGJiWUVmSndSc2lpV2RqWVgxZUdn?=
 =?utf-8?B?WUJzQXVXVUNCc1czY3MzZGNFd1hzdUs5UjhNMllRVDFKOGZhcStvM1AyOUFC?=
 =?utf-8?B?eWFBYkNrUUxuRzBHaXdNenAwSDVzNGZhMjhTYUZ5bDUrTjJ0a2cwYVZwZlA2?=
 =?utf-8?B?K2ltVVdqVnVSREJRZkZGVFY5Q2lTVXNNVGpZWS9uSDZuZjVYUmFaSVQ0U0hM?=
 =?utf-8?B?ekRBVVJLbG94R0lMdXB2RWdWd05OM2U2UVFUL1NIM0NZb25IQ0JxeUhpclJS?=
 =?utf-8?B?M2p5SjJZVTIyS05vNXA2cUswT25TUlNOSXgrT1hsZ3ZpNWRoK3kyQUYvUXFN?=
 =?utf-8?B?UGd5TFNoblBVK1hCVEUrMFpvSXlSMTlVUCtkU1dwVGFleTA2SEl6eFdnTDV2?=
 =?utf-8?B?LzJRM0k4cUM1Q0RYY2MxSVBINGNIdXpjZzhQbndhYVZ4UWRRYkxKQjYwN09Z?=
 =?utf-8?B?Rk9FVE5KQ0d3NDB1LzdRLy81Wjd2K0NMRnBWUnBFZGl3N3ZvczJxdVlUYWxk?=
 =?utf-8?B?ekR2YnJPZC8rWjJVRkZYQjRHSlVrUzRzVUxERURRZUE3bmdpdTlidklxVHRo?=
 =?utf-8?B?a2JoQ3g4bW1haWdOZXY2VTFBS3FySmxlMGgzb0hTN09oVWdKdjZPN2VMNk4z?=
 =?utf-8?B?c1ZSRkdKMW9aWGtXMnNtNklyeHBmWUJqVFB4aFpjMXFrTXd1Y2VDcVB6UHpt?=
 =?utf-8?B?RmYwaDRhbUs0OHhVaVUvRUJjWFBJS2FleGFicGRtSC9oOHErRk9jTFNwRkxZ?=
 =?utf-8?B?bklvbmU3NE0rbUM3bEtKT09DNnB1b0Z3TlEvZktQRlJmUWJvQVRRM2YxL2Vx?=
 =?utf-8?B?dmREVkxxVDAxc3RTMmxWMmFyS0FLaDZZU3BGWGZSQUhDWC9xNG5BVjRDRlE4?=
 =?utf-8?B?UWdRdDFZM1c4NkMzNzM2dEIzVzJYZ2prU0tKNmlra1lYcWthbVUvSElVcFFL?=
 =?utf-8?B?ZjZrY0hUTm9iQmxjakpZQVFQaURMZHVRRlo0Vk9ENkk4OVU0L0Y5YmxRVGty?=
 =?utf-8?B?dndyUDBNZ3B6SGpWSWpPT3hCcTlGb05VK0o0WWd0VnpoRGVTSDQ0MS9uamZX?=
 =?utf-8?B?cktRaVZlWkNJRHRneHhFOEg5NjFrQ2lRTVhZYi9MVzZvTDdWMU5oc2FOTk9h?=
 =?utf-8?B?azhhYUhnZ1JRVUhYckZMSFlXZFJlMTM2RE5hQldGamhEc0hqKzNScUNGcXp2?=
 =?utf-8?B?VndiREZxbVI5MjhUblEvMkdQOExKRVhMYWR5OVhLNGwxVjVRRDlKUXlVb2hk?=
 =?utf-8?B?MWdneHZkbU91OEIrRVB5a2xBdVNINVIvS3J6WWlSc1NhQ3VRU1VvcDFLYmNT?=
 =?utf-8?B?YWhlN3N2cmpaK1IrTHlyUDhBMUl1dExYVE1mVHpPOXZhbk9XSWlvZnk4SDJO?=
 =?utf-8?B?cGdGQVBtckxxOTJsZW5CYmtxdEFaMG1pVDhTSzBIQlo4ZURQcmVURGFqV0g0?=
 =?utf-8?Q?ocMA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c709dea-f863-4a7c-3583-08dc05ec6098
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 08:26:37.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImiSNllOpi4N/ydvLkciorBmbhN708aVEAODdSh7BQgA3snUqAxCWRAbqYqqInENoLVm0c2uyP1KGMt/ibBAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbDoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEyLCAyMDIzIDk6NDQgUE0N
Cj4gVG86IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT4NCj4gQ2M6IFJhZmFl
bCBKIC4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBIdWFuZywgUmF5DQo+
IDxSYXkuSHVhbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIu
a2VybmVsLm9yZzsgU2h1YWgNCj4gS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IGxp
bnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhh
bi5Gb250ZW5vdEBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEh1YW5n
LCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnku
WXVhbkBhbWQuY29tPjsgRHUsDQo+IFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgVmly
ZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47DQo+IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgT2xla3NhbmRyIE5hdGFsZW5rbw0KPiA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxMiA0LzddIGNwdWZyZXE6IEFkZCBhIG5v
dGlmaWNhdGlvbiBtZXNzYWdlIHRoYXQgdGhlDQo+IGhpZ2hlc3QgcGVyZiBoYXMgY2hhbmdlZA0K
Pg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNv
dXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xp
Y2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgRGVjIDYsIDIwMjMg
YXQgMTA6MTPigK9QTSBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gT24gV2VkLCBEZWMgNiwgMjAyMyBhdCA5OjU44oCvUE0gUmFmYWVsIEou
IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBU
dWUsIERlYyA1LCAyMDIzIGF0IDc6MzjigK9BTSBNZW5nIExpIDxsaS5tZW5nQGFtZC5jb20+IHdy
b3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBBQ1BJIDYuNSBzZWN0aW9uIDguNC42LjEuMS4xIHNwZWNp
ZmllcyB0aGF0IE5vdGlmeSBldmVudCAweDg1IGNhbg0KPiA+ID4gPiBiZSBlbW1pdHRlZCB0byBj
YXVzZSB0aGUgdGhlIE9TUE0gdG8gcmUtZXZhbHVhdGUgdGhlIGhpZ2hlc3QNCj4gPiA+ID4gcGVy
Zm9ybWFuY2UNCj4gPiA+DQo+ID4gPiBUeXBvcyBhYm92ZS4gIEdpdmVuIHRoZSBudW1iZXIgb2Yg
aXRlcmF0aW9ucyBvZiB0aGlzIHBhdGNoLCB0aGlzIGlzDQo+ID4gPiBraW5kIG9mIGRpc2FwcG9p
bnRpbmcuDQo+ID4gPg0KPiA+ID4gPiByZWdpc3Rlci4gQWRkIHN1cHBvcnQgZm9yIHRoaXMgZXZl
bnQuDQo+ID4gPg0KPiA+ID4gQWxzbyBpdCB3b3VsZCBiZSBuaWNlIHRvIGRlc2NyaWJlIGhvdyB0
aGlzIGlzIHN1cHBvc2VkIHRvIHdvcmsgYXQNCj4gPiA+IGxlYXN0IHJvdWdobHksIHNvIGl0IGlz
IG5vdCBuZWNlc3NhcnkgdG8gcmV2ZXJzZS1lbmdpbmVlciB0aGUgcGF0Y2gNCj4gPiA+IHRvIGZp
bmQgb3V0IHRoYXQuDQo+ID4gPg0KPiA+ID4gPiBUZXN0ZWQtYnk6IE9sZWtzYW5kciBOYXRhbGVu
a28gPG9sZWtzYW5kckBuYXRhbGVua28ubmFtZT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1hcmlv
IExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4gPiBSZXZpZXdl
ZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6
IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
TWVuZyBMaSA8bGkubWVuZ0BhbWQuY29tPg0KPiA+ID4gPiBMaW5rOg0KPiA+ID4gPg0KPiBodHRw
czovL3VlZmkub3JnL3NwZWNzL0FDUEkvNi41LzA1X0FDUElfU29mdHdhcmVfUHJvZ3JhbW1pbmdf
TW9kZWwNCj4gPiA+ID4gLmh0bWwjcHJvY2Vzc29yLWRldmljZS1ub3RpZmljYXRpb24tdmFsdWVz
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9kcml2ZXIuYyB8
ICA2ICsrKysrKw0KPiA+ID4gPiAgZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYyAgICAgICB8IDEz
ICsrKysrKysrKysrKysNCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvY3B1ZnJlcS5oICAgICAgICAg
fCAgNSArKysrKw0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZl
ci5jDQo+ID4gPiA+IGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9kcml2ZXIuYyBpbmRleCA0YmQx
NmIzZjA3ODEuLjI5YjJmYjY4YTM1ZA0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9kcml2ZXIuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkv
cHJvY2Vzc29yX2RyaXZlci5jDQo+ID4gPiA+IEBAIC0yNyw2ICsyNyw3IEBADQo+ID4gPiA+ICAj
ZGVmaW5lIEFDUElfUFJPQ0VTU09SX05PVElGWV9QRVJGT1JNQU5DRSAweDgwDQo+ID4gPiA+ICAj
ZGVmaW5lIEFDUElfUFJPQ0VTU09SX05PVElGWV9QT1dFUiAgICAweDgxDQo+ID4gPiA+ICAjZGVm
aW5lIEFDUElfUFJPQ0VTU09SX05PVElGWV9USFJPVFRMSU5HICAgICAgIDB4ODINCj4gPiA+ID4g
KyNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfTk9USUZZX0hJR0VTVF9QRVJGX0NIQU5HRUQgICAgICAw
eDg1DQo+ID4gPiA+DQo+ID4gPiA+ICBNT0RVTEVfQVVUSE9SKCJQYXVsIERpZWZlbmJhdWdoIik7
DQo+IE1PRFVMRV9ERVNDUklQVElPTigiQUNQSQ0KPiA+ID4gPiBQcm9jZXNzb3IgRHJpdmVyIik7
IEBAIC04Myw2ICs4NCwxMSBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gPiBhY3BpX3Byb2Nlc3Nvcl9u
b3RpZnkoYWNwaV9oYW5kbGUgaGFuZGxlLCB1MzIgZXZlbnQsIHZvaWQgKmRhdGEpDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICBhY3BpX2J1c19nZW5lcmF0ZV9uZXRsaW5rX2V2ZW50KGRldmljZS0+
cG5wLmRldmljZV9jbGFzcywNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfbmFtZSgmZGV2aWNlLT5kZXYpLCBldmVudCwgMCk7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gKyAgICAgICBjYXNlIEFDUElf
UFJPQ0VTU09SX05PVElGWV9ISUdFU1RfUEVSRl9DSEFOR0VEOg0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgY3B1ZnJlcV91cGRhdGVfaGlnaGVzdF9wZXJmKHByLT5pZCk7DQo+ID4gPg0KPiA+ID4g
QW5kIHRoZSBkZXNpZ24gYXBwZWFycyB0byBiZSBhIGJpdCBhZC1ob2MgaGVyZS4NCj4gPiA+DQo+
ID4gPiBCZWNhdXNlIHdoeSBkb2VzIGl0IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCBjcHVmcmVx
Pw0KPiA+DQo+ID4gV2VsbCwgY2xlYXJseSwgY3B1ZnJlcSBjYW4gYmUgYWZmZWN0ZWQgYnkgdGhp
cywgYnV0IHdoeSB3b3VsZCBpdCBiZQ0KPiA+IG5vdCBhZmZlY3RlZCB0aGUgc2FtZSB3YXkgYXMg
aW4gdGhlDQo+IEFDUElfUFJPQ0VTU09SX05PVElGWV9QRVJGT1JNQU5DRQ0KPiA+IGNhc2U/DQo+
ID4NCj4gPiBUaGF0IGlzLCB3aHkgaXNuJ3QgY3B1ZnJlcV91cGRhdGVfbGltaXRzKCkgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvPw0KPg0KPiBTZXJpb3VzbHksIEknbSBub3QgZ29pbmcgdG8gYXBwbHkg
dGhpcyBwYXRjaCBzbyBsb25nIGFzIG15IGNvbW1lbnRzIGFib3ZlDQo+IGFyZSBub3QgYWRkcmVz
c2VkLg0KW01lbmcsIExpIChKYXNzbWluZSldDQpTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVwbHkg
dG8gdGhlIGVtYWlsLg0KQklPUy9BR0VTQSBpcyByZXNwb25zaWJsZSB0byBpc3N1ZSB0aGUgTm90
aWZ5IDB4ODUgdG8gT1MgdGhhdCB0aGUgcHJlZmVycmVkIGNvcmUgaGFzIGNoYW5nZWQuDQpJdCB3
aWxsIG9ubHkgYWZmZWN0IHRoZSByYW5raW5nIG9mIHRoZSBwcmVmZXJyZWQgY29yZSwgbm90IHRo
ZSBpbXBhY3QgcG9saWN5IGxpbWl0cy4NCkFNRCBQLXN0YXRlIGRyaXZlciB3aWxsIHNldCB0aGUg
cHJpb3JpdHkgb2YgdGhlIGNvcmVzIGJhc2VkIG9uIHRoZSBwcmVmZXJyZWQgY29yZSByYW5raW5n
LCBhbmQgcHJpb3JpdGl6ZSBzZWxlY3RpbmcgaGlnaGVyIHByaW9yaXR5IGNvcmUgdG8gcnVuIHRo
ZSB0YXNrLg0K

