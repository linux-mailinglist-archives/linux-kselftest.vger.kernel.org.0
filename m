Return-Path: <linux-kselftest+bounces-5931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D487233C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298701F254F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C7127B60;
	Tue,  5 Mar 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9faKc1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEC12B6C;
	Tue,  5 Mar 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654093; cv=fail; b=Y6SCCYmvTQ5gWQqbniTNgmH3192E7q4dl0WRChinWIypoc/ObCCpcBFAFfXfl6EA5tog3CYpY+P30ATzPK1zSNfP6YfXO9w1n1zQA1Rq9YTY6A/JdBzdF3MjGEeKNA3xDcKm9CpBUyAuch+katOZRLMdnl6poWcgNUrQfVXRBD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654093; c=relaxed/simple;
	bh=hqoHwt9ecQxCNTnd+sHpErGT761y/h55L/8j9ofF+yw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXObISUAueLRzXsdS/95TD+HE6Flmxl8WrKMq7wn+3CXghUa65l3BUQyjH4ioc8/FhF9WgzxITHVx/dJrgL5ZEyuO9o6nLgCG5WDNnv96iQPVBovneXApT02m/PU3Ga/dGG7jH3qWotuN6EGZ36XnUXwjAnFRZv8mUC3KP8k8Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9faKc1X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709654092; x=1741190092;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hqoHwt9ecQxCNTnd+sHpErGT761y/h55L/8j9ofF+yw=;
  b=N9faKc1X1y65ZwNtiVG759YloG+O200lFWCim7936uJXt9D405eyKdV3
   MGyeOq/PKH75ycZZgrke0S5FDxVPk35BmqmG1oYgO6N8/EkCGeRuSmXTr
   8sIb2wx4SH3Ebj1Bw79Tcl7CFacuYnQToMT4GpNddGQreRhQr8kPbLADJ
   m+5z9KRzA4WKPbGT5NDKRVz6C2gQ0NzLnMKJTgHgXdAIKQcQKuJoSfdAT
   ywg57FcuAYqPhu1gkkJ2aWTEcR+ldtSztl7NqmIdPfe7ilTMBEfD+lImb
   8CFs70F9i5itpNE3zFrJbxotDYI7l/8yF+AoFkMdUKRc65vOr0VFq1JcJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="8033204"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="8033204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9319295"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 07:54:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:54:50 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 07:54:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 07:54:49 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 07:54:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtK3E/DA0AMyFBZ8vPGQLHb7/dykX3egBf/Z+5cvcHvnz4miupYEBih94POQbo7AQR4Y8MmTvzFOroLc8aTyb6KqzshbnxzFSOfRHjFQjz6xha0RT5g7uM74tHhQYQaRCR7dLsbOpnH3fL977X5MLj0MPkHj77DDNy2qxAbkP0tMOi1vBudbDsdizSnI5WO8gKPb7Ki5eNYTSoVqlgW5cJDN+U1OdrxVXgCTgUfTyqrv83Q4LpCYIi5Jo5p3es1imCvqPrtkWQiNDTelCYIbPB/y/dp64yf/VcBKqZY7QAHkxqvRdTwr5d6WjYTx521kh5jc9ZonC3BSBZSGVNbX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfuPYClZIxnM7X7D4JYbkUqBPtgY6F8L7t2qdWwFud0=;
 b=J6jmnD9ttAf72cC8mR5NtJJw+ttxdwb1XpyFGjv2e/pJU78Qn1pKFVv5LIEna8Dv72m3Ngl/6/Mw70/yNe5NFt2pPGs/hNBoqyk+BSF/wCuVIMAwlvvMAYcpOjjIcMvyenb/vQYvynFYQhtTiTmhKMxszEPp5s0HCfsjOy4wKHTSEqRdGlKdDxyiiEUFbuSoJ0FeNV4VbRJrzFvHLKtFa2p1QGF8fNiBkXhqGpDTzvzN44uMfon4cvqZDD1Lso4T8z0CYA33PEKGWOiVXRTdzLSFIML4pKr8OqajkUPM1kyw7iwSHsncPumTSZiVw/lDAbWISt/dsqDkXwnD7Jqs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.23; Tue, 5 Mar 2024 15:54:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:54:45 +0000
