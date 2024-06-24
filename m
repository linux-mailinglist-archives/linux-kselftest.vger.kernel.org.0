Return-Path: <linux-kselftest+bounces-12528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D101091402A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AFF1F23217
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013628C13;
	Mon, 24 Jun 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0nOOsq9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF41C2C6;
	Mon, 24 Jun 2024 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193430; cv=fail; b=HZ+BuipP2tHeGP3LFvIepFAO0BYvN9tbhTh2ZF1r53MjJBMY2t/J8HZVmEDtxe+mHgSTZS/ueIUINliKmzdk3QJjyjsWsjjEXCAv1jq1xEDKM4ilXWmfAt52AVY7eIJ9STLLhUfMh/XjIt+xyB8SnJ+9gDTOkqc17d3Z6kIqKBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193430; c=relaxed/simple;
	bh=Q72BqOPsb9SS3tUSxrvmNW6Ag85m0YBEMyBuqXPhE+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxymoO0k2nnGnjTEFYsfTD0GTiILGBS02tBqtxQ7xbS6DKiCZpxWkVt8g4CDKVwb6z/umikvPibze7wzDdppPIEIsHRr6/eXwCg8S0ZmWTJbKaffBqFEKBjIKAtvqcw4IdsJBYoyPYjou9e4u5Q6hCglyRlNvhx1DIgdD1NNt0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0nOOsq9; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK8UejZxAsDVxyERLid3HJ/fcG46kbG//23eJ0TWiFB4rKy135XCQlHOBolyH+g3IO6jQXECA75iR/6iEvihelCNwu9KDYLfCNeOvdgQpcuZmAYKjyTgRI5WCbRlJ+nMIANVRNUIB7z/t2l87tcfyKsOrYYjCYy+w2zUL4m8e8FUEBE8mjKVt8ou6qMJFDZwGDA/R0NCQlrdQTVcqHGuoLloQuwKf+sUkGzJKwwht5HXELjJ+X4BIhSbqEwPYKKpHUbKQ0+R4ivL8XP7yfqYMoyLksY3e/N3jZnvA55wqD9kJdbXRxxpbgRHrB3E84YZgM4GoSqKdihOlNLHFMMHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbaNp7PX8ey1YwhpobrtkKNe8mUcIOgaCnmynQ15AlU=;
 b=PLrYWbxmXeFhuQvelBXitKDEPmVwgJK6DGLhXp14VYH4VtXyNNssT7IInR38f2nl+OB6jaxEnkgvagd06C+CFOuS+UBujQ/r3WpQYGXE5975OlAcsysYw/16EFZpPqVOhYobCbHXRuMYqUMTsFix5YuyfSeJG5WW/WzmhPzCBmK/s1uPVdqlNG1acrU6PhvaO9ihhUBWeH/MhNsYsCRWU/fYho7G07V93Qu+3SVZaOMTR78XCRQxLNAQsGH94iOv9B9E0M8BZvKxs45m2UsOAVa3qPVRQyAJUjCoN1Zpe2HY+Y9gGAGBdAm6z7xPPLPCiumO3MpcbxJsuSiAkZI2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbaNp7PX8ey1YwhpobrtkKNe8mUcIOgaCnmynQ15AlU=;
 b=g0nOOsq9QiPO1E43aFK0r4supQb+1AlPuvXPr9Zo4tnhHCh1Tx3PSqWfGRwfXjGkHitKwNZ+euxqydWeJHTmDAeB+smiyoQFJ1+ToHbxZQi/vjQXNECMC7xHi9rvdPgmM7vgCZXgJe6CTCcY32Tr7kp3kcNj7JpfZ4pue6vNowCS8RRajQgyOAoCbz+ve8A6aUvPnxprdLQp1PXP6jvnuyJQmw1OBOp5FEd8GJ7CP4WgFAdPWLuJbtGZ+vxNTTfTArHY9B4Ysu7BWT4KLJFnluiP9qPNiMI3HR1gdI8mvfzpRUq7LZgQVVULq/XX4bUqArnc5N744po8GoZzzyq4JA==
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Mon, 24 Jun
 2024 01:43:44 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::c28c:f5f4:7b8:e636]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::c28c:f5f4:7b8:e636%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 01:43:44 +0000
From: Joseph Jang <jjang@nvidia.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "shuah@kernel.org" <shuah@kernel.org>, "avagin@google.com"
	<avagin@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>, Koba
 Ko <kobak@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
