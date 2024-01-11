Return-Path: <linux-kselftest+bounces-2839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A382A8C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7350E1C21123
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49394D535;
	Thu, 11 Jan 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ckLtIGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F3D512;
	Thu, 11 Jan 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1gMUzdSAHv9y8dHC5WIRS9rycn20y6r4ksD/tQGXdSSQBamrfCDET/AytkAixP4cYbcLTPQPHslX6gmoRqdLdZCBERqG/eqUDrpF+E3CX57GTk58GHkPBlSZ0WXFMab8pnpvX8o9dqIe0TA7n3quJ4lF/pNsD04pt8YyZFg42ZrgWcvxAoGNVSE8lW2hJ/pXb5bcXhjAi3UaezNeMNAyVuNrB6pVdDuGKOPijTRghCx2Q1HaiYRDNsfNt8CW2ELHCNzHgVEfVZMrsUqO5u/uOGr7ZW15mfuPODL+NU/ZHxH9WSy3PH6UMzuHfEf7TkGRTT18uwzhr9MuQgfR7ZXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1IhLnpZ9LEaV5pZgt7+wzhJo4TGCzCowHdHQJvuv5w=;
 b=iJqCLRGkrCQlyAqHphyB9fevytC7GeCqblq462pPy0z410R3K9xC4visj3lRb3i7VenbSi0+DBAnrT1BgXb6t+SwARBUU3wwrVFzR1VTTSrUnMNE59MrptH85zjPxL/PGytZt4OgYJ27tuJ9ob02jJI6yuIOvCvUvlqHxUOXR8YY/2vgnErEuMhfXV3obx0vEPo4EX21jWh9VxbuAjOyaV66TdcnVaUjpTzQEbgOgZFpQpMnJ/PXHg6u+9ElUl4eOvow7MtmI6pSrAaSWMpS7+yCLFn+sCZwGkyZq4xxfEqSq/qpPIDtnQ2qng6OX+ugfd5aW0faN3wxexBRFPCBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1IhLnpZ9LEaV5pZgt7+wzhJo4TGCzCowHdHQJvuv5w=;
 b=4ckLtIGgw8Wvi5WI7ruJ+h7ce+uF2ytwpW3QK1hVdUpsZ1jAE8OEVO9rFdhLXRQpHdse1rGE+l481AWwwQ+rF4q0FLr9Yabio46BP1D4a9j0bmy+fnz0wGtRNPh28RDhIt3BCXCWXAYrFtPRCTYi2LsGmmb2h93lClnYQCiUj94=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Thu, 11 Jan 2024 08:10:48 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 08:10:48 +0000
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
Thread-Index: AQHaJ0WXc70+j+UhMEyCzlQ5Z3CFtLDRg0wAgAFSCWCAADTMAIABcn4w
Date: Thu, 11 Jan 2024 08:10:48 +0000
Message-ID:
 <DM4PR12MB6351BAC3EDC9BD184D5D1FAFF7682@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-2-li.meng@amd.com>
 <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
 <DM4PR12MB63515E818A5B4D5E512F5234F7692@DM4PR12MB6351.namprd12.prod.outlook.com>
 <20240110100402.GAZZ5rklxQUZk_KFV4@fat_crate.local>