Message-ID: <24a1f5df-1629-4569-ac1e-b7c9a128f0c7@intel.com>
Date: Tue, 5 Mar 2024 16:54:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: avoid using SKIP(exit()) in harness
 fixure setup
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>, Mark
 Brown <broonie@kernel.org>, <ivan.orlov0322@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <shuah@kernel.org>, <jglisse@redhat.com>,
	<akpm@linux-foundation.org>, <keescook@chromium.org>,
	<linux-sound@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240304233621.646054-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240304233621.646054-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db03913-5a9f-46a3-26b5-08dc3d2c9446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTaOafrnb6vCsiv/hkMymesjnytD6RoE04FklfaKqxAsA1LCB5wFlfbEGHGxGv91SYQd8zCIVh+X/JWpf63S/KxyUD7DwRB/mK1AI55oQX9mJ088Oq3G+GD8COHSYp3ZFBdQFGtGGNMmsw5THdjw0OJ9X8OfAnckk+Y/B2jAKwHwi9PznR4AXHS4T8Tftqs9SnQdNcSQ8CoB+e/AnTsVcqzOIx7ZNkTxqVEFmfAQWOn7gxrAJBZpZdSFgAH09DxhaTRS8Siv005+P40WkbgnCPCOYEMHSx5iozsCMigfWkDXuegLzonqeCF/bSAcypATH+bsDTneDDefrFISFfvzHrZf1GixZ0DYcVylD3ctXbkIXuBV75dvNVu9aspfn/U6ziHT+J+rB/eZIApJ71kzrYpMbrIteOBTancjRAzKG0/6vQtvoEqp5syioAaYwL9hO9nzg7fFgwY2nPG3ZvGy0U64kIivG4n6w+oLXyhH0x7ZYBZqz6w75RYMnYvsIu3yKzBgB+SD1vy4+5pYWCgsad1f5jJWYppsnQMmbeGy3+TyBkutqKML3U4RFlCuxodaPQxl14L3OIJwtgyIRksokqjTMBaWlIIwxomVgOvLrVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M052blNXVHFQa24wYzQ5UUlYOHJQejBWMmdERlVlU1NOZkM2Q0xtWkN0ay9L?=
 =?utf-8?B?RHhMdGNPRzh5SXBjdEpYK3JOVXpNZWY2MnJLbEJ5Nk1TaTE1Z0VyYk5qYUcr?=
 =?utf-8?B?QUE5cHpoaHNidFYwOWYrU1hUQkl0TVlXY0c4L1NJdjVZTFFKTmJkYTBJMjdt?=
 =?utf-8?B?dVdwbGhSZGZqUGVPRlZSZGdqQjRPdFdtZnhkdnpZREhVMmhLcllNTDBGUHAx?=
 =?utf-8?B?K1ZuNk5LWkVEMGdhODNTUHNyNkNSbGFka05DS09ic0RjdmRYOFJOcE9yYXox?=
 =?utf-8?B?NUNaZnFJYnd3aUk3QWltN3lBRHlvZGJSSzdLT2lJTzRoc1FwRTR6ZlN4Rjk4?=
 =?utf-8?B?WWtUS1ZJa1dRUkwwYjVoRndubTNPNmt1WThOS1ZaMWJMSzd0NnpGTzNzaUEx?=
 =?utf-8?B?YmFvNHdzVWxWMWZwOExIalAxNXc5QnNyZ21uOXFQMjMvYkhoRFNEQkFEdlBp?=
 =?utf-8?B?ZWZ5SU5KazRuRlBKcGkrMUt3dGtlNmV0a3ltYmhaOSs4emJUaS9obzZveUky?=
 =?utf-8?B?SXpIaTZpVklUZDZaQ09Rb25WZGZQMnltdnpVRC9nRmhQckJhY2dscmhsSStQ?=
 =?utf-8?B?bEFVM2VVL09JZTQvdHA4VWVpVEgvTkR2L2Fhb2VVcDM5VGZjQjdtdXFrZlBV?=
 =?utf-8?B?Z1VhUFBvMXpiTno0SWRJZEJZclFzZ25EaFhzUmoxV21rNGpLQ0lZVk1OOXBX?=
 =?utf-8?B?TlZwOWZWbHdyT0Q2QUxFd3FjUTVCc3dBdUZZMkdHbm5VTXBsRWFCL3MxUVc0?=
 =?utf-8?B?bktKRzgzT3lXL2dabEpGMEN1UCt5b0VHTFhPaWl6Zk9zUGJkV004WklpQ3RM?=
 =?utf-8?B?V2tHRnphWFpVTFNPU0tDUmtkUTlRbTNqN2xwQUltaG5IVnRrcGJDMnZMMTFH?=
 =?utf-8?B?S2RYUjJ2K1BZMlRicUswRXNMUW4yR1RaT1JZOE8ycGVHdzV0ZG9rMXhLTEp5?=
 =?utf-8?B?NTRsRWVGdjhYVkRKNDc0UkhuYVFNWHl0WWExZDJqSkJWRGNCdS9TQ1RHbFF1?=
 =?utf-8?B?UmhwUTJ0eTJKUU8xWkpCQnBIMzZEbzJTVlpmWDExVlNFQlVuWGp5Wk9tT1Jh?=
 =?utf-8?B?bEtUWHZEZ0FPMFJZeWc5MjVDR0ZoOU4wOEdBUlBiSWlvZ2w1amVFN0x5ZStt?=
 =?utf-8?B?b3VBK1ZOVFlWd1M5a0l0VXFrV1BMTGdVbUVoNDN5eG1kYXBMbWJWNCt1Wlcy?=
 =?utf-8?B?c2NCTVlFL25ubnk3YlRVZEU0OFhOSE9XWHhWTEhudFNjQnJ4YnJiYTlsNkdm?=
 =?utf-8?B?NTNRTTVYVC9nOFhOQUlGUytYQU9uVVNrc2JVL3BKNnV1TmRXTjlYcGYvWVpP?=
 =?utf-8?B?UUtHZUYvaXBFeVAyTUFvVkprQytvYTV6S0dISnBFOUY3Q0R6NW5QY3c1ZHd3?=
 =?utf-8?B?eXdCbGptU1pObXlSMkdWTHNVeGxqV1NYZklhTFMxbVIzOVRBQkcwMmdCaWZR?=
 =?utf-8?B?dHZYQjBFemNrdkRiK3ZSM2tCdmgrNVBQUW16U2Y5WXg3L3ErQkJlblp6Nlhu?=
 =?utf-8?B?V1YxcDZFa1k3K2F2b2toekNLUnRDcjVKWjhnUmZLR0JzQ2grMUVKZXFHZ2kz?=
 =?utf-8?B?S3NhQUlkZEQ3a096d2NJYjJXWW0rMzhyckcvWTlqSUhNaFdyaU1vK2EyWW95?=
 =?utf-8?B?eVdEQTYzK0ZsZTJ4bVRHZjhvU0VUaDNkdGszVTlpeGkzMnp2RS9ULy9GN1o3?=
 =?utf-8?B?c3pFZ0dLZ0dUUUtGODJQT2pGZVBuWHFlbkJ1aloxRzh4QnM5VVFrTkJCcm1P?=
 =?utf-8?B?TElJOHRlaENvN0FCcTNEbVFHazRqaHQydmtpVi9tWit2U0x1MHFGVGhzb0VH?=
 =?utf-8?B?QndjMjJpYVNsN0JMcDRnckZPaDBRejVRYXVMbWJsQWYvV3oyN0ZLU25DUFJS?=
 =?utf-8?B?Qndkay9uMUp2ckVEOGo2NEM3dWo2VzJLTVJDQVRCSkxYdHZaL1ZEemFia1E4?=
 =?utf-8?B?b0FmWnN2Z0hzNWZWb1pucnNyMmVuS0tRaGNCY0xjMm0wQzhTbnl5L3JLaG1P?=
 =?utf-8?B?UFJ0RU9OZHhub3NxbGdna2hrWkJaMWN0UmhmUTU1VkplZm1peWVaSWVQVzdO?=
 =?utf-8?B?VzhlR1B0R04vaGtiK0hTUEgvZ2RzZzZ4a3ZYTFRoRWhZdkZlNGdrUnpNZHY0?=
 =?utf-8?B?cEIyV3dIWGtoN0o5RjBHUUlOaGFDTEd4RVpPQUJ0VWR3MHFQdGNkS01hTXR1?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db03913-5a9f-46a3-26b5-08dc3d2c9446
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:54:45.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYDNO1nkWoHuP4wHwR6OPcVmDvA09AmllfPLpRhSrxoJcO8R3c0y/MrqH5J4kmNRMy318pZRIU8A1rmeFkS56aFqVwjq4BeT06Oc12iDWpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com

