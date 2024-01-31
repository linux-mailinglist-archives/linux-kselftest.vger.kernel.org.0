Return-Path: <linux-kselftest+bounces-3828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE959843FC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8C41F2606E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2379DD1;
	Wed, 31 Jan 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Me2MKUsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FB53E20;
	Wed, 31 Jan 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705736; cv=fail; b=lq2iuvxgpUVIgWJay1c/QEi0Iq2yW/2UaHYBUbbJEewOr3RsfjX9pKGA1N6E8URjdZOLDL/OBL27D5QXjKncCuNKlvml3LxapjL6Y4F3fQwgv1AhN1XrjNspz2b4+P76CynKsjtFJ3M0x3GsYYy3PhN92PWm6/3+Ub5wBhXwgNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705736; c=relaxed/simple;
	bh=ccQlZ02bg54QVbE9cV9FIgAZjHIbp6KHj3Q/gpvJVmU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cg2QGrfmN/G0I/4xGWCnFE2BW6P2KCIm9XXiLy60osW6o6hGzXEA7NEZ7fZt6NpMOO0tiqhdKJxu/nmAh0lrzk8yK2atZLykwus7w5M2i6qfRY2T1JXywkOJcNVEOY7CAVWaXJJ/Jw+vlpVhPlyc7bRw4M1ZYWfst6ZZntrHdA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Me2MKUsB; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706705734; x=1738241734;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ccQlZ02bg54QVbE9cV9FIgAZjHIbp6KHj3Q/gpvJVmU=;
  b=Me2MKUsB7OPpXXOFQOSk/FDKuyfTP6DwdNWbyndvbSIunyLlyn22a4Rd
   8WHJ1uM/u5zn4FHrGOsam4TM/2HULCizKEy6bM3DkBFZS7BdjfQwTHGXM
   zJu9dDdRU6op8ckU7AhqZS4OLpRGs1iPzvFK6tQsXcdr4a9ZGcBwv7vqm
   YmSh+rMvdzo1q4YdTjV7fZhhg3B3MuPPTjRzF8+ggxEJCuNHpjGQ275Gp
   xRVMXJkcCgsoynNvEFPzKjGaQOLxbUMbUjENUamx5Oay9ZXtwFJbuRRJp
   XgJ1F6h9Zp8lSSV5LxNd6Ezamkl/EZUlXfyAmnORw1mp1xT+YcF7J5hLl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3442156"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3442156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 04:55:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878774787"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878774787"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 04:55:32 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 04:55:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 04:55:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 04:55:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY6AF8Vpc26RNdz9Hcwemnsw05Td3S7UUlX9249HCbkFVUSA1i6KhMndyIQn8g64JtYyRmvgbKk8yc1gc1gLMJbKYrZZrwKFFLIVCaEcO6XgB/7KxF92YhOZKXvhjQpHUiLytihYkvx2EdVZvbBuPquZfgnQeIg7nfepBEr0UxkjMt5TbYsbbuWii2fS/G4OfwVFiqYGstO+K072ExqEq5tGtD9lLhcEfNbno4Xa1T35RnPVm/XV/qxuutom0/9qPdLd6v4AbGWusa9DdlvUuZLlsjrh/s2XR2Ob9aBZcX5NU5ecz3VzBbjMlIg6A4qw27iGnPOKIVLYNRnouKTPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqUBdEBnyurw8twMnQk4mjzHR/kd51x4bL9osZN8wYw=;
 b=kceXBfm8nCGgCf8+knV31tekc0sU4Al93uA2uKNlv5zb8f9SOiLagNWCUp90X+1knpfyjhum5Cvj3gqizfByho1MX4lFoKkpaMVVIS0P83X5NlWhR2vVJvHMx2CcQMisTGKAhRm6ZHad05iIYQSdyzeEmpajJlx1PQ5A+TVf6T1oi+ZMwBYgWPkQNBMF3fM6XAMKz6j4ddYTMxUM50TYZvl1L0Ef3H4mcEys0OBoHCHhKFXaU6ZOSw13OYv2XnK/M4FXhqjYbXauyyN2qwjpNGQ76q1xvKa2Mc1LGZ2XXv+/SSZ3uPEDABHv6m8iYyc1uEajayjUd2DHX433RFeHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 12:55:28 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 12:55:28 +0000
