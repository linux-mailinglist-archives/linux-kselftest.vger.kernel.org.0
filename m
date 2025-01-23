Return-Path: <linux-kselftest+bounces-25017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E805A1A6F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6441604B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB24211A1E;
	Thu, 23 Jan 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyqGCk0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2F20B22;
	Thu, 23 Jan 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645881; cv=fail; b=dOsUEFgh7NH8omvQBBkdRCOCj0kr0aEFGoxQbKejyWBJrM/m8Gt3lipbsM8G7x1hPatxk4oSJPWLQJR4ZIlW1S76xn0CkUJgAmHueEj90fZXdmDhPojYp77BY7zTL9a0gyx93z7yYBAiFf4S5PH6r4A0Fhk5US90vOhphIdBrRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645881; c=relaxed/simple;
	bh=Vdm2HQagHUI4F4836A06RlV0aNSi1JxdmBK8qrcETYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YPljTsOEUJVqKm3imovRJXh2ULo1r1qZvDbcacmlft1JqFy2u7pgC4/lOMxiftxKkQkD2dOZ2eLp0caZwkJhfKT1DLEkoyi+TvHB2fli6V8PZCFkltsuKXnVXXAtyiqHSqFez/9ZCSppJWjkDDG54nzUFZF2gr2ZbqUOxcQJ8Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyqGCk0K; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsrgVAdNp8pUPDWTFq0511VVjmNaSFk5RrG5zQnTPgonOKISR+iqjI5E5KjZcv6pyScXdyZ5Qfxy1ItzzWcEGhiegikOmuhrpZU/yNA1P79qJp8T6nQOr5/1pfpyTiUYFan9NY+gYqQTR8SiKwKyAjQqvy50+BgzCI+38e2t8eF0vawyNtxQfln1zw06QNK920gAFQazPpnoW4gUFduEGXUi0jct9M3JV0bGEcOKhFtjgMVZfGu3WhxDyHAwXWk0NJ9AiVixBFvEALwrGwJCNAph7uQCwNJksum/2s4Qup1EI/I04pfJpwJLhmvwwp80SPyWcciiXGpGt8W+pFQRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdm2HQagHUI4F4836A06RlV0aNSi1JxdmBK8qrcETYw=;
 b=bJFGf/UrMRVKm3vnOrtwSR0cok+m8Ec/7+yo+hZKVnb/w/n6GJ3wRd9M8o9fJ4gYHoQrr6i9DnA2/vJLbRHjNGkEfz2usClNOHZaisHX8BrTjj/bmdenZwrSJ3/nSNvmigyIYtlZNl/KuVftxrErEtfUhPhvJ9JwNwjAJTExyzFDWfUkS0LHKGMLHZ1Id2pMEs/k+ZN7aKHAhi35fxns+qu3DRRDqTHNyrSXbIRENFvX/WkpRl2Cw657jGSt9EO+nvHlnLrWoPydCwcvr7njbSZbHwKHmAa28gUNC64L3PFoF79iLh2S7+HUd183fSfTCWYG6NE7GvSLfLhyAJ8MxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdm2HQagHUI4F4836A06RlV0aNSi1JxdmBK8qrcETYw=;
 b=fyqGCk0KKa+ZKhXvyBoNmD3VHKaxs7lcGOWWV3C7vh3TUpcQtFCGmoniJdy4SEbfNyMnZK6ubGEA0cz9erk54OcMv7qFVakCCiSHB2dcvwVOd1s4VtgU+jqrt/8PB5O8A+ncd/MrVgZAvBTMX6zrO2lW+/W3wvRs0Bpu3BpK7RETDoQ8iCfa+4wyzXJMarwtBE2+ckNFiG4qI72OuoK1yLLak43VDwXIj9hztoNR4o2s66+TkHWkxxC42XL+Z+WqfSrfYjANOeL5IIAFpWraXjtiNEP2tpVMFL4RSrVI4aKRxzAnk/irp2GDDsx9yZbOEqCLWLlxNDHKw2jua5kvgA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 15:24:37 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%7]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 15:24:37 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "razor@blackwall.org"
	<razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "liali@redhat.com" <liali@redhat.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, Boris Pismenny
	<borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Topic: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Thread-Index: AQHbbNT/TlKnluHwVUefPV+xYgABi7MkRzCAgAA09oA=
Date: Thu, 23 Jan 2025 15:24:37 +0000
Message-ID: <fc63c005a8f2fd6a34a055c1ac484bc36869f8a8.camel@nvidia.com>
References: <20250122135218.183578-1-liuhangbin@gmail.com>
	 <40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
