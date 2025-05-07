Return-Path: <linux-kselftest+bounces-32584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA838AAE420
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE0D1C061BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9628A707;
	Wed,  7 May 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKu7aBoF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726D28A705;
	Wed,  7 May 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630828; cv=fail; b=kA4G03u6omuKECCBMrlrc2YYQk9Vdol8dnhDUA3zbgKavretQOw4bO6KSQjs1TdHCMLj6cUl/wIEdUQ9V839LoNx3lrNTRNxNDc7k5gR6wIeR+3FdTuesEGsVOy+5rHUCgmov6dZ+nTiczJlnZnNytR3vpJkyf91RVhDgHAbVec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630828; c=relaxed/simple;
	bh=EzIOO3gWsvBA8iJ/Cbz8qsSVBYq8qP9UQfdlfW0riwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USTAOamcSIEvdKytsUiKUUExnuDHzEFGOHIZVL2IilBHO3pYVg2rB65eqc20oGPgfUWeY/DofmYYpqgNP6t/4FrURPK9IQ7Z27oz9BiNN9BKyGicKCYTKKqSXCRCLnobh4/MbiPqA768k068ivaLWm/mWc/TEWZZIcsxHb7PY6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKu7aBoF; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaBzIIdR+F64Qsg25XflOKOjqONjqbYVk9XHURJjY2au+toTYvJA5//uz0GuTo6Oy4zvHuU9GcJFhiWksXpqc6IRDREwOrXq/zxGb/4K5N1BlCq8WaSdwOPA6z4tEjUgusLO7oPHXlZy9MSnnBgfzCySBj1I2+f5Fllwu0ybAI8ISud+G7rIm9ONTinU7kymcNzFH2/7qnRYUAwzObNEfY2J/+OI4U/VMaoUvGamEgFkbcytIO2kYEk0XNJykB/ayC6Q5eonc1hY778b1HrupZgB2StfkHA/cXlTTarB8j4or/z2Us2LU5JoTeTw6f/80gBoPzHqdhzOO4djeOpnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzIOO3gWsvBA8iJ/Cbz8qsSVBYq8qP9UQfdlfW0riwM=;
 b=tqnsstPi61lQ+afpASKT9DCCQ+l6OXT9GnU8/F/zgY2PLHrjHqFEcN2Hn+HKXD+SrJUS8Z6VKXAK34zN2TLA0I7Hoeh1j8Z+S+3VOH0IP6XTauDtd7M26hkVYyv2EWBdG21QWdIOafpRodNOUEL39vkJjiKJPwvfoyW2t7kyS4Yy5kLVbCsGaUO7wNr1oDoQFBSF9GRoXhPtkQuqNiTYVLKs4D829brTJ6UqFNOjtiOdI6WOv5l0+OaJeEBLol9mMChUbMePHF5y9JlZ4GkWA78poLUdTzPlDIjeNHi3GoVULFQz7i+vOgqUVqRf5WylgJ4pNE/hWrjQdNn77GKwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzIOO3gWsvBA8iJ/Cbz8qsSVBYq8qP9UQfdlfW0riwM=;
 b=WKu7aBoFNKu8m9x1u6ebzj4Lgyw8jmanSroJR5I2Cje9QEsS50Ad8vFMbsuWR/s+rkS2Me34/mpIgL34uBXD4K9+XfVxTI0Kyy0GgBM3zAOtnBifz0sj4C9Io/e6ccB9IdFAbmzqMm+JctA/DJNPrs2AnmH5TumyvEMa/VqG6i6w8oSB1YSe10SuH+MKkAVK2B8PgEkh+RIVif82BFs0q80NV7kz6QOtWKggrtdtiJd+j1xq9oNQvM5TOSgqR79N2w7iGvZiTAx+ZslDOV4NnmUJM02f4Y5cCupKWYwltTfk4u95i/HlVlF7C5wEx/I+XW/FLMJv8Fni0LroAkQIKA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 15:13:37 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 15:13:36 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Dragos
 Tatulea <dtatulea@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: Lock lower level devices when updating features
