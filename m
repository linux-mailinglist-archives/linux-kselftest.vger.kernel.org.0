Return-Path: <linux-kselftest+bounces-6077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95118875B2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 00:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33031282B06
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C48845038;
	Thu,  7 Mar 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHlFyH0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E471D698;
	Thu,  7 Mar 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854870; cv=fail; b=drvs/VDVLZSJIrsbLKL2f/N6kpxyi8BPq7A/z1d5YHbzqpeemFDYxG56r/Xv47z7U0rQh5yfwOBFqYqYrg8HJ75666p4u46DmwMEHkbMCCSfxPK2la46payDndXrL9BuWRPDDRcTkaMykcLRjE+LtkUHEoakJWXQ+nJkuNM9nDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854870; c=relaxed/simple;
	bh=0zRl3TRoClbZtTN9haZA9PVzKG2DJvTXJURAzv/YEEE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9M9cSE9d8i/1+wydTmvifc9ZVjueb7hVaAoM8FeQXu7CblCDQyZ4QHb9h16k+78ZFYRstf3fgQaLVxfJmG8QPO4wLfnOGXK8SRQJC4i4gRzoAxvAXmj7IDe0HX6XICyK0+nj51xhNkF1hsNXPkndPIpdieqgQWotba6tw0Wxas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHlFyH0f; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709854869; x=1741390869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0zRl3TRoClbZtTN9haZA9PVzKG2DJvTXJURAzv/YEEE=;
  b=hHlFyH0fzpLrIgsf4YOXL/Q0PpmIx9bg0FRbY02rmIBA0pGnYbVRvdhk
   DT+0MMj7geLLVpygYZjKGpLKfmDO7wyIpNi8z2z1TF+90GMY2w1gBXopx
   56GukIFx5EAFlQHYt8PQh85WlGwB45GcZK0GJc/DWgtVq9J54Jf0TCkxj
   igj01g03XJKiNenKPrj/dp5xJggXnu2nY2HpqmZxAVh+mW9eVcqlKRf5j
   tpo2xPRm/Nliml8ZpnM6jA1KZy5s7hc96hAzLqm0fl7fHFdNWc0Lrilda
   nI05wC4SuL9fUwZa6aHEpDDaZn8QmgOzBb7q0jEUTC/8E7pRnoJF9H234
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4681698"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4681698"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 15:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10834828"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 15:41:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 15:41:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 15:41:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 15:41:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:41:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRp746uLkI6/3Jt8G+Cnc8BdVvA7nPao5nyKkz3SL1QENQ9vUPJXRA/LnD3kZMXIBz8NkHzHg+oLjIyqvCOaxIKK8PcRO80cVmitvh6G74cQqP/VBuSBXmfbbfHA80WWNDCW9tgAMAB4f8gjBTbLupkILoutZXMIf6cO+YUH7dn88ucsB6g6PZF9x3XRq1SGCaghbMjNEjaCYvt7xpV4Ll0WRgyUviJeDNprxD6TAeM5lQPn4ll+oaQAgTLus+6INBVWcDrwuFKbQd+Asd/I/wAXXkph6mpo/mdDt3IYNzNUoyrdnASxod4o39WSivkcs617ICIGK2WbPJj0LJlB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ/KIfOnbd1KZwrlhMCO659dFD90lhW0TEWBwpeC8ks=;
 b=dRcoOs/KzG8sf9LjjsbCpalMtYuRsWCdCiW4rWEuk5A8dEm6j4/bxKJP9eFYV6/cCbEnA+osVIdeY/xfa/o76LnlCU3AOQvz7QwmRc5s/dFgnM76UpMxS4gOBFJXjAAl7Xmn5nrPhuMp1CzHFCZxqrggjco+4AIMqpbySk2OeHqFL41KQ0BrwUj4JebxhtLMEYft79bNwK+S+HeHhmy7rxo8VEMJQQZdryp+3gdPVV0GPusNtq14Qa51axOiZZMaglWHwxxoU6+0VZYI1WSJ3dWcPMiN9A+kkaWS7NLjSRGsiyk4SV3kwrnSYvaThfvYHZCLkgpMvuwCqkrjrPtREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8724.namprd11.prod.outlook.com (2603:10b6:408:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Thu, 7 Mar
 2024 23:41:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 23:41:03 +0000
Message-ID: <83b12a33-6841-40dd-a825-b4db7dbf22db@intel.com>
Date: Thu, 7 Mar 2024 15:41:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>
CC: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
 <ZepK4mtoV_J8-UbE@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZepK4mtoV_J8-UbE@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f85f3a5-af45-4024-e4ed-08dc3f000d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD92XIuN8ajXg3e64FNJPvCc/61lLjMg2x2djAG8vIbpsRshr/9saQ7edh13ezwpaPL2nr+lkU3e7/SpMJvrsQfzicfjrAbO032XLvH/l7Ul1XPGlKrAbXJDCGmfl6Qnaas7GbEA7/k48MtUuZ6i99P3VtVwZBT6Cj1eTqh63IPY6Si+pEnKSVl9IKq7GE30ktqobjLlwWzCRzsosgNAeLh1P50i4E8DsQBVn5wolB5ePYBsqdu5uIjZcgpKFYLrr1PSjjyTV4DWXz+EHneN3yqpyVIJKrmObWfVYrBr/GEdtGVqq8IdfdeB4Ii9RiZvmqBW2C+feKNvojSPHKn8CNrfoxkVS+BjF7aiMTrkRdAnZV/BEGYTZ17Tn9n2j/ENn2b+zRorGTnDxupQPSAXjt03sQ0dfHCgmlaGgyIfAwzrCXypc0tNQ71e0qFiCs/LjK/+O513utb3uQXNj7ls7tm34H8+Vd6d/96hs467i9FVxBjAbSuwcMijc7nprAAsoXHwMyI+OqBVDF73HJTZHi0pGgM+rHZkHAXsjxBFQEXulx7XhAKghbgYHHL/zKQahAdnqbbFwBe0CCpuS5yC5J8SnengXuA3Z+FCUzHlYl+qzqs40ioFa5z+xAzcKKj/ZLCZj9yipvzF09bhCQsp0Dee1nuStM1+HkC2B1YEz7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekwxOVg2UnVPQzVXVk9qdnpEMURsVEV1VUgxS2YvdGlPK1Z4YVFkV3NWUXUy?=
 =?utf-8?B?Z0pmT1duZ1MwOFRvQ1ZvamdLSTJ5OUNIL25xbkNWci90R24vWGw3ZlZOVjJG?=
 =?utf-8?B?eE01MnJYZUZGeEZnSFBqMUcrcmV3ZWNVRzBVdFplNGhIS2t5MWZFNWxYOHE4?=
 =?utf-8?B?Z2FmQmhRYnUzeWI5U0V5TWtmcE1Jbm1XeVdHTWtwWng5UnF2WUx2N1E4QVE1?=
 =?utf-8?B?ME1MZGVQQ2FvUTdLTDRUZkdZY0pYVG9QUmpxR1VGdklKQnRFM1JoMDhlTktY?=
 =?utf-8?B?VE44Y2lTdDVrTEk3WjFJTHppeG11VnNGZXd1S0pVNmVpOUY0TGVRT1dMd1dl?=
 =?utf-8?B?dVZGUVdMaUw4TmIyTk1uZ3c4NUZrMytuWUpMZXVocldDSlBGNVM3OVdYZDc5?=
 =?utf-8?B?VVZ0UXVwdkVnWjY5MmZteXZDeVppcWJrV2hpdzA0VDJOTTlEVWVpQmRqK1B5?=
 =?utf-8?B?bVVIZlU1RU1zMzdrQ3hpaG54di9vc2dwYTlxK0FMMGx5Q2JWZ3IxVlllcEx1?=
 =?utf-8?B?YkpUSkFyb0p4cG1OZXVDRldXSFdyNFl1STJwT0xTcHpnaFNkUXlmNHp2Vkp6?=
 =?utf-8?B?eTVMR1hSeVVoZnNxLzNWeGxYaXc5elREMytOTWVCQVUyOW1TTW1Od2hWU2FQ?=
 =?utf-8?B?aVNTM2ZpOE5oek9RVkdkVTc5anMrRkhWaGdEeCtDR2FhbU9jcDJ2eEMxTWd1?=
 =?utf-8?B?b2NJejRkUFY2azBzTWFSaXc3TXp6bS9jWERDZmpFYmUxUHliZ2ZSZzh2Ympk?=
 =?utf-8?B?WDdkZjgzTWsxRmw2c1JjZk1hRE9vSmNUajdlUzVsUTBXZDFoUmtKSEV4aHgz?=
 =?utf-8?B?cDNONURDYVJlZWowU2RGbzhTTXBWRG53YzdUNFdyWm1VSHdkUThNVkhrMFZY?=
 =?utf-8?B?ejlzQlFwc1lNQ1Z2aklsUVpFUUl1NE1jQUlBeFVZNVN1V2JYUVl2YjY3alkv?=
 =?utf-8?B?WjJ3eURvNmU0NkdmcjdnV3l6RUhZUktpbHd0Z2hVR2d3NkJXaTBHb1FLTldK?=
 =?utf-8?B?OU9KRW5lbGdmdCtoQWlON0dnbzNjSE9DSTZtQWtDbGR2ckF3N0EzZThNd2dO?=
 =?utf-8?B?NDVnNVZhdnRRbTJrNFpEUllMbERuK0lwQmJjd0hhT2R5d0R3dERXSm5oaFhs?=
 =?utf-8?B?eGdxOVo1ZDRqSEZwQ2liRC9tTlJrTTFZT2J6SHplQlBNbEtJNUMxMjJHZk81?=
 =?utf-8?B?aWJWbzF4eXIzZzFHT3ZsVVFEZk04SzB6NkJ6b3djZk4zSzFLWVd3K2lXWTBj?=
 =?utf-8?B?eWxFd3djL2M0SjZDMm5uVjZYMFByVTZMN0sxMzhiK1ltb01UcDdscHhqMjdF?=
 =?utf-8?B?Q3FsWU1LK2RNWElrWHoxSmU0RTVPTXNWd3Y4ek1LVDJUVUFCbG94OGcyMUdD?=
 =?utf-8?B?NExqd2k0S1cwNDY5UzFBQ0w3ZElNbUhNZ2wzeEdKLzR5RnNEZXl1bjRmTEpp?=
 =?utf-8?B?UG5DYkt0WUc4M2hMU0tCelhQWHo0SXc2aSt5cHBndFJvYzQ3Uk9HQkV4ZkdQ?=
 =?utf-8?B?TjlkMTArWWdpYzlsN016RW9ndmpXVEZtanhEWFdQSFBTSG1BdlZ2ekRSMGNU?=
 =?utf-8?B?SDlvM1JjSStkWDJpZWtoMVlXTFdUSnN4Q1ozWllvYmIzemN1TDVoNGhlaGNT?=
 =?utf-8?B?YnMzMUhJa2ltckpyY1k1eXJvVlMyNWtsOG5pbjQ0RXY0SVF5ZlYzN1dINUZh?=
 =?utf-8?B?MFJ5QVRIaVc1ZXozdDZQVlJsa01QUnZaNFNOaEhQWHRmSmZsc1c5eTVvQlhN?=
 =?utf-8?B?dzVPYkpZSkR3alM2ejkwR3VsNHZJa2d2aDFiMGxYNnZLNURsRnhHQ0FEb3Fs?=
 =?utf-8?B?Vk45UFZIaHUvcW9QbmVtR1BKQkJqNmJmMG9nR014MG0zVlRXWHVYSlgzWjdM?=
 =?utf-8?B?OWdnRFRUR3NEb2JWOHU2eEJxcnAxSkFnTE5kSTBod0ZOR2VPVWkzRTlsdko0?=
 =?utf-8?B?Ym5kSG5QNm5JdnoySlhuNnVhaGVoQmFORXUwOGRlWFlibmpyTVhML3VsaDR0?=
 =?utf-8?B?TnlYei9vejYwUDlmMmRiUWIzREpFOVk5ZTNBSG0zY3ArcWNMSXQ0ZDdHMFhw?=
 =?utf-8?B?anRYeGYrRXpKaGMwYktRS1JlSkZhMUNVSU9YQVp0di8zR1A4Q3FoZzEvU2Vy?=
 =?utf-8?B?SlhpMzkrUFg5SGtZMHkyTEY0QnVTMVBXcndEeHJVWENzbThKMkVZT2JPOTY0?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f85f3a5-af45-4024-e4ed-08dc3f000d05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 23:41:03.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u75YCsbduAABO63RnpBDYxT1IMTOPDJDUsLJ85Y/TP7d3sRiMERuRMaEBFfi4cGMpy+1SDbydKZ4Zj2YrCWmPbB6mrFs74mk6jxg19cb98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8724
X-OriginatorOrg: intel.com

Hi Tony,

On 3/7/2024 3:16 PM, Tony Luck wrote:
> On Thu, Mar 07, 2024 at 02:39:08PM -0800, Reinette Chatre wrote:
>> Thank you for the example. I find that significantly easier to
>> understand than a single number in a generic "nodes_per_l3_cache".
>> Especially with potential confusion surrounding inconsistent "nodes"
>> between allocation and monitoring. 
>>
>> How about domain_cpu_list and domain_cpu_map ?
> 
> Reinette,
> 
> Like this (my test system doesn't have SNC, so all domains are the same):
> 
> $ cd /sys/fs/resctrl/info/
> $ grep . */domain*
> L3/domain_cpu_list:0: 0-35,72-107
> L3/domain_cpu_list:1: 36-71,108-143
> L3/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> L3/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> L3_MON/domain_cpu_list:0: 0-35,72-107
> L3_MON/domain_cpu_list:1: 36-71,108-143
> L3_MON/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> L3_MON/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> MB/domain_cpu_list:0: 0-35,72-107
> MB/domain_cpu_list:1: 36-71,108-143
> MB/domain_cpu_map:0: 0000,00000fff,ffffff00,0000000f,ffffffff
> MB/domain_cpu_map:1: ffff,fffff000,000000ff,fffffff0,00000000
> 
> 
> The patch to do this is pretty straightforward.
> 

Thank you for looking into this. This looks like valuable information
for user space. Back to what started this discussion ... I expect user
space can compare CPUs associated with control and monitoring domains
to learn if SNC is enabled? (And now existence of domain_cpu_list and/or
domain_cpu_map can also be used to determine if kernel supports SNC).

Reinette

