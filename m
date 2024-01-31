Return-Path: <linux-kselftest+bounces-3824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D9C843EB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169AAB2106E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9376052;
	Wed, 31 Jan 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVDSXD17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1277603D;
	Wed, 31 Jan 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701728; cv=fail; b=THJM4KO+hkYH48dYlEO9l2zK0QVpIEwHCAO9KAxSHxkAl+gCYpE7ig26iUXn0+1G/YLEFXpJkj0ZCbpFFRzB6cDJt+AWbxHlSTfj8Bub3vi/v5kvdJva8HnNFsIhSf8Vgkux7FH5j4XkuVBh1+9eo+C3wS2ch3vAEC3HInrZVcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701728; c=relaxed/simple;
	bh=mg9owkgc9/dYtCdt2nfZXYsdL6bwCtmAoBX6bm0b8+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPXpHP2mCh2NhIvNs6Qz2+RmspQRkuumxk2G3Kihu5D109NvZoriSGrGEqpIy9seRkK7i6meSE5LktF1jhWDl/YOk1PqT43nnhIiZiA/HFm8TQWOkBqyXw68Fb95HYQvqXWAM1gAMRpqm49LUzngPXprc9DVaeUm9oxA0EldPKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVDSXD17; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701726; x=1738237726;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mg9owkgc9/dYtCdt2nfZXYsdL6bwCtmAoBX6bm0b8+4=;
  b=GVDSXD171Jn6oNq9A8TPUkPPx1t9XTXPF+pKcH+k8OL1fmUCMWrXeLV+
   tSPZkyhAKrU2LC/8Gq5d4NQzUEdbU9JJXjIKB0kFhiWeE48rmv+TK/NA4
   VsR+l1pGCc+bpbwE+c52rbuby29WDtUWNhGw+S5uNE8Ky7joeszESTh+I
   wqiisNQr4Zbn0brFrRBr3T6s7HfztBZ6VSJYkNzogF8omdc1EMqcv8pfq
   pG4t40XW/TMUqnRKUPfvviQAdE6IecH4rQ3eaL9Nt4S1gom0O2uI05n+U
   G2t6KslrLczORG9X8nOtCfjbWfkPL9L/0YGWT9Y0/s0B/r57LSB08z4v1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10213263"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10213263"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4031617"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 03:48:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 03:48:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 03:48:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 03:48:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 03:48:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9M0ta+p+hFfJfg0A9g5tJyVkFaHdRaIR/liaVx8x1INbRa1W9bP0SRIfwlAuEs6DVYOftyIHJaHm4/ljo+dGLDKvgnI7WgJaJ3a28ctjknUpld0EXLdw/MvlL6h0YuanXNjWCC+zt2WdrDyjmGniqnNVf1ruLSLZ+WxAPmcGLVvrmEECBEdOw2S5IiGmMjL5Rr+7Kh/d3balVckt3d4X3nMIbYeoAUwtstK7e8jxfCwzX+xcZhivX/yTPe6OFrOEqFVTqFOa5FWsafS6pR6Iou8C6XN54KPTz0yrhNc7orK6M7kEMntYXX997cIdKRlJnru5VKOyfB9+pO0jQqSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty6Rra0h8OhnA/F+O8TlJPPGlqGJbMDhHwfX0n9rXGs=;
 b=ZDZyar5ieBgvM5K/qoC9TsNuv66UzquOOBIvRIUYNNlfSYbuF95JBRLsTsAMbmo1Choc5TNWLfTJmDmoo3BnMxTqQY6K1fRI/ioizkIPIwfw1y/mMq2xI3ZgRkKj94jl9+Kw2ZFqttDAlp2x30YRNlr2JU9Te0QB4cqm87KCZG8rxErU72vVcEXrXqYC91O2wR5/5s1uEfQgTLnib4ldG/rusrGqcBojFptuuc6ndjivUG+zUiLpcsdJoV9uLM/urgOkoDupZFHvoNG7LXmMbOfZTCOiwi/YKxf0ND0vQy5rH54fYfrslA0MIKCWD1bMXmy5h26pBuVGf1KtJFAmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN0PR11MB5696.namprd11.prod.outlook.com (2603:10b6:408:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 11:48:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 11:48:42 +0000
Date: Wed, 31 Jan 2024 12:48:34 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Message-ID: <a2kk6npzrdy4qeimmb3ifdbuse64t3c7wbnn2gocdqxuzkcqm5@lwoy3ou2eihc>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
 <e486cafe-86f7-47d5-9d11-eaca2007e5db@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e486cafe-86f7-47d5-9d11-eaca2007e5db@intel.com>
X-ClientProxiedBy: VI1PR0102CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::32) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN0PR11MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0e8e64-fe44-451d-8e8e-08dc22529284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2x6BsLw0Cz8+K4YGsJ/6UZovj/4b40M1AzrAYj/8JuiP97+EgyKxvBRb44aYeQtXpyaSzwAeBIYgHDqBTU6y7vXsocV9UjqvCY1tDk+U4rVmnpJi5L4bOiq4CfHDuRKZWGGSgmf0pob2vkPw2pfb0WvSI4JWpW4H49fIL6Au5MS3Sjg0cTV+GE7fLIgbeUKIZQ8CYX72pBr6X3n09+iSSzSPvAAuXJvqvTvuMpiMlL5vpCfbrvN3vBP4P1xV9CwBJ0HCUJhOeaB0UD/ZphklTarhyMGbNqWmSGN3zKpJ/i1zMRZC344IrIinhuQVROdVVHN6A32pecrlp5RP5K50Wxj2hEVweS0d2TWInnHExZzX7VeDgYPerk3fqygE4ucRjiDtnHcGWA0Qo9vOX8TssnTNsn3HYUgD0xTbDRKa3peF1s9vo3jYI+Hpquen/oPoWU6ix3Llk1j34mC6zXQgYVF2lIivmxwHjiB7Kd93UQFQHF8k2nfU6u+4i7YFZej148TsHn/EraKKMP0P3W/wlIFmSZHxmt13vwRdpMCCMX+EGZ6UoWH/6QDY1JBjqY6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(66574015)(316002)(86362001)(6636002)(66946007)(66476007)(66556008)(38100700002)(82960400001)(8936002)(8676002)(6862004)(4326008)(478600001)(9686003)(6512007)(26005)(6506007)(53546011)(5660300002)(6486002)(83380400001)(2906002)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RH1ejaWFA05cnGos8QJZcVKaejp3vhZv/B6P7RZeiyuya02SzZGTqLUSsB?=
 =?iso-8859-1?Q?sAfySuIaGeUiiDu4m8FZPWMfmzIIi55aclKwDFUl/v8lHHn1u36y1iDxo8?=
 =?iso-8859-1?Q?DeS1ikR9XKWenuS1nlUtTcOkoLzOGRHGCUIOzNp8lEgqmppX7yLVW2oWY1?=
 =?iso-8859-1?Q?bmP8pdUGTuvN89dW4LGgbsvqnYBoXaDhl1hy0O/TeH2kP1KLCoDGF83wEm?=
 =?iso-8859-1?Q?rwr+yPZJuw8OLFjL50YCTBnNl3qGO/51Eb59CPQvOzFx1aGauj4Jx015TX?=
 =?iso-8859-1?Q?WQsz1WBGm11SqqfxJJNSt52ta7+H717jLsGTxuae3fqnqGM+dYeEN0I27B?=
 =?iso-8859-1?Q?4LFRFCbKeZ8tYN7TBS6plFmwZV/rH7UCBnoqdRUKIwYKlUAlCZy3G0Lvrb?=
 =?iso-8859-1?Q?4zwcwdzBdcc+gov/8OpqQGAvmDFui6SgcbTmvd0CcdWKw3WUQCub/+xB4x?=
 =?iso-8859-1?Q?69nZw8ruFTUSTv0ZHEbCWXNepWnpmKUhkjaAP2/a2nS6RK84uwJaHb5GSE?=
 =?iso-8859-1?Q?ZdYAy3DW3IUssRVaJiV1Hef+cxNI4YhRyFwW1AyHUxj9W9f3BjNidIBDGA?=
 =?iso-8859-1?Q?F2ApPnIQSwYa3CwlcjxKX9OZ3tiWjC78/gjRlfyV0bAocYVDNKB3mRybu0?=
 =?iso-8859-1?Q?PNpK7JJSUAhLC+gEMhzz7dAzsHxbAE1Bo9sbxlt1Xs2XXQQ72Konbw6egE?=
 =?iso-8859-1?Q?JE3ZFUfg5nEJ2v/i4LFxv22qMnwPaq7XhIztjC0exFox61ZBP9u3uSF0om?=
 =?iso-8859-1?Q?6aBZLEQrmD4finmoZsLF+DKolHZfL0O3YkGzPxFnFNf6AxOUkhTbP1oRwo?=
 =?iso-8859-1?Q?1pygje8ivcbdetqls8rCkghvy0iww/jHIg8ldF5MTzC4BGIwivkQ87tYOk?=
 =?iso-8859-1?Q?um62o/Xc8Jd9I9NpMrweQ/vB2HDHrXwPxLslVFg2URqEIQfBEgceWlfQ2D?=
 =?iso-8859-1?Q?b6zWVUoS693140rRFCeeGmJ0RYtJbzQdt6gVphO/Egmxg7smKcbW/LE107?=
 =?iso-8859-1?Q?9myHT/Kx5NYGabWdBIAtBqJiH2SdwytoW+DHlZilcPOZH3s5nZGFllL1Vw?=
 =?iso-8859-1?Q?l+pSMiYRkPXuAW4yxVoIaiPcxf/scy+hHt/bvDXIMw7osuE3BLTakEiHSB?=
 =?iso-8859-1?Q?URW+8tVrjJTQsHYa9/w4fqDvSeoSUhAK+uXA4YufZA2w+OCDEWyhm9n0Me?=
 =?iso-8859-1?Q?vLrut3pyptYTjPBBCPPS8kz5vn6UeipOekX5t7N64xv/4+5C78raF86p2w?=
 =?iso-8859-1?Q?DoOVbg5wcWxbaWtpigb0Slc0FAiwFdEsPQIJ10jP0IowCnKc/Lo+6lrK+B?=
 =?iso-8859-1?Q?Qxz8jupoEJoPGfWOnwNRRaI6oqoOpIUYMzcYGBnsDXf5X04KWxjtyID+uK?=
 =?iso-8859-1?Q?ZeGVRJ+k5IK2lBVShJLC/9n6BMjsx4CD/Wx1SECr/ZjhEHGr1vB9jnukO0?=
 =?iso-8859-1?Q?8pLgALjJSwBBW6Tky0Q8qUPPhCXancdiDFgtVrKFbMrWBkM35GqBx7qB1V?=
 =?iso-8859-1?Q?mH0kAbo2qc0Pu5uNEzlsmYzNBbqsesR9FD57O3dguawSxeS7Q1OHGXTIQc?=
 =?iso-8859-1?Q?T0lKXEOjqrwt+6rBnkXnjRFqOB5XqBPM/Nf8ThaTM5KyjTGGDgZ84uZpD3?=
 =?iso-8859-1?Q?bQss1siGGoJV2CcNF26OvKKpepdBjedfNP9KFW3G+BzWjrvg+Y5u+4AMFJ?=
 =?iso-8859-1?Q?WGdyscygALFpPWq7CsY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0e8e64-fe44-451d-8e8e-08dc22529284
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 11:48:42.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdWIwK10nhhli8L1b8z442hlUzFb3iL/XySY1JouwNbXlsM3H/v4QajSGQ1yew5HOu2COn7ooue2Mo0vhGMzg2HaLwQW4AWWCYA+v0QOB+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5696
X-OriginatorOrg: intel.com

