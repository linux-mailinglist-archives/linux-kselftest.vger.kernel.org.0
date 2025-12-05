Return-Path: <linux-kselftest+bounces-47212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEACA9636
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 22:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF8DF308D5A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 21:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F018BBAE;
	Fri,  5 Dec 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwYxf8Ky"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8143B8D7E;
	Fri,  5 Dec 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764970248; cv=fail; b=UYlV2MoZ03MvC2+SqVbgxpyN2riJI0Jupks3ZNDsQB1FNsUJhIe5XZq+3mFvnLXIbpGbYxzfapWD8H5bRgOVUbbfA7w7pVp3FuaJoFe0hnZ6vsw9/yIIX3zuD+CVOqFCqWvd+wjengikMXLtuYSmoBeoGp1JOKX6dyb2pj6tHuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764970248; c=relaxed/simple;
	bh=iQZCtwyM/9+jKlgjbkhTwpQLvxaAg69Q/4MXMCo3IPs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tntSX4AHLpR8fyS+WnztH9wVqbi6tV5sxtw78ZWbwnP+Ug3rUY188sY2vS3D/+c1CEIIB73fFMG96Ls7kfIbOF6DkMdUnOz4zIqpSmR0883ywmIID5DvlVHNneICsG0u6WW+Wbaabd27WxOSScxxQjFdbhF9IZiwLsfv86sPj0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwYxf8Ky; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764970246; x=1796506246;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQZCtwyM/9+jKlgjbkhTwpQLvxaAg69Q/4MXMCo3IPs=;
  b=YwYxf8KygKPhWE08oyFY1mCt1m9VAGCTy3hoQ59vZlPogrwI4KgpaDmr
   tzX+ASg9/AotdqeUt6HE4pahjgr9gw9V0Tsqkkhv1n7bS69RUMbFGcXUH
   S0PbsuFaH6hkTnM5NyrxWjP6UnqBKgZmw9ECSOPrpZk7nDTzQ5ymTYkEQ
   vUh4L3A2Bkuy95fTEh2puo0icGHD60Nn1AiSsmvryE3NszCMzuwb3MjIZ
   Y5hsnnFBSbF8SQx+o7fbwpPolDPn2WRP3SYs39wVNBcbElPdnRYnGcv8V
   BCJMPb1r4EkzGUqJly4WuB5qfgvvfyUxYYqcQBMzT5dGjRezp0dt7Clp+
   Q==;
X-CSE-ConnectionGUID: 9AA9UpVyR+KH/J0M3WxTvQ==
X-CSE-MsgGUID: YChTWdEBSMaFRclCjo5qPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="69602393"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="69602393"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:30:45 -0800
X-CSE-ConnectionGUID: QBYnV0OdRySsII2nnNveMA==
X-CSE-MsgGUID: EM6tuAEuTWWPPCehp6SBhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195835277"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:30:45 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:30:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 13:30:29 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:30:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLyvk2G6AMCy8PhoJijnYEXGKljKq3h4bIgxMA6AjpfRzBKldly+4UbvRod4xrprInqHQUOU4FhEgbqYjv5TMTqiPnm0AY1lSSJZ8qXCvhpJx7WSKgzY88JoXDhDnnfGaycbXd1ygnsCtXodOtIl9Tc7/97xKG/iO4YwTlM3Ig1LobLbwpypMm2Mfi0Yq7ESo+9sj8hXFpPdMUTSlJIuf2Dh7wl1mANlcFAjeCqu9M6QEj5IGV/kwzjUH2QzRUtDdkMPayDxLvQMfxpQngLdTxMxKPI1ygF8lVQYxutGrJ+4E0O3Z81ZJx14RVJAY5KboqdJ0sGCbiJ4gaxJOwYFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmwGa6SRBAkgipidejU3iT6ntQ65ocQ77R/7rQGkF/M=;
 b=FNvHedKHj7hqrsxPsT7NWNFAgY1ca23Rmdn3bsMVWlYcCwuKb4PPJIGl0mch+zQmLAfEsPHW+dXQ+7Qmmvzpp1zTQqowth6KaDBFl0N1D6DpEQg8/r6KZKWXAKRVllte+5L0+LwwEnVGVqnV5ogDt7kqjaiMHNf5lvyMnZEAAd4JLFRWDCSU216X7JITbMVjat5fgalFGmHq/0/8m+g2H9x9CB2KXSkB1GDGvO/ejqZJx0N7yMY9Dfeg3MMEO0R4kJY4B28gbiNAkc3/ZZxlR5oCuXo2h1VCQyq/35LPG/Xq0znyxsgBtq/6giUBIFPz32OYoSrDcKC8R4c+w0U90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 21:30:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 21:30:24 +0000
