Return-Path: <linux-kselftest+bounces-4463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB0F84FAF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 18:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38A728A324
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5927BB0D;
	Fri,  9 Feb 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSpn486G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FAD7B3D4;
	Fri,  9 Feb 2024 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499282; cv=fail; b=K7xR+L9HMf5mNk9uU0MwL1VPV8dWdildVF9tajGrZIqlaT0i0KkkIyTXOvsY9Sib1S6+oZp2oDGnhbqADCGgzW/80Z2D7tPHASNW7ju1pSOEftVIIQ9qo7DSrgjRzYbedi3XsywYaT8ZhzWurqdW4uoIGsL32skBwy+DnIL7+kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499282; c=relaxed/simple;
	bh=K/6TUg2euT8ZgHyafk7U8DfIg0AAQjnToIFMf1eEDx8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jAWnc7ZgiunJWP7JiLeDEwfu4JrTvPEZCpqR9mONBtNuVC2N106XiGaWg++I/x0VN2bXaILp+I0N4MGOC/L6S3J8XtzKyHH3wZNb6Xgp6p95uYDmwRRNVQ3mvp9XEmTianWrZkOBY5AwyQyg+z/T1jO2w4QpH0p2noPSrmpIQAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSpn486G; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707499280; x=1739035280;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K/6TUg2euT8ZgHyafk7U8DfIg0AAQjnToIFMf1eEDx8=;
  b=WSpn486GrER++4D+uvu9eqtYpJdlhQNxUUW/JgHfqxa9RAANBunPJOkX
   Pzejv/1xZlRjYH8yrr02P5/PDoOFl7boC4ePeHqWQJ+pa608kmFUN/TXU
   hLJcEWdaqPAJjJVVgTHQVkEGckwNBUojU3HDM2QnX/KYQuflyzbQ5B9rc
   8ovXl0/Y6vOuZMdwYbsMAlZRpbDfzWSH6Sp+AYPh3VNx7Gjopj569ZOLR
   gS6TS9YOZ9vne7SiCOChzP/zatVBSjhu62OytsH3SEK2jZuB+2j1Kr778
   YsBuHEJAix0gg1PuZsF63VauhUJ9M2kbz+LyB5vqmuBrP7zd6eNnYZ1YV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4446048"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4446048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="25217971"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 09:21:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 09:21:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 09:21:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 09:21:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhMTBrsdX0tgIsjqCsdX6vVSg2eXvNKYwgqafNngfM1Y8Ah/wm9zA/is4F3e77q+rPmQ1+WJszWIcYMftQa5uSzy5tS2itIJDu9sywSgwLaVxz0AtPfhLt8o0X9JAN2WcBmVN3FVMuj9rWHf+9J2iWw6k1uy0E6xXaFu5ZSwOZwsQ5k5DLX5Lj/okNvNgYowTrjW8moL1ISTdaEVmEPBrsUuP5v06aJSwWYTjnbUckSDgEeinhG99Nf67k/6ZvOFnWkzdEt/aJIwtu9aQdUdm0ixIJvKO2mCNZqq+H7oaI+FR4AuwZ+5+cJ13WkPvPpWuyAFcoOLzDx1M1JCJ0jWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH2oxud/lkoOOlK8FklgWZqfaRTRfyzcZxuIxm/UypQ=;
 b=BdmQOtqMu27iao5nQzjBUOnut9GMLvCVP3wU+bNeyz0ECyX1QbDyRUiOd5ZmRNIBI1Jy0oIyp+X39DmLvxxal55JotJnnIMVcvjsx/+xAEO8O8RQ105N2YiFsrm7Cyq/hvFPK+KB7rWZG1BldDo1SCjZ4u1FaNvgJLs6S3bMfCNGuKDRBtrtCEj46tN0y2c9uheXQZ411ZoKCCgaGDrQFsW52VUcWtrTOMI1uCWFGFuodpg022VqnKQav9PKgn5LOnVf7/bVuwUF4RtgoW05c7dQ1EOQEFjMWtQ+N+JewfYjJWE/KlpBPGpbRVz+IyMJ7vl0P7YMB2Htv71KjTlKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6157.namprd11.prod.outlook.com (2603:10b6:208:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 17:21:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 17:21:16 +0000
Message-ID: <b63354ab-458a-46a5-a80a-971845f1de9d@intel.com>
Date: Fri, 9 Feb 2024 09:21:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2c1011e7630605365b67caa6ddfe4e8ee2ba5bff.1707487039.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: b79a2b69-bcf2-4793-bba3-08dc29938632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +txaqjTvJ/NFv55NZvHPK/07LrCHEYHxiTD0z2ug23JIxWft2TkKYFITQgQ617J0qIXpHOgjolIzJ894k60M7BgNCeVIkcg5WflN7fzYYfgkIjcSq+gBZeP+jkyU+x7241l6WUc340Lz1NUDu35o9h8slU9lpS2SrLa9BQGUjtVWtmVgpNzST/NTKHncNsdLiLTlu6zhpKrDM8gTfn8VvPii/2YbxPTA60k8AOzeIxC+mWPyrvrsIuXbnzgbyem5I2cRqxBi+WLaPgfb8MYepJdHvFejmK4I7qrlcOvoYsOC59eZewpku4aGoG7xr498O2I/kqsvpF4aKRFMWGnAKsjZOwp0+xPr1vPYhgqxmYA1el1Ut2b8ooEvlyxjCGIkqdLbaU0ssCp18RVSY9mkTbdiOJDZ6o95i+5YCJqVf1UIbw278rd7i4nBP6VbzxBEfeAe5uSxqkx17eYnCQrmUi+OBHxyOkjlAYe4fCuMJNHolYI0OQAo8IbjpNhm44J0X8WkmmdCQsO9dvhRPcyKpflG+SO2U/M4941VmUkaMcIXm2yjfhTraXndSr9u8B8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82960400001)(86362001)(31696002)(6486002)(6636002)(316002)(26005)(478600001)(2616005)(6506007)(66556008)(66476007)(66946007)(38100700002)(6512007)(53546011)(36756003)(8676002)(44832011)(4326008)(8936002)(41300700001)(5660300002)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVk2RXNzM3hlMzJSZm51UjFzRnJNV3hDVzJRbXFmaUxBVDl6dWxjSVN1UzM1?=
 =?utf-8?B?ZldGaU43bHNKR24yeFEvZFNXcDVISW5ZVEtrT1MxZFh1U2l3L0RETDBBeU9M?=
 =?utf-8?B?QVZSSVhaMGtYbWF5cEFIakRVRDVQK1VNSFQvWmloRXp6WjNBWGFucVNsTDNk?=
 =?utf-8?B?WkJ5OEZYU2xrNWZ3bDErcXNJdFhKTmZJbXFDRlRzaXlWODhkSXZvbWo0Mm9t?=
 =?utf-8?B?ekxyNGdFVks2TDJIUGw2V2hYanhrcXVHeEpLTGdMcTg5b0tWbkVla2hDSWoz?=
 =?utf-8?B?QS9OVm0waXplalhzMmRlbXZ3bVhadkgzTlpqb1J3cm5tcjk1Uk5rY1B2dGV0?=
 =?utf-8?B?Z2g0dy9aM1FkTVRiV05uaTBtZE8zSTRjWXRFazc3OC9WaUhweUhhOW1jNHVW?=
 =?utf-8?B?TWtRRDlYczJ2NVNUOWEvRTdnaGs1MzFuaXlla1J2RHpiMnNiQXZtSzdGNVlt?=
 =?utf-8?B?bTE0Vkh3UjRRaW15dlQxZUFXVkYyeXZ1NklBZldhY0F4eDZlUk1jZ2x3UWNl?=
 =?utf-8?B?alJMUGhxenRWNitMMVJ3c0tHcUFTYjFmYzFMdkRpL2RzNmZ3RWxSYmxHYisz?=
 =?utf-8?B?MDY3Nk5JLzBrTnVVbUxiWElnSWJaeGlqVjJwbHl0K2VlelhoWmQ1cU54MEky?=
 =?utf-8?B?TDlRc1VRKzc1Rko5aW8wUDNVMDdjT0FKckZYTTk1bUl2MGwxU2xwbGZsV3BL?=
 =?utf-8?B?cWd0LzFXNHI0eWtBdUZBbzh1OFpzak9ldDNtc1I1dHgzVkh0ZzZtaXBZWEZp?=
 =?utf-8?B?MUczYzdxSlNzTUpPeDIyTzJWckF1YWNISzd0UHYxNzA2WFE0c2tRM1RjcFFj?=
 =?utf-8?B?Z3JvM3FsYW5vcTZjU1R0WWNVZnlRSHYyQWk0cHpSNTBDcDZTVlRCbGlJU3Nl?=
 =?utf-8?B?U2VhMitBaHFwTU1FTjFpT3pLdVFOcStSdnhaeWFTTmxNNmJ0UVdnYzNqSDZa?=
 =?utf-8?B?SXpZSTRIZnRTSE5vbjdyYmlUYzdMNUpuOHd2eW1ORk1iTFc4aHo1bXhERUZM?=
 =?utf-8?B?SU9VVFU1NDdWN0h3dWlxZ285UDNsRWFiMDBnNElSeXlxa05uaXk4QURWUlg0?=
 =?utf-8?B?UCtDY2EwVVQ3NjIwSldtYXp0bmlFUE8zSlJQcEJDdW1qUVpOd2ZndzI5ZVZv?=
 =?utf-8?B?cGFyR2w2L1pkVjRnN0ZxMlpmckpva0h3NXpKV3pJaTZ2MzdkbXRMU0dwUVRJ?=
 =?utf-8?B?b1MyMkNzK2prRnp3YWJkb0EwQ1EzY1ozOGZ5L2lUVTZqTWNhUHhCUW95ZEtz?=
 =?utf-8?B?WUFVSDhERk1ac0VsdEFaMEFXK3VZOEtGa3Y0QmNqMzNiWS8rbVRDTlE2UUxP?=
 =?utf-8?B?WEdKalVoVHI2Uk52ZTFjL0tWNnlZTmFwbDU0aE1SbEg5LzQrZ0Faa3FpNW5m?=
 =?utf-8?B?bE9WdjZYWGoxWHNlL2FnSFY0MGZuQVhhZFdKQ25PZ2pQWllNMzNUOXRla2to?=
 =?utf-8?B?MmIxN2Q1dm00TTd5cFZZOU95ZjdUSXhLVWVCeTZCNEhmOFF1Y2FvLzRqVW9r?=
 =?utf-8?B?R1VSbHlaT016VTcxRDk5NDRXV29kS2JGSlpvMFBYcDAwSngyRFhKNVc4dTE4?=
 =?utf-8?B?ZG9XNmtLa2VXTUxNSWVsMk1zQzlJYWJSWkx0aTBOajdHNGZSWkxvSDQyREFH?=
 =?utf-8?B?ZnJaZytEeVI2dVpFaG1HZHI3WkZEcE1DUFlkMjlvYmxRRkRKVTNQRHNuTUht?=
 =?utf-8?B?TWowT3o5SElhWlNxYVBtM2UxRURzaDg5Q01NNC9od3E2UGpzZzA2SzJOK01r?=
 =?utf-8?B?YWVSZE8xb1JMQlRYY2JqRGpJMTVDVUdLSVBQN0hIa212Nk05U0d3YnVXazRZ?=
 =?utf-8?B?Q2pMMGVtYnRXL1hvMnRpc0REQUpRd3FiTDI5bzRUd0ZieUkrd0wzYU9LSnc4?=
 =?utf-8?B?b1Yxb2d4WWdGZEwzVXE2ZVhRWi9QTjMySENEOUp5b1pTVjhIcEMzWlkwZERj?=
 =?utf-8?B?Umh0dTJYWHZiTUZta2NxSmFiaFdkcDQ3UklDY3l6QStlcGlNRUp4eTM2bVhS?=
 =?utf-8?B?YS96b3BLYzBQR1hYUVNuZDZUNCt5RXJNWEM4UkJkMWpZcjJ6QmhudTYrZVZp?=
 =?utf-8?B?dEZhWTFZSkdteklLREFVTGE0L0xBVEdaSGNYZVlhTCs4ZjN4NHBXVEM3cDd5?=
 =?utf-8?B?djdnc1R5REE1MmY3SzJaNUIrTWRxeHljMVl0MHVqbGcxTFM0Skd2N3pKNWd1?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b79a2b69-bcf2-4793-bba3-08dc29938632
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:21:16.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9UdLU/ayDUZElFTa9VvfpCaISIrNXNIxWEsk4GmyrIhTBqC3jOR4XwYVXWGhSRk0Bktb9c8HVHr/pmNP+SLBs7jeFJ2ff/IDV9VRdzsNcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6157
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/9/2024 6:02 AM, Maciej Wieczor-Retman wrote:

...

> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 39fc9303b8e8..d4b7bf8a6780 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	return ret;
>  }
>  
> +static int noncont_cat_run_test(const struct resctrl_test *test,
> +				const struct user_params *uparams)
> +{
> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;

I missed that "ret" is "unsigned int" while the test expects it to
be signed ("if (ret < 0)") and it is used to have return value of functions
that return < 0 on error.


> +	char schemata[64];
> +	int bit_center;
> +
> +	/* Check to compare sparse_masks content to CPUID output. */
> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
> +	if (ret)
> +		return ret;
> +
> +	if (!strcmp(test->resource, "L3"))
> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +	else if (!strcmp(test->resource, "L2"))
> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +	else
> +		return -EINVAL;
> +
> +	if (sparse_masks != ((ecx >> 3) & 1)) {
> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
> +		return 1;
> +	}
> +
> +	/* Write checks initialization. */
> +	ret = get_full_cbm(test->resource, &full_cache_mask);
> +	if (ret < 0)
> +		return ret;
> +	bit_center = count_bits(full_cache_mask) / 2;

It would be nice if no new static check issues are introduced into the
resctrl selftests. I did a quick check and this is a problematic portion.
We know that the full_cache_mask cannot have zero bits but it is not
obvious to the checkers, thus thinking that bit_center may be zero
resulting in a bit shift of "-2" bits attempt later on. Could you please
add some error checking to ensure expected values to avoid extra noise from
checkers when this code lands upstream?

Thank you

Reinette


