Return-Path: <linux-kselftest+bounces-2740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD1827AAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 23:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA088B22FA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F12904;
	Mon,  8 Jan 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lseMbwAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B781E48B;
	Mon,  8 Jan 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704753409; x=1736289409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xljyjkrHcYtSGEbsNY+S4UCsIMUV5PRvvhOBykWmwNM=;
  b=lseMbwAbkUMUDCSPgfbnZ44w1xGbKpJNbSqatGsWEywwNTw6J+Bv2hao
   mLKquem3evHF1hZ9oO6JRF6wMC7k0a49HOn68wAuTknmCoPj6+hjkl7FJ
   LMV6hHWYGH40WLGauEeTP4AMm0CTkWYemGRcE916SelZp37un0PDAoGSZ
   vdNoQgWq5a1MdvSfeL/WBuZGAYOGoFGRH7i6/Qz0brBEfZqKK1mCupGVA
   +Nd7qd6L3Wjr8P+Ln9PAFQCSLOydM1ycjNbwjVG+ro6G1+d5FUI6IbA+C
   V2nQcPxd8BOL9puLz+2rXK+pRhOzm7yNRC6T2rnWHsmnfcQgzAZnDVlHo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4780683"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4780683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="29943152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 14:36:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:36:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:36:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 14:36:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 14:36:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2lxNhFoOz03+hLpUEfnwSTyHVb0LlrxfY6NGS6DN3TD6b2pS7Wo0rKpDJochxtmikl1h19axa4eDdXVc1QXUk4uDo0IhFHoigYVzHMWJMevfT9/jn6VtgoXmXb1QWhS9xV0tcWIDNXLEvl1WivEP5FX3DJhcyVHZkXNhd8oVFgEHMB/+pMIwY+HXfqexGJJOc8um5l7590BlJ+iriQHJKei8g489ilh+33l49HdxCaxGGU0G+uq7/4m3iJT0dL80zhtcXxwbm3dizHgU9V0rR6r4GAgSzn8TZkJR365+ZLDN2huqO8FOB0063xlKqct3NsIS0dMkX8Ags/qWj7B2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnvKIBaNq8D1GBxnGM3qm0WXYeY//XWKQSzgZE/7618=;
 b=HFyhU6mTvddtm754PRzFLlL49oZziZ1LXARidZ7PXoEP2Y7xOI6ah2U4rkETNeuPqyLY894N0jdiHaG8cdTvzQVZHjxr3IPU7ijmu6KzODf3nj+KE+ZxG9FzNG74nlEw0dSDi7Y8w/JPqHhpzeaES9sKnp26D6UOCfFVwvxMDPVNaVcyZ+lnUwBGkX59hhHpn+se1fFX/QVoAEc7oWnnMmSC2SAoObgyMTsvSoDarSWR4PQ7AqGSd+3gx9yOS2TpKEb6lGi+eUxhCziJxo5uWasMe32NgPGE/FCv3UUHU1WTx4xGGWYny+OW6MwPsboS8BybPOMgw5fqo/QkCuPc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 22:36:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:36:38 +0000