Date: Wed, 31 Jan 2024 13:55:16 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Add non-contiguous CBMs CAT
 test
Message-ID: <jbgkiwfkotntcdzhwf27dceit4w3j37sumkayixmyuee6zyaqg@un22a2iljgmr>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <647fbfd449f8b0e0ad6cfe58bb280ff44ee162b8.1706180726.git.maciej.wieczor-retman@intel.com>
 <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db08ba56-ae73-4c70-87fb-aae59e524238@intel.com>
X-ClientProxiedBy: VI1PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:802:2::43) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a3897c-c6c1-4d69-5ca8-08dc225be5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPpLL6LxJa5y7D9Hv5XS7bxwVHT0XW7dZUnDq/qrT+CE0/5CO9U+3jKiOconWm+jUbzFUsxs8RphUbFDKFLHagqwXVT63N4uU/eZSst/MzqXPY7qIOzA+fcQoHzv9+nwTDI6sVu+wQNUvlfJw1OKB33E22JJfAuO6v0nqJc7Kn1PhXRmNgI/m0S+sKFIBgxwwECQv7rNUo+03vuuTtgLYVvkNEMhcAey4K5oG2P+Zrkcswp9sO9PiUqWV/OgshUFFmfI1A3F5MiBjSnkhYyYPQIjR3bVKIH3GM39TJKsaKJNUOsaIlr+AiQmPyJhxyvw2BBv3KPIK9gq1qolpyaegYYPzYrgHULRqNBk7gtx2cyj64Ykbrd3P7l5F44pfakzk7P45+7/Q6E+bmJ1lUwX+dz3986Fa+Jq/N1UMi+veVZd5vjA0w29TWDw/thnv0SYEjhevI8uWAkxZpCceVGDPkVg2RhPn9Tu0Em/MRWreoMo/yjO1WXpOHLWh4L2JNRZ0Ym4XM/fIwShmdfpFrneaS7g+7fXyXVqiXSUQevudHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(82960400001)(66946007)(6636002)(66556008)(66476007)(2906002)(6512007)(8676002)(8936002)(4326008)(9686003)(6862004)(86362001)(5660300002)(38100700002)(83380400001)(66574015)(26005)(6666004)(33716001)(966005)(6486002)(6506007)(41300700001)(478600001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A1BlZJ1xn4XW1ZRCw90ugKit3SsXVSKac5+MfNK/twlxDlo00Fh69yvQK8?=
 =?iso-8859-1?Q?NZW8O1Sw6m9J9SPsHUjJ6EhkeBsZC+GG6aGJZhr91fovTO/E7g1Fb6Y0gV?=
 =?iso-8859-1?Q?+Oe+3vQ6oGBxnKQ7cWuMnprLZm1gdkBQM52Z8GdIYl28liZowApRExwB1M?=
 =?iso-8859-1?Q?jHuGniBq8U185b26t2SS834oLrIxacTqKEc30LVTOZQlBYoZ+ClwGMUPI6?=
 =?iso-8859-1?Q?vJwP/k4ijNE+oBZRlkq4mN5tk6b9as7M10/xb6aDfYLFOnzX4bAKmQsq7c?=
 =?iso-8859-1?Q?p214au/cEm/uyI5KxU/4evLkMzBwa+VrSi1wkYgCtLPNYAHPsiJNVizMn1?=
 =?iso-8859-1?Q?8mmMDOXbNTjcHuQk9twUYs9a5UUf6GA6oNMvGz4Be0cTgucTnha2Y1x+LU?=
 =?iso-8859-1?Q?/rJTj0PhP4HbjDA7reWghvDsCSRrQANB1cBBKx2TnSos8RqS1sgjNK2Rqn?=
 =?iso-8859-1?Q?SweU0cWQLLDTUvccs86XnG5lbTOhc33sXZzAqgSDqKbtsIUd2rffsKasZ3?=
 =?iso-8859-1?Q?QUTLP2GHFxfV1bpUo6T2m6Opfa2Eig0M8XOWP8WsrycoD0WrF4/nZcVPVo?=
 =?iso-8859-1?Q?4N5hM/I0o0hK0l/fNEFXrs/jAmau5BnKm6nnOIxrqeeIWUFpCKdxrKqwLx?=
 =?iso-8859-1?Q?nURMyg0WLIWvzkM6zPfyM1hXc878mAQ5M+HAPnIZTeijJjTPsw7oZVN2fT?=
 =?iso-8859-1?Q?PSySIpNv2olqFfiu2Xjz7yNsYZ2+o8Qs7Hx+BCC4RQTHMemCr2XqVQJhV8?=
 =?iso-8859-1?Q?NRnY49rLgpTsU+zkzsCJoa2g+JvY0WVBWAc1TP61X1WHG0tAgdhVwTa4Ev?=
 =?iso-8859-1?Q?8V2iQxtHbM6RuW37HSSBqfq6MtaEB7PFTmpRRtm26U9PTXqxqaGLojkh91?=
 =?iso-8859-1?Q?pxAppd3jUKrPrR/k9FMq07GLvj+oiFDFoOGGFmsry598GzOCcpgpkssyZG?=
 =?iso-8859-1?Q?a9DVWfifVsDbw3s8O8bH0FxzRCzNUbkp/TDXEyRXsH+T1Pn5vQ4fsdejgM?=
 =?iso-8859-1?Q?UwEu3jOcR86xOiCj8kRqHueDDd2daHW81CVCDF2YaKye8xeAaqSLd/2gBV?=
 =?iso-8859-1?Q?uf0gx+yEeL/Bgc3yCTfWk5cnEK/uQ55347TrdD/Yu/recz8GNiDjRkeNUp?=
 =?iso-8859-1?Q?mg9vDrsbWY1oM/697RQBftDL+x/N6tcNRm+MP1dRMJNtW7KrfVRTFh7lsP?=
 =?iso-8859-1?Q?pe2PWZL7JxEUo055gxKc3scZAJHl/TaPthFFY7ve1lscB2eewcxVK6zjXQ?=
 =?iso-8859-1?Q?IGlphoDGqVcQeDbQGQQ71VCefglXntM/tdO9Yd366LsxyesN99nSf6Eg3F?=
 =?iso-8859-1?Q?XSOha8WSu/VdqMyiLofYxAtBl8uABTfnXzN/UrnvVK567RJhkjwbwFnfgu?=
 =?iso-8859-1?Q?xf35scOnvy7hJeT4rrIqzCb840u1JbyljDZl5cXF6GVIHWdJWgMH/7C+pB?=
 =?iso-8859-1?Q?XcNXpBdZQcOcv7YziISM0yceeIMEq7MlePG6IOjnBp9tAzE2hxBh64y6H/?=
 =?iso-8859-1?Q?obPCcV5zRw0e+C2WbcqwOWLnu/drgI7xF1FIa+hVvOsuw4ATnB3lNkJksb?=
 =?iso-8859-1?Q?it1b72s0d1U/QpN7G4szmVXo9aqP2gCn9XPx3ExIckj2qnRXfMORrYQrAd?=
 =?iso-8859-1?Q?+m8typzn8vWbbFvDOzf6M1byL+n/HRpWWvY6b6eJ/BkPm6oaN6f15vhuz3?=
 =?iso-8859-1?Q?kRc4xQ+DFEKEcUuPxMs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a3897c-c6c1-4d69-5ca8-08dc225be5bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 12:55:28.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM6CU8ksZRT+uqtxjYOg/tbajxceyQLawAOACzIbVaDeWZ4ExUKh8JFMjQP/Jc5eHGb7BtApoEk8A+LJnLw07sCZs3E+QtZjcABEmjGos84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

Hi!

On 2024-01-26 at 13:10:18 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/25/2024 3:13 AM, Maciej Wieczor-Retman wrote:
>> Add tests for both L2 and L3 CAT to verify the return values
>> generated by writing non-contiguous CBMs don't contradict the
>> reported non-contiguous support information.
>> 
>> Use a logical XOR to confirm return value of write_schemata() and
>> non-contiguous CBMs support information match.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v3:
>> - Roll back __cpuid_count part. (Reinette)
>> - Update function name to read sparse_masks file.
>> - Roll back get_cache_level() changes.
>> - Add ksft_print_msg() to contiguous schemata write error handling
>>   (Reinette).
>> 
>> Changelog v2:
>> - Redo the patch message. (Ilpo)
>> - Tidy up __cpuid_count calls. (Ilpo)
>> - Remove redundant AND in noncont_mask calculations (Ilpo)
>> - Fix bit_center offset.
>> - Add newline before function return. (Ilpo)
>> - Group non-contiguous tests with CAT tests. (Ilpo)
>> - Use a helper for reading sparse_masks file. (Ilpo)
>> - Make get_cache_level() available in other source files. (Ilpo)
>> 
>>  tools/testing/selftests/resctrl/cat_test.c    | 81 +++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>  3 files changed, 85 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 39fc9303b8e8..9086bf359072 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -294,6 +294,71 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>> +				const struct user_params *uparams)
>> +{
>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
>> +	char schemata[64];
>> +	int bit_center;
>> +
>> +	/* Check to compare sparse_masks content to CPUID output. */
>> +	ret = resource_info_unsigned_get(test->resource, "sparse_masks", &sparse_masks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!strcmp(test->resource, "L3"))
>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +	else if (!strcmp(test->resource, "L2"))
>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +	else
>> +		return -EINVAL;
>> +
>> +	if (sparse_masks != ((ecx >> 3) & 1)) {
>> +		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>> +		return -1;
>
>If I understand correctly this falls into the "test failure" [1] category
>and should return 1? ...
>
>> +	}
>> +
>> +	/* Write checks initialization. */
>> +	ret = get_full_cbm(test->resource, &full_cache_mask);
>> +	if (ret < 0)
>> +		return ret;
>> +	bit_center = count_bits(full_cache_mask) / 2;
>> +	cont_mask = full_cache_mask >> bit_center;
>> +
>> +	/* Contiguous mask write check. */
>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret) {
>> +		ksft_print_msg("Write of contiguous CBM failed\n");
>> +		return ret;
>
>... although here I think the goal to distinguish between test error and test failure
>falls apart since it is not possible to tell within the test if the failure is
>because of error in the test or if test failed.

Is there even a distinction between test error and failure in resctrl selftest?
I've been looking at it for a while and can't find any instances where
ksft_test_result_error() would be used. Everywhere I look it's either pass or
fail. By grep-ing over all selftests I found only five tests that use
ksft_test_result_error().

Furthermore there is this one "TODO" in kselftests.h:

	/* TODO: how does "error" differ from "fail" or "skip"? */

If you meant the distintion less literally then I'd say the sparse_masks
comparison to CPUID would be a failure. What I had in mind is that it tries to
validate a resctrl interface relevant to non-contiguous CBMs. If it fails
there is probably something wrong with the code concerning non-contiguous CBMs.
On the other hand writing contiguous CBMs shouldn't fail as far as the
non-contiguous CBMs in CAT test is concerned. So if that fails there might be
something wrong on a higher level and I'd say that can be more of an error than
a failure.

But I'm just saying how I undestood it so far. If there is some clear
distinction between error and failure definitions I could try to separate it
more explicitly.

>
>Reinette
>
>[1] https://lore.kernel.org/all/33787043-5823-6de4-4e5c-a24a136ba541@linux.intel.com/
>

-- 
Kind regards
Maciej Wieczór-Retman