Message-ID: <8ae52291-27e8-4614-9d27-b497ec22574d@intel.com>
Date: Fri, 5 Dec 2025 13:30:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/resctrl: Fix non-contiguous CBM check
 for Hygon
To: Fenghua Yu <fenghuay@nvidia.com>, Xiaochen Shen
	<shenxiaochen@open-hieco.net>, <tony.luck@intel.com>, <bp@alien8.de>,
	<shuah@kernel.org>, <skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-4-shenxiaochen@open-hieco.net>
 <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0027fb-e379-42c7-26d7-08de3445808d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFpVUlgvaGVKbWJ0RzkvQUJ6Q1h0cWdlSG5YRkE0N1FibVM1Mng0OXJ0YzZN?=
 =?utf-8?B?UU5oQkMxOXZ4a1BUSlNlYUIxUHFDamloZmFpeXlEb3hHR3k2NlEzb3hQTkhw?=
 =?utf-8?B?aStwUGIxZ08wUW94ODJYWEdLUHNKNXV0TkpjZTNDRjJ4U2Z5TldqYVdyWXZF?=
 =?utf-8?B?L1FYMThYVE9FdDF0TW5oWm9LL0QzR2V1VTUyb0ZSRERpYmloa2Q1YVhTQjJH?=
 =?utf-8?B?YWk2endFVnFKTUZwU1dnZ05tWWwyMEFZSDBaMTZYS1ozMlFBNENtVWc0bk5y?=
 =?utf-8?B?R2ZhS1Q2QUJZb0dJTzJsTTRHMUJPN2lYUGVKVVdMTHNTbjQ1TzdDV1pHOGVG?=
 =?utf-8?B?MC8yOU5zN3h5UDJGdWpESXRidDA2RVYwOC9oWUNBQ1FvSTQxQUtaQUU0QWlv?=
 =?utf-8?B?N3hRRGNoMWVsTTU5emE4dDRxU3ZtTjRDeFhpOUFLVzA5SGpqQ0xMN2ZFTXdl?=
 =?utf-8?B?K2IwQ0RWLzdIUFh0bS84VlNHb2toSWVia3l1dEFSTWt4YytqcjRobmFoR1p0?=
 =?utf-8?B?cHkwNWQxSS94QzNXNThIdFdpcEk0ZFVaR3c4aTdyS2dnc2RrVUpTT3p5L09k?=
 =?utf-8?B?OE1pNlJjTkZxNW9CZSs4OVIxeEFYWXkyeGUxVEM3c085VERCU3RlTDFlVGVw?=
 =?utf-8?B?cFQ5azVLRU5IbmpoY1JBVUxEU0RTYTg2SGVCMmd5RGl1WDNDMlIrdnJPWVVX?=
 =?utf-8?B?U1UwZDhLUk9uZ0pkOXB3TDZYc0pnYllXZWROWlRURDNNN1ZTWHdTcXFPb3N5?=
 =?utf-8?B?VnZ4YVBubENvMVNFdmJkNHI1L3UxSWt5MDF0elcvZEsvcWQvY0ZMejhyL0pC?=
 =?utf-8?B?VEtNVi93Q0xlVTdwalZQblM4V2xzNld4MU1SOEFya0RKQ200WWJZYWtReEZU?=
 =?utf-8?B?b0V1b2xGOFMvd2FEUlh2aUdocUt4U0t5dUFldHJ4ajZQU0J4cEpiZWRQZC9y?=
 =?utf-8?B?elh4eExNMlZEVHVDOHRwYm41OXhPekpyS1greUJhOXc3Q0IzM1cvNnNGZURv?=
 =?utf-8?B?QUlQcWFuLzkrQm5ZeXl3ampBakovWk9tdnVkQUpKb0Vwa3ZEdG10SUVpczQw?=
 =?utf-8?B?Z3BUeWtNYnk5VVAzalptdllUZ05URUgyN0hyb1JCM003TDlUSThHMXcvdWY1?=
 =?utf-8?B?SUR5WlQ0STYxWmFqbVZrcG5GeFdjQzNVdTgzb0VDQ2JScnl6MnFSQUpCbU00?=
 =?utf-8?B?WjJaeE5FdGxhTnkvNllNMTc5OG5LcmdMVDRRRFVBaTQ1alN4TDZWL1RYL2ti?=
 =?utf-8?B?UFRMZi8xVVpuaTlSUkdzWTNWd0JmQUVOQmVyVGsxNVIzMGkxcmd2bHNuY08x?=
 =?utf-8?B?ZFFMWHF6dWxzRDBXOVpCWDUrZjdINmVxRHZXTmtxK3BreS8vQXBCTVJqQis3?=
 =?utf-8?B?SlI5SndPbGtIVmxYcGlialZRU2tWVHpnbU5qMVlKTFAxMHdwQStpbzd6QWdi?=
 =?utf-8?B?UjRlV1QzaVg2eWV3UENyZzVVU0RPeHFqWU9CUzRRRUJ4RjNTQnFiWlFMNFNS?=
 =?utf-8?B?c0Y0M1Q1QkxrYWw0ZmxmSnBhalBKbTRpSGl3UGkzeStkblpjV1M5RzlGd3NJ?=
 =?utf-8?B?T0pEclY1UXUzQmJobEhaREVRVHNqdTlrNFN1eE9YdDROMjVZQlpzenJiS0Vz?=
 =?utf-8?B?RW9qazZ1a01ucjNxNG9aaFpTdDVzUGhNc1ZsU2FzN1RiQXdXdnRnbTNaZ3I4?=
 =?utf-8?B?TmpEKy9qT2gvVkdnekphZzZ0T1FNYWIwbkpkN0RVTVR1V1hKbUtYTDVXSTRo?=
 =?utf-8?B?blltUDN6bTlyNGNRb2Jia0xqSldUakhaRGdmVVdvQ1ZTTWs2VFN2STVVNVUr?=
 =?utf-8?B?Mjc0aHlUaUdaYXkvZk9PNDlzaXROT2kxOWY5ZFpJY3FDZWFUcGJGbVI3WGFD?=
 =?utf-8?B?cjJOWFpUY3JrbzViMHNMQ2pHeU96UVZITjduZGhzYm9qdWdjN2pnV3JBOU83?=
 =?utf-8?Q?v2nmyI9kZ6mynIWAB14F9kJWMsGbd/+6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1pcHBReVYzRVpOU2ZjeVRlak1nbklJclI0Ty9PcjZac3FzOW1ETUtqR1JG?=
 =?utf-8?B?NXRVZEFTYVp5QXh4QmxEazJQZiszVjJnQVZsZEdxR2lNbjRCWWMxT1pERU83?=
 =?utf-8?B?UGVONzkrZnJsVXpxN0pRaXZTY2JxWjZCRkVlZmkvSGhoQlhRMENqU2pDRjVz?=
 =?utf-8?B?UXZ5L3pjUnJiU0VBSmRzeXV4bThDb2kvenVMYnJvQVhaeGc4OExqS2xUZUJS?=
 =?utf-8?B?MnV6VWRXY2hwTDRzRGx4ZjBwNUxMTjg0ZC85VDE0NkFLZ25FcllVNXFITkFt?=
 =?utf-8?B?OXRNTlErYlorZ1Z3Y0ZVU0ZZOENhRzZHZVNlY3JoWnJxUXMvbUgzV3FzNW1R?=
 =?utf-8?B?R0NXODRubVc5TThRRC9GRTFlN3JxUU9xZkNvNDdvZTRTb3JDcUlpVlF1U0NJ?=
 =?utf-8?B?YzZpeU9rc0E2VjN5bm4za3NhZUtWaEhlUWQ2Si9FVXpmQTZkVER4WllHbUl2?=
 =?utf-8?B?Ynh3SVkxejFTT09td2U5T0tqUFllWFZscW1GeitKMVE5OFNvQ3VkNGNpdk1J?=
 =?utf-8?B?MEFoUFVvdXNaWDJJV2czNy9SdWtWNUpPdHNNc1Z3cFp2NWthb2IzVjcvMVA4?=
 =?utf-8?B?N1Z0STdBREVKQzhJUWhTWkNHMmVUOTlmUFBlZnFRV04weS91Vm02VWFSMVJI?=
 =?utf-8?B?U1Y3dzMwaWV1WU90a1lWbjJvaFg1VlgveGxIR04zRE4yZmRXdkllSE0rcW93?=
 =?utf-8?B?UFc5bG03K21DNittN2h0bDZ4VHpWdmhsbitPR3ZEUVB4UjdEK3lDTXg4WC9F?=
 =?utf-8?B?ZisyQlRmVGdkZGZsdFE0cW4xZ2lsRjhHRXFKanBJNDRkTkVjTXRzV0NoMXd2?=
 =?utf-8?B?MmNRTkxURkxZUTY3ZndZTTdRN2FEMGRndnZIRnhUaVpFZWNKbldla0pxbWN0?=
 =?utf-8?B?cGVmZUhWdDhYYWh0bDNwMWxUbzNDQ3k2bmVOUEJFYTNDOXhaVjJGWXZQWmxR?=
 =?utf-8?B?OGNhcnBpSnVIamNaSXB1Z3ZpK3gyWDJWNlpQMEhCUVRWNVNWWkJCTVU3V0Y3?=
 =?utf-8?B?L0VMM3FBMUNsZ0Q4OXJ3YkpBLy85cVFUdDIyWTdDWWNjTGFHQTNnMUZjenhS?=
 =?utf-8?B?S2NsOEM5MHovY3hTUi9xRzZUQWtDWjdwaUxUVHdqaUR0THU2QnZ0NVpXSGhj?=
 =?utf-8?B?MGswTUtYa3IzTTRPR3JVdWlSYktyUVhBS0RXM0c3U0UxQkYzQy94ZGFkQ1pG?=
 =?utf-8?B?Q0xsYWYvQytXSnIwamhCUTFSTk96RldUY1RJcm5qTWxYRFF1R2oyMmhvQTNq?=
 =?utf-8?B?QzIrNXcrY0lPTHB2QkVDdVQzaDREcmtLenJJcDEzRHM4aUZkVHA3VjJaazJH?=
 =?utf-8?B?eng4RGdUV09rVm9pQzRQejUvWkcxWFcxWHdKZlp1dU5ad3pPNHdVSlZBek52?=
 =?utf-8?B?Mi8xK1NFSk83ZkpRK3JKRm40L3dSazBJeGFjZGhrSlRha1V3cjJVbHlSUTM0?=
 =?utf-8?B?K2dPRjFuMHVSWW9JU0xESFlXMlNodDMvSnFHT2hrYk1teHNIcTUyQjhmZzUr?=
 =?utf-8?B?MnhzL1dZbzZjcFozVG8zN3BseDJpNVozWjE0dHg3QTdZVG1TZ3hVNzY2ci9w?=
 =?utf-8?B?UnpEZlJRM2FFaDM5UFZwTjdUL09hT25mU3VLZjBtMlQ3SmxOR2U5ekVvMTBN?=
 =?utf-8?B?VEJDQTNTY3hlZHhGcVpDeERqa1JQd2N0Z2Z0QU9hMVFCQk1zN210Q0RYTzVK?=
 =?utf-8?B?NU1CY3ZHYnRob3lBY2JscEpDZTBvMjl5amQ5NjZXTjZUc0Nnc1pQNnJTYVRi?=
 =?utf-8?B?YmNHUWp1dkhoRnFKT1NwbFNQM3RWR3pDbmhJb2ZuaG9LazNKK1psT29MOEkw?=
 =?utf-8?B?RGRnR3cyOFN6MkliRG5KWXJjVHlHOThRcmZZTHFodUZhTWErWWlJSFM1Umxw?=
 =?utf-8?B?Ymc3bkdDbi9hOVlBdjgvSUd2Nk5VK1FqL2Y5Q21DKzFJb05nV05JUTVWR0Nz?=
 =?utf-8?B?dVZiRmRHcXN6QnF2ekJNemtvc3J2TXhoOC9JM1FlaVZTTGcweDZlcmdDbWtF?=
 =?utf-8?B?M2l4WEh6QzJ3Q1FrUmRKRk5LUG1XOTM5bVVhVWpyRU5JRFg5WG1DNnZNVmpl?=
 =?utf-8?B?bHJlM0dVKzN2bGNOU2R0VnVyTWVFdDcwcEVpWUJGdDlCZDJ3YnpDSUdVdXZK?=
 =?utf-8?B?NG83UUY4SktDY0FDRlhYYmRQcUl5aTRGQ04zUGhIOE5ZbkMvUmdrcU5DQTY5?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0027fb-e379-42c7-26d7-08de3445808d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:30:24.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbHnpTRS3eveIW9lUg9+o8eiNozC/aHPNYFyUEL3RD+MxG+8T4UwuY55ODVCTp7tlvsCFlDsx8Fb2Rtc9HvPMxFmIB2N+crhB8ZfgpPS/jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com

