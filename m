Return-Path: <linux-kselftest+bounces-9900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68C8C181F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592F91F21D28
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BED84E05;
	Thu,  9 May 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgcEnR1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032D770E0;
	Thu,  9 May 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289086; cv=fail; b=KuvmbD0KVKMc8N3l2kMPHBYyzZZ9Q7TXCKxpDOzfe+B9Thtzt8ErjqWLazHsSMNOy64X4a1oErUZJfPG0xtEPHQksX/FRfiwb63P5OJrLFwqZrZP7zwKss4W3gArxJGCchZbkSgzKAeX2Xv4bPyGpG+yRJs6htIiofoqKshO+Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289086; c=relaxed/simple;
	bh=qvmiDJr7+N6x/y9K1IG1V996hrbiNjaiKiOVUcZi384=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzcNIsZKnRNyS/f25u6ZTtQPSQ29+QbyIXsdPNGd7Qv08Zxg4z5C/3nuLT3DXg0+Rtf5JNYno4kMP0qB76AXSXN8VOj6iu6FiqlSFg2pQkH6poZ8R+IRF2pKs19AoGC//T3d7H+CWWZfZ9ovX4VcvB4IidF3dNjpLwXJcGsyGjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgcEnR1u; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289086; x=1746825086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qvmiDJr7+N6x/y9K1IG1V996hrbiNjaiKiOVUcZi384=;
  b=CgcEnR1uXUkvpCsbSL5BZLpb6AinbbNn1YP1/2tBIdn/T78Sy0tlfSuv
   mkVdiLnxdcedbXeP5BGVw+NWF3H7VEHEc0rByT5giCAGpqY/9Ab5sIz5P
   eeE+tocRbvWFV8wIHf6oybbKCnZSSwi4JjGSQ8s6UehlaiBzFnQ4QdWyc
   VYXzHJfpcAkS9E7sIIVTMp/+OCmj5hVM0ZYulkReuZirbrr8dwuQxeLoW
   g6GEN/xEd2CVwuc7Qi92mNXGVTFflyouX4tj7YYr37QIhXbJZw/C87E9C
   Jo4Qm0+SXCerLLjsLF3YQ1hn3s0F+JQap/I/ztniXhvp8oSrBnZy85tiq
   Q==;
X-CSE-ConnectionGUID: tIF/z17tQL6+RWJ4w2/KPg==
X-CSE-MsgGUID: pvgskuaOTK+g/mS4sd8wGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11084054"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11084054"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:11:25 -0700
X-CSE-ConnectionGUID: KrLCG1PFSGKOjdasIaztAw==
X-CSE-MsgGUID: ulS0sqgzQ32K176C/XKnNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29479369"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:11:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:11:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:11:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVSVSALsnn4S+lYiheAU56dNgozdJwi7hOojXpp2aH8GF4XjC6pZSRgkkWyMboGS5XxHO7zgt+V34K9cNx3JOJIb1Xja49l29ofI1KrPCbTgV0NaaAfHhtZbtPqqJp+poPMVnK7/MGgBX0tTJ+Q23aWRRxxVD/5AyLLDGSdaqfwQuw1GoJo0Xelg59hRwyYnwoSuIBFcnwPWnghCBSOo5SQk4m10Bp5aPD+/3TLmUNswBfnVL5oVrhSslkTpQai/ZtVi0odIX35ceUjEIgZNNOUilUpv8Bv4IAnN7uKqgrr4rAVuGSLt3WNWoHhrjXAi6AtyQNB2qkXWHXWkPrQ/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0q9FlO5hERJAxmA0Cv+h7cHb4SBMQ3CcV3jSHKjDz4=;
 b=MNmhwlCj13iO5/mYGdV0C/OWrnCVIGST+JOI9iluz5uFJ9RZc6Yn+bKrGMsjrYU70mAr52yc7gAPihsDBcv6be9D2xdrLBNl2tvA3M5Dk5fV71u2HTkafz4Pa/zAYP/911ZHziPRGAQ8iDI9IEIFho/JyN1b8IemMreZQHONutob1rVH9Cecf298vblKzGa8qFTcmjlEbMtK0j2KHvkdewUn9k0xhHILYfAFvxu7uQq7fCWf/IgG6xCGHILetYtbsq6/bb1xtMZrFX1KjXykaU7cSiJ+g5DIooeG1UCMIR+YplN+rqf1/b78GOSklByQRvoZfmz7N2hCq/Y/2mNAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 21:11:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:11:12 +0000
