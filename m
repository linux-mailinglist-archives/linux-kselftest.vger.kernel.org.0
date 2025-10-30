Return-Path: <linux-kselftest+bounces-44430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A1FC211C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992ED3A6E4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2363655E6;
	Thu, 30 Oct 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEZrjMED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1870336EEC;
	Thu, 30 Oct 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840715; cv=fail; b=Y49p+O2U8hbxsafpleBHA1F9PBsHMFzo5he0pByjMTlklHEsIgr3KAWDKvxjHwG/PuVVwygk+Qgvup9gcj1NVrVKSL+c8KYY8CyuPjIQakrGYVWC55/faww4i0/zB5xlDJKUISUhSIh8Hq0/W9p+OmPscUUFoYavZgC7TVowSyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840715; c=relaxed/simple;
	bh=k1VnJ7KpK4ShdiLMKgEHRGwkqstmpaqfomBldzJVBx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QMozKNi7fJRwXrzpqcqQFPBZplRQly2SbJkV4uX+jx5uvlp3HMEe5Xqvepy34uaCctE42h/dSfqpT39oMLKu9QMU+66o0YBh55vWYksJeYdIByxP/w0Nx2Zy3QPBdHThuFIKitJAcIWlXL52pCxPgg9zcVlhnqX6Ln5y8azXB2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEZrjMED; arc=fail smtp.client-ip=52.101.48.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDn3Q6f1m2emkfTxux4RC7jhPDP6M7yzDRbaSjWbx3Znm7hI4piQUKyRvofKnAdZLyWtVEks73yNu781zSANpjdFX+iJ9fD9dbqC4mc9nBen53Galsdohbrd5/byNbtFYY+iWPaOh0BwWbDjbH4iRjZ5ErWRsQ4rkjkNtbFT5X6ePf9nJN9sBKpvo0KwmBVIf380zqp7nb4UfaAnz+mpSpJAKIG4yNfncHN1NrxsIaJhC7dIvE5htrq7JlyVFPOOyzoM+IcrUrazNi9Te4Iy5cvhWP7nTxilbmojj2HQ/6gMtHDGs34nuVdX1VPo5QumEEdzMb1hsPIbNQCeHqOO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1VnJ7KpK4ShdiLMKgEHRGwkqstmpaqfomBldzJVBx0=;
 b=i4sxlwsekZrziCmEOuVtqvQuYCcRno8bSQc5TCtbtuyf6QodV99LKJq6Ag9w8Ared7Y4F8V9GW+qAePPNoXwf4xQW30o1ZKp6o9C+VcQNLVpx8vwTA9i5axa19GyEfslMS87ljj10vq0ZOLDJ7m7y0PSAmiWYOR007LaRXtSgZYOdVX7C9W7TYwLFybj6P63CBNGbAard671iJyUIfp/Ky9sQJE6Pzn0ycnjwPzpcOpJiAOBW247fVlnIkw9ZHnvwL42EuqhpEBJNWrl6hRSKmAQB5zKTqAK2Q3M8/P1REmR9GjssHnGAewXDDm63UTtGNVKPUyKU08Q935YmGaMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1VnJ7KpK4ShdiLMKgEHRGwkqstmpaqfomBldzJVBx0=;
 b=kEZrjMEDBuPKzzIl4ZZW785I13HQ9BDeOYXyBapv9cWOKQ2I9OicpCwK28iBHrjcIcLCZFlldxX5fnGxLNipSVfVq8khyVQE52nrpjoGJSM9z4e5/c9Z0AWhA1yF//ysTlKYkbwDnMPmsXdjvil5k2Lx1NBjTdPB1D4trQh2j/h2nyBlCafRjCyUTYSj6zvCzN59RT47/PWt/zX0P36csGFI2f83V4P8B3747mwQIZHDkyG+7a5HbNK1sKjKOsZGbk6DWwTI0qNeLohlWg+e1qJAz5Pqn2/i6wVK+TA/VkqRi+kbc3EmmV/HXjGey3phGzkDkhMrSXDXkrfYH+pjYg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by PH7PR12MB6000.namprd12.prod.outlook.com
 (2603:10b6:510:1dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 16:11:49 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 16:11:49 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Saeed Mahameed
	<saeedm@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/5] net/mlx5e: Add PSP stats support for
 Rx/Tx flows