Message-ID: <ddc900a6-7337-4721-ab0f-917c32e917ff@intel.com>
Date: Mon, 8 Jan 2024 14:36:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] selftests/resctrl: Add helpers for the
 non-contiguous test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <c7b66a4682829894ec72d8a1f78e324233ef0535.1702392177.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c7b66a4682829894ec72d8a1f78e324233ef0535.1702392177.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e54ceda-c7ab-4f1e-1780-08dc109a4729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7s9qUNN4FeMXhrw/q3YJjdcqDRwKebntoQ6tD9j0SkNa9n3Ugi+ZF4ISMmNEEnWz849bo9+eFXRkZJ3ehSUszxfssKDqULf2Z0rOvrbIm241/M8OMVmFJeoh3GrSoAfK125IR4wRFTtL33Avs+gTvkD1Gek420TicRovxZ9aL37gowGamn4LqrhhTg7cGvBPaQ2uxL0/ANVlbI4lWoZ7HBZghP2u3k6zLDkqKg27Eh+5uRbDZHOloEFj738E4bmhfybjE/JLrydT9u8us9hbjEN7VjkY0Rg6AJZdijSS4df670yQHAGvKvCNObTGWDlEv5AY1I/805rxGnBcrH5ocb6IvJ9ytOYGKI9IfVLZ81PCKDQa2dkkUaQHGypX+JL+JIAKhEEwGzrQz0Gu2bZ462L6vcGUmrDhpk0zmzkDmgSHz44KlKTLbM6wP1zgT4QUXSuYhkCFsJFDSAPVGc+CgyeKr+ZRIfg5GP3hmY0kgP1S1368O6mNobX2JlYunJ5WvM+JvB+XgQmXBjN5AtJzRwjkULsLXxLQLt+tkfN0A13F596rvewerfmVN0dH98yRfZQdIbdqM400iq67cCh+PK7f+4JsWA5+SOfjqMYHb+uaq8lWekQSjinlH2+a2EqazP0NfQjbbHZmRPmdPmvWn1eisam5kzQQBREAg8gS3d9EeHxxGEY7i9ZFBgmDUFz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(2906002)(5660300002)(82960400001)(86362001)(41300700001)(31696002)(31686004)(316002)(110136005)(36756003)(8676002)(8936002)(2616005)(6486002)(66946007)(66556008)(26005)(66476007)(478600001)(6512007)(6506007)(83380400001)(53546011)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkwyUUlabXZOOWdhR2pDaVJrOWE1d2JEMG8yUjVCMTkxQm9oUGFmeUJacmxI?=
 =?utf-8?B?NmswaEpPYXVHa3ZmN21TSnZRZnEzRXJxbTRaMG9ITWRMQnQ0OXlCZkdaajM2?=
 =?utf-8?B?eXE2bGdOaHVmVFc0TGFWbGJRSnFxZVZ5dDVYaVBNeTFESzhndFUreEc4eTZQ?=
 =?utf-8?B?bVRHVE9wVjlJRSthSHp4SzBSVS93eGFKUnE5ZmpmYUp0ckxsMzJXZEI4MUg4?=
 =?utf-8?B?VlBaRXZxS2RjVi9CYkt1SnVtR3pDdHE1TnN0SVZTUmk4RlVFcDlmUGMvL08x?=
 =?utf-8?B?U0FWQjZyRzA5L2pjNGdEWG41WDBjZnYzSFZlMURPTnpMSUFMcTVrUGpxODlZ?=
 =?utf-8?B?TkNDelE5SWNVK3lUNWNGTzR4bGdzZUpvby9uSDBCTlpwbTlxblA0ZmdJVklv?=
 =?utf-8?B?MTQ0ZWpzTVZ2TWNKZ0o3b3IwSWZ1Umhsd0gwVmZpSlpHOE5ha0tPSFNzU25w?=
 =?utf-8?B?SEZpZ1NjQjhHRHUyb3NaR3B5Y1Zzbmt5OHlYcytQaE9qTGI5ckc5cWVRSTRC?=
 =?utf-8?B?bHp2T0JSdk9ISWkwSUhTdFRNSVpLZnZWa1FkZmFoSjE0cmNyb3FjZGYvVDBI?=
 =?utf-8?B?YTZTZW81aEVMTlpiUnNjdFlyTTZjT3Nzc0ZFZjlkYTJHaFZLakRqWEUxRW5T?=
 =?utf-8?B?ZmxFSkt3bmJNbWF2WTJiSmFFTStSRTR4UmVIcm1ORzVDZTgyWDNjSzYxeWJ6?=
 =?utf-8?B?d0thaUMzbi9qQTU1TytLejZ3SzM5MUVXblhpSHRJbkd4dFV3ZVREbGlxZnpW?=
 =?utf-8?B?TXliSTZqWGh2K0hCdkFYd2RVNE93cG9XQW9TMVR0Sm9WcGMvc1FVbTVndm1C?=
 =?utf-8?B?OU81bDFLRHB6bjNoVGgvRkxsNkZXZk8vVk1pb09RRUZoQXRtYTIzOUZMVlZ4?=
 =?utf-8?B?SHhONnB1dXBJdVdvb0dHcFVKUEpDcmVmYStsVDE3ZUxBOVhKbVozRG00dnNM?=
 =?utf-8?B?dFBncmFJWE5PWmJHRHF0bitPd2dUZHVlTU1KU0JMd2dRTy9zUHRPcUNxL25x?=
 =?utf-8?B?YWk1RU04a014QTRMVmtqVVdBcEU4MEJIQThkN2pqQmEvdyt3TEgzSjk3dVY0?=
 =?utf-8?B?cGVxL1ZBejdPdVFCMEZhaDkrU1ZEMngwdEZmMmtsb1c3TmJzQytZeVhnZzNZ?=
 =?utf-8?B?enNGOUJiWUdKYnRYOHpvRStONnBVUGh6aWZxWi9LSUJaYVZuNjl2ZXR1N2N2?=
 =?utf-8?B?N3RKSFhFS2RvNWpTWjRNMUF2cHE1RnVyYWZoaVdwUmdUUERxeTl0anZlaFBu?=
 =?utf-8?B?R1pYZzEzZkh5anVsaENEeFhRT3FIYUZENFlUSWNUVmZWWk5SZll5emZPVUZI?=
 =?utf-8?B?ODFld3FGQWVNcmFhODF2eC82QVR5UnVock4ydDlwSVg1RlY5MzRLcEVjQ2oy?=
 =?utf-8?B?S0xwWHJiNnlsbFV2dUdjMkNMNXB3M3YwOXd0NXZMV1FldXhRQ1lHK0hzdmpy?=
 =?utf-8?B?Q24vK0J4R0Nmc3NMMkRjRkd5L1Z6MkZBOWRZVG50MkU5UlNBbjJGclZ1b0h4?=
 =?utf-8?B?TmpKMDZQN1FkekdMM1d5MlUrVENhOWMyTFY4Mks5TzVMRXFDM3c1S2RUc3NS?=
 =?utf-8?B?bThSeHVQZnpORFhOTW83WjQzMk42cEN0NHpjK2tYNVo0Snp3dS9uSUJ5SXlQ?=
 =?utf-8?B?cE5ORG51OElWeFUrbzJHZTZ4OUpBQjY4a0dIZEJnV1VxS25STVZmSzhoQXNW?=
 =?utf-8?B?TzdpSllsVGRSNW9kWUNvckRCOTZkL25zSVhXaXdJUUJ3N2lkbFBsNlVYazNG?=
 =?utf-8?B?ZWsvNDFwYXdmNFZ6bXhtZE15K1YrNnMvb3dVcG8yL2JXQ1JxWGhZU2pRTnB6?=
 =?utf-8?B?TTgrazZ1UEJ2TlpqNnJxZmQ3cmdDOWdOeUdpNXBlSEREOTU1QzdLQnZLcWp0?=
 =?utf-8?B?VXBqZkFXNVFBekZOOEtYS042T0VXQng1ZDcvdEt5N1lyMmxTbktLU3JUM25G?=
 =?utf-8?B?TDlRM0ROZmhmNWw4TVFIY0M3WFRlT2FyeEVXMVg1TWwvS25PWGdjVittU2hI?=
 =?utf-8?B?RExWWStudlRhVW1sZWphVFpNb2JuK2Q1eUV4dS9mL1lqRWNHSGk4dHEvZnM2?=
 =?utf-8?B?Q1J3dWlqam5menpVZDBDR3lmNE5sdUxyRnlNaWFmakJGbXpvejZRNFhFVXJw?=
 =?utf-8?B?bXhsM3R3dmhTSzRSZWZ0ejM1T21Gd3FCQkpwV3VkNWVkeThZWG5yZW8xelVL?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e54ceda-c7ab-4f1e-1780-08dc109a4729
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:36:38.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stTTszMmRQUEnZdUKlRBjDjN/7yuKak9NzxO8J1qsJ8o7XZ627QOC5JeiHmOEF47Onb9/otZMIkiOtz61gSyMWv6rg/JzcBNR8+Yr15FBL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in Intel CAT. Then the test