Message-ID: <eb80df2b-d6ba-4171-ad05-c76c218b0e3a@intel.com>
Date: Thu, 9 May 2024 14:11:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] selftests/resctrl: Pass sysfs controller name of
 the vendor
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <406d1fbe6b480fbe13fd0b8c432cdc517a7bd8c1.1714073751.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <406d1fbe6b480fbe13fd0b8c432cdc517a7bd8c1.1714073751.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa337ca-5418-491d-2a91-08dc706c8e05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlU3QzBvR1l5cFlEUEJQQk1jclc3ZnNFbnZJUm11MTJOakVHcXZoRldmMVNJ?=
 =?utf-8?B?bCt6dEZjQ2o5bmJBSjRNMXRGZ3Zhc1lzcU5vcWxtZ1RGMmR4KzJxb01kSHMz?=
 =?utf-8?B?ZTFqR0tMRWRZVFFSU0N2ZnpIcDl0aTlxZ1FycktmcmpqcGNoRW45ZUdrbFVm?=
 =?utf-8?B?bS9TTGdFYXFFVUk1eExMU0J1QWtiR216TjE2L1RTMXU1NVM4eVNPT25HdG9G?=
 =?utf-8?B?em1BbzEvZGpOc0htMmVFamhMNm1IMDVBaWsvVjdwZVBxMFl1ZTNIeUJTRUlT?=
 =?utf-8?B?ZmkzNjN0MFNJa1lSRXFiV3ZPdVVYclNQcy9xdFNadVVGMHpubmV1TzJMREIz?=
 =?utf-8?B?aWdZQXYrRnp1bWlRbzlUVXBaMU5JRkM0eGZKMWNUK3kxT2NyaHJtOGFjNHZB?=
 =?utf-8?B?QkVQaFhUMzBBeXFjcVV5TkNoVitOa1BpdUN1d0hMWkdrRjg2QmtDdlpqTXlr?=
 =?utf-8?B?TkVGZnIwWHlBbndLNWtQa2pnVVhueThza0puSi84S0c4cG9wMWRVdk5ZZzFQ?=
 =?utf-8?B?OWlhN0NKVGhmTXF4dEV1NHR6MEtiR2QvTEdZQVdFYnRmWXZWUDZsQmpIRTRD?=
 =?utf-8?B?dzZOWW1kZXJKSkp4YVM0N0dsdktrYW9PNURDWkUyeHlYZlpSMUZvTnErcnZi?=
 =?utf-8?B?NDRIZWs0bkdjVmE1YlBsU3VqaG0zMGZwV3lKOHd1MzNONVFmdWFRSkZmZEFR?=
 =?utf-8?B?TmVrck1WeENVbklHN09kcE1SS1NNeEtjaVRaM1hsc205a0w4ODJpQ0xEdTE3?=
 =?utf-8?B?THpNUmZCeTFEdUdocGZiMW55M0dnNzgxa3RwZUFFZGxVM0JiVkxVMW1LZFBq?=
 =?utf-8?B?VkRHMDg3WlhyZ2xoVDNUeHhFTk94ZXRjMWsxZ2RGbStGcW9mVDNqTG9Oc0VM?=
 =?utf-8?B?TVFmRXRYcmpVRnA3L0RsbGFpemxqU1pDc2ppMXFxdlNRQUdzYnBHSitqRzNX?=
 =?utf-8?B?bnFFeHI5YUd5d09QMGxlaTNIS0hBM0t5MVNzY2hKdkRiZTlUS0JtcDZabEtT?=
 =?utf-8?B?U3A3L1BteVZHSWxhMjNxWkkwMFcwdEI1VlgxYk95MDVwazNReEFlYlpZb0Z2?=
 =?utf-8?B?N0NOdktxSnJIQXY0cTMxVStBb2gxYVgwaE5kdVRxUXVjLzFWd3VjWS8xQ3VG?=
 =?utf-8?B?aXFFd0dsd0NUM1g5SzFnRUF5TWFyMXpZK0ZDRVVVUUhnSTRGM1VkaXFxREl4?=
 =?utf-8?B?V3UwWG9XWGQ5VXVPSUowYkgrLzgyR3FEM1VvOXlRa2xmZnV3OUxGd24rV0xa?=
 =?utf-8?B?UkNnODlwdm5MZklaNm1GN3F5cXkvNm9IekRTTzM3OUQ1bVJOUHJvekZCR1pF?=
 =?utf-8?B?TExiS3ptY2kvZS9KcWoxYjdKdUVIVzlCTFlCM1l2Z2ltMHUzdkRsNk9uNHJI?=
 =?utf-8?B?dVZYRk5FSE9nUVhDekx4VHNteVRkV0ZJcUkram9KSHhWUlpyM1JzbFRBMUlM?=
 =?utf-8?B?bXBDZzcxZUx2K3A3YjNsbVdzY2ZVY0pBNXNDNm9uc1JRbmhlN1hKUERTOTQ5?=
 =?utf-8?B?L0lIMG5vNWRJUTEvUGN1a3dpNVZhbkhyRzFKNXNmak52MUsvTHMwdzBlTTI1?=
 =?utf-8?B?OGpiYlZYMW5UbWRGblNwK1ltYktrRng1eVJpaDNtN2RTMGVxOGhvWnVKa2Y0?=
 =?utf-8?B?c05yU25yaTBSSWlOZHZDNjh4cTBRVzcvM0dBaUgxNTdjSFB4Y1pEWGtSUEJK?=
 =?utf-8?B?SGVVM0lpUzV6aVZIU0ZCSkdISTg1b1RoY0hSanR4cHlld2E3ci9kTjJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3E4QVRIRlEzdDJodVdNWVBML0JROHFyQ3M1ak5ycEVkY2lvUVdYN3FxTXdL?=
 =?utf-8?B?RVdHK3pYZUZlSU4wakFqdUQxaFNuU3Y3a3lPZzF4UkZHWjgrckJ1YVl0R3Yz?=
 =?utf-8?B?QjBja2ZmdkE2MmJncE1LVEc2NHlnQnIyYk54SWZjN2gvWng3S0p5NDVxQ2VM?=
 =?utf-8?B?blpCdmNHR2p2VGZNdTlFWFdJUkVTWU1Qc3FoamVCTGU2aTFaMng1RWRzL3RP?=
 =?utf-8?B?REQwN1dpLzlZTXB6NlY5WHhHMmFlamlJTDE4NFRWdGVnazNxUlN3NVVqUHo1?=
 =?utf-8?B?MDIrZjZEajVUTy90YVFFcnJSeGJFOG5iOGxWQVJ2NnZDdWVRRUg3YllobDlK?=
 =?utf-8?B?Y2prVVk4cmZiQ0o0dW1abGI3ZmpkazVQbm5hZVFtdHhsWlhUblM0TUxNeEJF?=
 =?utf-8?B?dUNVbzltMDk1T0V1SVBqSXNUL0krdU5heEZ6R3paTWRSUDhmWGdhSXMyTEVV?=
 =?utf-8?B?ZDZZK3ZzV0hSWkxabkZPaEJPbWoyNTI2VTlNVk9uWmtka2huYWpLRytUcStQ?=
 =?utf-8?B?TzhXZkgvcEo5amUyc09OaURhWndPNkRDRldyMUJNRU9TT0VsRGhnTS94WHZ1?=
 =?utf-8?B?bEtCNlRQWmNtcjNzaXZEMnlOV1JPdGZvcFVpMFlGckZjNXNXVmg3Q2hZOFJW?=
 =?utf-8?B?WUhhaUlkM0x1Qjhhd1JZWGVqRmVOQVF1c3IxMFhEOXFwMDJINmZUaUpZVXZm?=
 =?utf-8?B?OE9QVis0a0ZVclJOdVBhdzN0SHRkV2JqNUdYak9naUU0NlVkNlBoZkppUTl5?=
 =?utf-8?B?T240RXBnZzc5dTNuYnZSeFJNQkJUbXFKUlh3RnFSNzI2ZU5sVjUwaVZWV2dt?=
 =?utf-8?B?Tm9DY1RBQXpIMSs2Tkt1cGlwb0FVenJXK1A1ZnZMZHFCcjBFZ2VGMVptVk5N?=
 =?utf-8?B?RHYwREVGNUw5SGxxdkNpZ0ozZkhlK1NaaG91Y1o1MkJ3RlU2bFFuT1N1dEtQ?=
 =?utf-8?B?eUtEc3o4MG1HQWROalpzWC9XblU1Um9FMTlSek1uTFl4S1ZMNEZOSGo1WHBt?=
 =?utf-8?B?bFVpWFUzVVZJbTlselZQMGpSNTE2ZXBNYTVRdzk0VFlqOVpCRmZIV2FDallh?=
 =?utf-8?B?eEpnM0dTKzE5RXhuQ2xRTUVrR0E0d1U1NkZrVlFsZnlBRENYc1R1ZEVROHE2?=
 =?utf-8?B?UkJubnlob1dzTVh3d2Y1b2szbVhJM3BncDdxdWJMeE9ZYU12K0xSSkxOZlR0?=
 =?utf-8?B?ZVJxL0lzV0ttNTYrcFJ0Vk5UNjRVdUhSWU04MWZkMEJaeWNrWGNFVGx4a0M4?=
 =?utf-8?B?STVZYjJmTkMyN2IyR2FwYWJMa0k5dnhLWGVtL2paeG15OVBPSzZGZE5oK0FB?=
 =?utf-8?B?VWlDaTF3bkM5d1dQQnVYWEFjcXBOQ0xyWmlqUG5SN1N2SHRmb3BZTlhrK0Mz?=
 =?utf-8?B?ckgyVUpnMUdzUmR0ajIzZytRbENpelpNZzJvV3lrenFkQVRLZjJMbWdIWGJy?=
 =?utf-8?B?Wk1QWDNuWGJxOVFsSHRtclNsUmdDL28yUzMxWUpla29yZVJSQUN6UUxvMzB4?=
 =?utf-8?B?RWtoY01ZWmFiemRaUHhsZHFaM3ROQWs0dVI2REkvRjBIbTQzdzN5Ukh4MDNv?=
 =?utf-8?B?eitURUQrOUJEc3BGRUgwTG1oUGJNNXJYRkZPbmwzR0gvakcvNFZlZEpaS1A5?=
 =?utf-8?B?Z0ZScFZ1YVhtZFhaVFdhNmYvTXhFN1BjMG1Ic3liLzVVZUx5c0M4cHBUd2Z0?=
 =?utf-8?B?V3FDck5pWlF2cFdqZzRLY2FvQ1NCNkk2SjAwSzVSTFBneHVhU2kxMXhZT0NV?=
 =?utf-8?B?Uk5GMmdzSGI5NERUM2RsZzAvRWxRS0ovb1dqdUlhNUJhM0l0L0ptcnNDcUwy?=
 =?utf-8?B?R3JUclVxTW81MzcrdDdwaWJkd1d4L05SZFVxbmxPK1VlRlhMMXM5SkYyc0hJ?=
 =?utf-8?B?MVZ2R3dJWUhtWjNxUXQwRy8vZCtSM3JMd2U0MkY3REo4Q00zWmhoN0lMdFFD?=
 =?utf-8?B?RHRpeWFIalJkTnFOMTF1aGRkeFBJc1BnMnk5VE5HNmxCMjNmT2pqRHdaWElm?=
 =?utf-8?B?eDVSQzhBMTNpMHA5ZExKdEVObWFpUzU3d1RhOXBUTSt5SWsvQXRvRk8wZVc3?=
 =?utf-8?B?ZW9xdTJXMVpTWUxxUHZVNCttV2JiUkdqQk5yUGsra1FPVE9RTXg1TnJnYjBW?=
 =?utf-8?B?V09ZcU1wSnZNeFQwUGQ4RVIza1duOGY1L1FWdjlJVmJ2b2ZuSUtBMWVyWGNY?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa337ca-5418-491d-2a91-08dc706c8e05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:11:12.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U+zznIjeei+bIKhc8ynnbDJg4g01RyyFc1Y0w+AejQxRivsx6fEps2SMwvqGxgYu/aYcVKWqeliA4qqx3Tn4UP1+h8RyInNzM+CoPJEEZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com