Thread-Topic: [PATCH net-next v2 4/5] net/mlx5e: Add PSP stats support for
 Rx/Tx flows
Thread-Index: AQHcR54tVafUicJYVUOgSH1FwEBU77Ta4IoA
Date: Thu, 30 Oct 2025 16:11:49 +0000
Message-ID: <0025ef2f3eb0787d6ee29111f936a86f865320cd.camel@nvidia.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
	 <20251028000018.3869664-5-daniel.zahka@gmail.com>
In-Reply-To: <20251028000018.3869664-5-daniel.zahka@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|PH7PR12MB6000:EE_
x-ms-office365-filtering-correlation-id: 166fe071-6218-458e-cc04-08de17cf082e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1ZDZmIyTFFQUWc0VSsvZmpQMmZMUnl0Y3BLN0Nndy81QlB3YmFJcDdFdXJs?=
 =?utf-8?B?OENjeHBEYjVpZzUrQ1hMQVFpS3Z2Q3BvZGtYd0JKcGl1SFF0VXQwTno0aHJN?=
 =?utf-8?B?dVlCWEFGcVRUZkpnWnNFcExDM0ducGwwTEFaQkNybFUwRVNXTXZMYWN5UjR0?=
 =?utf-8?B?clphTGZaQW1EMFcrTTVvRHRpOTcvVXBwRGJEYklsWGxmdkVhdjZjUStjdEJW?=
 =?utf-8?B?d0djS29XTU5kYVhjTVZqQUpWMGlIb1pJUUdPL0xpNEJsTkJpZkFNQUtIaTlN?=
 =?utf-8?B?dG9BY2lQOXpTYk1LeTZmaTQrQ1F0Nm5QeXd5NDVNOGZNWFZLSGVEZEwyUERp?=
 =?utf-8?B?MmhreUc2dmtDQXVxRm5hOXlvUm8vTDJtckxzek9kOTNpRGFsREZaTjhEREFN?=
 =?utf-8?B?MGtYcjhYb0kra054cmprc2cxRjByMS8wWFRuUGVMSHB3SXN0b3Qyc0xFTUo1?=
 =?utf-8?B?a3R6Tm1NaEtqa0lRazY1N0JTNGhUaTRlUXovUVRFQjh2U29DdXMxYjlWbUpZ?=
 =?utf-8?B?bENLVlhMV3k2RDMxbjEvYi9jMmFCTXJod3loY0M4TTIzOGxrZnh3Q0xJQWw1?=
 =?utf-8?B?QWlYd3B4djhzd3RuN1ZtL3JLTlNkOXJZMkhTM254R09qNHNWcjJQTEg1d0Ey?=
 =?utf-8?B?SFMzKzBkT2thVnhzNlVpRVpWalNXMlpMS3dac0xnQnNYVWlwNmdyYi9TcVl4?=
 =?utf-8?B?OXJyblY2SzEvaU4rbWdabFhDbzZsNnpuU3hVQW1CUlQzMlVKVEtjZXFvQzlx?=
 =?utf-8?B?akowVXhTcGRaRmUxZUIxTzNiK3QyR2ZuRTBmdndUODZ4empVOWJsRzBuUEhj?=
 =?utf-8?B?WWlrTEZuNU9Gd2VoZlZhWVVWT0pEWnNPdnV1cURxckErM3lmYytJbmI5V3Jt?=
 =?utf-8?B?U243eFlka1A4dU5hZG1rWm5MWnVHRDkwZXFVVkduRUVRNjlJeHlPcEZTTTg3?=
 =?utf-8?B?L0k0NDZ5RlVmL1pSS2FQOW1rR001bCtGOCtzMmpvTTFmamNsakZ3ajEvU1c4?=
 =?utf-8?B?ekNJN2R2dDJKdVBEM2VRTkE3d04wSUdSWnMyN2NQeEFhQkYyWS9jMzVZRlhJ?=
 =?utf-8?B?RWJpSHNiYWRGYkJPL0c5SjN1dzBsSnpWeFR2cmFBaVo0NUZoa2J6NEdJSkw3?=
 =?utf-8?B?djdxUlFOOXhpTUlKN3IyeWJ2cnp2eFZkWktkcUp2eG1naDZYZ00vMHY3SUZ3?=
 =?utf-8?B?UG1ReWpJaFU0NVdmL3A0ajJialZVN0NwMHIyVElwWno3b1c0VVBld1lrTzE3?=
 =?utf-8?B?a3E4d3VDV3o0S0NGUkNJN0hzbGt0QmdYeHpIRmowR1F3OG5NUEhNMmJTV3ps?=
 =?utf-8?B?OEc5RHNMMzhLSFJ6bDQ0SmRHVWhUUjlBeXo5VGxVTTJFeUswSmcyenViOUl6?=
 =?utf-8?B?aHJBanpEWkFDR1Q0QXNMcFFqL08xOVQvME9KYm8yR2NJVm91bUFDOEZ1WnVI?=
 =?utf-8?B?UTdIdXhRL1RyT1JJc3F6NzJ5ZGt5ditaM1VMNTM4YXhzY2UrYkd1WWRBVTBw?=
 =?utf-8?B?RFdWVzEyN0p2dk5PVVc4eWkzMDJ4UWswRWEzMzlaOEkwVWN6bjF4TkplcDFO?=
 =?utf-8?B?TS8vaktqakszTUM0L25yVjF2MjRIVnhNM3JONWN1aWQyK0xEUXFhZ2JDYytH?=
 =?utf-8?B?aHgycXVmN05NWFZKVC9uZVlQVzFWbXlJejlJY3hTNmg3TC9aL043MkVnN0tV?=
 =?utf-8?B?Q0hYazdWRnZ6b1o2bUYvckdlak55WkVLMzkrUTRxZ3NWb0JuMzM4MVU1djNo?=
 =?utf-8?B?T1I4M1VaNXdvTzJTZ0lkbWZRejU1WTBiZnVzSEZXc0NKNTFxZTRDc2NOOEFz?=
 =?utf-8?B?OVQ1NDhyNnRFbDYzMkpaT1ZDRUU3RGQrZmRiWkowN1MveU1pbVlXQWErYXJQ?=
 =?utf-8?B?UE1EcWwxNkNEV0kvK25yU2J4MVNPWFZWVEx5UDUvMmtKMXhDM1dZMUMveGlT?=
 =?utf-8?B?VkFlWVJKOEE0clVYMkRSSXhtSDhZaXR2YlpQc2FZRmtqQlErZkp4dmU2Z1dN?=
 =?utf-8?B?bVN3blBiMVV2YzREMks4MTZaNGVONzRuMlI1aDhxVjBTeGQ4TWNzNVRCdzM0?=
 =?utf-8?B?dUhtTk9yS2tPcC9YRWZaUS9lU0RjUm1aWWZXZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0RjWXhTemNUR3hXZm12S3VaNEc4UEY3NWdHS2tCbjJOcUJjT2F2cXoxV1lp?=
 =?utf-8?B?ZnFwOXFwNmloa2RrWGNiVWl1SmlQdUFINXI2ZEhkQUthL0JQSmJPZmNoT3U4?=
 =?utf-8?B?elVrMzJlU1YrMU5aaXBIbEJlTjVPNDFvSkpZU0Z5NzlpK2VCNTZuaUJZS0JH?=
 =?utf-8?B?NUxFOTNOQUNuMHh1WHprWlB4Sm1yY1RiS3o1ektYZmRMLzVTRXBUT3VXS0JS?=
 =?utf-8?B?SWQxN1BUWmw0ZDgxamFVZ1FDN1FsUGFndHk4VElUeFhYOGVFSE9SeUYrc1pm?=
 =?utf-8?B?aGNqM0RlUC9pd3FwOXF1QjNBYjV0enY1d1I2b3RHWFM3OEhnNU9FTzAzTUVz?=
 =?utf-8?B?WVdFcmtaaTNDbStNaURhMUJDRHlMcEozWE1yV1FYdFdFUEJBeFl6NzB6dkI5?=
 =?utf-8?B?MzU3U09DUnV2RFpGTk0zaXI1Vmc4YlF6Q1BCOGkrQk9ZcGgyS25Kc05RZzVv?=
 =?utf-8?B?bWQ5RFAxUlk1MmNSbVBNT3Q5RTlMZjFpdWZVbWtkdmVyUUhQY2lRUFVOSzNG?=
 =?utf-8?B?S01xeC94aS9mRFRKS3FnMGNhM2dhVkhoZDJIa1hLQW0vUVp0cW4vTm4xcEpt?=
 =?utf-8?B?UFAremhpUVl4TzRtQTMrTEhPc1ptcmo4N2xZYzNUNWxhT2N4TXB3dituWFhP?=
 =?utf-8?B?RlErekhlbk1aeERDN2FJbDhaSXBqUzdOUmduTGtnSWRUK1pIZnBXTVdwUGMy?=
 =?utf-8?B?YThuZnprbVE2ZS9UT1p3Rk9UNlJhK2p5d2ZpRUYvemJBb0J4QVFwWXUwMlVu?=
 =?utf-8?B?b0RkWlcvTHBocFYweU1pZVhnWENyNUplZFBSZFVqTDNObDFnbXEwUXpQRGlP?=
 =?utf-8?B?OVk1aGpjbHJadUY1OUxTUDFmNFRURDBrMDA4SXVBaXBDazlRZ1JEaE8wd2Ju?=
 =?utf-8?B?bk4wQzlTeHFVMjM0UVRpYVBubHIvektNMUJGblVwZDFTYmdNS3ZET3FWdnpa?=
 =?utf-8?B?STZPOXFJU1BHUzZiOTBjMmVmUXBPSVFMNzVyS0xmRmlva3hYV0ZqRU96akc2?=
 =?utf-8?B?RGFnU284aUJJOEwrb2lndmlNK2dhRG01TFlqRW9GS0NXVWxKcjFteElxMm9O?=
 =?utf-8?B?SHBDMTZLelk2Wm1IVzNJT29QRXBLNFpDaDl0RmpYTnJSZnFsRU53ZXc3Y09o?=
 =?utf-8?B?K2xDcVBkNm1IQmkxSjQwZkpGWUF6NXh6WVJPcnY2Vm9jWHRvc3lNTzRaUFg2?=
 =?utf-8?B?ZmI3MDkzSURoK0VOM0d3eEh2U0pOaE52V0djdlRvWkZQcXVZQTRXTUdLdERS?=
 =?utf-8?B?dmo0U0F1Slg0TGVhUWt6dURuWVBtTHNFZnRFMVI5OHdZVHVTWW96TTdHdUpB?=
 =?utf-8?B?QTIyTkdHdjJVL09ad29RUWJSL0orZ3BSSHMrZk01RVFSTkIrckZsMzBmcGIr?=
 =?utf-8?B?d0F4OU9ueVQxeWloVkxOQVdQTHFNVkdPeHZBTXVsR1NPNUZ0cWdqdTFkSC9C?=
 =?utf-8?B?L0NLbjJLWWFQVE91NkZFbGNLSTIwNWtPUW50ZGpXeENQWnZzYTlzelM0UXUx?=
 =?utf-8?B?S0FzVXc5SVlnd1A5SjVYQ0JpZGFkS2xQTHdSUUNyZTVOSUlwbnRncEZUVGdD?=
 =?utf-8?B?dVVnVDdISnA4VUVyWW9vSnc5WlR3RDhwSm5iQWlCYndJV2JNb1czMW1yeWh6?=
 =?utf-8?B?dUVOOFlHeVBQaXNXKzE5b2lmTWJxM0tlTVZkaDNlWHlIT0I4bTlOeGpjeTln?=
 =?utf-8?B?VFFoNXJmUTNmOWVJN0JRSkFjV1FYQ0dRWXUrbWo5SjJrVFUvNnZuTzZyWmNs?=
 =?utf-8?B?dmc1WkF4VEFJZURtbFlEeDZHMGVOUy9uN2Znc1YvdnBNNnFmc2ZZZkcxSkRn?=
 =?utf-8?B?YVJRVHhYbDFLWVRsTXpyUjFNK2pVekdoVEFvajdRVHBFb0tRWGw1ellqQUxQ?=
 =?utf-8?B?LzgrR2U2NTBCTUMyWm4wREU0akEwbWcvZE95dHVDZkxsN3l1UzI3dGtCQVJN?=
 =?utf-8?B?S3pELzlId0hCSFNWa1JlT0UzNWFVa3ZwQ3pYUitmdDdweG1tdnNrbVByb2lj?=
 =?utf-8?B?aFl6SHh2Ykd2UGhlTEVxcWRibHZZRFMzRXBDdnR5bFpGRFgzUUxHWkhZby9Z?=
 =?utf-8?B?ZmRuZ0dUMGhqbW1VWXBJUzQxR29aeEkwT0hNVkloN0hRdHFoUGpYaXk5a2pw?=
 =?utf-8?Q?jJ9OoY3i/xEWaJPfetgC/sc19?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A2B01F9AFFD064CB4047637522A5FEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166fe071-6218-458e-cc04-08de17cf082e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 16:11:49.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxEh+8lx/LaiVDHGDDGkvp3eDgi5xXRqP5WUEVr23670NPpqaiKh3GQlrXO0Sexfp6x/Hjn3FJQNeSqZcnIPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

