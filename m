Return-Path: <linux-kselftest+bounces-18438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CC987D3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1F0285CE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 03:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993CB482E9;
	Fri, 27 Sep 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDTkMfwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6641208D7;
	Fri, 27 Sep 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727406255; cv=fail; b=Do7jkSe3aAbHVXq74rZ3hqS4lzHiScMWWbAIL24NnmMAQsx0+0DM4VrDWkFQH5cHxCZaH3b67naqQWSf+/tKWgrwlx1lDyU/SspvBZ6i109hyNUe/k42KXO14My/tWyoY+do/lVSBBrIUB2eEQ9Me5Fh4cyvKZGID76iciu1w0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727406255; c=relaxed/simple;
	bh=6tu4KRSq7aajnQesVAq+DyggwnlsHNdUSJNrO2Jw4H4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAL5KEvznNiC9AxA9vrI8a6pJ9rVbhR2qcWuY5Mi9eqp7N07fl5aLlrCSJvuOmhiZydRsWjFPkcNImg25rnoyWbB1NFxbiAL7eptqQQ/Mk/nBf4xkSZwC+PdR1tdhkMHczj5hOkZL/WvUDL3fQ/79SldS+PYuTD2s0kmyKhaKqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDTkMfwx; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727406253; x=1758942253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6tu4KRSq7aajnQesVAq+DyggwnlsHNdUSJNrO2Jw4H4=;
  b=lDTkMfwxBdDA5aeaa86lo1wTaeLwFOQd3LVwerwW1NQul7MtPLZYysk8
   1Jq/1DPufXH9MWZqy1HUBBHP9uc6gWARv2F86mRPLv1au9lLpQSO7a5si
   WB/AtJR1PmAd934yJT3E3VKBtXf0v7A1Gj7bgo+yClD/xbtPUDTPTHqA2
   4JBzvkdwPeBTD1ZqsQwfRLHrbLS0RHuIxnb2OHbtJg5RkP3Ck+gYeMseo
   WBhX8HHmwP97efjuidvQMOtu1Q/XDOofwvlMVEh6RfU+voEfzQIxyj8Le
   TX0i6nirvo1dO8Mz+LKHK4BFnmkGOOWijuaKo0JTEiC6UOGOOiVYmjWsF
   Q==;
X-CSE-ConnectionGUID: 5CuNJRRWRHWbvLBz6SRnfw==
X-CSE-MsgGUID: WoYxFRbQTwe5S6xD7beQKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37212923"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37212923"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 20:04:06 -0700
X-CSE-ConnectionGUID: S5tLc7dCT++aCnSuUP6++A==
X-CSE-MsgGUID: H5xJx0ZCQ5WwQvFwTkSHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="71974718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 20:04:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 20:04:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 20:04:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 20:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQd5L996JTfSXUmMDbgM0ji9Uu6fhW7c218vGHBi2DGiwcqQCjVV0E9j5Du/aE3opWLytnxtdNJL+aSslc4NEQNIcgLDxo4hIEy7yr1l1RFEm0PvxEUXXYnk2D4O7VkQ5oEU7X1BoYqI5d9Z4dKalpuXj0stTH95koJP27xuuOaVgfnUMqu3qTopyjzbbjsRPfwrtEWHTiPvjGWYAK9MzjGY8RuAD+Vl8bRpWgtz4OlZdYy3Z2lzRRpGfasf9K2LYZToYqRBYq7KODywBZiP+NzSq59FtfUH60/nsw/BzexDNrhTnjWAaOO9Shvh6MQIT05BMYQUZ/rjOxzNA5ksjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDCfW6Z2u9A8EPmS/M9rEgm1ieM31EWqIvFeGxEZD84=;
 b=FxzPnsLuyoFNjOOjs8B+EfNBAlLkujUQ2dmYYAmLJPfxg71rJhCYBpGEVp8E63+0vYfMfF5g6L21AJasZkp3kvQmC7MtRZp5wvAXsHeDBX0liXi4KLD2Prg1YImCiqeRji5ijRuM/+0BkK891GDeb8xuMXEAmXRo3akBn6NIhLZ30d0bMQCIUj9Lf4m9y+H7Ey9slMMx04EQKuJYIau4n9x/cyzsG8t+Y5h6BpA6O6PGmFhViGTWpJ/+6ff13mQDyRENyU3mSoC/uu1+LIQNc47W6h5ZGKPq1279s5phCKkzVX93FcdccpJUrgw2hkAxHe7LYZKOMOFH97tMAUNKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 03:04:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 03:04:02 +0000
