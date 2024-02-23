Return-Path: <linux-kselftest+bounces-5382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1185861EA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479B5B22A67
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF21149386;
	Fri, 23 Feb 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwlpjej0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668E149382;
	Fri, 23 Feb 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723124; cv=fail; b=OlaRiQzu1FrxPCO7BcD0pGHiigLXFFcHchi6suHQPOLQ9yCh1GtD62bMHXeP1MgmMh6oLh23Ns3DLVFPcXP1s1JhC0o8q3RVlhA7yPtn/Jq6HuLLzBRoXwR0z5qwzBVAgG3pJPODh/9wPpBJtD19OoAQSJxBySrytcTweJZ2ERY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723124; c=relaxed/simple;
	bh=4C6MUqLyTz0bxw46TQFerq8o4MtHBQVdeF/UUrrDnK0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQ2gHTCs8upBCdC8X2b+Hepn/FaHA4cz6PNPU/W1q9QoMmgR0kkf+y82VrlxaTly3OQJs6pM4yD64OhtKfunU3Sskx4m6DwNqIuXcDoblleYpTuztETunB0G+ITIbXra+xSjsN+hjcuQQRatyqcp3Q6ZlDlhJNSwDbn39rjgSdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwlpjej0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708723120; x=1740259120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4C6MUqLyTz0bxw46TQFerq8o4MtHBQVdeF/UUrrDnK0=;
  b=jwlpjej0wAW9H5wmuFUGxAdSOdyNuUmTth7OrmrWmv1RLuzn2i8qTWss
   iY6rZqaagII++qsqE6QNHFbcf0WJHIPq+2RxqzQK+LyU2c+Fu8b8OBiBS
   JmwRq90Gng+2AYSs2Ck3Ov4qqSyOc0gVAb1UbLYatqhPzsD3ashy96iVg
   sXUFXFoFZp9gye/8LhHeiKuENVMx4DgsKE1zK5UFJd63nbuzsxfEhD++1
   8OgBqmaf51pGfIiVM2Mbyz5ZlWzxVE0IK+wAykcMqKlk6B5lxmbqeLOMA
   Q2JIpcMGMXgocCsSiNFZu9ZcnQX4J5ZtN+qPzcvQW3BCR9jWWr+poQCSj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14473598"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14473598"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10628480"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 13:18:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 13:18:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 13:18:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4HSrJGuOUnF5EgXN6PNXTtzTZSthz7aE+hvrCduyGFvWzFCjDu4N1yBSJACbrlo99Z9Zs7bX/qEMy60iu9kYeM68uA+hHIV5HP9IOcGhF0GkU/rJDC+r52iXPbvfEV4iWNxPzO5qP1UyHeI5U6Jcksbc4wf7LVbYGKV69fOxktvParvirXIWLhQJiOvBNJ6/kF7xBzT5x83qW08o910Qb98gPJesJoNGZYTINuqIGc45sMy8UVrmJa84RwpmOmAQpeAmxd7BJdFFWo05DZdNgmFuA6vqkfznBf++WoRCeMWd4vZ6i/GMYPGJQnu+ih+0eykad4HrhrIseDmXEFxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykEiLN2ojtFjwy5WWeCHoCsrWTf7g01guZtLnedtcPA=;
 b=JQytbcFY35fGChhGT07S7L7EiyH0xhG7OZfprA0nIIVFXsIOR3qYCK1ORoCMIPNcZMNn8M0YWueMnVzSxzAVYBqqgIK9XSKFtVi/JrqAxjIi8w7h4su9OvCcHUxwoMfWApc5lqlO/HEXV056hwHMQz3QdF/9bG4PAH0FMGYGSVdcV2zY4hfr61Dtp+ToGMh4BClqZgH/kJYRDu6k5Ou8ht4XVLwqMSvbOQ2hY5snpfbtmE2QiLmxAiDMZQ4oT5pQZ3LpnfTNqd5SS2C7C8Osd+SUSFoNMnhHKCgdtOQv5jMp0zPQ0fWIuVxXgMuPgoU3fLqSN2KiejZv0dl4cBkQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Fri, 23 Feb
 2024 21:18:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 21:18:33 +0000