Hi Fenghua,

On 12/5/25 11:39 AM, Fenghua Yu wrote:
> 
> 
> On 12/5/25 01:25, Xiaochen Shen wrote:
>> The resctrl selftest currently fails on Hygon CPUs that always supports
>> non-contiguous CBM, printing the error:
>>
>>    "# Hardware and kernel differ on non-contiguous CBM support!"
>>
>> This occurs because the arch_supports_noncont_cat() function lacks
>> vendor detection for Hygon CPUs, preventing proper identification of
>> their non-contiguous CBM capability.
>>
>> Fix this by adding Hygon vendor ID detection to
>> arch_supports_noncont_cat().
>>
>> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Maintainer note:
>> Even though this is a fix it is not a candidate for backport since it is
>> based on another patch series (x86/resctrl: Fix Platform QoS issues for
>> Hygon) which is in process of being added to resctrl.
>>
>>   tools/testing/selftests/resctrl/cat_test.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 94cfdba5308d..59a0f80fdc5a 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -290,8 +290,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>     static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   {
>> -    /* AMD always supports non-contiguous CBM. */
>> -    if (get_vendor() == ARCH_AMD)
>> +    /* AMD and Hygon always supports non-contiguous CBM. */
>> +    if (get_vendor() == ARCH_AMD || get_vendor() == ARCH_HYGON)
> 
> nit. Better to avoid call get_vendor() twice (or even more in the future)?

Are you perhaps referring to detect_vendor()? detect_vendor() does the actual digging to
determine the vendor ID and is indeed called just once by get_vendor(). In subsequent calls 
get_vendor() just returns the static ID.

Reinette