In-Reply-To: <40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|MW4PR12MB7165:EE_
x-ms-office365-filtering-correlation-id: 85cb1c14-e31f-4982-165c-08dd3bc20c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3c1QkdZNXlubzYxSmRSK3k4K1c5KzVDYXZKOUZzcHp4ZU9YdStybGFhcTd2?=
 =?utf-8?B?RFNEd2JxREpPaWhTQjBoNDlidFlKMTQ1R1FSZG1VN0xScEcwdXR4Q2FRUSto?=
 =?utf-8?B?T2pkbWU4RzRaYUFlaCswTGtZdS80VE1vL1F4bW1jQ1k4NG5scnpiTDFKMEJp?=
 =?utf-8?B?QytQcE5NT3ZGajBYSE5WeVVzMmRrM3M1cmJ0TGtzb0dITUpXZVdIZWlCdjJj?=
 =?utf-8?B?d29wWThZRG5QSmQ1Y1U0ZVNLQTM3V1I2MmJxZ0h1YUtFblY2NUt3djZZQkh5?=
 =?utf-8?B?TlRpVDFMK2dSd1Q2S3QxU2s1aFVTZXJrMnA3MlMvYTl1OTh0c0FjOEE2T3Ra?=
 =?utf-8?B?ZTRpenpFcUJETVE4eDZGYmk4YTJBbHhQUTVJM1Z0TUVSWkRLd0FvVXFsV2px?=
 =?utf-8?B?V2tFY0JKZThjYTRYSW5pa0lLWkpDenhLM3lSOFhHM24rSmdHWG9XekJ6b1pD?=
 =?utf-8?B?SkxibnI4cW1xcFdwUGtEL2wxMGw1dFNWWDdXdTdQSlo2QWRxaVBvZTRzeits?=
 =?utf-8?B?MngzZWdNS3QwblY0ekpENWNEUG13aVFJUDVEa0ZXNFkzbXVMUHdPSzkyUmFM?=
 =?utf-8?B?SFNKRFdmWWhlODNVeHlTbjJQRGxDWElHL0hVU0I1Q205WHRYZmROaFhiS2JM?=
 =?utf-8?B?WkxKR0xGdXdaL2JSTGRQV213Z0U5UnRnWjErMGNCUHAwbU13RjBRdGM3bXE0?=
 =?utf-8?B?aUhKY0lkMnRNL2U2UEJVQkszejRvMzJraXRrV1NFdmFHMVRmQlFJRFRNczNp?=
 =?utf-8?B?Z1VkZFpWdnA0Rjl4b0xOcXdqVTYvZmRETk9kRlJZSzNNYVZjWDhnRlhReDI0?=
 =?utf-8?B?a2Y1MUM2MjU3L2JDU1o4bFNJdS9wTTJhYzZFcjVMWkd1UERlNnFDQzYyZHRm?=
 =?utf-8?B?c2wwbmtraVFIMTZ4UGdDRGRCN0kwSWRCZ1Z0ck5URUxXa3R0T3VnUmZlQjJz?=
 =?utf-8?B?b2Z4QktxMWM0SEtvV0gyZUlSRkYrOEM2a3lRNzJzcGpGeHE0QVhTeHoyWHJX?=
 =?utf-8?B?RGVWUlR1NTJnTlp3SjRrSkVUclBIVUs3eGUrUnUvc2lGajlyQjhVdU5rd3Ro?=
 =?utf-8?B?V2RkN2VEYjFEamZvL3RNWTF4OTJGU3lkc28zWDYxK1FvL0JoZXoxYzMwRDFl?=
 =?utf-8?B?aGk0RzFRdUdhbXhJc3luUmdjN2REMVdEa1YxZ1Bpc1NxcHBHMVJtWlpFVHli?=
 =?utf-8?B?ZjJ5WW1aSjJ2RENkNUl4RHdVc3dRcFlMWC9WRW5qNmkwNStMS1JjSjhQdlc0?=
 =?utf-8?B?a3VKQjFPaVZWOUJKSG9IYnBTR1ZpaDcwNW5nZVR4UmJFN21yYXQvc1hTNzRE?=
 =?utf-8?B?T29aV1NCc0kzNVZKbXpaNTIwcmxIcytXUjVOclNvWHJiMTVXN1FhcVAxN2V5?=
 =?utf-8?B?dDExMGkvazdXR1FSYVV1OTNXOWNERzQ0emJyZnVaOWQ3OEVReXY4TXpMVjBB?=
 =?utf-8?B?TjhmMTEwcGVKbkJDQTJkaHAxbkc1TERvTFN4bE9YT0dNblFteExTbDhNbWJQ?=
 =?utf-8?B?ZmY0b1hmK2RscGpvVDRJTWxpKzBmU2xGNU1SelVKRm56T0crNisrbWNrblU4?=
 =?utf-8?B?NDhMK1NRbndYdENCOEh5emllQkpMelNKWWpxT0ZMdFBHSWd0VE5KTmhSMEZi?=
 =?utf-8?B?ZERERWM4R2ZVQmg4RHJIZi9aS3JnczY5eEp0WTgxOU5scFJUdzQxMzRlVkl5?=
 =?utf-8?B?cnBpYUxUR21FMEJ4V2ZLM0ErK2t2cnRUTXBMRVkwcnNxblV1cXZhdkxIY0RP?=
 =?utf-8?B?eS9SWWoyL0pQWE1DTmU4N1RJQ1lzMTRITFBwbGFnb2hmc1MrNU1PMkszdlZG?=
 =?utf-8?B?ZExDeWVqUVBkUVg2b2t5eHFuL3FEOS9UK01ETldiMldPUXZSMDh3LzVwR1hp?=
 =?utf-8?B?Z0Zld2xnSjhtSWF1MzlYeExDa1FwNlVGaHlPVUczeW1kT2R3SFRkVkhCdUxV?=
 =?utf-8?Q?FiqSu9ZuhaLPhTgomYaQOIJ4nopWa+Di?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkZlZlhjNFVENGVrVFhnK1lETnFrUzFxQWNQZEhnMlhkMDMrRUFqQVU3c3Iw?=
 =?utf-8?B?dXRNSGgzN1BMYm0xZGRuL2dERWxMWDY3RkhBenFxT09rQnYvY1lMN255SnVm?=
 =?utf-8?B?Qjk0c2p0ZHBqNkhBdTA1dExGVDlHMXA1Yk8vT1p0QjgzSTlXbkh4M2ZFc3d4?=
 =?utf-8?B?YXI5b3JUc25iTno5YlV0ellndnd6TnVWV0N3V280dkxVMGtjSGU5TGJDMWEv?=
 =?utf-8?B?NVkvaUdlTHk3VTJIS1pQOXFNa1p3WEJnaTAvOThBMnkwZ2RjUWpNMm1PeWRY?=
 =?utf-8?B?azlaeHpySUY1N1JZV0NLYSt6cFdWMEdpZW1tNVZTSkR4WHdiR1hjNUxtZkp3?=
 =?utf-8?B?VFY2bTJRVlpHbTIvRkV4UUZia25UNnZxb2pYOXRObzZnUENwTVNqdUQ0UDF2?=
 =?utf-8?B?N0Nib0s0RXhQYUh1NmNBTFZVcUVOZFVsQ1JQUTJVY2NIM2kvV0NHT1hSS05x?=
 =?utf-8?B?aGpRL2wvSXV4Y0F0K3VGaXZYYVowVGFKc0RYYWM4SlE3RDVMb1BjZEwxWURl?=
 =?utf-8?B?Mk9oc1J5eVh3eWdoZjUrKzA2Qkk5QzBRSmRHL0NGYmh3eFFiQXFNeHhCbHRX?=
 =?utf-8?B?azRLdFkzTEh3ZGVheUZkNnl2TkVyU1VaUDJaSXAreTdMeUZsNkZmNEZ5NEF3?=
 =?utf-8?B?enU3a2crOWszTk5rU0tBWElNb3NyM041cnJCSm9EY2JBQllHNkszMDB2VlFX?=
 =?utf-8?B?T3NlSTA5MGM1ZWd2QVBXWkNOZWFOUkFWKzN2QjJTODJUUnFJdkd2L3ZYQ0pz?=
 =?utf-8?B?dXdzRWF1eXFqVTBZQmtNK0krSzhwMHBwSlB5bnBZdU95aWFpTDJFUEk1OVhK?=
 =?utf-8?B?TVFUampNTVA2bXQ4aU1iWitkdDlCRnYxVUpRMjVoSEZGSWtnWFhWZ25WQ0Zv?=
 =?utf-8?B?TEZDZWZpYzN2MHF0c1JrNWZIV1JnVkFnZHFnam5IeW84NkxTekY4b0JXenYr?=
 =?utf-8?B?R2JJL09tQjlDSUNsRFJEY3ArWEUrQ1NhZWlERE8vN3VGbTJMWFh3SGlwczFj?=
 =?utf-8?B?WGNzMFVqb0ZiUGF2VkZLTFRDSDQ0Q29VU3dCRUhpM0I3dE5rbEVWdGFzQnpy?=
 =?utf-8?B?OXFsRjlyaVRGY1JVV1VaY0t5cXFIU1pLY0c3N1hTTXN1WHhHMkNJZCtYS3RZ?=
 =?utf-8?B?VWMvNitQUkFEdkUxb1NGczM0NFduNy9SajFub0pTdFg4dXNkQjVYbHAvWnZJ?=
 =?utf-8?B?TDYrcXRHUjkwZlQ1OGRMbExNVnd5Wnk5d1hsVFp2bW5PQlVJYTFuSDNjbldN?=
 =?utf-8?B?MWU5QW1SUGxrbnRRdGdBc3hUUDdYZXNTLzhGRTg4eS9RUHFTR1BVU0hrYVUr?=
 =?utf-8?B?cDVHQ2R0YmxoWUNYTXZIVzlVdkQ5RzVQejlQalNvM0lOS2orYUxnVzR5Y0Jt?=
 =?utf-8?B?STVQVUs0d3Y2UkQ5ZVFMQXk1Y3B6OGQra2FJOTNCVHhEcHVDTjhoa2FpeVd2?=
 =?utf-8?B?R01UeCtENDUyOVJ3ZWVURk9DbTYreTNtWFY2aGIxOC9UZEVobnRSWnZvQVVT?=
 =?utf-8?B?dENvcWdDTkc1NXdqOGxISTVIVXI5L1VxcllqKzhSeEYwSU41NzZvdW5JeldZ?=
 =?utf-8?B?cGRXMmYvTlhYclRNRWlGOGNYSXRaTTU3em91UTIwclFBb3lCM1BhQVJHUlhW?=
 =?utf-8?B?UlE4YkxFN25RMnBaZWtGbWxEaDBvV2VsYk1VTjVUZjhOY3BpMFF2M0F6Qytj?=
 =?utf-8?B?U2hrUTlJbnNySUhVQmJidEhOQjRvNzV2cjhralI1TWhlQktkdStoRWVYOFg1?=
 =?utf-8?B?RVpRUnBDeE1sZys4S3NKK3gxaTIremZFY1ZrRmxRblc1Sm1waWU5TU11MXhR?=
 =?utf-8?B?ZFZaZlhtbXBaT2FvRnFibm52NUFiMVFoYnpKN2R0KzdxWUd5NjErUzJRbU5M?=
 =?utf-8?B?U3RLSUJ5ZncyOHF6enczTXArV3NTNExQb24weDJ6VmJqRDAwZTdUMEpybzk0?=
 =?utf-8?B?Rm03ckpIVVk4YXcwYndLUjE4WjZ2aFY3azNVTC8vNDFoQ05YLy9ETkxPZnFh?=
 =?utf-8?B?MmhRRFFVVSsrUDh3SE9qSnFXd252M3l1WHFrQnNPU283Z2gzNXZnVUJEZjJu?=
 =?utf-8?B?alhtNzUzc2pabFNTZDFRMXo0c1FadzNmUVJXOXYwd2RqSTJwVFJWSytzTFBD?=
 =?utf-8?Q?fGi9iRHQBZLK5bEOetabhCIVQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38E6A372497CFB4A9BB63CE2709B9026@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cb1c14-e31f-4982-165c-08dd3bc20c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 15:24:37.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Riun72LYzf7VXVLi54W6RDQTA0m32dAYSzegxGJ5365KFc6JUH9qFc0Nb6+JuUJ4Ni+XzJpqSy5UQREvRpp+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

SSd2ZSBzZW50IGFub3RoZXIgcGF0Y2ggdG8gc3VnZ2VzdCB0aGVzZSBjaGFuZ2VzLg0KSSd2ZSB0
ZXN0ZWQgaXQgKHdpdGggaXBlcmYzIHRyYWZmaWMpIGFuZCBieSBwbGF5aW5nIHdpdGggZXRodG9v
bCAtSyBvbg0KdGhlIGJvbmQgZGV2aWNlLiBXaXRoIHNpbXBsZSBpcGVyZjMgVENQIHRyYWZmaWMg
YW5kIG5vIG90aGVyIHR3ZWFrcywgSQ0KZ2V0IDJ4IHRoZSBwZXJmb3JtYW5jZSBvdmVyIHRoZSBi
b25kIGRldmljZSB3aXRoIG15IHBhdGNoIGNvbXBhcmVkIHRvDQp3aXRob3V0Lg0KDQpJIGhvcGUg
SSBkaWRuJ3QgbWlzcyBhbnl0aGluZy4uLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvMjAyNTAxMjMxNTA5MDkuMzg3NDE1LTEtY3JhdGl1QG52aWRpYS5jb20vVC8jdQ0KDQpDb3Nt
aW4uDQo=