Message-ID: <8caed6ce-808a-4d25-823a-fc4d6b56268d@intel.com>
Date: Fri, 23 Feb 2024 13:18:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/resctrl: Move cleanups out of individual
 tests
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
 <bc4a4fec20420fb792612be024473f31f40d7bca.1708599491.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bc4a4fec20420fb792612be024473f31f40d7bca.1708599491.git.maciej.wieczor-retman@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: bde7b39a-b9e1-48fb-3d89-08dc34b4fd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fo6yCs2YGtpaFMst1WTo9Q2pkqKyAJEEdynKFfgBFaZrPUO+7wtUUyTxTc5c9otNSlbvMByVK5/UrR8Kwwcmqf2lycmAetlYe6ijNmYap9bXkfHTVw4pWhpzSOYpusiZPknapBnc8huA+8gqwPZfAQIkgwhKwMdN99Mvbu9RMv+KdzOacjNGmhew+VNCo7LOwleuFDsvjX8y/7QwOatPI5Y+kcDsoF5Bll7FtX6zD5BN89J3CEw57iW4rTMx17ghV059NSHRDnudJN9aLugQqwMUZodRxtL61fv48MO+FjflN8jcq3KkNK5uamr5NCBDZLhjVXNFY1tqbeMA9X1OglZMkU8/93+/1uiDpCXrgtUC2VPpnZ2Alttno2cy65wECkxusU7rcIQsl92gDf1i+OKsZUfaubEhf6SDEpdTvGSO9Ywi7cCAn0aCfInOjv5YcA3SOY5IrwhKR/I+h7gTXlx7lnqdRTUIydJGU3IJU8FI4fR4MQEtV20g57a2vINyU0eJNZsdI0GEMX1wJViZEtnfjlEp5TP8HEN5HZvFYos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlhvcHoxaFNERnBqbUl0V2NSUGcrdmt1bW9QLy9PQnJ3eFhFUHhkd0VHZTZY?=
 =?utf-8?B?WFdUZGlQMENkOXo1UVZHbUcwbGxNSXR4ejFieDBwZjltOW80S0M4TXhWbVJG?=
 =?utf-8?B?MmttV1hDemtKZUVHaTBzR1NpbTFQdE1vLzNiMGhCeGJIWXBHQjVEQnpZRWZU?=
 =?utf-8?B?LzhHQVRUcHBtUTY1NzFvK3Q0N25iYTd4WFNSMVMxWjgwdnAwY2RLd1RNMXYw?=
 =?utf-8?B?VzhXcjBBWmRMOSthdUdhbTQxR0RqMjlIVlJ0d2NkUGg4NEhKNEJuNVJESmlq?=
 =?utf-8?B?TWNla2YyOSs1MDc2a1ROTHNpUjl0eEhYMDV6a2piMEE5MGlzVzVtSlRwaFhS?=
 =?utf-8?B?SWtkVU5VeGl0bGUzcmVQVnI1Z280ekprVW5WdVd5c3lHaVRQWjZYNnNFRTI1?=
 =?utf-8?B?eTh1ZTc2eU1KMXBYNVBORFFCa2dobWFDbnJCUjVPaFY5MGF5VU1wQk5iOTJ2?=
 =?utf-8?B?dnBHenVCWjQrTVJMa3B4bDNjZ1QxM1duQXgwei9FQXZaTFlHdm1KOGRQUXQv?=
 =?utf-8?B?OHl5RUZhNHRGQi9RMWZHVnpueHNrdmFjbGVkWHFTT1I4VE00bHl4Z3JUWXpl?=
 =?utf-8?B?VjdndzlLbDhRb3M5a1pJUUFsZ1M3ZUx0Y24yazl0YzVSWEY3TG9xNTRxSktI?=
 =?utf-8?B?YWpKSTRtVkVYVk5naFBCVGpiRkhXbEU5a0ViVUhUdFc1c3R5ZU5HUWVIRXlh?=
 =?utf-8?B?MHlrZjhjWmF1NmRyaEdlZDlxeVV3RTB2Q1VXcWtiTUYyeEg3ejVmY0JQdW9S?=
 =?utf-8?B?elk4RWVEMW9lYmNZVVNsbWtpRmdneHlDQ3dETGdtWjhiMGk5WTQ5MzV0YXc3?=
 =?utf-8?B?WTBxS1lQMUM2OVd1VnpsWndUK0xrNzRkSWVtWnBIc1RjTXQ3RnlpZXN0M0VN?=
 =?utf-8?B?NmVEU2RSN3ZCdGFYN2pacmdFQjM4akV1bVhYTHNKSWE1THZtT1F1YVBBdlJB?=
 =?utf-8?B?citMY2lXS1M2YkQrbGRIU1YrcjJHK2FwSnhES0lGVDh0d3U5M3BOVkFYek5z?=
 =?utf-8?B?aCt1aXlNZVVzSWpiTllodUxCRGJYT0w0SVB4aW8wMnNBcjhOMVB0NXhxOS9l?=
 =?utf-8?B?REhSVjQ4a2c1aStPODlqWU5FRk9leEdkREFhMHZOVTZDTmFXN0h2NTlqZlBm?=
 =?utf-8?B?d21Ocnp5bXgzc0IrNWg1QnpXREMybEtwTVEyOWp4Z1dYNm5oS05OdytkanBv?=
 =?utf-8?B?aGE1OUhCNDYrZEFRQ0hDL0xZWkE5TlovK0FHWnp6QlF4YkszK3lVS1p4M3dt?=
 =?utf-8?B?WjU1b05kUURiMzMzUVJmZkg2OE05M1h1QlM3c09JR0tBZ1R5RlZvSGRZWitN?=
 =?utf-8?B?TklqQkRGckMrK0svQnV5R2l1MEZMNEMxc1NnOHRnekRGMVpkcTBEdllwV25Q?=
 =?utf-8?B?TWZUNVo3QXpld2dDYjY1MklPQkt2bUU4Vk1iR3pTSTErbmZmR1dTRHFRdEky?=
 =?utf-8?B?dG4xTy8rbEt0cHYzWU83K0VZZjl2ZUJlNDF1QVFlR3VDRWpiWkk2MFZlOVhh?=
 =?utf-8?B?RkNrSjIreEU0RERySkdCdU5CNUJJOFZGNnRrODN3YnFHUHZmV2dnam40SVR1?=
 =?utf-8?B?RGM0c1dQSlVJRUdZR2YxME1OdXl0dUx0OEVFTUNqVDNnYkdqZFZGVUwzSjBn?=
 =?utf-8?B?WElROW1PSmt4N2xyTnFmRDhWTkNhR3dGT1VOU1ZZTUNlcnlhOGhaMTRLdS9s?=
 =?utf-8?B?MmZTQ0FmS3NTMTJ1dkFaVWZPV2FsVmZyUk8wVWVDNXlvbFROc3cwOTdrU1pF?=
 =?utf-8?B?V0RiVFRRRmgvS0E1b3BLUXdzUnVpMGlmR2xkVXhSbXJ6UW1ScGdNR1U3dFBY?=
 =?utf-8?B?VmVVUGZqcFo0ckxnajFTQ0NmZmNuOGZPN203YjBScjF3dGx0UlVtalJuL2NR?=
 =?utf-8?B?dmZsbG0rMUw4THRLTGtpRDNEMmtteEN0ZmREWWlJUVZmeFI2alUwTG9OU1NP?=
 =?utf-8?B?ZVhTekhpT2JYclYzTjBhWFNTdXNaeFFEd0FCcVM5c1ZBenplLzBJUGkwbis4?=
 =?utf-8?B?blJJZ0Z3YzRKZm53dThyc1pqK1RtcXFiSmF0TU9ERitYbEt5K01BQU1ndWhX?=
 =?utf-8?B?MkgyRDM4dy80akRmaUR5dFlLQnUzUWVsZy9WMGFkdFNUUjRjQnRYa1diQ0ZI?=
 =?utf-8?B?NExiZGtzR2lKSk5FbDRGZlE5Nk9Jcm9IZDhwREI3WmlvOUR0dkdUYWc2WU1S?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bde7b39a-b9e1-48fb-3d89-08dc34b4fd9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 21:18:33.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNIs6HL96BOztniCbFfIPz+q2TV1fLMcDPFDskaluwtZoaFUEXnDXj/9qDpL9ksp7caVapswGpqkV9BWw8egyNctjKFgKMB7/eZSe8iqcZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/22/2024 4:07 AM, Maciej Wieczor-Retman wrote:
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 161f5365b4f0..bae08d1221ec 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -134,6 +134,8 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>  	}
>  
>  	ret = test->run_test(test, uparams);
> +	if (test->cleanup)
> +		test->cleanup();
>  	ksft_test_result(!ret, "%s: test\n", test->name);
>  
>  cleanup:

I think this can be potentially confusing to do cleanup here and
then follow it with a test_cleanup(). Could this test specific
cleanup perhaps be called from the general test_cleanup() instead?

Reinette

