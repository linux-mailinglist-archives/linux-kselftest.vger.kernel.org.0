Return-Path: <linux-kselftest+bounces-6135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3396876E5B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 02:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A84282A70
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Mar 2024 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7EA29;
	Sat,  9 Mar 2024 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4IexVcJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F742FBF6;
	Sat,  9 Mar 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946398; cv=fail; b=feas4CN7hfrTiCdfBm6Q+H+ms0ZcRERbi05IW0g/qz3uL0OPJWzF5C4Ik58b+cPk79aBnK/BebXxog0v6vY5ke9+k2vb6k+ui/2PuRa4172X9l0btgy1yR3iGj4fNTZ8Ms0DRx6BU2NTFogPNg836vn4awWID3QHjDIiHSr7sHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946398; c=relaxed/simple;
	bh=OGcy+RW96Dkmf8oDP47H3fmNt2aVDI6mE5t74yUA5+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TP2BH6j5XTiXKFL7zabYmpKgvj8u6s5/7ORnWX9xqKdZscepi9GswU0UfMMgXMm14QqXQFr4fvrvvL32BZsVFDv0BWOK+FO+y8AeuDMmdMEc5AVu1xzvR9ob2TqN6pcUDkAs5PV05J7cW2nxsBZN+sC38vCt1MFsH9FqW/rbYlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4IexVcJ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709946396; x=1741482396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OGcy+RW96Dkmf8oDP47H3fmNt2aVDI6mE5t74yUA5+E=;
  b=F4IexVcJxqxLDIyaLdlN0j8Bnfnej6igWurnnOzWz4iyKLDQ305uc0fA
   LfUQZCtyZ+4DBTNsb9KgCJqjRYjjp5G2j2gMoXeumrlATWzd5GlsIGkMe
   Oa+fCuNDr3lF4KU5H6bZAMBNrpmBIy3+pwgpYzNX3jv5mqUz9OZ2LhhfE
   m1cllUWLlh4vCROdrVkOG/zI466rXEIPMTB4CGRc6zCWcbykWfwcv47CA
   3A7jWWBLlGmWOi8RtbgkztLxc2eb7IjJ9fHTOa76fPY19wQJHrXmjng53
   CcyhpcESDDx4fVCiKlWcJan1RxxYYBwiMkpbA0f9tTe+cB37IbilaqRD2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="15413050"
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="15413050"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 17:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,111,1708416000"; 
   d="scan'208";a="10706935"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 17:06:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 17:06:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 17:06:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 17:06:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0h4g/p46AAWa+Xsvr/NLXyGLBL0RA0ar/xk2YpOtDhv1y7lykR1syT8e9jTCGdGxHuZJnlZdXw/IwPMlCA2O+TKVsyLnSbXZILadIO9bxiRHsB038kJrvEQ5hOIVYAi2/IRm//bqRt5pf0E3gHnAZgub3kDR4sVTS9nw/uqx+dUh/AzpwI1AZAqqSfGrAyAt49yGgcMXHu1+BlQlf0+YSNaGQCaMzicXWMGD24q68ZEaOoMOI6LQjuCcvICxu78qpYsr6EvXiC794q6+LK2qGL89SMBt38WJmFQ4qE/ww0hsKrj+kOkydIpoUS4pLlLtoNJS/U3+NYz+oCL1/MofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNZt2gXjIeYaohiUB/7FGa5Thzii5hi0sFJ1stqP5bc=;
 b=JmPIRsyzok0d0M4HIDPm2+aNaIF2fCElGIK2ZnCrpYo+DELP6q73oIEM6f4wm1hldHmX76ceQ4GuVOQjWZYy00oZdmzzOkHlsh6TMQPwxocbjGNSasd1wd8cWAlRQiECiHvBt/K2JVkvMzQgHKMApCQr2qC5fAd920dppUK/Z8j7OEWczYkNnOybR2aDXk23a47wj86TW+VZmClUv5smRW6LQmSM1BiyKtAgTu1kHtNcIGO/RhCCpxJUJNnQ0BHRNerRVLaCjTRxGAbMHmf/UcfovXkg70lPdm9sRWQqk2JHejzcwVy8v+uldsbzMskb4yaNbavz+3ZY7Qd+2WGhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by CY5PR11MB6437.namprd11.prod.outlook.com (2603:10b6:930:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Sat, 9 Mar
 2024 01:06:32 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.009; Sat, 9 Mar 2024
 01:06:31 +0000
Message-ID: <dc8d122a-22b7-4d17-abd9-66262af0b058@intel.com>
Date: Fri, 8 Mar 2024 17:06:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Weihong Zhang <weihong.zhang@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>
CC: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240307183730.2858264-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|CY5PR11MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd94c70-f3c1-480b-709d-08dc3fd5285b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1Wpq8rKS6UcP+OKVn3Ta/6cUukzfaPF/e2C6CBw1W3ZH653xPXW8LlIe7K+0I+D+z6w2K9cfl/bFpC5rKNjjg00KXcJRirn54XVluBONtB3zH6Igh3Q5ja+FJp9ZQwTf5JS5llT0ldFQYgipywafdnxBaYVGOqrCaQuHnV68kdJDspkAmMgfgsBJWodnf1/0iapej/7OYlVleQJKWjAgPKGm6YCJihxGMdEhzq20vgX88QjFDSxkdUI2zqWYFeJUFKphw98tDCr9OpCkwzFH9/25emYy6V/b4Xjd9rT2UWXq6Pg/ECBgnjDjqkNSA2V5MaK/0IWmWtlCuNQcPkKrG60A3xkOiLHZn7njH8CwiX9+ojWZ2nzP2o+FLMJPoTLuzZsceboUtZOk4EdXr5OgglJVJUAFNjLr6MQl77y7+MvNePdpp/ws25c868TJr+Tn2ObvAR5/rbfvFw8METXdNx3ede7BS8PAmpgDNhPq4famtxutAjlgwPFxcPHXPc+15cOzOz61JwM0L8JbyOafeJDZ6hFf9D53b7EUQIe+EXCdmSC8q31nSvpT2S4CsbjNs/YBQpb02iI6ALiDaJK9b2SOIpdZmd1s7UIU1kxGLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJqNS90NW9NMW9BNmk0ZUM2OERPdldpYjRMUkhqNVhnSkpGSDZaTzI5VFp4?=
 =?utf-8?B?aDM1azM2ekVEdElqbFhrVys1dUtCZ2RhcjRNdWxWZWoxNnNSL2hZMGdRc3da?=
 =?utf-8?B?c2pScDhsbWZLSCtQQzNXandWMk9Da2psMldJNStJTHh5RDFzUkZNSUZob0Ji?=
 =?utf-8?B?bzllYklDcFNiS2dZalArSGJTSjFaZ2drbHBWZ0pvMWZKZzZUeUxzWkd4cWdh?=
 =?utf-8?B?RmQ1NXV5UUQ2Z3VsOUxGVEUzekVaSjVYaEs5Z2pwSmpTTGZJbUk1SmdaTE95?=
 =?utf-8?B?cDVaMlFaRDB6NFNiYTdBWllJVFdzRjFUZmRTTGdYbGZ3VTlLclQwQ0NxTzJS?=
 =?utf-8?B?NUZRMWszWUNvWlpXaUdGSytrVktTcW0weDBqb281LzVGYkxrU3NyazVmVlg3?=
 =?utf-8?B?RWFBdmRXV2I5N00vTVlOQTdCRENGZGlrc2kvM0FvMGxQeExnREQyaXNWRkFG?=
 =?utf-8?B?U0kwQk5uUG9BZVBIZWd4cS84Q3NEbEQ4VlN1R2ZMeEJGVjNXdzVkc3VQQkNm?=
 =?utf-8?B?cE91UE9qekx1czJWRXFleWJ2UkY2S0hYdUE4VHR4U0p2eEFGODltUGRQNitm?=
 =?utf-8?B?QU1YSjM5N2Y4M1grbHpZUlVTU09hM214dFpNdDZYcGZJWlRUNVVnNWszZ0g2?=
 =?utf-8?B?S0ZUUW5Ebm5WQ2RrbFRYaVJsMHNoTmpONEFuNnBOamY2MkFIK1JMY05WenlQ?=
 =?utf-8?B?SGlQRXFNeE5qa1VxSTZHN2s5cmxMWmJFVEE4ai82cmg3ejc0em15K1Q1WFZ5?=
 =?utf-8?B?N0FsNnBvTlYrak44c3Ntckk3eHI3TkxTellSbVMreVpzdXlwc3h4aysxbzNp?=
 =?utf-8?B?T2p1NnBYbS9Wa1VheWR5eVMwa25qSTJXcG1GcTVXVWNDZ0NEQ05zb0pMakVp?=
 =?utf-8?B?bWdKNlZzRlYyNURabnFoQXR4NE82OWN3d1laNjFReHVUU1JDaXk3OXhQMzN4?=
 =?utf-8?B?SDk1QjFHamtxMEcrOGZyUDd0b0lrNjVPTlJCVm9YVGZCbDU0ZnkydHlkT0pv?=
 =?utf-8?B?TWl4eVR1eVZPcTdYL2hKZjUrNDk3VG1nU2g0bXlVamhYQkloem5hZGJMaURq?=
 =?utf-8?B?bzdvanA3SFRhVWlDVXpyMXF1OFY3REt2SEFoVnhHRnl3YmNydUtTek5TdVBG?=
 =?utf-8?B?RnMvbUtBNjNQVVk3SVQ1SXRMSkN3cVovdkVIVWFibWZoWTFoMVdnc1ZyV3ps?=
 =?utf-8?B?RUpNNEJKOFVXbklRTGlXMlB5SExhQU55aHRHZEtwdWpWL0ZGakJPN1hUd0JX?=
 =?utf-8?B?Z3c1bVppSVIxcGtjN0x5VysvdFN3U3E2Mlh3azIydnFBNDVMSmUzbjlRb3Mr?=
 =?utf-8?B?L09nbzdoKzhzZXZNRCtuYkFKM3p6WWlidGJXSUp4cWtnSXQzbXg4elUwcTkv?=
 =?utf-8?B?T3Q2aHNHcXg4R0VHaWIvV0Y0MjduUlBuWXB5YUtKSGZkcVJNeGNYZ0lUZ05W?=
 =?utf-8?B?OFNjYk5PSmE5L0xJQ2lPRm4wQ3gyM0pZT2J2V0VPMDlkbW5LbmtlSWkzMXJF?=
 =?utf-8?B?S1FDZzdLYTQweFpEVkgybUM2Mko0Q2ZLTktOWDMyaWV0QXdxQm5MVFJqUTZ5?=
 =?utf-8?B?NzVlWTI2TUhUWHBEUklnQ280ODZFWDhXZ25ZYlJxdGZxZS8vT0t6aklSODlL?=
 =?utf-8?B?dWRWMVVFbkJoMk9wcmkzQlpiRDFtYUpteWY2VmtQeUJXME1LVlQ0SnJzVUI0?=
 =?utf-8?B?QmYrZW45Mmp5UUQveVZHTzU5N3VDbUZzSytOd3QwcGJ5TXgwOFFML3hLT25P?=
 =?utf-8?B?a1orbUtsdmFnWWtYOW82SEhOWFpOaEtmbW5lMHAwd1JyYVllTFN4N0NxOTQ2?=
 =?utf-8?B?VGNUYlBRaW0vSWhCYmJKamFwSDFNVk1ZaGovMWNBanlBNncrVVJQK09yNkZF?=
 =?utf-8?B?eXY2NGx3NkdXS3hqNTJDeGNrQnVDRncvZU5CSnlvaDRyWGx0TVQycGFyQ0Jk?=
 =?utf-8?B?b056c0NOL3F2SEFoN2xBQ3hwK1RVRTVRbllReUlNK3BmRlluc08vbUorOUMx?=
 =?utf-8?B?UjlnNVN4SVFLdzRhZkJZUHM2ZnBTMW5IZ2dtamVCQVZzN2c0UXEvdDhwYXMr?=
 =?utf-8?B?LzBEVVpSMms3UHRjVzlISmtXNXYzbFBlUGpWZFpiV3RFQmU4cXpTcGtHVFRt?=
 =?utf-8?B?VXZyQW9Fd0tCR1R2MGVMbUo5UXB1eW13SzFFOExac1hVdWhUOVRFdm1IYW5B?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd94c70-f3c1-480b-709d-08dc3fd5285b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 01:06:31.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx8R97P22EZIolsYkdDsSXhB3mumvX4EptutOdva9WZI1IJmKbAo1IMEK5iVeT1oPC/oPspaG0v/6jcHu2LEBDtA4qV4Bk8QObZ086YRvEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6437
X-OriginatorOrg: intel.com

On 3/7/2024 10:37 AM, Muhammad Usama Anjum wrote:
> 
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index d884fd69dd510..5d1ca0bbaaae7 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -103,9 +103,10 @@ static void clearhandler(int sig)
>   
>   #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
> -static inline void check_cpuid_xsave(void)
> +static inline int check_cpuid_xsave(void)
>   {
>   	uint32_t eax, ebx, ecx, edx;
> +	int ret = 0;
>   
>   	/*
>   	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> @@ -113,10 +114,16 @@ static inline void check_cpuid_xsave(void)
>   	 * XGETBV.
>   	 */
>   	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> -	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> -		fatal_error("cpuid: no CPU xsave support");
> -	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> -		fatal_error("cpuid: no OS xsave support");
> +	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK)) {
> +		ksft_print_msg("cpuid: no CPU xsave support\n");
> +		ret = -1;
> +	}
> +	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK)) {
> +		ksft_print_msg("cpuid: no OS xsave support\n");
> +		ret = -1;
> +	}
> +
> +	return ret;
>   }