On 3/5/24 00:36, Jakub Kicinski wrote:
> selftest harness uses various exit codes to signal test
> results. Avoid calling exit() directly, otherwise tests
> may get broken by harness refactoring (like the commit
> under Fixes). SKIP() will instruct the harness that the
> test shouldn't run, it used to not be the case, but that
> has been fixed. So just return, no need to exit.
> 
> Note that for hmm-tests this actually changes the result
> from pass to skip. Which seems fair, the test is skipped,
> after all.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk
> Fixes: a724707976b0 ("selftests: kselftest_harness: use KSFT_* exit codes")

I believe that the next patch of the linked series is a culprit,
but that does not mandate a next revision in my eyes

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This needs to go to net-next because that's where the breaking
> patch was (mis?)-applied.
> 
> CC: ivan.orlov0322@gmail.com
> CC: perex@perex.cz
> CC: tiwai@suse.com
> CC: broonie@kernel.org
> CC: shuah@kernel.org
> CC: jglisse@redhat.com
> CC: akpm@linux-foundation.org
> CC: keescook@chromium.org
> CC: linux-sound@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: linux-mm@kvack.org
> ---
>   tools/testing/selftests/alsa/test-pcmtest-driver.c | 4 ++--
>   tools/testing/selftests/mm/hmm-tests.c             | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> index a52ecd43dbe3..ca81afa4ee90 100644
> --- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
> +++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> @@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
>   	int err;
>   
>   	if (geteuid())
> -		SKIP(exit(-1), "This test needs root to run!");
> +		SKIP(return, "This test needs root to run!");
>   
>   	err = read_patterns();
>   	if (err)
> -		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
> +		SKIP(return, "Can't read patterns. Probably, module isn't loaded");
>   
>   	card_name = malloc(127);
>   	ASSERT_NE(card_name, NULL);
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 20294553a5dd..d2cfc9b494a0 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
>   
>   	self->fd = hmm_open(variant->device_number);
>   	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(return, "DEVICE_COHERENT not available");
>   	ASSERT_GE(self->fd, 0);
>   }
>   
> @@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
>   
>   	self->fd0 = hmm_open(variant->device_number0);
>   	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(return, "DEVICE_COHERENT not available");
>   	ASSERT_GE(self->fd0, 0);
>   	self->fd1 = hmm_open(variant->device_number1);
>   	ASSERT_GE(self->fd1, 0);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
- that's totally what mandates vfork() introduced in recent refactor

(Sorry for pointing the same in the Link:-ed thread, it was just
newer/higher in my email client)

