Return-Path: <linux-kselftest+bounces-5267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F885F2FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB331F25DA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6A2261A;
	Thu, 22 Feb 2024 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrTJfst7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79517998;
	Thu, 22 Feb 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590686; cv=fail; b=Zzoaxc3XJFwBjqU8yTS5qK/odJiPPobFGwYpkej2Ur47y2UzFrw7sLz/R7nqknnTMUUg8GPVmkSq10LqDdXJCJupWihMkTwzr4w56PGwakAG02lnPAePYLck6aJl1OkD2ecBXaPXzIRrl8TPDzjWKVbVK1nMHxyyXvng6Z5eaSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590686; c=relaxed/simple;
	bh=mPM2SM5oJfPC1/ANNkLQZdS3VsuZEx6b5N/Rs0uJ4sY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9aW+ypcUeyZk24ta9QGpyIev/Lytu2AgR+llYwaPCw4rXtwhR3KnyJc30Pj/ZyWhfatell6eeA1jp0NV5ZMst+MRY3En6ZIfw6k3FVKVKsB8Rll57U7KWz6Klwhlb+I6e/q1ncU5SELTX+ivtgBeiAG2Ax2tMDB+9lPwviBNsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrTJfst7; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708590684; x=1740126684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mPM2SM5oJfPC1/ANNkLQZdS3VsuZEx6b5N/Rs0uJ4sY=;
  b=HrTJfst7GPMIoGdNGmn0OKL573sGVO+0eDX5YFnxOrGcLuWii6RKlKo/
   RilbbSXMDbr7m2Keoz2/i5zpmllh2DRqf5J3kRnALjSTqHvmN4kidEHzg
   FjwhQ/Al/0SW/3gIxfrBdq8jl82AF3ju+K+D+ir4Q8isOBF+AiGh563Yd
   WUZ1heDPHeVa2Nfv9RlivALO5MWANZLsZJ8JHfq6/NN8D12WGWYBaESFE
   qgIs6Wc4BFbYPBRxvt3iICV8bD09pIhujN8ku5SIixlRlgSXh4tyD0xtS
   SlNrl/GvYmBiDNvUwCSG5TXQedZyb7WJak+sUxePYJ6dImJAQUnXdI5aW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28243244"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28243244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 00:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5620969"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 00:31:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 00:31:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 00:31:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 00:31:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 00:31:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2aeCz96NKkorIThA4I8ucUxzxUUc98/rdPMve10jWF4W9es7jRLG8NWrGMI+MKTSRNsynZ3bK+WYbwwf0EPpZxMXarCZwQIOjV5HruFlrq2seHBL2gq3bACg/r4vzmRv0vUuMFAJscvCZpU2O8dZm0T30WkybFFFMumS/UCXnbgymZ8Io5tA5OEO2eHFBj3tIidvSU6JanNi8NHEANm+z0IwJGZaSEqUyB0ywaxoU8LGC1tZ6krh0DIMPXX7WGd1Vp7M5YVp5TwsHNrKKk2GjQIu/d4EKQ2gBBeMhbtenyQjwZjzmLRiU3Tle7gHAwvPaKXE6qBohW8rxhOUxtgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hMdbUuFDROBZcjp0Ct9WeDRjQJnZqDR58xekG83mbw=;
 b=bnDOKBmm58uAmAUObFNhD2DuErSnCfhSiJ4+dB87LjN/XocPAQ3fo8/R/0IPgXXo3QaLnogRwlYDAkw5ZDfuq/bOVeom9QQL3spp0Goed2IfRkbSUphVZK/HzbRby+8DLgOChR7cakgmqeiwcUEhfu319Gne+ucA6bh90j4RCgxtTDr+TBld+WZmfmFtlRyDmay9kYaopj0ze5AdMeYF1JrfW2E2G1EqwEh+c0g0DEpFKXOXHbv7qMTo6IeUGFjpv8T0FeVJm3yL6zTuc6WqSOMe7NpcbxqKfCWgQ47zE4FutXaY1jWioREmNAA2pVTANiigivMJ0+kKbJvrwsSMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 08:31:03 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8b51:c6ae:f8e0:8ada]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8b51:c6ae:f8e0:8ada%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 08:31:02 +0000