I thought check_cpuid_xsave() can go away [1] by simplifying the 
availability check through arch_prctl():

+#define ARCH_GET_XCOMP_SUPP    0x1021
  #define ARCH_GET_XCOMP_PERM    0x1022
  #define ARCH_REQ_XCOMP_PERM    0x1023

@@ -928,8 +911,15 @@ static void test_ptrace(void)

  int main(void)
  {
-       /* Check hardware availability at first */
-       check_cpuid_xsave();
+       unsigned long features;
+       long rc;
+
+       rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+       if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+               ksft_print_msg("no AMX support\n");
+               return KSFT_SKIP;
+       }

> -static void check_cpuid_xtiledata(void)
> +static int check_cpuid_xtiledata(void)
>   {
>   	uint32_t eax, ebx, ecx, edx;
>   
> @@ -153,12 +160,16 @@ static void check_cpuid_xtiledata(void)
>   	 * eax: XTILEDATA state component size
>   	 * ebx: XTILEDATA state component offset in user buffer
>   	 */
> -	if (!eax || !ebx)
> -		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
> -				eax, ebx);
> +	if (!eax || !ebx) {
> +		ksft_print_msg("xstate cpuid: invalid tile data size/offset: %d/%d\n",
> +			       eax, ebx);
> +		return -1;
> +	}
>   
>   	xtiledata.size	      = eax;
>   	xtiledata.xbuf_offset = ebx;
> +
> +	return 0;
>   }

I don't think it is okay to silently skip the test here. If the feature 
is available, the tile data size and offset should not be zero.

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/327cde12-daea-84ba-4b24-64fe12e89dea@intel.com/