Message-ID: <460c723c-1809-4ed2-9fce-3901b9754299@intel.com>
Date: Fri, 27 Sep 2024 11:08:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID
 capability
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<alex.williamson@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-5-yi.l.liu@intel.com>
 <20240926193559.GN9417@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240926193559.GN9417@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB4818:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aeb44bb-4419-45ad-86ed-08dcdea10a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnNvR1ZqOS9pMW96andta3Awb3oxT3pUTUhHcHd5V3ZWMWZIWElXS1Q1R1pa?=
 =?utf-8?B?dmQxN3BybFJPamlDcWRSUGplNzBKZklIUUliZXRSNFlidG1Gc1Y3VUZXSFZU?=
 =?utf-8?B?YnFFK0w4YXhFL0VySVRGbFdWMmpuMVVFVkw5OG8xMHFUaVZZRGlvN3IxN3V1?=
 =?utf-8?B?dFp5SGZqZ0FjeXQ4VEg3K3VyMzlHSzBhZHlhK0hLejVubVpteWUrVEdNTVhl?=
 =?utf-8?B?anVJdmZOMTdNOFlTWXA3VFRjOU5CT0srN0hzcGJ1RllQMFpoc0FVNkV2bDJU?=
 =?utf-8?B?RVduVkRKKzFyWW5FQWZQTVhSZmoyVzZ0cUxHRWo0Q3g5R2l4c2txRHFHM1JU?=
 =?utf-8?B?ajNPU1ZUUDR0MEYrWGxIQk1OMHN0QmNpU3BvRG9zOEF4SWZEUk90VEI0UEho?=
 =?utf-8?B?Ulp4elBOcTM3cCt5TzRJVDhkcndUNTVxd3E1Uk9hbjM5c3Y4dXI0ZjF6cGtF?=
 =?utf-8?B?YXhGdm52cHRncGk4aDhHSEMzeENKQ3o5ZUNrWG03YUFwWXJKRitVa2NuZURW?=
 =?utf-8?B?Qk1tUTlXYXJyUUdGVk9QYmlyVmdDL3NRTmtpaGROc1dQdkNaREFncmtaNmg4?=
 =?utf-8?B?RzQ5dTFqM05xWm90eklhUGh3WG96T0hBb3JvWTZqOGdQQ0tUZW1JL0hiV29v?=
 =?utf-8?B?am03QWxWa1dUSDlGQlFvbEZjTStQRHVNWWtML0pyK2hTN0pIZzFON0ZzWlIr?=
 =?utf-8?B?WWdGYUZOYytiRTdRNlAvT0ZvczFNVHJ5NkVrS2pTNVl6MmRRN2hoT1B1SzEz?=
 =?utf-8?B?M2hHTWk1ckREV0FhUmtxRm90SjlueUI5bmZFbDhWRjY5TkZRb1ZITnM3SExZ?=
 =?utf-8?B?UFhjRFhMRUlMbThPeEVSaUdZNFAvSC9saUtaTGlaM0o3S1JweEFIMGZ5R05J?=
 =?utf-8?B?SkN1ZGpORHFvNXlTeWdNeDFGUEZOcHd0UkpEUm1sbGl3cTFCdGFXUzBlZ3Uy?=
 =?utf-8?B?RFVuQitiSXh6NnhJQUE5MU1oVFBUUFFCQWVQZWsxblN6R3EvSjZkbDhheTdn?=
 =?utf-8?B?ME1jQTNKSjZjdm85cytpQ21hVzFuUk92QU5IeSsrTVRtYmFEcTVCc0RFRE5w?=
 =?utf-8?B?dlpnSzRYeUs0WmpUTm5jR2x2amt4UWtjSGhMdjQ3S1d5N1ZkejZMRThrVXV2?=
 =?utf-8?B?NnJWWUVYOUk1QjNOSkxEMG94dTlPdFdVZWVEZEZibFUzM1A2UzhQeEJuY1FI?=
 =?utf-8?B?UzI2UE1NcjhDNHNhSGMyY0RqMlhBN2hMa3FKTnc1Q0FwWG5INExOVkJXcTB4?=
 =?utf-8?B?VlRSam9xeFZ2Qk9iSkZSYmlDVEdybHJINi8wZ2hOeEY4RXlscmdaYW52ZGNG?=
 =?utf-8?B?WTd0eHA3eXphaERXSTdjWUdBZzBWdVh1c0x1Q2Erc2U4YldZMjAxYlBJWkpj?=
 =?utf-8?B?RnBOV3BoZjNpSytpQ0VYWmNUWFhZcjBtejlnMS9hM0Zic0pKbFNoMmlvdzM4?=
 =?utf-8?B?VW14SkozTVV0Y3FIeGRhTXRBbzVJWlNwdGd0YmZYUEk4akF4ZW1GN2xIM2l2?=
 =?utf-8?B?UitzKzY1T3cwOUFuSVcxR1RBQ1hCZWhocDJ5YmZyczRZT1BLOU5iOHIzZ2F1?=
 =?utf-8?B?U2l1T3I3cUxEN1lvNENkOG03ZytyQnhLN1prbWRBSXZsbnYxSnFvY2x5dGlj?=
 =?utf-8?B?UkxmNmRFaHp0VzlpaE1LbllwNXczbmdZT3cyaVMycDhpcng4ZUFwbTdvbXJW?=
 =?utf-8?B?bW1wVXhidUhJNGdFZWdwMzN1dnhhbzVlWTBqNjY1RU9WMy9OODBJVFhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWphZkZqZnFmS2dJb3hlS1JDbWYxMXFzdlNpUDAxalV2T2dBN3JDcG93aHdG?=
 =?utf-8?B?VCt4N1lCTzdCS1RuYjJLRHRXOG13UmxNTjFkay9lN1l1Tzl5YjhzTDFEbHpo?=
 =?utf-8?B?ZjJoUTNCRGxnV0RHelMzelZnNlhwSFo2VVNSVysyMmRUSk9XL29JV09Bdisx?=
 =?utf-8?B?ZlVMYjBoaDNLVWdEMmxyS2ZPVGVaczR1NU16UTljcjF0Y1ZLS2doSXRQMHNR?=
 =?utf-8?B?RUcrN1RnbWtGZ045V2dIRlJUNk4rdmZyNE5KQXhlbTZ6M2xBQ0pKbXl4MWk4?=
 =?utf-8?B?MnBCWm1CdFpvTDA2MUpmeWZDU1FteGZiVktCZVE0dFZyWjVUeVJ2eXBkNU5u?=
 =?utf-8?B?VUdRcytyMVA0Y2RMT21SNXlHamV6bjIxZmx3aUdNbkFjTXhJelBGczBXY3dU?=
 =?utf-8?B?QzFIM25GOHZNb0lwS20vN1BpbUk2MHNHL1dIdnh5dFlRcFFGemdjT0h1UEJj?=
 =?utf-8?B?eEhnOG5qdU9jOTJ5cnV5V0J4a1UwR2xCOUdaeWFMVGdaSWx3VFFQMWtnbHgx?=
 =?utf-8?B?SnZIS08rTGZvMU9INXhKbE5NN016VjJiQjVNL1JpVmN3R3dQc2ZzcVk0dlMv?=
 =?utf-8?B?L3pCaXh1Z3ljSnJCN1pjT1dSbWIzWVNGOU5FaDhMV2V6eGg0cURRVXFwdjBZ?=
 =?utf-8?B?WE5yQWlRZlRGOUg0clA2bGZxUUhGTjN3U3lJS0hoUkFaOTVsYUtJVlo5U21k?=
 =?utf-8?B?WGoweDNaUGFIaldFME5Bc2RZMi9sdmdXa29aSWFXWHFXUmplYzI5TW5VYXVm?=
 =?utf-8?B?UG04K3pYWUxaTW05NndDd2ZMSUZySW1GYVFTR0hLdGE0V0MyR3h0a2s0Y2tY?=
 =?utf-8?B?RDZNOFpvYXg1Tmxyc3JNUXBYdTFJdU10VkE2bEJST2g0Q3l3bHBqQ0tFSzQ4?=
 =?utf-8?B?L2RQNVV6RXo4Z3Y5YWJsZ0JaQVh5ZzhKMk15RHNXTzRONmc4eUJ3bEdCWE1m?=
 =?utf-8?B?RkdTK3J0dVJXK0ZmMTc2d200cGxmUzBYbkRJWTE0YTVEK1E1Nzg2ZDNhT3p4?=
 =?utf-8?B?blBKL29UNm9zTzEyeXRBdjlvZEF6bWpERk9wcFN4aTZ0OXZMUFN6amgyblNl?=
 =?utf-8?B?Y28xYm4vLzlOOWdXQy9veDJXc1lqTmhYdFJyVWZ1d1hZRkRtZ3NPK3RwK0hV?=
 =?utf-8?B?M1dvU1NuWXhlUXU4MUlzZ1pZRS9Ja3JDd0hNOW1YUjd6cGNhbjJUUnRoQ0J0?=
 =?utf-8?B?NnBYc3NZQUFHblJXdzBsOVoxeWVzcVZJQ0ZwTW82OE14Qm1WSG4wSlFGRXdx?=
 =?utf-8?B?and4VGV2SmZ0NVllZnQ3VVRDZnlLa0UxZkJUM0h3RDVlU1J5V01VdWl4WEVQ?=
 =?utf-8?B?YVNyMENEOGZuMDNjRXJueCtxZ1VYR1BVYzI5NGJZTFF3d1czdS9MMzlFVndG?=
 =?utf-8?B?aTVjSXhrZmpDYTJWWTJQQjR6aWVtVGRDMFduZHFNbHpoN1JOUWlpN0xTTmhy?=
 =?utf-8?B?K0s3NU82clFpcUQ3MkFaUlZ4RUd5WHgwQWs4NmRtREJ2a29icHlyL2lnVlJE?=
 =?utf-8?B?cms4ZjAwcGEvUVhKbnJNYjYxSnZ2N3E1TEtXUjRscWo4VUZLTVc3c0t2WURu?=
 =?utf-8?B?cUgxejRuMjN0UGZqSlJPNURkUC90dTdsSUs4aWJsblRvcnJXS1owOFZ6VVZs?=
 =?utf-8?B?S1hYSkRRZE94YnJtREEzZnplZmN4YmxuMWpyc010S0o1NmcwdkNLWGwxOTBT?=
 =?utf-8?B?UXdPSFdZSUUvU3RxcjBuUkphM3B1SVNUSS8vRExtQ2tyZWNQeUUwNmtoTmt4?=
 =?utf-8?B?QVBnbnJOdUMzTlRlR3hIbWcrRnIrU1RxZEJZYktwNUt1M2lCVDFDc2JaVHgv?=
 =?utf-8?B?aUUzUTJOeWRkamIzemkrZWlhUG5yTDZrRnY5RklMSzRJT3h0TU40YmhBNjVB?=
 =?utf-8?B?MUpzT2NuUEgwL2UycDNnTWk4cTl5MmZBL21LaE02eXBvNHRmcSs3WkVPL0Jl?=
 =?utf-8?B?dWVHM2V4ckl1ZTJsN1lqS2FGS2doc3J2UmhwTWN2T1ZFUG1Ma0I5Y1lheVl1?=
 =?utf-8?B?VXJtQ3JFOVUzK29ZUStqV01YcHdNZGUzZmpibVVLUzJSTDBKWitaSzUzV2xS?=
 =?utf-8?B?YnpxNTVKZTQwVUpRR0QreGtEcU5Mc0tSc3YvcXlhVUF0UEVpWSszWWJTWnU4?=
 =?utf-8?Q?2smxZWshtqyaPP2OTpp7pVQX7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeb44bb-4419-45ad-86ed-08dcdea10a67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 03:04:02.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnuA4OGbDdHGruIx0L3OQdUzHYKyQzdbYy/ExPaM7v+mpsvww8etePD7KOpsOf2GV8D0CZNqYjBiiMF0e2lb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com

On 2024/9/27 03:35, Jason Gunthorpe wrote:
> On Thu, Sep 12, 2024 at 06:17:29AM -0700, Yi Liu wrote:
>> @@ -1242,6 +1245,28 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>>   	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
>>   		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
>>   
>> +	cmd->out_max_pasid_log2 = 0;
>> +
>> +	if (dev_is_pci(idev->dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(idev->dev);
>> +		int ctrl;
>> +
>> +		if (pdev->is_virtfn)
>> +			pdev = pci_physfn(pdev);
> 
> Don't we do this twice now?
> 
> Let's just keep it in the pci core?

yes. let me drop it.

> It looks Ok otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

thanks.

-- 
Regards,
Yi Liu