Message-ID: <d6b9ccff-3aba-4508-b83e-4bc3bc859e96@intel.com>
Date: Thu, 22 Feb 2024 16:34:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<alex.williamson@redhat.com>, <robin.murphy@arm.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-4-yi.l.liu@intel.com>
 <20240221151923.GU13330@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240221151923.GU13330@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: c350a0e5-cd95-415a-ea55-08dc33809acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSCUX1eSwdnb4eBw5PpvqwOql5Ww1+zaNvilJO+bXRldMdo00R5S0yb+B8ulhHSEj4KSZbbYDGfd6iqroQUK5McJTfzLE4RUxSTPI6cuzF2ZSQv4rY6a6ZqCXg8oVNvraLHNspdo+o/dUDNLDn+xTJ2RNM0/q7OhDYKB/2S+EbVei1Eo/KS0pPQUPDVHknfoEoZLhmQ/jZCfwUoEDGQHYqc/NtFjbLtqZkqk5j0U+4tfnE+Tc4gowH/FfBuzwDa1DEIAuYFtHXcvln2Mkp12L7AqW8aCAaHdq9vSp3Bl4vucubF63yDcJgFTaJj6dxRz45dNw+AsW6GtxnYTkZBo8KhPmykiZXnqcSDeNQ+omaaZgIabcFh4C0/j4XT9nSImVs64S5PGy73WSuC66zqQMgilTIhwaa6PXhOVdxHY8Qw42v/4MQmV31V7BTB5pknLqFPug48uuRzBvgAeP4dEa/qakOLKaqIJhUONAE5GkCARc1o4yrgiJ/nh1zenAh2USl1th4cSIIBVaqDrDAUQnODAb4yyjJem9SCnPwf37LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldNRFI0Z25WNVVuV1pseUpQVnVtNG5ra3o2eE9yV2FMcG9tTEg3MExjMHFS?=
 =?utf-8?B?T1d6ejlZOU9veTh5Z1hjdFJDd1NvOElxbVgxTWJCaTVydnBrOTR5UjdKTVlR?=
 =?utf-8?B?YkFtUkJiS205Z2xDZitJOUZVZXdyMDRESjJFY0s1d1VFMlU4QjF6WW9FOUp6?=
 =?utf-8?B?bjlpcG9NWitKSDU3cGdRZzNuTEFlTEd4djg3UG52blJZZVpxRTdhWkdNMjVZ?=
 =?utf-8?B?bWdJcFFIUWpqcmdYcVcrVk9KZXlQaXhYdU1wSXZaR2IzV2tmSGtsNXJWTnlz?=
 =?utf-8?B?aS9ab0UxR216Q3dtdmhVaHo5c3doUXgxeEU1ZnoxRTVtSmU4YzVDRG5WTmla?=
 =?utf-8?B?aUtKcUx0SHNtWWJ5Y1VBcEtDcVhld2RMZmJkZUZ2RktwRWZjTGJoV1l1dzNF?=
 =?utf-8?B?cVpZYTFBZWtFaE1sZU9uc2xMdHJMdExKYXpZSVY3TUdEdjNWOVk2R1BPSTBL?=
 =?utf-8?B?UUZaZWVVTW9RdTVSYmlEbDl1YndiTG04ZEFwZWEzRGliRTAreENmN2g3Z2cy?=
 =?utf-8?B?SWd0LzRqcjhJRE96YWp5a3o5VXkwR3pIUnZBSUpWR1pOMjFyZkFkdmZrNXlK?=
 =?utf-8?B?Vzh4QXBCemczcThwbE9zcjRlbHUzT3UrdkJyUXlPNWhuTE1DektzcFdlR1h6?=
 =?utf-8?B?SDVoUThoWFRkeFRUMFJ4dGZHMW5rYkt5eTdROGtUWWcxVTVITlhpbmFaY3ht?=
 =?utf-8?B?WFlBZCtIUit2WDBuRDlSRHRSeVZmczRaaDFXc2VlazRUNzViaUo4TkQwcmp5?=
 =?utf-8?B?ZnBwb08vNFdWOVpEYTRLM3pGdnIrU1BDNHBGSVN4MkgwRWVwUjNld0gyWjB1?=
 =?utf-8?B?RnQ0Mkt4QTZlS1QwR3F1MGJUMDdvVitWUlVxSUI0N2hpZkhZQ2V1M1lCbmU3?=
 =?utf-8?B?L0QyVElEUmdBM2FNNjBwditMZzBidml3VUZNOHdqYS9mZTROcUh3ZDMvNUlM?=
 =?utf-8?B?eE5uQ0NMNjNzRGhaeWduUi9oajdmRDM4bnZDNEp2N2c2cDlwa0VXRVpoNGJ6?=
 =?utf-8?B?THlsRmhsSVhRQzBuQngwYWgvaWg4czBiUno1WHA5STAyUXhrRmtVcW5zSmYw?=
 =?utf-8?B?Q3VDN2lGbVZtRlNsb0d2WFJuNmh6cG5Nd21jUVhDWktxTW1UeG1CK2Zha0Fy?=
 =?utf-8?B?b0VkSnQvQlZ4T0lCR0greGhCSEhWb0JvdkN6YTVRczY4SjNDTkp1QjcxSzE4?=
 =?utf-8?B?djBzOGI5NUo3K3BWbWIwSFdlcng5S0VRaDVWalJiZ0t2MDU4KzFUQUpMWEQ4?=
 =?utf-8?B?cUw2RU1BM0NFUEV0d3NoZTRyU3ZXemJZQ2ZDYURHRFA2N0QxQ1o2SFhBd2ov?=
 =?utf-8?B?OG5PbndUWGJ3SU40anZ6eFNkNmVIM2liVmtSOWl3UkppVHZNRTI1RGlwUHBI?=
 =?utf-8?B?dkJOTGtrZ0FTOUlqcTJXS2NTakltMU9IZUY5R1BSbFNWUUExZXFrdEgwbGdR?=
 =?utf-8?B?WURhZmtXamd1R3VoWTZkUGljbm83MlZydTYxeUFnNWNWeHpjV3hhczJyNmJV?=
 =?utf-8?B?enVWcFdZT2FVaGkwNFVOdzlHNC9iZWtIOXFRL1N1VGo4aXpUYW5FY2dPR296?=
 =?utf-8?B?cHpDZUV5STk5bTUvQWx6L2NHWEdEdmZPNjZ4UlRXYncwMTUyUjZVTVJINDdG?=
 =?utf-8?B?MmRScysrcG1XTXVoVzNDaHpVc2ZoWHU1UGl6WWl6ZkJYZnZ6N0V0QXVVSUtx?=
 =?utf-8?B?dGF5d2NXZWc3ejdJOEw4ZXUvZzcxK2lsRnpOZmhuMnRUMzM4dUZGdnR0RDJ0?=
 =?utf-8?B?NEFjMmVEVW5FOHZwUnJTOU1WOVo3TmpyVm5yZ1Q2ejhKb01wYlZzOVkzZDl4?=
 =?utf-8?B?VHVUUkJhRlZPUG9tZ21TQ1UzSUovZTFEd1RObmRjUWVBNjUrKzdRaHcyN0Iw?=
 =?utf-8?B?V1huTzQzNW9sTHZEdXQ0YjVDSVpLRU9zdTNXTlMybUFSMnUwNHp6b0g3R3J1?=
 =?utf-8?B?OTlHeHc2cGoxdUJIM09uVXVXYkJlYmRJU3ZFYXhKSkRDRi9oTXpSaTA1OVBT?=
 =?utf-8?B?V3RxVmxqQ3d0bWYrd0ZCV2szU3B4bHV5QzArKzJRNXhqOWJwaXUrdUlGWElx?=
 =?utf-8?B?ZllJY2VwSy94OGFGSzk3cENDNGNuUUFSZmF4Z2ZQRktGOGVWMjk2L2YwcUlV?=
 =?utf-8?Q?vOUya1dA4IxB7YT3KJpm5IKl5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c350a0e5-cd95-415a-ea55-08dc33809acf
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:31:02.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quXv/iDF7xWnTiqsvTCgHbUG3MWWc041nrubvajIF/MxMC0IbcchfUt3r0BbcRHgfrhWOWOZTIc0khObx2aeqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