T24gTW9uLCAyMDI1LTEwLTI3IGF0IDE3OjAwIC0wNzAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IEBAIC02NzAsOSArODEzLDU3IEBAIHN0YXRpYyBpbnQgYWNjZWxfcHNwX2ZzX2luaXRfdHgoc3Ry
dWN0DQo+IG1seDVlX3BzcF9mcyAqZnMpDQo+IMKgCQlyZXR1cm4gLUVOT01FTTsNCj4gwqANCj4g
wqAJbXV0ZXhfaW5pdCgmdHhfZnMtPm11dGV4KTsNCj4gKwlmbG93X2NvdW50ZXIgPSBtbHg1X2Zj
X2NyZWF0ZShtZGV2LCBmYWxzZSk7DQo+ICsJaWYgKElTX0VSUihmbG93X2NvdW50ZXIpKSB7DQo+
ICsJCW1seDVfY29yZV93YXJuKG1kZXYsDQo+ICsJCQnCoMKgwqDCoMKgwqAgImZhaWwgdG8gY3Jl
YXRlIHBzcCB0eCBmbG93IGNvdW50ZXINCj4gZXJyPSVwZVxuIiwNCj4gKwkJCcKgwqDCoMKgwqDC
oCBmbG93X2NvdW50ZXIpOw0KPiArCQllcnIgPSBQVFJfRVJSKGZsb3dfY291bnRlcik7DQo+ICsJ
CWdvdG8gb3V0X2VycjsNCj4gKwl9DQo+ICsJdHhfZnMtPnR4X2NvdW50ZXIgPSBmbG93X2NvdW50
ZXI7DQoNCk5pdDogTW92aW5nIHRoZSBmbG93IGNvdW50ZXIgaW5pdCBiZWZvcmUgdGhlIG11dGV4
IGluaXQgd291bGQgc2ltcGxpZnkNCmNsZWFudXAgYSBiaXQgKHNpbXBsZSByZXR1cm4gaW5zdGVh
ZCBvZiBnb3RvIG91dF9lcnIpLg0KDQo+ICtzdGF0aWMgdm9pZA0KPiArbWx4NWVfYWNjZWxfcHNw
X2ZzX2dldF9zdGF0c19maWxsKHN0cnVjdCBtbHg1ZV9wcml2ICpwcml2LCB2b2lkDQo+ICpwc3Bf
c3RhdHMpDQo+ICt7DQo+ICsJc3RydWN0IG1seDVlX3BzcF9zdGF0cyAqc3RhdHMgPSAoc3RydWN0
IG1seDVlX3BzcF9zdGF0cw0KPiAqKXBzcF9zdGF0czsNCg0KV2h5IGNhbid0IHRoaXMgZnVuY3Rp
b24gcmVjZWl2ZSBhbiBtbHg1ZV9wc3Bfc3RhdHMgcG9pbnRlciBkaXJlY3RseT8gSXQNCndvdWxk
IGF2b2lkIHRoZSBib2lsZXJwbGF0ZSBjYXN0Lg0KDQo+ICtzdGF0aWMgdm9pZA0KPiArbWx4NWVf
cHNwX2dldF9zdGF0cyhzdHJ1Y3QgcHNwX2RldiAqcHNkLCBzdHJ1Y3QgcHNwX2Rldl9zdGF0cw0K
PiAqc3RhdHMpDQo+ICt7DQo+ICsJc3RydWN0IG1seDVlX3ByaXYgKnByaXYgPSBuZXRkZXZfcHJp
dihwc2QtPm1haW5fbmV0ZGV2KTsNCj4gKwlzdHJ1Y3QgbWx4NWVfcHNwX3N0YXRzIG5zdGF0czsN
Cj4gKw0KPiArCW1seDVlX2FjY2VsX3BzcF9mc19nZXRfc3RhdHNfZmlsbChwcml2LCAmbnN0YXRz
KTsNCg0KSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIHRoZSBpbnRlcm1lZGlhdGUgc3RydWN0IG1s
eDVlX3BzcF9zdGF0cywgdGhpcw0KZnVuY3Rpb24gY291bGQgcXVlcnkgY291bnRlcnMgZGlyZWN0
bHkgaW50byBzdGF0cy4NCj4gwqANCj4gK3N0cnVjdCBtbHg1ZV9wc3Bfc3RhdHMgew0KPiArCXU2
NCBwc3BfcnhfcGt0czsNCj4gKwl1NjQgcHNwX3J4X2J5dGVzOw0KPiArCXU2NCBwc3BfcnhfcGt0
c19hdXRoX2ZhaWw7DQo+ICsJdTY0IHBzcF9yeF9ieXRlc19hdXRoX2ZhaWw7DQo+ICsJdTY0IHBz
cF9yeF9wa3RzX2ZyYW1lX2VycjsNCj4gKwl1NjQgcHNwX3J4X2J5dGVzX2ZyYW1lX2VycjsNCj4g
Kwl1NjQgcHNwX3J4X3BrdHNfZHJvcDsNCj4gKwl1NjQgcHNwX3J4X2J5dGVzX2Ryb3A7DQo+ICsJ
dTY0IHBzcF90eF9wa3RzOw0KPiArCXU2NCBwc3BfdHhfYnl0ZXM7DQo+ICsJdTY0IHBzcF90eF9w
a3RzX2Ryb3A7DQo+ICsJdTY0IHBzcF90eF9ieXRlc19kcm9wOw0KPiArfTsNCj4gKw0KPiDCoHN0
cnVjdCBtbHg1ZV9wc3Agew0KPiDCoAlzdHJ1Y3QgcHNwX2RldiAqcHNwOw0KPiDCoAlzdHJ1Y3Qg
cHNwX2Rldl9jYXBzIGNhcHM7DQo+IMKgCXN0cnVjdCBtbHg1ZV9wc3BfZnMgKmZzOw0KPiDCoAlh
dG9taWNfdCB0eF9rZXlfY250Ow0KPiArCWF0b21pY190IHR4X2Ryb3A7DQo+ICsJLyogU3RhdHMg
bWFuYWdlICovDQo+ICsJc3RydWN0IG1seDVlX3BzcF9zdGF0cyBzdGF0czsNCg0KVGhpcyBkb2Vz
IG5vdCBhcHBlYXIgd3JpdHRlbiBhbnl3aGVyZS4gSXMgaXQgcGxhbm5lZCB0byBiZSB1c2VkIGlu
IGENCmZ1dHVyZSBwYXRjaD8NCg0KQ29zbWluLg0K