"in Intel CAT" -> "in kernel (resctrl)"

> compares if that information matches what is reported by CPUID output.
> 
> Add a generic helper function to read a chosen functionality support
> information.

Since this is a generic function that just reads a value from a file it
cannot be assumed that the value represents functionality support.

> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Added this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 739e16d08a7b..8f72d94b9cbe 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -161,6 +161,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
> +int read_info_res_file(const char *resource, const char *filename);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 0e97036a64b8..70333440ff2f 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -249,6 +249,31 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>  	return 0;
>  }
>  
> +int read_info_res_file(const char *resource, const char *filename)

Considering that this is intended to be a new generic utility, could you
please add some function documentation?

> +{
> +	char file_path[PATH_MAX];
> +	FILE *fp;
> +	int ret;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
> +		 filename);
> +
> +	fp = fopen(file_path, "r");
> +	if (!fp) {
> +		perror("Error in opening sparse_masks file\n");

The error messages do not match the goal of this function to be generic.
Also, please note the recent cleanup done by Ilpo to replace the perror()
by ksft_perror().

> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%u", &ret) <= 0) {

I find this to be potentially confusing. The function claims to be a generic
utility to read a value from a resctrl file ... but hidden within is that the
value is required to be unsigned, which is then cast into an int. This could be
made more specific and robust with something like below:
	int resource_info_unsigned_get(const char *resource, const char *filename,
					unsigned int *val)

The return value will be the result of the request. If resource_info_unsigned_get()
returns 0 then @val will contain the value read. 

> +		perror("Could not get sparse_masks contents\n");
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +	return ret;
> +}
> +
>  /*
>   * create_bit_mask- Create bit mask from start, len pair
>   * @start:	LSB of the mask

Reinette