In-Reply-To: <20240110100402.GAZZ5rklxQUZk_KFV4@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e4639cb7-8cc3-48cf-a6ff-098eaa2a83af;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-11T08:10:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|CY8PR12MB7564:EE_
x-ms-office365-filtering-correlation-id: 297d74fe-1b36-48c6-785d-08dc127cd1e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V7cO/F6RKZjZubF9R6ZWl2c5KKWIed6oy8EyEdCdKF+RgFntxypT7Y9EYQeuiY11iv0K12sU5FTRYJciavljW/b/jarCMiuJE6wL5z9QJV3ChDKAA4D64E7t98/ggfwDDUeEY+18SVgXW4viyeEFbwI8qok776O845Wa53QLKeKb1CSmlp5JE6igxCJeablSCixXVHyxrRfk2kVOK0ozX7wEUxq7pZeLdXusuVyDbNq5aKmA9GZ9g02b6E1O4DpJ0IR7rBUy70Pg60O+2MZaNS6xNQEzI1gFhSJv+y0O4BuCBfsbCyv4XKNrpqzpZAEa3pAxbtl6VqmZ+lZJGxXdplmDG7a6WZ5BjHWfc7ON0Nktz5Yif7m4tGki9nfahTbWVmb2yN7oY/P/QCfpr1um7RZI5LNlMEGE2K6HLBJa/5o9R8dYWmKkQmg6CMe3h3lP31TAoQGcv/jXxqjNuuU1J4fgPw88W50G9F7AcBgYc6Y33F8HdiqL1svMsNLPVEZ8npBH85mPkCrJpRtJDSNcfScVqdOolN/VuUI0IQmwTQhYF0+4wBPmXKnkkC34fdxVDdKAvMOgMzTy/VUHx7EJtgYqla/KNYJNsXDR0b6Jl1aopZJYxKUkpO3TzkKoGJGDDK3NIOmMhpKFsgPwEjsi4w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(83380400001)(71200400001)(966005)(122000001)(66446008)(64756008)(8676002)(52536014)(54906003)(66556008)(66476007)(4326008)(8936002)(6916009)(76116006)(316002)(66946007)(478600001)(55016003)(53546011)(9686003)(26005)(86362001)(7696005)(6506007)(33656002)(2906002)(5660300002)(7416002)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vzd1MkNZVS9Oa3BkNWJ0MTVhUGt2TisrWC9ydENNMllCakI2ODV0cG9tL2po?=
 =?utf-8?B?ZVdXa1dpZzVvY1J0ZHBkTHB6cTVHK3JzNGpuamc0MjNwNmZ1VjhzMDZuYTNU?=
 =?utf-8?B?algxOUxBT2tFRURaK1pYNVFMc0tuUGttbWtuUVhHNDFrMjh2NmZNMmJkMDgz?=
 =?utf-8?B?REZqbGY3TCt4bmJLWjZUYnA4SmFBbkF2NHIvK2pQVEE1UWNCaVk4eDhiK1dq?=
 =?utf-8?B?YWV4WXY0ZE9Mc05TVDB6ZDhjcVJLTGN4bTF6TURjVnZ2bmx5TlhsSTF0bmdh?=
 =?utf-8?B?cjBRVVJTZnh4eUFFUTdGcWdVeERLUlIxWmt6RWlhMitzTmJIQ3NoU0E3N01E?=
 =?utf-8?B?cFU3NDF4MDR5NnR4eVpMbFNGRDJ1VGNPYURyenJBYndxVzJmMWF2NGpnRzJB?=
 =?utf-8?B?WFBaOW4wSVBleHJhMTJpWnkyUExNaFozZWJrWW9WRXErNUVQSUJlczQvbGl2?=
 =?utf-8?B?RzFjRTRKcHBFS1FLYmpwSjlGV1pYM0hEY0RYSHYzVjdQYWNGWllGT3hEbkZU?=
 =?utf-8?B?azF1MkxYRVVMRFhxcTc0OTE3dlBXK2Z6TEo1eksrWGVMdEZwZWFES0ZTZEZi?=
 =?utf-8?B?REdRL0dFTzlibTQ5ME5zL3U3dmNJeGdhV283RGZEQ0FrSFZrTWw4Mjg1d2Iz?=
 =?utf-8?B?cXZnZ3FHRDlQN2k4QVBZdk9xWDlBR0gya3pFSWRHdmd5UU5rdnJxK1h5OFhG?=
 =?utf-8?B?U1lHeElrL0paSE0rNkNvOEJPd2ZHbXAySHFHUGUzYWlKL0hsL0lMQ2tMaUtk?=
 =?utf-8?B?Skt5UFFSQU5XTlJ5VVFuUmVNUVFoU1Z2Mm5yd29xeUdUVFlKRlR6SENDbmRJ?=
 =?utf-8?B?KzZTZkxEQSswMUxpQXRWYnkvNFZJSXlVdWZ2NUN2REV6cWE0YVVHN2NVMHVi?=
 =?utf-8?B?MHFCT3JGUEp5NXJhSXpVZ3o5Wk9kdmQrUVVYZVA3WEZYMmZKV0dzdlFmd1Jt?=
 =?utf-8?B?ZU5jUjdUd3FpRmNRNmNoUjhpQUx1dzZkY1ViR0FBdm42dnpwRHptODN1VUlL?=
 =?utf-8?B?S2U1WWJqNmVDNktEN29jcnNZcjJueW1yRWF6bm5LOEtNeDkvUVVTbFZMMHZE?=
 =?utf-8?B?WWkzdWxlTHZGbHMvRFJlK3dYNkl5U09qUnE5VXUzcVZpUDBIZ2x5UjB4dU9m?=
 =?utf-8?B?ajNFUm9NY05lTXh5enRPVHpjTEJENE51NHZWdEltaTg0a0Y0RjBsVHRJb2hz?=
 =?utf-8?B?MG1CUnhJQ25XWndGM0Y5d2ZLRzZPbEJoeUhGeFJzM3A5NnlsK0RUaSt3VUxS?=
 =?utf-8?B?Vk0xSkU1QlJVdDNCQ3ZSWmJxRmc2N0tpSmpXVHI3azJvNEt3eDJjNTJUMU12?=
 =?utf-8?B?MmlKTGxPZ2hhc2lMSzkvTFRNM1RkTk1MbDZRM3Z5TXdxUmVsNUt1SkRXallY?=
 =?utf-8?B?cmkvTDltSEcvazQxQk1UeTNna01SRm9Lblk3OE1STURDWW9hZnR6V2d2ZU4v?=
 =?utf-8?B?dXpUM3kzSmZnZHdFSy96SEllWGJBd2V1UE5pTVoyTllyRG9aVEhDTElKSGVs?=
 =?utf-8?B?R3ZmTmJjWmNXc3lPYWdUU0wwQ083dnpKUytnUExneC9VNzJoeTNMSTRXek41?=
 =?utf-8?B?ditlaE9zYkM2ZmRkWFB5MzRUUU1nU1NnNUt2ckhuWmlwYkZCaXp6ckM4azhX?=
 =?utf-8?B?ZkQwWFpPMjdpU1pOOG1iTlFuOWJ4Sk1WR0MydkZjRWkxdkpYc3ZKTnZQUHRM?=
 =?utf-8?B?K3ZCcko0MDVuRlJqdHlqcC9WM2Q1NkJJanVGUURBb2NRY2hCbEFtc2tZMm1R?=
 =?utf-8?B?eTVPMVNXRTEvR2xTVkNZU2kvQjBmQWJCeGp2U2xRRDNiUHVHbFhVd3NEQzc3?=
 =?utf-8?B?VWtrbXcrTlN1ZU9QNW1ndmlsZlBjU2t3cmk3cll3MFJVbk1yejBxTDRUcWpr?=
 =?utf-8?B?c2lFeitaUDZsd3czYTRyTDJGd0hxVjd3aWZvTURuY0hiaHBVUGNYTmZCQkpR?=
 =?utf-8?B?alFSZXZvajRzcWdSN2F2elpzSHVVdjJwWVVxWkpsVTgxTVkyOTI5MjFJM0Z4?=
 =?utf-8?B?bWJmQU5QeHNOU2locm9LRkFLZCtzUGQrUVZXS3RuM0FTdkJsNkJuKzNGbDN1?=
 =?utf-8?B?OW16TlM3bzNzYVVVbmJSOVhURExEeVl5QmZ6eTh1TDZjZ2dkN2dTdEUwVkp5?=
 =?utf-8?Q?W2Cc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 297d74fe-1b36-48c6-785d-08dc127cd1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 08:10:48.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKua1aLChHJa5YiXQdTOFMHcZNKyQf9mRcAEWZugl2a5WBCf14jCfv1iNw4wC1y+w1qd1LTsQpVvDQs+3VZabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBldGtvdjoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDEwLCAyMDI0IDY6MDQgUE0NCj4gVG86
IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT4NCj4gQ2M6IFJhZmFlbCBKIC4g
V3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXku
SHVhbmdAYW1kLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVs
Lm9yZzsgU2h1YWgNCj4gS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4LWtz
ZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEZvbnRlbm90LCBOYXRoYW4gPE5hdGhhbi5Gb250
ZW5vdEBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9u
Y2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEh1YW5nLCBTaGlt
bWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBh
bWQuY29tPjsgRHUsDQo+IFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgVmlyZXNoIEt1
bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47DQo+IE9sZWtzYW5kciBOYXRhbGVua28gPG9s
ZWtzYW5kckBuYXRhbGVua28ubmFtZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMTIgMS83XSB4
ODY6IERyb3AgQ1BVX1NVUF9JTlRFTCBmcm9tDQo+IFNDSEVEX01DX1BSSU8gZm9yIHRoZSBleHBh
bnNpb24uDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0
ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1l
bnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBKYW4g
MTAsIDIwMjQgYXQgMDY6NTk6MjVBTSArMDAwMCwgTWVuZywgTGkgKEphc3NtaW5lKSB3cm90ZToN
Cj4gPiBUaGUgcmVhc29uIHdoeSBJIGFkZGVkIHRoZSBzZWxlY3RzIGlzIGp1c3QgdG8gZGlzdGlu
Z3Vpc2ggZGlmZmVyZW50DQo+ID4gcHN0YXRlIGRyaXZlcnMuICBUaGVzZSB0d28gZHJpdmVycyBj
YW5ub3QgYmUgc3VwcG9ydGVkIHNpbXVsdGFuZW91c2x5DQo+ID4gaW4gdGhlIHNhbWUgcHJvamVj
dC4NCj4NCj4gTm8sIHRoYXQncyBub3Qgd2hhdCBJIG1lYW50LiBSZWFkIGhlcmU6DQo+DQo+ICIt
IHJldmVyc2UgZGVwZW5kZW5jaWVzOiAic2VsZWN0IiA8c3ltYm9sPiBbImlmIiA8ZXhwcj5dDQo+
DQo+ICAgV2hpbGUgbm9ybWFsIGRlcGVuZGVuY2llcyByZWR1Y2UgdGhlIHVwcGVyIGxpbWl0IG9m
IGEgc3ltYm9sIChzZWUNCj4gICBiZWxvdyksIHJldmVyc2UgZGVwZW5kZW5jaWVzIGNhbiBiZSB1
c2VkIHRvIGZvcmNlIGEgbG93ZXIgbGltaXQgb2YNCj4gICBhbm90aGVyIHN5bWJvbC4gVGhlIHZh
bHVlIG9mIHRoZSBjdXJyZW50IG1lbnUgc3ltYm9sIGlzIHVzZWQgYXMgdGhlDQo+ICAgbWluaW1h
bCB2YWx1ZSA8c3ltYm9sPiBjYW4gYmUgc2V0IHRvLiBJZiA8c3ltYm9sPiBpcyBzZWxlY3RlZCBt
dWx0aXBsZQ0KPiAgIHRpbWVzLCB0aGUgbGltaXQgaXMgc2V0IHRvIHRoZSBsYXJnZXN0IHNlbGVj
dGlvbi4NCj4gICBSZXZlcnNlIGRlcGVuZGVuY2llcyBjYW4gb25seSBiZSB1c2VkIHdpdGggYm9v
bGVhbiBvciB0cmlzdGF0ZQ0KPiAgIHN5bWJvbHMuDQo+DQo+ICAgTm90ZToNCj4gICAgICAgICBz
ZWxlY3Qgc2hvdWxkIGJlIHVzZWQgd2l0aCBjYXJlLiBzZWxlY3Qgd2lsbCBmb3JjZQ0KPiAgICAg
ICAgIGEgc3ltYm9sIHRvIGEgdmFsdWUgd2l0aG91dCB2aXNpdGluZyB0aGUgZGVwZW5kZW5jaWVz
Lg0KPiAgICAgICAgIEJ5IGFidXNpbmcgc2VsZWN0IHlvdSBhcmUgYWJsZSB0byBzZWxlY3QgYSBz
eW1ib2wgRk9PIGV2ZW4NCj4gICAgICAgICBpZiBGT08gZGVwZW5kcyBvbiBCQVIgdGhhdCBpcyBu
b3Qgc2V0Lg0KPiAgICAgICAgIEluIGdlbmVyYWwgdXNlIHNlbGVjdCBvbmx5IGZvciBub24tdmlz
aWJsZSBzeW1ib2xzDQo+ICAgICAgICAgKG5vIHByb21wdHMgYW55d2hlcmUpIGFuZCBmb3Igc3lt
Ym9scyB3aXRoIG5vIGRlcGVuZGVuY2llcy4NCj4gICAgICAgICBUaGF0IHdpbGwgbGltaXQgdGhl
IHVzZWZ1bG5lc3MgYnV0IG9uIHRoZSBvdGhlciBoYW5kIGF2b2lkDQo+ICAgICAgICAgdGhlIGls
bGVnYWwgY29uZmlndXJhdGlvbnMgYWxsIG92ZXIuIg0KPg0KPiBGcm9tIERvY3VtZW50YXRpb24v
a2J1aWxkL2tjb25maWctbGFuZ3VhZ2UucnN0DQo+DQpbTWVuZywgTGkgKEphc3NtaW5lKV0gVGhh
bmtzIGEgbG90Lg0KSSB3aWxsIG1vZGlmeSBpdCBzb29uLg0KDQo+IC0tDQo+IFJlZ2FyZHMvR3J1
c3MsDQo+ICAgICBCb3Jpcy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25v
dGVzLWFib3V0LW5ldGlxdWV0dGUNCg==