On 2024/2/21 23:19, Jason Gunthorpe wrote:
> On Thu, Feb 08, 2024 at 12:23:02AM -0800, Yi Liu wrote:
>> If a domain is used as the parent in nested translation its mappings might
>> be cached using DID of the nested domain. But the existing code ignores
>> this fact to only invalidate the iotlb entries tagged by the domain's own
>> DID.
> 
>> Loop the s1_domains list, if any, to invalidate all iotlb entries related
>> to the target s2 address range. According to VT-d spec there is no need for
>> software to explicitly flush the affected s1 cache. It's implicitly done by
>> HW when s2 cache is invalidated.
> 
> I had to look this up to understand what it means.. The HW caches
> per-DID and if you invalidate the DID's S2 then the HW flushes the S1
> as well within that DID only.

yes.

> 
> It doesn't mean that the S2 is globally shared across all the nesting
> translations (like ARM does), and you still have to iterate over every
> nesting DID.
> 
> In light of that this design seems to have gone a bit off..
> 
> A domain should have a list of places that need invalidation,
> specifically a list of DIDs and ATCs that need an invalidation to be
> issued.
> 
> Instead we now somehow have 4 different lists in the domain the
> invalidation code iterates over?
> 
> So I would think this:
> 
> struct dmar_domain {
> 	struct xarray iommu_array;	/* Attached IOMMU array */
> 	struct list_head devices;	/* all devices' list */
> 	struct list_head dev_pasids;	/* all attached pasids */
> 	struct list_head s1_domains;
> 
> Would make sense to be collapsed into one logical list of attached
> devices:
> 
> struct intel_iommu_domain_attachment {
>     unsigned int did;
>     ioasid_t pasid;
>     struct device_domain_info *info;
>     list_head item;
> };
> 
> When you attach a S1/S2 nest you allocate two of the above structs and
> one is linked on the S1 and one is linked on the S2..

yes, this shall work. ATC flushing should be fine. But there can be a
drawback when flushing DIDs. VT-d side, if there are multiple devices
behind the same iommu unit, just need one DID flushing is enough. But
after the above change, the number of DID flushing would increase per
the number of devices. Although no functional issue, but it submits
duplicated invalidation.

-- 
Regards,
Yi Liu