Thread-Topic: [PATCH net] net: Lock lower level devices when updating features
Thread-Index: AQHbvpI68/ihdVxTiEiw4lpvBpBbzLPF1uyAgAAJx4CAAAdlgIABVUcAgAAKsIA=
Date: Wed, 7 May 2025 15:13:36 +0000
Message-ID: <6c0a6b462200847d87221dcd7655b6a746012061.camel@nvidia.com>
References: <20250506142117.1883598-1-cratiu@nvidia.com>
	 <aBpC9_SgUaAA2P0f@mini-arch>
	 <8f700330f22b741ad72b398ff30a4468c2cb67e9.camel@nvidia.com>
	 <aBpRX_afG5X_rT_J@mini-arch>
	 <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
In-Reply-To: <411b4f945c89548ba79efbe7a95cafbf5bd53abe.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|PH7PR12MB9075:EE_
x-ms-office365-filtering-correlation-id: ee6f9462-b311-455d-c458-08dd8d79bd2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1RCS2RiWjhoNlQyNW5yUldTWkhwWWhMZkRXRGtUcVZtRGM5MHE3TGlaVDI2?=
 =?utf-8?B?SW5PTTBOUndlaEFuUkdhaGVGY09QRUlyZFIrcmVPZXBKSUJkZ0xLRDBJL2Y1?=
 =?utf-8?B?TUxZWW9jcTFsS1MxWFREeWRQUkVVZnViSzYwWkQ5RnNVU0RHT1pVVGpua1Yr?=
 =?utf-8?B?QWtSZmlHR1ZwSkpZUldIbCtmcFlQd3c5bncwUUNseUNaL2JvaE5FUExQem1X?=
 =?utf-8?B?aEJQdXk0K1FlNlN2a2dhWUZCUWtvYStFR0h3WDVGYjVaTXVTVEFUWkg0Zk5R?=
 =?utf-8?B?RzcvSHMzc3E4amJTbEU2QmRGSW1mUnNCOHMwNmp0N2xmUDFnNVc5UDVFQnJG?=
 =?utf-8?B?Q0lkRm14cDRBNThEVThqcUtKZjBycGZjV25GY1hmWlhTTmlIeGlzMHRTdUxI?=
 =?utf-8?B?TkpYNnh0NEtjbWFTOGhVbEdUaTRDN1I1TzBCYVU3TTF4d2VMcWxPSU5VSzRk?=
 =?utf-8?B?MlREUktRcUx2dy9xT0FaclVwdHllMjJPTk1STHVweEp5YS9lallhZTM3c0xO?=
 =?utf-8?B?b2lIVmgvVDdLelZuVWNGNE54OGpxVGMvRjJjZmhjTDBuUnpQTEw0bzRjN2dn?=
 =?utf-8?B?QW1WMk1LcVdkV21uSG50czc2WU16YURkSXZKdWV3UFJoMFBaMVg2MXIzVUFH?=
 =?utf-8?B?ZmdaKzIxdTkzY3RiMXpJK2g2Tnl4bHlKM1hrRFVueDlTRWw4OTZxbTRncmhY?=
 =?utf-8?B?MFcxNEc4V0M1NGs4TkRreUxMbTVaVUJLb1BrRVF6R2J6cEVaUXc3QmlvYjJv?=
 =?utf-8?B?MnkyVmNGbUVQNkV4eXRIWTd6Rkcyb1BFV2lDMmQ0SVJFenZiWG5mVkhhMmpH?=
 =?utf-8?B?ZGk5ejhobGViTStaM3B5bzlZcS9MZVpGenExc3Z4cyt0WDVkVUNwSFlmSWlD?=
 =?utf-8?B?ajQvOXRydk5pckVBRUVEZ2ZYbHNjVkJTZEhIcmc3WUtXN0dLQ2JwY3FSNGxI?=
 =?utf-8?B?c2NudGc4T3JvNzFjL1BBNWp0WjZ5VTdkWlpBYlhTWlZwTUw0K0dkVHgyUmE5?=
 =?utf-8?B?MGw0OXVqRGdNODBGMDJPWFJxMUoyL1lqaXhaQnBNd0tPZFNmc2R1Y2ZUTHFk?=
 =?utf-8?B?dnVrbzFBekVoei9taE1RUjI0c0g1OFFwYUc2Y3JJcHp2NWF3b2R2NWFUZlBK?=
 =?utf-8?B?UEpXb2huYkh0NUJQejRGMjBXamg4RjNuNE9nblNLSjJsTHdUSm9UTU4zeWh2?=
 =?utf-8?B?RTVFNFNFakdCZVQrMCtXMldXR1RxcVFGbXVITjgrYnRzeHBXTldYbUJKU0xz?=
 =?utf-8?B?VVRzcThBWjNxQk9velBjRkZxWEhtczQzNDNjd2NjS01xc3ExaFByY1h3c2FC?=
 =?utf-8?B?cm9hb3RGWjlRRWVCMnYxTi9yK1N3Q29EaTlnNFRxb2VsaWgvSWQxNis5emRo?=
 =?utf-8?B?YjFsZlo0MWNIeXNIK1RKSzJzMFQ5dWM2QnExRVMvUHFrT092aWFSU25lUDVZ?=
 =?utf-8?B?czJiSTFqSTJxTUd5bXkyQjFLSHZvdDg3SEFZUklOcWVmV0R2eUtOV0lIVE1q?=
 =?utf-8?B?U1JjNXowWEdiT3pIaGxCbzd0UjRHZ2JLMkFxYWlpNkJOcGxwYmxORXIzRWxy?=
 =?utf-8?B?MSs5RmEzSUtHWXRxWGlmUWJKSlBaS0pjMFlicVFXWnhBcUtRNWlJeDlMYmFi?=
 =?utf-8?B?Rml4QlRjaGR0UWpadlVjVFppSzl5VmVnRC80VjVNVVczM0JvSzJPWld0bFNo?=
 =?utf-8?B?NW1jZEsrYWN6eDdnaU9TdjAwem9BMW1rTHpLR0JMcmdUblpuT2xGZU5DTm96?=
 =?utf-8?B?WGV2bjh1MUJSTVphZGRocUQ4ZDZoVVBIT3VTRExBdXRsTVhrZnFWRFdkdW1M?=
 =?utf-8?B?RlNraUdyVlgwTkpkc0toZWVuS24vd2VXWkl5MDFCNHFncEJ0SGRkMVhGQmx1?=
 =?utf-8?B?bnRaSjNoaElEQWZPdFdjdG5VcnlHSTI0WVY1NEFYVy9hZ3hUa0EwcXE0dWtu?=
 =?utf-8?B?MW1XM1lkVndIU3puZHZzcGdteDdHS1lvNW1WMGVoeEFCR3llTzc3ZzRLRE1h?=
 =?utf-8?B?M1JsZVZtSDN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1RDQ3p4VEVGN3FDZnYzZEpJbHB0b2xjczNaL0NnZFhDd3JRRmtoZXNheDVK?=
 =?utf-8?B?WVdtV3NUNkV0eU1yb2JOWnl0bXpzYktjTXRXaVB2YjJ3L3hBVm1jNENnUGJk?=
 =?utf-8?B?bnovcjVmY3RFMkdXZVlEM1BTZStIUzR0ME05bEY0S0JzazJwSmkveHAvanYz?=
 =?utf-8?B?b05naVNCWEZEelBwdklLS3NuMFlDa3NUZkxudmFrRmZZUjFLaG1QRlFPaExw?=
 =?utf-8?B?bG1MY0pPbEZ2YzZ3YW5BdlQ0TENmYktqSEJjMkN2NkxPbVR0alIrQThYK3lh?=
 =?utf-8?B?L3ZaVWk4TFp5dUJNZU0vWHBIM2xyRi9uckovU3pjVTRZM1ZyZmtpV3FldTFR?=
 =?utf-8?B?eTRHMVV5STBhMUt4M2xNbS9SZS9UVHg3WlJIVlhPU0hoRzk4WXhWWmh1cHJ0?=
 =?utf-8?B?N3VTK0szck9xTk9RYWNsQndseHdTMzNiSElqZEtyb1UzNTNrTUxtUm93RWJ0?=
 =?utf-8?B?UWZwOU9yZFU4aEZUWlczTitvbnBSZFVnR3d1TERjRDJxa2V5c2szNnpLY1d3?=
 =?utf-8?B?MWQ2UGhxSDNIVGVrbVFPNllRWHBiaCtRVkRqNUNkMUo3VjVPZHFyREovVGRk?=
 =?utf-8?B?bXJDQnlFdXVyMmhvdG1wbHJjblM0Ym9HQzh3R3Y5enYvOW5zVHdVYjI2WjhK?=
 =?utf-8?B?ZWdHWDFEUFdJZ1BGRXR1Y2RGZndjWGlFQkpheGNOYlpPeXE4SFlRQlFQRWd6?=
 =?utf-8?B?bGtqSHo1dkZGNFB4WEcrMi8xSGdEMFhZVGoxWjZ2OVpubFFhWFVQTFo2ZUZw?=
 =?utf-8?B?NGk1bDF0cmlXemo2ckhUMkoyWm1wd3d4VzgwYjJNL2tqN2hVd2xSZHI4Y3pp?=
 =?utf-8?B?aEU3Y21rVWs3QkppMjVIRU94TlJuSnphYzFaei9idnhXN3U0RFNFNHFYL28x?=
 =?utf-8?B?V21GbFlUa0REMnVRWVNRa0k2TDgwcW5ZU1NhYXlvZWMzWktuMFBaRy9zZnB3?=
 =?utf-8?B?SExhQVFRNVRlSmF5d0JYOXlQbVdmK3BUdldYTElhak01dExzc2N6THg4WHBZ?=
 =?utf-8?B?ZUpzTGxsRnRWSUhNbE5RVDJaT1NZK0s2eXZ2MVhPd2kxZE5IMEpMMHQyQkxI?=
 =?utf-8?B?VC9KNVJPOFpUZDJwL25pTURPOEplbzEyNE9NM0duK1oyYnZaOGdvNTVBT0xv?=
 =?utf-8?B?MXNSM1loYkJjQjE0QXZBYzZ1NzRwdEpFeHZmendOZXkzaUhjeWo4a0lSSElL?=
 =?utf-8?B?QUFjVTR5ZTR5OUtUcHBrU0dwQTNqa0EwSjArVlh3QTBKMWRvSkl4bjhBZDVR?=
 =?utf-8?B?SGY4T3RMbzhERzZTS1RiVUNmbW44WkRHMndwYWYyTEJLV3l4ZUNBaWRuUkk2?=
 =?utf-8?B?WithQXNoclNhQko2eGdYaXRBSDBUOHpnZDV3dlMvalF2a3JQQ3FOUW1WTkJn?=
 =?utf-8?B?dWdmN0llbmxPWjVsTTVqQ0p4YkdGSEE5ckVIUHFzOVpZV1hNelZrbzRKZS9v?=
 =?utf-8?B?cEo1MzdRN1RXZ2pFeGgzbEVJWXh5WWJNWjA4Ujc1aXhwd0FadzFrRUF5QytW?=
 =?utf-8?B?b2pHTEVackxQNXdNQXRNZ1YydlI4OXU3ZjczOFA3akg2M0RMeW1ocE4vQ2Jw?=
 =?utf-8?B?UUphaFhGREozUXVIeXlUMTUzS0k1aWVTdlZWV1FHNmVNdzRiRURFcjBoM0RU?=
 =?utf-8?B?YjdaU2JoN3B6ZzlZdVk2YXpiRjBaN0pDNE4rOVhDM1FOVC9nNkZPeUtCQ3ZI?=
 =?utf-8?B?WkdRamZxSTNkK3hYQXA3TGsrSDdrdHpzOVNnOG1sUlZjb2tuNk9yaGFja05n?=
 =?utf-8?B?aXF6ckJvbjlVbDBxVSs1b0xGSEhnT3VCeGdYcnV6dldycXlQRWZnTWxrZ2lO?=
 =?utf-8?B?enZxS3RSdTdjMTM0cGhVWjVPeUcyUm9wWG5MQWtxSGFrcUhCQjY4akhIT2VB?=
 =?utf-8?B?emx5VEVjUGlXUWtGeHRQY3hnNmVaaG44WmZqdll2cnBtdXFlakNGTUp1SldV?=
 =?utf-8?B?YUtJdTNxMUYyN3J5ejF5cENRK2xEVGo3ZmcvT2pmZG0rUHdDcEpQTFJiTnRQ?=
 =?utf-8?B?Y0x5ZWxFYXVHdFZlOVFvS2U4YkNlZTlvcEtVaEIwUkNsaTk5c0ppNVBxaHQy?=
 =?utf-8?B?c3BQRzV5SHdqbmQ2bU1pUmkzS2RHMCtaUUNuYUVVUlFiTkoxc0U1VXk3cUE4?=
 =?utf-8?Q?A23ozoAlK9JJsYgN4BPX/es2f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F05DDA48DDF82E4FBD19C51FE09511CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f9462-b311-455d-c458-08dd8d79bd2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 15:13:36.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDTt5zZI3ATJ9e4EDF3ZFFSoQZM9c39e+SDaUb8NyAm0+SMogGuQhdIMXtp49C6lWQAooJuPe/XfY8h/DQTRKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