Hi Babu,

On 4/25/2024 1:17 PM, Babu Moger wrote:
> Detect the vendor and pass the sysfs name for the vendor for searching
> the controller information.

Could you please write a proper changelog?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index a30cfcff605f..e3b09128ec3d 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -224,14 +224,24 @@ static int num_of_mem_controllers(void)
>  {
>  	char imc_dir[512], *temp;
>  	unsigned int count = 0;
> +	int ret, vendor, size;
>  	struct dirent *ep;
> -	int ret;
> +	char *sysfs_name;
>  	DIR *dp;
>  
> +	vendor = get_vendor();
> +	if (vendor == ARCH_INTEL) {
> +		sysfs_name = UNCORE_IMC;
> +		size = sizeof(UNCORE_IMC);

Why is separate size needed? Can strlen() just be used when needed?

> +	} else {
> +		perror("Unsupported Vendor!\n");

ksft_perror()?

In the message, "Vendor" need not start with capital. It may also
help to print the vendor value in this unlikely case.

> +		return -1;
> +	}
> +
>  	dp = opendir(DYN_PMU_PATH);
>  	if (dp) {
>  		while ((ep = readdir(dp))) {
> -			temp = strstr(ep->d_name, UNCORE_IMC);
> +			temp = strstr(ep->d_name, sysfs_name);
>  			if (!temp)
>  				continue;
>  
> @@ -242,7 +252,7 @@ static int num_of_mem_controllers(void)
>  			 * well and hence the last underscore character in
>  			 * uncore_imc'_' need not be counted.
>  			 */
> -			temp = temp + sizeof(UNCORE_IMC);
> +			temp = temp + size;

strlen()? (Keeping in mind the adjustment for the "_" character).

>  
>  			/*
>  			 * Some directories under "DYN_PMU_PATH" could have

Reinette

