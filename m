Return-Path: <linux-kselftest+bounces-5381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84646861E9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB542896F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05CC149381;
	Fri, 23 Feb 2024 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8/R8exg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5B14532B;
	Fri, 23 Feb 2024 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723111; cv=fail; b=rQxqulCxk1ZIjyJKiC+BS//rkKfT+GRfFerArMVFISaZby5d+Xq2L5voLdxmtioU9H77EB+Lx83Z+q/8NmcbYcEb5Q5DZS7Qtr32RcdlLSUn6s5MvwvHsMA4STSFfBciLoUObq31+ypp0E/f/j4nkTHmYkHDmAWXCg8ZoRWxrrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723111; c=relaxed/simple;
	bh=IlVMFK+iiDDKyo2YwqFE4oBxmL228ZOlQ3g+6TGsv5E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m/wftdYexkzg1xFQY9/syNRlV21IbxHCCMra5j+ymIWKC+9rfaWmL9GoCXa7uwDpDPbDUDGf8jZIdRzozL480UQZma3xh4TvpFuiSqQAlouZKNAvribSKjVu36hm93Qef35ogJ3lViMzAkK7Oxrj39pDOTXOYggQXYA+EeS+TEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8/R8exg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708723109; x=1740259109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IlVMFK+iiDDKyo2YwqFE4oBxmL228ZOlQ3g+6TGsv5E=;
  b=Z8/R8exg6UUmCEkvm+YIZN+i54XI9l7uoK+o/30re5PHgbM43lnnOmuN
   euV7p4eZ5n8NzJDP1J4McuORmLeaEiCZEHTybLXwaVl56c/0ykh2SJ0WN
   KZTyJ+0hhOGg/tkSsE0o+xKpecB7qBmQg/N+XhMbZKzcAdkfBaBhTGHWf
   cBlcByA9YyS3kKbdeeZB5SLrcpdiWMvf1QdAXZIZjVb7YsZbu3QrgvhN7
   k6FNc1wtX7G3o2hoKoGoAWKyg/OWBLjQeBOl4LL8mFebdr/toO1MvM+hD
   agjOwfgcgk8R5eHuvU9SPI40yYmj3DhEc54VXm2uovIOvLJevAhryJKtC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14473582"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14473582"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10628445"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:18:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:18:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fyh077KRi4lTs3j4mfHp19np1/IbIORYLwQpdFjZWa8oMzYedLEiFlXUaE9jWR0trRSFjHU/Hw/d4ACqRHzMf5523Q9qXHyVkUGyrQK60JgokLtiKwD4wLyOT7FNIP+umL+9bT8l5jqKCcN32+8jLeIbZPrlIaERMQwlEwEJqEDWqsBcjbV52QEzpN221Q2xAqKkt6CaN7E/ahk6ay3HAWViZpC+GVkjtVQ6AWHBWRDdLLMn7XlEVjOzqNXkSRvawKyHdrr1A8vD3fC0Dna7i9+jRJeVyvdjDqYpvzN3GsprvVonYp1qX95MQSzKzbH7w4tBlLThcumXpas8lBxT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25PFu9XoEpZ7B+CBX5dVy522hKJLcM3TwS26PV1KnWc=;
 b=GY5CmwjftDy3ZbXXZDOlDdpMOGw35TcFuD71dcGHmTOADv9U0WA1pEzZop5rnDOXnDShWBJwNtmucQ3hdt19NQdi/pr3s2+4Q4F0AINEOxJEKc01NqcU6gDVrBgU0/tFnb6p2Bbqt7mTv+G4juD56UvBij1sSKtuqwOu0Cjm57d2n7leu+CzygG0dTz0Gi3+nxREa0Mt2g69ismY9orZ1GIx6uGTSz5Be5CMJq/STBnhVzJImyNc/GADEqhe+hbIfORgVM0kEXiX6K2FgOzFR58WPryYZV4VjJGiGRYIChkiN7D/HeP2PyUtZmERrOLpOmiP4GrXfk+Hj+zuwFLSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 21:18:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 21:18:24 +0000