Thread-Topic: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
Thread-Index: AQHarXsP3fmz/hMmlEegF586aQVuz7HRN3IAgAWgyoA=
Date: Mon, 24 Jun 2024 01:43:43 +0000
Message-ID: <c0db5bd6-8c6a-4017-911e-f3e01cd522ed@nvidia.com>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
 <20240620193654d3cd1f05@mail.local>
In-Reply-To: <20240620193654d3cd1f05@mail.local>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: IA0PR12MB8374.namprd12.prod.outlook.com
 (15.20.7698.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8374:EE_|SJ0PR12MB7034:EE_
x-ms-office365-filtering-correlation-id: 7ae8ab96-48e5-451e-d9cf-08dc93ef150c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?9k57Z+Z2w9vdret4hweM1A1SRvI+iAh+TyI8D6b6VfQU4KNr+mLUxNnU?=
 =?Windows-1252?Q?mnhVAf5BjJrft1XxoIkcEv80T8T6p/EqBWZS9iHBzvVfeyijof96YfFg?=
 =?Windows-1252?Q?jQ8r5nivZejiOx8HnagXqrJ1U1GY7gV2N2VWwYknF78ku9jPwqRxXTFo?=
 =?Windows-1252?Q?DGtxQbBTbaVkn6b7V/2GDSMvfE4CVGIqOxyZAAuSyox2xXciyeizpkua?=
 =?Windows-1252?Q?eK2rSEFvgvvBqJzWcK5wttUDC7IRavTDo3nJ4avYpXvU1yaKEuLo7ai3?=
 =?Windows-1252?Q?tXDEb0RxPsdO2EEs0OQPZPtHRuVH0dL3IBe96KnDI1XU7QdkXEdyTjxn?=
 =?Windows-1252?Q?xGb1Xpkf7eMmHsrO7/mNRi3R0a4/UytOmx/4XBfb1CWctnZAEXuq03vS?=
 =?Windows-1252?Q?wnFziw/b+JgDvPF5eow8vgUEMyqlRUphJiyn0Pya7x1S9RmPvl++4UjD?=
 =?Windows-1252?Q?G28W/cj3Hudob8vZNxU3Q74IrwIu+r2RE4gmc+uZKoTnku8rILf7Pv2I?=
 =?Windows-1252?Q?n/ajfWEEqMQNbHt/G4jclwIGB+6I83OSwEmpUHMlSw+x/6HYA+HxFwWm?=
 =?Windows-1252?Q?sQT+bBcWJWhYZykz6XZhT8mKa2yzeEskv8qNHf6DnsChls/TpUBj5ZVT?=
 =?Windows-1252?Q?AZPmwgyulgTi43duH6YYvB7crAmyFIydAoaPIB8HJcm/gSZsG2OwEUPu?=
 =?Windows-1252?Q?nQzfGBTkTAhmflgHIJ7/9DL1MMfAp38qESt1ntukBSj45n2kzvmC6kQ1?=
 =?Windows-1252?Q?4yLL6Vx95vp+cT5GfKJRZ3b488dihyJY+A5Uud+1hVcNSapAVYF6eFhy?=
 =?Windows-1252?Q?Am/m+j6EzJRmZ0yv3JZt2r5Sz+0+ISmjJWq6tf7JqhLeMWY9jdrkdwKE?=
 =?Windows-1252?Q?e7PDSe6zBgKatd8sZ71lV1deMNnFKst9hkyrH/2SR46SWEYkkABJkWIH?=
 =?Windows-1252?Q?wPAGgizGOATJ0EvYH5ND0Cty1REh7tBLEbzsIdd/ljNgykGyfVF8IsK3?=
 =?Windows-1252?Q?nJwClK5QhSH6ACueJOr2GI7pqLXqEh4rjfd2QpRwz9ttwrrgK5/dIWh0?=
 =?Windows-1252?Q?TJirNky852ynxzLQsslCRybVLj7B3WTp5IHheBG/mlu9Me/MzTo3Cpfx?=
 =?Windows-1252?Q?lBDoUuq6svgdGpSF8gqrfsfj2hdNHiZ2IdfFXufk9FoHCG5JjmkpkDny?=
 =?Windows-1252?Q?DfvTnyA2vaHJFSSdos568MVGqyW/mwLEaSRDZEbP1EywHXc983UlgO8B?=
 =?Windows-1252?Q?ktOE5yQLyJofpRu/Y4MumjPT2YDpZzjnUwXMl7aWiuixdIWjhtDRk6nV?=
 =?Windows-1252?Q?VET5vtiyo7JSFOvAEcwBfzcgDZCR06BDVhdJabclAUdG6fTMtDPBCZrJ?=
 =?Windows-1252?Q?ZatcvlQHJZhAG2Wt0xeKWCbSf5jl3/56B2MkBGoYpNcifYwmKOh75V4f?=
 =?Windows-1252?Q?a9TJT06rkqVewQi2uHIBtv2La/pFL4irv5DuVcFw6to=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?UsK4rYsWx8o5L7SkdqFTxqvYtTYUiK2RmAhrG3k1PuJtZP1jBi3t11v6?=
 =?Windows-1252?Q?gs9fpSorf2cGhlEhGHe9N5kb3B2U5j3j9KbRvY7FqZKgnXc+3HIVlkde?=
 =?Windows-1252?Q?JGkyuVg23vlkVEcpNo5iAvUpQPKNpGAJeOf9Bke6OecyEAUEpOVX/MoX?=
 =?Windows-1252?Q?5gNdkUWLWFHUHudNBomhItWpSEWwik1qIksSka+EpWtFRtlTgQy/1ht6?=
 =?Windows-1252?Q?83PBSxqlRpT4+WYeRwh6TI6F34RqDKjkq1tfcIoGmtfMqTw8VqNXv0xu?=
 =?Windows-1252?Q?ArYSyy1hWzmlkjZlVAgmuIWr1+62Ssqw4hSHkG26wyvsA19fUYw3lroK?=
 =?Windows-1252?Q?FjNniS2IwfQmsWySChn7JdJyVqQ1a3BCy/MEaHsqX+jTG4SKZltoY4G2?=
 =?Windows-1252?Q?hk2UfbAO/GQoObu6IHfYTvbqubb6pR7RZMzFzC8K7lryJkRjw9hervPg?=
 =?Windows-1252?Q?yo901oAcVKlPRzdQ3wAwgvK6gwYLNJb0DyyMlzQnisw3QXIS4T63cG+K?=
 =?Windows-1252?Q?6mIJGXBnAXnAk2xH/QaVp6xxZtbz6C7OscHg7st6ADMVDwnz2CKN1m0h?=
 =?Windows-1252?Q?wu2YGdDjuKssbjVO/0GqrEUYTTEmgH6UDVfRjDwiZAlOHrESx8GpmrY3?=
 =?Windows-1252?Q?DuokjFRr29lM6xyBIY7Jo8OWeOBpJyS99WjF79h9eAnUPT13muB9PRQu?=
 =?Windows-1252?Q?JaVCZAMWzOQyVbjzlcHJkS6c/fz/XBpOJ4undBduEGGxqqEx8xjfnOgp?=
 =?Windows-1252?Q?pZPsEfdYl/ngo2GZxhC60d+75vq/+e2FaT8dhel2pxNz5JcDsjbA4NIa?=
 =?Windows-1252?Q?7b/iHo8ky2k+MGWD4OxcyDI5tHJ3p3wIYtnVBKVRpy6RBig8O/JWhvyO?=
 =?Windows-1252?Q?IYxpd0BZNBRaFwH+qHutO72gRsJIETr0HZlLe2TrSWT2y2/W6CBsXQj4?=
 =?Windows-1252?Q?FgpD99B51r+6aV6iJbn1ccnzjPuJHAOOXsg314IMIUuCOVeV06fOdmPR?=
 =?Windows-1252?Q?+Ipvx/4n9zv2IeDMSbIEA/tsNGYmOHo09yBlLAEDnpsoxB/zDzb1YukX?=
 =?Windows-1252?Q?YpqSV65+uXSdLusKbaYhHDPovJc5iynEVpZFLtItI/Fqk6rsWBaI57Ue?=
 =?Windows-1252?Q?SKjAscjRhbVyDRRjwXS69Zklgp/qMPK3ot1+xuBJzuZnEbufwDFOGmBB?=
 =?Windows-1252?Q?vme66GJ8/pu6ai32WxbOEi9aDdyZcXDmBgXkrBtElil6YXc0uwI4M3Z5?=
 =?Windows-1252?Q?g/DKiVamoc39ZYx4usjOrrluB+/kS2TTToRB9DQ57JV+EUEz1ewkziSn?=
 =?Windows-1252?Q?2Pyxmmx5YjKdFDG0qpv7LGsO9vTwqHmQaK/R0egPnia0rdXLjviMHzrk?=
 =?Windows-1252?Q?X/1ci+d/7sily4p65wZrHPzkmxDQCF28u0jDH3wB2iIjVAVoUT7v7YpM?=
 =?Windows-1252?Q?aLvpLazCwchMfYvdv4siuwdSFMgdHR0T+SM+uVb7t8foL/Netwa3hZWg?=
 =?Windows-1252?Q?hSR21GAaBbTPEcDxcVMPAb2fr5i0Afbkc4OLqlwtqRE9OA7xhsCETszm?=
 =?Windows-1252?Q?M4DN7XFLUpX8v6iMK7SA0Nl+7FBDeiWARcyV1yTFxPGvr0FDwWdZBZvj?=
 =?Windows-1252?Q?Bs6k/p0kevQu87zPwRycc1TFWqaLZLnpaV1bV6V6yDTnV5iXwKN+bxbt?=
 =?Windows-1252?Q?MWTE/34UzSY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FEBE7BCFC847644F81F94DFFED9BC98C@NVIDIA.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae8ab96-48e5-451e-d9cf-08dc93ef150c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 01:43:43.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Haer0qxZBamDiwKbIdX+X7MhZCixvIhWSsHi5ft7s10ak5FMXl7fzIMbGfBvKceNc+omdfThAhFt2MfBcJ1SIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

=0A=
=0A=
On 2024/6/21 3:36 AM, Alexandre Belloni wrote:=0A=
> On 23/05/2024 18:38:06-0700, Joseph Jang wrote:=0A=
>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different=
=0A=
>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will=
=0A=
>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error=
=0A=
>> code. This design may miss detecting real problems when the=0A=
>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET=
=0A=
>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.=0A=
>>=0A=
>> In order to make rtctest more explicit and robust, we propose to use=0A=
>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before=0A=
>> running alarm related tests. If the kernel does not support RTC_PARAM_GE=
T=0A=
>> ioctl interface, we will fallback to check the error number of=0A=
>> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.=0A=
>>=0A=
>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services=
=0A=
>> as optional")=0A=
>>=0A=
>> Reviewed-by: Koba Ko <kobak@nvidia.com>=0A=
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>=0A=
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>=0A=
>> ---=0A=
>>   tools/testing/selftests/rtc/Makefile  |  2 +-=0A=
>>   tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++=
=0A=
>>   2 files changed, 65 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selfte=
sts/rtc/Makefile=0A=
>> index 55198ecc04db..6e3a98fb24ba 100644=0A=
>> --- a/tools/testing/selftests/rtc/Makefile=0A=
>> +++ b/tools/testing/selftests/rtc/Makefile=0A=
>> @@ -1,5 +1,5 @@=0A=
>>   # SPDX-License-Identifier: GPL-2.0=0A=
>> -CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall=0A=
>> +CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/=0A=
> =0A=
> Is this change actually needed?=0A=
=0A=
If we didn't include "-I../../../../usr/include/" in rtctest Makefile,=0A=
we may encounter build errors like the following because rtctest default=0A=
look at the header file from /usr/include/linux/rtc.h which miss the=0A=
definition of struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET.=0A=
=0A=
rtctest.c: In function =91get_rtc_alarm_state=92:=0A=
rtctest.c:94:15: error: variable =91param=92 has initializer but incomplete=
=0A=
type=0A=
    94 |        struct rtc_param param =3D { 0 };=0A=
       |               ^~~~~~~~~=0A=
rtctest.c:94:35: warning: excess elements in struct initializer=0A=
    94 |        struct rtc_param param =3D { 0 };=0A=
       |                                   ^=0A=
rtctest.c:94:35: note: (near initialization for =91param=92)=0A=
rtctest.c:94:25: error: storage size of =91param=92 isn=92t known=0A=
    94 |        struct rtc_param param =3D { 0 };=0A=
       |                         ^~~~~=0A=
rtctest.c:98:22: error: =91RTC_PARAM_FEATURES=92 undeclared (first use in=
=0A=
this function)=0A=
    98 |        param.param =3D RTC_PARAM_FEATURES;=0A=
       |                      ^~~~~~~~~~~~~~~~~~=0A=
rtctest.c:98:22: note: each undeclared identifier is reported only once=0A=
for each function it appears in=0A=
rtctest.c:100:23: error: =91RTC_PARAM_GET=92 undeclared (first use in this=
=0A=
function); did you mean =91RTC_ALM_SET=92?=0A=
   100 |        rc =3D ioctl(fd, RTC_PARAM_GET, &param);=0A=
       |                       ^~~~~~~~~~~~~=0A=
       |                       RTC_ALM_SET=0A=
=0A=
After adding "-I../../../../usr/include/", the rtctest will look at =0A=
linux kernel source header files from=0A=
<Linux root directory>/usr/include/linux/rtc.h to find the definition of=0A=
struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET and fix the=0A=
rtctest build errors.=0A=
=0A=
=0A=
Thank you,=0A=
Joseph.=0A=
=0A=
=0A=