T24gV2VkLCAyMDI1LTA1LTA3IGF0IDE0OjM1ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyNS0wNS0wNiBhdCAxMToxMyAtMDcwMCwgU3RhbmlzbGF2IEZvbWljaGV2IHdy
b3RlOg0KPiA+IE9uIDA1LzA2LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4g
UmlnaHQsIGJ1dCBuZXRkZXZfc3luY19sb3dlcl9mZWF0dXJlcyBjYWxscyBsb3dlcidzDQo+ID4g
X19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzDQo+ID4gb25seSBmb3IgTkVUSUZfRl9VUFBFUl9ESVNB
QkxFUy4gU28gaXQgZG9lc24ndCBwcm9wYWdhdGUgYWxsDQo+ID4gZmVhdHVyZXMsDQo+ID4gb25s
eSBMUk8gQUZBSUNULg0KPiANCj4gR290IGl0LCBJIGRpZG4ndCBsb29rIGludG8gd2hhdCBuZXRk
ZXZfc3luY19sb3dlcl9mZWF0dXJlcyBhY3R1YWxseQ0KPiBkb2VzIGJlc2lkZXMgbm90aWNpbmcg
aXQgY2FuIGNhbGwgX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmUuLi4NCj4gDQo+IEluIGFueSBjYXNl
LCBwbGVhc2UgaG9sZCBvZmYgd2l0aCBwaWNraW5nIHRoaXMgcGF0Y2ggdXAsIGl0IHNlZW1zDQo+
IHRoZXJlJ3MgYSBwb3NzaWJpbGl0eSBvZiBhIHJlYWwgZGVhZGxvY2suIEhlcmUncyB0aGUgc2Nl
bmFyaW86DQo+IA0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiBXQVJOSU5HOiBwb3NzaWJsZSByZWN1cnNpdmUgbG9ja2luZyBkZXRlY3RlZA0KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBldGh0b29sLzQ0MTUw
IGlzIHRyeWluZyB0byBhY3F1aXJlIGxvY2s6DQo+IGZmZmY4ODgxMzY0ZThjODAgKCZkZXZfaW5z
dGFuY2VfbG9ja19rZXkjNyl7Ky4rLn0tezQ6NH0sIGF0Og0KPiBfX25ldGRldl91cGRhdGVfZmVh
dHVyZXMrMHgzMWUvMHhlMjANCj4gDQo+IGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2Nr
Og0KPiBmZmZmODg4MTM2NGU4YzgwICgmZGV2X2luc3RhbmNlX2xvY2tfa2V5IzcpeysuKy59LXs0
OjR9LCBhdDoNCj4gZXRobmxfc2V0X2ZlYXR1cmVzKzB4YmMvMHg0YjANCj4gYW5kIHRoZSBsb2Nr
IGNvbXBhcmlzb24gZnVuY3Rpb24gcmV0dXJucyAwOg0KPiANCj4gb3RoZXIgaW5mbyB0aGF0IG1p
Z2h0IGhlbHAgdXMgZGVidWcgdGhpczoNCj4gwqBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBzY2Vu
YXJpbzoNCj4gDQo+IMKgwqDCoMKgwqDCoCBDUFUwDQo+IMKgwqDCoMKgwqDCoCAtLS0tDQo+IMKg
IGxvY2soJmRldl9pbnN0YW5jZV9sb2NrX2tleSM3KTsNCj4gwqAgbG9jaygmZGV2X2luc3RhbmNl
X2xvY2tfa2V5IzcpOw0KPiANCj4gwqAqKiogREVBRExPQ0sgKioqDQo+IA0KPiDCoE1heSBiZSBk
dWUgdG8gbWlzc2luZyBsb2NrIG5lc3Rpbmcgbm90YXRpb24NCj4gDQo+IDMgbG9ja3MgaGVsZCBi
eSBldGh0b29sLzQ0MTUwOg0KPiDCoCMwOiBmZmZmZmZmZjgzMGU1YTUwIChjYl9sb2NrKXsrKysr
fS17NDo0fSwgYXQ6IGdlbmxfcmN2KzB4MTUvMHg0MA0KPiDCoCMxOiBmZmZmZmZmZjgzMGNmNzA4
IChydG5sX211dGV4KXsrLisufS17NDo0fSwgYXQ6DQo+IGV0aG5sX3NldF9mZWF0dXJlcysweDg4
LzB4NGIwDQo+IMKgIzI6IGZmZmY4ODgxMzY0ZThjODAgKCZkZXZfaW5zdGFuY2VfbG9ja19rZXkj
Nyl7Ky4rLn0tezQ6NH0sIGF0Og0KPiBldGhubF9zZXRfZmVhdHVyZXMrMHhiYy8weDRiMA0KPiAN
Cj4gc3RhY2sgYmFja3RyYWNlOg0KPiBDYWxsIFRyYWNlOg0KPiDCoDxUQVNLPg0KPiDCoGR1bXBf
c3RhY2tfbHZsKzB4NjkvMHhhMA0KPiDCoHByaW50X2RlYWRsb2NrX2J1Zy5jb2xkKzB4YmQvMHhj
YQ0KPiDCoF9fbG9ja19hY3F1aXJlKzB4MTYzYy8weDJmMDANCj4gwqBsb2NrX2FjcXVpcmUrMHhk
My8weDJlMA0KPiDCoF9fbXV0ZXhfbG9jaysweDk4LzB4ZjEwDQo+IMKgX19uZXRkZXZfdXBkYXRl
X2ZlYXR1cmVzKzB4MzFlLzB4ZTIwDQo+IMKgbmV0ZGV2X3VwZGF0ZV9mZWF0dXJlcysweDFmLzB4
NjANCj4gwqB2bGFuX2RldmljZV9ldmVudCsweDU3ZC8weDkzMCBbODAyMXFdDQo+IMKgbm90aWZp
ZXJfY2FsbF9jaGFpbisweDNkLzB4MTAwDQo+IMKgbmV0ZGV2X2ZlYXR1cmVzX2NoYW5nZSsweDMy
LzB4NTANCj4gwqBldGhubF9zZXRfZmVhdHVyZXMrMHgxN2UvMHg0YjANCj4gwqBnZW5sX2ZhbWls
eV9yY3ZfbXNnX2RvaXQrMHhlMC8weDEzMA0KPiDCoGdlbmxfcmN2X21zZysweDE4OC8weDI5MA0K
PiBbLi4uXQ0KPiANCj4gSSdtIG5vdCBzdXJlIGhvdyB0byBzb2x2ZSB0aGlzIHlldC4uLg0KPiBD
b3NtaW4uDQoNCklmIGl0J3Mgbm90IGNsZWFyLCB0aGUgcHJvYmxlbSBpcyB0aGF0Og0KMS4gdGhl
IGxvd2VyIGRldmljZSBpcyBhbHJlYWR5IG9wcyBsb2NrZWQNCjIuIG5ldGRldl9mZWF0dXJlX2No
YW5nZSBnZXRzIGNhbGxlZC4NCjMuIF9fbmV0ZGV2X3VwZGF0ZV9mZWF0dXJlcyBnZXRzIGNhbGxl
ZCBmb3IgdGhlIHZsYW4gKHVwcGVyKSBkZXYuDQo0LiBJdCB0cmllcyB0byBhY3F1aXJlIHRoZSBz
YW1lIGxvY2sgaW5zdGFuY2UgYXMgMSAodGhpcyBwYXRjaCkuDQo1LiBEZWFkbG9jay4NCg0KT25l
IHNvbHV0aW9uIEkgY2FuIHRoaW5rIG9mIHdvdWxkIGJlIHRvIHJ1biBkZXZpY2Ugbm90aWZpZXJz
IGZvcg0KY2hhbmdpbmcgZmVhdHVyZXMgb3V0c2lkZSB0aGUgbG9jaywgaXQgZG9lc24ndCBzZWVt
IGxpa2UgdGhlIG5ldGRldg0KbG9jayBoYXMgYW55dGhpbmcgdG8gZG8gd2l0aCB3aGF0IG90aGVy
IGRldmljZXMgbWlnaHQgZG8gd2l0aCB0aGlzDQppbmZvcm1hdGlvbi4NCg0KVGhpcyBjYW4gYmUg
dHJpZ2dlcmVkIGZyb20gbWFueSBzY2VuYXJpb3MsIEkgaGF2ZSBhbm90aGVyIHNpbWlsYXIgc3Rh
Y2sNCmludm9sdmluZyBib25kaW5nLg0KDQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KQ29zbWluLg0K