Message-ID: <635699af-4abc-491e-9528-66ebfe9eaf6d@intel.com>
Date: Fri, 23 Feb 2024 13:18:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
 <e84995d79debfa8775a1535a82c6ca637f6891da.1708599491.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e84995d79debfa8775a1535a82c6ca637f6891da.1708599491.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eec9da-5849-4847-735d-08dc34b4f848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TA09VMAAZfMV/MStiXj1r7wABeFDCDNuFrv7Hkd+BUX+k4EaGjnXs0PhodFiZEvE6yiwfb44uumrMCtAvoS0YhokfPu41ACYxpqjmj70Bc2JgGnIzeclU1r428cZ+gs3mpYCwxCcuaZE0VBxBF3XUALLpNBMmfuQRBtDhz693ZyA6EH0p+z8UovLJYdi8y4bcn7AeElZwKsAH0xn613OUkPSUaNnSUoU2e6kweXGZCwCqg1gPvKJjmdeU/6nBowUId7A5b+2Ofnnt+rkyCwGEI7rZzDALQVqZ09X3INkfBWOdt+5tu4mcqCDAv2gG4VSFLFoxZ53hwViXHOEdToYyJbCkemrLUpUTuzC/c7YuuWvV1n8RArbU+E7LjfjqIDasSqEGz9R+uPYApCAeH++5HE98AwZFD/qr8pUUn+iod4Zexw3l7G1ZZjIUWzc6khIUs9jWHanUCocMy+dq8nZGOGeCM5WyCv8Qf85XrEVygaGsF3rMTzpeLHIjbENBjGwBlaiZxGvGnXNjea8SYYIwabncGX8WIbiaUYl/xi8X0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25ibVQvdkpTMGdDMkxTK1BSN2JtRFhjbi9wMWlxZmdkRVZ0NWJKSkk4R3pL?=
 =?utf-8?B?UkVQUHIwaWUwK2pqWVBZTWdiQlBLdFVPUi8xVEUvMUpsVXZ4VzJQdUVPRmtF?=
 =?utf-8?B?eDBmZzlJOXlzdVRKaFkrNlh3dFlZQTlScHh3YVR3N2trTkdyRm5yZjhvaVJJ?=
 =?utf-8?B?N0ZONjRkK0NHVEhHU3o4Z1FZOUl4WUJoYjZNTVlaK0w0UUY0b2FEVUd1Wlh4?=
 =?utf-8?B?N2g4dm92VmFmSkN6TXo1dlhnVmRMK0k5Y1Q3UC9UNThaYzhacHhheXRNYTQx?=
 =?utf-8?B?U2dVcVdjRnkyc1I1NWhZYitFWGhmMzhuNkgwMFd2NFJrcHVCYnVva1kyZC8y?=
 =?utf-8?B?ODRGKytITzZpdVFXVUZqRUdKS29mWnQxcGFRRlBiekRWVjZabmFWcU1kN2lP?=
 =?utf-8?B?R3BhMkd4bmNsRWd6aUxPL3Z3ZW9WYUxRY1Y4OHR2QTRydk5yVWRzeDluZlVB?=
 =?utf-8?B?RkJ5aFl4OUJKL3dqTlBuNnBjbGRyQkFuRnNRTWRlaEhBQmlwWHkyTnF5akFn?=
 =?utf-8?B?OHdJSlFUS2xvWE5teU1jc3d1MzIwOWFsQjgxZzl0Qi9PNHZMZXlMWXQwdDk4?=
 =?utf-8?B?UGREZUdscUNuakVEaFhuK2VzWWRQWUMrbHdVNS9WdFBDQnVTUGJIaFllWS9k?=
 =?utf-8?B?TWNiV0JhWEZGUC9XMGxjRmJPZnVuYWFoTDhXZGpqYytBQzFSaE9RNE0vMk1s?=
 =?utf-8?B?MW1MWHkxeVcreElURlBYVnhsdDZsRVh1dDIxcldOTERnbXNZYzR6bTdSRDFG?=
 =?utf-8?B?Ym9qZGM3NGRORnNNY3d3WHBOSkZIbm1VNzhtUUx1WjViMm5JRG13alh5bW5y?=
 =?utf-8?B?VnhZQmxvS2NqdHlGWG1jbCtxT2JXMnRnRVhyTnA3b2NsbU16RlVvaERpOSs1?=
 =?utf-8?B?N05iNm5ZNTJEVmM1d0EwczUxcjgyQlI1R1pvWW13VCs5RmlrMGNNbUQvUWRr?=
 =?utf-8?B?WXRHc0ZmeGRWNWFhS3pUWU9Pb2lpWnIvVnBYQ0pBbEJuNTFESk1wTXA2bm0x?=
 =?utf-8?B?Nmx0dy9kMkhxK3dldU4yRGExQlEwZWlZM1pZbk9YT2xHck13VXdsUUwvVlJk?=
 =?utf-8?B?TlNKUGxNbnpxZnFWY2IwaGNhN01aYjNQbGFJbUpLUmtZVXAwS2ovS3VsSkdM?=
 =?utf-8?B?eUIrblcyQTJrZXR1R0VWaHYrdncxb0lvcFhIdnovWGdGQVhkbXpzWmN4UUJD?=
 =?utf-8?B?eDZ4eFI3TWRNblRHSGFwUDZvRjZSTzNBN3pSU0t4WmNGMTh1RmtQV0FGbVZM?=
 =?utf-8?B?OWNuQXZheU5pdTVWbGFYVklQbytXNmpLYVNyQTMxbHJGWW81VmpHTDhQWlJz?=
 =?utf-8?B?YnpwOTRUZzE4Ymh0WUYvL1ZaNDVJN3hkWDZXQkdXZXVRRG9OU3psVGJLSVdu?=
 =?utf-8?B?aXBXY1pVVUV6R1dsRlpaL2FXMjVBNzl1RGp3VU9YditXUVpLenpqbDZvRTN3?=
 =?utf-8?B?elhrUktPRjJyektDa1pES1NVQzI1Z1RGTk9GOURxZHRiUjVGY2pHcUxpS1BO?=
 =?utf-8?B?Y09NRWdKM2VBcSt4eFdQYWVOMzRZSXFPRExTNVdhVDNCakw4QjQrQ2VETmow?=
 =?utf-8?B?VlpNRlBQTVNSYzhJdTdWQTdvVUxuRTZrYzh5RW5hdTc0cVkzQ3FqUWUzbmNP?=
 =?utf-8?B?SmZaTUlYTURLM1JPWStVSG1HVU5lcTNoRlY2NFRWNFhZVWZSczJFOEtzZzNw?=
 =?utf-8?B?VCt2dVJVSmQzY2FGcnkvT0xWRllyZ0tGaTdCY2FmMnNhSzBGY3JubUFYaHhB?=
 =?utf-8?B?MXZBVEVERE92YVZSY1JVMldneHR3Wlh5WjJtL1V5V0NYcG5MM29obGFFeVhj?=
 =?utf-8?B?VTNkckpDTFZSYWRVNVZROCtUTHY1cWExQ3l4eFFqTXRRZDhDZGF6dDduc1Ft?=
 =?utf-8?B?VjFVSis4bzhrTHlTcW1yaUVqaWxIbFJzUjd4djFtTW1SUTNrZEMvdWpCQXFy?=
 =?utf-8?B?T2REVXgrem1ud0hWQXlnckdUaUE5NzM0SjBXNE40aDhwWThVMzFpZm92UlJF?=
 =?utf-8?B?YTl5b0VsbEQrUjJSZlpRbzF0NWdyZmU0ZkF6UWplRlpobDYzb2haSy9WS1Bz?=
 =?utf-8?B?ZTNqL2thZFJoL3NvbmZwalZ2aTluaHR1ZUtCL3FyNk0zRGxJZEt6d1RmK0VB?=
 =?utf-8?B?UkZ5bFhkS2EyRnJYam1NZmdiRGZOdWNpVHphc0JlRFNHenYzV3hrdTA3VW1a?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eec9da-5849-4847-735d-08dc34b4f848
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:18:24.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11O2OyOdlPzA0nghnK9zRuchNSZ8h5VZ+xCqSnu5V5QtlJw32OsvGKM6FV2//wiaFJIWcG/Bwra5Y7mVhLuGf2L/qj01pMNtqqJXIeY41Mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/22/2024 4:07 AM, Maciej Wieczor-Retman wrote:
  	}
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 5a49f07a6c85..0134aa2f896a 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -62,6 +62,7 @@ struct imc_counter_config {
>  static char mbm_total_path[1024];
>  static int imcs;
>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> +static const struct resctrl_test *current_test;
>  
>  void membw_initialize_perf_event_attr(int i, int j)
>  {
> @@ -472,7 +473,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  	if (bm_pid)
>  		kill(bm_pid, SIGKILL);
>  	umount_resctrlfs();
> -	tests_cleanup();
> +	if (current_test->cleanup)
> +		current_test->cleanup();

Could you please make this more robust with a:

	if (current_test && current_test->cleanup)

>  	ksft_print_msg("Ending\n\n");
>  
>  	exit(EXIT_SUCCESS);
> @@ -482,13 +484,14 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>   * Register CTRL-C handler for parent, as it has to kill
>   * child process before exiting.
>   */
> -int signal_handler_register(void)
> +int signal_handler_register(const struct resctrl_test *test)
>  {
>  	struct sigaction sigact = {};
>  	int ret = 0;
>  
>  	bm_pid = 0;
>  
> +	current_test = test;
>  	sigact.sa_sigaction = ctrlc_handler;
>  	sigemptyset(&sigact.sa_mask);
>  	sigact.sa_flags = SA_SIGINFO;

Could you please reset the pointer in signal_handler_unregister()?

Reinette