Hello!

On 2024-01-26 at 13:08:19 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 1/25/2024 3:10 AM, Maciej Wieczor-Retman wrote:
>> The CAT non-contiguous selftests have to read the file responsible for
>> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
>> test compares if that information matches what is reported by CPUID
>> output.
>> 
>> Add a generic helper function to read an unsigned number from a file in
>> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v3:
>> - Rewrite patch message.
>> - Add documentation and rewrote the function. (Reinette)
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>>  tools/testing/selftests/resctrl/resctrlfs.c | 39 +++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index a1462029998e..5116ea082d03 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>> +int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>>  int signal_handler_register(void);
>>  void signal_handler_unregister(void);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 5750662cce57..cb5147c5f9a9 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -249,6 +249,45 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>>  	return 0;
>>  }
>>  
>> +/*
>
>By not starting with /** the following will not be interpreted as kernel-doc
>but the formatting does appear to follow the syntax, but not consistently so.
>I think it would be more readable if the kernel-doc syntax is followed consistently.

Sure, I'll change it.

>
>> + * resource_info_unsigned_get - Read an unsigned value from a file in
>> + * /sys/fs/resctrl/info/RESOURCE/FILENAME
>
>"Read an unsigned value from /sys/fs/resctrl/info/RESOURCE/FILENAME"?

Okay

>
>> + * @resource:	Resource name that matches directory names in
>
>names? (plural)

Right, it doesn't make much sense, I'll move it to singular.

>
>> + *		/sys/fs/resctrl/info
>> + * @filename:	Filename of a file located in a directory specified with the
>> + *		'resource' variable.
>
>I think this can be shortened to "File in /sys/fs/resctrl/info/@resource"

Sure, thanks

>
>> + * @val:	Variable where the read value is saved on success.
>
>"Contains read value on success."
>
>(no need to refer to it as a variable/parameter, it is implied by syntax).

Right, I'll change it.

>
>> + *
>> + * Return: = 0 on success, < 0 on failure. On success the read value is saved into the 'val'
>> + * variable.
>
>"saved into the 'val' variable" -> "saved into @val" (since syntax indicates it is the parameter
>there is no need to elaborate). 

Sure, thanks

>Also please let lines in comments be of consistent length.

Okay, I'll keep it to 80 characters.

>
>> + */
>
>
>> +int resource_info_unsigned_get(const char *resource, const char *filename,
>> +			       unsigned int *val)
>> +{
>> +	char reason[128], file_path[PATH_MAX];
>> +	FILE *fp;
>> +
>> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
>> +		 filename);
>> +
>> +	fp = fopen(file_path, "r");
>> +	if (!fp) {
>> +		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);
>
>(apart from other discussions). "file" in message seems redundant. It can just be "Error
>opening %s". It may also be useful to print file_path instead of filename to be specific
>of what the code tried to open.

Okay, I'll change it to file_path.

>
>> +		ksft_perror(reason);
>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, "%u", val) <= 0) {
>> +		snprintf(reason, sizeof(reason), "Could not get %s's contents\n", filename);
>> +		ksft_perror(reason);
>
>filename -> file_path ?

Same as above.

>
>> +		fclose(fp);
>> +		return -1;
>> +	}
>> +
>> +	fclose(fp);
>> +	return 0;
>> +}
>> +
>
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

