Return-Path: <linux-kselftest+bounces-2741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB9827AB5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7431C22A00
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA114002;
	Mon,  8 Jan 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6DJeXiE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685632904;
	Mon,  8 Jan 2024 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704753532; x=1736289532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AL8AKnUF3CBSP4ELOsIv5Bg/xCrAU5ACjXJscrmdWCg=;
  b=G6DJeXiEpSqM7C7EsVy9Gqy7ivP4TcwPJkXKxMwIHVdSJHxLNbVpA9fr
   b3ma5XUNoGwy4v5uQ2BV1JEPwhQESgg2WujYBlX8wr07mnHZZRzUGtI9R
   /ewrzyx7aH19M1bHkZcXqYbZfKRrLjLXfzu00DvYTvYdgM+n24l0058m6
   E3RCRtkpQiqM9NQDQ7ljTEAb/XA0zPdimo4xRUQ5EFgGy9bQxuVEBY1rg
   1JjY+eEfg0mdDOPkqFz41LYFe7IwFiramauM3fFmZPMvafHjdwJREDZKC
   x2fsXaxK5mharL0UuqTFRtkXSa9mGYaIsgP+MS5Sl0jSiMronYzdurBZo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4781042"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4781042"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 14:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="29943716"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 14:38:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 14:38:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 14:38:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 14:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdAqb1PPf2DUeHNSqjLSNGNCaCDMWLa0D+VBZzGUS5XxiTtxF/0RpI6wvX24wvhBKwHX6OHZjOpcHHbWNw+Q2VClkU3Vfl0eXYG8LRgkFMBN6VIIKUXFR+wnkhzX1q9AxFJ9QqCOVPSIu/sogj6ThMOgVTFpQB01IogL0COPNPTQcBJExut/L7o9wYbBLyqbOn/IXYhJL7LJ4IYNh194T7A6aO/eiJGvuejiQUM9p2sOh/BQjNWj4BOfntEYXy2bs6zGhfWKn5O7PnZ20HTvJoNzwKyfEJMnXMYOisvklR4T52DTefkI+u+78WpSlaUvIj7VxgZqImmpJ3HoOdjnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blg9IHLpJx2SiabwyJaEfxg1KvRKtXrXTXdgZDRIqZQ=;
 b=JMXzSQ/Su+PN7AI7HiUey6V4l60Jgf3xiXNsVsnBAfGRpZ6zwKGzSs3k89XryskrGHvKHHda/Q1kKFTZ4KMSJ4sh0LhMRGMrZ9iRfb5B2XfDLKKfWtvi/NU1Fqs8d3ubRSX2cNC9fwuBOyKNUDlnGE1551vn1xwHNJnE3U/MrM/Gqt8a5eYz5MMu668oD0waMljQh3O7nxbh95/r3MBXinU483KfjaeWauel/vZJRvtZssPHH7MEvKzUlcpgdQP3ggr3o/Xplsi67N62m8xRemqISp9hwwO6fcbw4qBlIqAizI5RIjDNvgSxPWP0MqE9TuZf2kjXANRn+h6yr0r6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4935.namprd11.prod.outlook.com (2603:10b6:510:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 22:38:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:38:47 +0000
Message-ID: <64b6767a-201b-4c61-98e9-f01aa271dd33@intel.com>
Date: Mon, 8 Jan 2024 14:38:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Split
 validate_resctrl_feature_request()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>
CC: <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
 <d6442103165be849d32585e861fc2850f7c4e8ea.1702392177.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d6442103165be849d32585e861fc2850f7c4e8ea.1702392177.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4935:EE_
X-MS-Office365-Filtering-Correlation-Id: 471607fe-8259-43fd-0f82-08dc109a93f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFUYyeuRSoApRmrv7Qsp03tRDZLtlKOsQcDmZXqmy7jMxhBuq6VPtySstf/HMkwGYz66/F1accOoIR9VyMrTTpSGRV3Tx9JwfL0K67sxTU00j3toPD8LtSQNANbaIZyBp0gRyjq8eE2EOLd1Vks486xpOeVSG3pW4v4hNv4lLpk8Hf3HrNogtpjASH9EA4Lp40xVL4RO6gjEzhs+GuDEaZVqBmPyyD9qvz2eZ6o2ixBnSLYNjozKL8lpov5OULLV7NcpbVnClJk8wITDDM4VEPCIOvYZC/FLNEWAEvRJpxD4/s60bi8E9s2NLVJmUIXv/nmscfxwekMaKI8JpJdBWjTCmJkfGxGiNw826j69FWccJCq60W0fzQXeD8k6T/30qBJ6yeTPshUX9DsNghO1+BwRnsF17pN4VtsnHO3iihyumWrw/w544VZ8Yod4cvfGmI+O87+X4TTa1eBMTzu6EUffUjkWsyffcsIAlzqZrLtHWoxyVAIPYkfCvHYuCeTs4ftZZfUMP207fBNz8TeMwUgT5PMkP3ozgBubeelYdJD8bEUnKpigQ4C4SgL3zFJOcdqrOssrcuzjpwdNCXqPe6LGM4Ru/V+EBPYuD81P7aD8qi1Od6RZ95nI68hqIUS1g9StCkYollxRa6cMizqAHBKKEe+vV6kQ4CFDoDBnsGXiGbbLbzlatkuMOmh1aMbk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(82960400001)(31686004)(2906002)(5660300002)(15650500001)(110136005)(6486002)(36756003)(44832011)(53546011)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66476007)(66556008)(31696002)(83380400001)(26005)(478600001)(2616005)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBTSmVBMTdjWE9sU1BtQ0k3ZkluMys2bUVVbmZtSGUxNm9QY1dIZDhxdzBV?=
 =?utf-8?B?NC9oWVFTL1dGWWtHTVdZM2pOK3pOVldjNUxQUzhiQngzUlpYTHZlYnArdnlh?=
 =?utf-8?B?dUNTTVNTYmM2S3h3UmpEU1ZTVDNPVzN4M0ZhcHpQU3NxV1pvRVZOU1ArMVpN?=
 =?utf-8?B?QnM4K3VHU2M3SWtMT3pabmo4cDZlcWZrS2JXUTBBampubFJBeWg5RDhCMFpp?=
 =?utf-8?B?a05uZEdTNzNRNklVSHI1UUVqOGVSbXZSNEtvc1ljd1ZDb2twSWpQejZyL1kw?=
 =?utf-8?B?UTRVdk0weFVVRVFaMTdTTXlpU3BUMTYraWRHanFJNFlvMGVNNlEwendpb202?=
 =?utf-8?B?blpyZWRsUmtqS2lTYkp0czlpUko3Q2xYUi9PV29oamgvcVNJR3pDOUphVXp5?=
 =?utf-8?B?Y0czWlNjemJiTFlwb1ZUYXFOS0l4NmkxYWhMa2FTN1hFa1lrQ0tPMC9aQURS?=
 =?utf-8?B?YWIwL1JQbDJjdy9VNFM3NHEvemZFMlQ2V1l6YTd0QXpKb0p1Z2tTTFQzOEpp?=
 =?utf-8?B?dEp5T3YwckI3ZWFnTXUwbFQzeWI0ZlN6TkdwQXU4d21ZOXhpY3FiNnh6TWJX?=
 =?utf-8?B?OWd2dFowbldySysybjd3YTlZRllyN3NTdzcvU05EQVNOdHlEeWp1VDh0RFdX?=
 =?utf-8?B?Tkl5dU1uLy9QRnFaQnFPa1FtOUlGODc5ZUxJbTRoaTJHTjJLQlY4aXRvZnhh?=
 =?utf-8?B?aWRGZWtzNWV2eE8zR2RwbGhiR2piK256VE1aM1UrcnYrMGNyblJXVzFIZjJv?=
 =?utf-8?B?SHB0NVdUNURDS3FET01SMW14YmdqdFRpaERwK2VKSSt5eXpzM1VIMWIzS2pu?=
 =?utf-8?B?K0dtd1hBcGVqL1JYQ2wzNjUzeEZjUG15S0g2SFVDb3VCdmNyanFLOXMyNVFj?=
 =?utf-8?B?dWtUZHJhTEJ4YVlmcEd4ZXZBN0dCN0RjaVQ0ZE9pV3pmSjFHT3hBcytDcGtj?=
 =?utf-8?B?VmF2TXUvNFBTbkxTaUk5K0tDajJjL0FyeTBoWTFYUDhDb0l6OU9Uc242VW84?=
 =?utf-8?B?OFh4MG9maHlQWGRnQnRiS1NJSDE5YnhtZWJkNDgxb2dqSmxwK1p2RmtFODI0?=
 =?utf-8?B?eVQ2VFlUMVZtNEF6Q0NHa1VTUURDb1EzVXIxOVIyeWNDUURxRktmWmNBWXdR?=
 =?utf-8?B?eFNNSGx1TmxqVTZEN1BFYTdNOVA5MjFYTmxXRGk4MzNqeVArN2pHdU1iZFdL?=
 =?utf-8?B?VXVrMmlsQmZPakRDaDBJS3dHVDg1bEl0VHh3bHB5N24yZEhubnI0ZHRIUS83?=
 =?utf-8?B?azhYMDZkODA2YUFTcmZYd0hiTXlKcndVc28wOTlMQXNlOWF3SEVWazkySWhD?=
 =?utf-8?B?QkRJR24vN2NpRTFuTkdLZ1lNSVlkOTM5VDRicjRZYytuQ2VLSkFIV2JVQitW?=
 =?utf-8?B?Q0JzOUNjR1M2U3U4UmNldVhiNXExNnZJU1pMUFdBZXZJRUEwMEN6T0lBVUlq?=
 =?utf-8?B?RnVmL0ZhWjAxMUw2QWNNU3VGR3kwK25TVkJEOFJIQU5VSFFoQ00xUWlDMzcw?=
 =?utf-8?B?QU9uYTBXaFBGUUQycVNmRk5ndnJFRCs3NUhuQUhlUjdISDJmcmxQOW1IbHl0?=
 =?utf-8?B?QmtJRlVpY2FncUVUNkordTBJMDhha05Ib09nb1YvTVhkNXZpUmk4U1pOSDg0?=
 =?utf-8?B?S2RsOHNyQ3pObzJFRFJwTEwyRDNUNnQ0RHR5Q3dPSnAxQmVsQ1FFZkFTUFJr?=
 =?utf-8?B?Kys1QUkxT2xVTjVBUTI1d0l1Q29ONjV0YzFFLysrYXdqQURINE1sUXhLV1VP?=
 =?utf-8?B?cHo3Nmd3WGdlSGsyQUpkMXgySVZiWDdsbXlpWGVMSEFha05XSFhqODNnRWRP?=
 =?utf-8?B?enpvcXBvSHo1Y2k1dmJjbzB4aW1VdVNDemowQ3crcFhsRHFFbDBvSHQ4eFlM?=
 =?utf-8?B?a202SWVQdm1MYkx6K1M5Z3A3WURxRGVOU0xFZ2FaUC9xVExuL2hvMmtLaTNa?=
 =?utf-8?B?UXlWeU9pamRvM2pJSkdIWnpKcTY4QVZsQy8wUXh3eWZXRWdBSlh4enY4ekVm?=
 =?utf-8?B?c3NWZE9XcmhFZm4weFRaVzZtUVR5ZHY3UkdGUlRKMTQ0SHUxVEp0emVpT0VB?=
 =?utf-8?B?WWdPVFpYTzNWSjRKdEs2UktMamxGUGExdUU4TUZFWEEzTXNKaE5yYzNsdWJT?=
 =?utf-8?B?b2JSR2VGb21uVDJiVVkwR0cwc0dEZ09NT1JRSEV2VG5KZEQyaXQxR0ZxREJ2?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 471607fe-8259-43fd-0f82-08dc109a93f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:38:47.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nGc8LJjpCyK35zrePciFKjSqLf4ZkiRi4u3xFmwtzQEA2menLiKFonQ9BAlcsnKuyEAr3v0UC1qzITgTVIwD68K2IvstexL0tKVVbKQLMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4935
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/12/2023 6:52 AM, Maciej Wieczor-Retman wrote:
> validate_resctrl_feature_request() is used to test both if a resource is
> present in the info directory, and if a passed monitoring feature is
> present in the mon_features file. There exists a different way to
> represent feature support and that is by the presence of 0 or 1 in
> single file in the info/resource directory. In this case the filename
> represents what feature support is being indicated.
> 
> Split validate_resctrl_feature_request() into three smaller functions
> that each accomplish one check:
> - Resource directory presence in the /sys/fs/resctrl/info directory.
> - Feature name presence in the /sys/fs/resctrl/info/RESOURCE/mon_features file.
> - Feature file presence in a given /sys/fs/resctrl/info/RESOURCE directory.

Please present refactoring of existing code and introduction of new
feature as separate patches. 

> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Added this patch.
> 
>  tools/testing/selftests/resctrl/cat_test.c  |  2 -
>  tools/testing/selftests/resctrl/cmt_test.c  |  4 +-
>  tools/testing/selftests/resctrl/mba_test.c  |  5 +-
>  tools/testing/selftests/resctrl/mbm_test.c  |  6 +--
>  tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
>  tools/testing/selftests/resctrl/resctrlfs.c | 59 +++++++++++++++++----
>  6 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 39fc9303b8e8..7dc7206b3b99 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -1,9 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Cache Allocation Technology (CAT) test
> - *
>   * Copyright (C) 2018 Intel Corporation
> - *
>   * Authors:
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>

Some unrelated changes here. 

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index dd5ca343c469..7b63aec8e2c4 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool cmt_feature_check(const struct resctrl_test *test)
>  {
> -	return test_resource_feature_check(test) &&
> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
> +	return resctrl_mon_feature_exists("L3_MON", "llc_occupancy") &&
> +	       resctrl_resource_exists("L3");
>  }
>  
>  struct resctrl_test cmt_test = {
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index da256d2dbe5c..ecf1c186448d 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -170,8 +170,9 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool mba_feature_check(const struct resctrl_test *test)
>  {
> -	return test_resource_feature_check(test) &&
> -	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
> +	return resctrl_resource_exists(test->resource) &&
> +	       resctrl_mon_feature_exists("L3_MON",
> +					  "mbm_local_bytes");
>  }
>  
>  struct resctrl_test mba_test = {
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 34879e7b71a0..d67ffa3ec63a 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -97,7 +97,7 @@ static int mbm_setup(const struct resctrl_test *test,
>  		return END_OF_TESTS;
>  
>  	/* Set up shemata with 100% allocation on the first run. */
> -	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
> +	if (p->num_of_runs == 0 && resctrl_resource_exists("MB"))
>  		ret = write_schemata(p->ctrlgrp, "100", uparams->cpu, test->resource);
>  
>  	p->num_of_runs++;
> @@ -140,8 +140,8 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool mbm_feature_check(const struct resctrl_test *test)
>  {
> -	return validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") &&
> -	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
> +	return resctrl_mon_feature_exists("L3_MON", "mbm_total_bytes") &&
> +	       resctrl_mon_feature_exists("L3_MON", "mbm_local_bytes");
>  }
>  
>  struct resctrl_test mbm_test = {
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 8f72d94b9cbe..74041a35d4ba 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -135,7 +135,11 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
>  int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
> -bool validate_resctrl_feature_request(const char *resource, const char *feature);
> +bool resctrl_resource_exists(const char *resource);
> +bool resctrl_mon_feature_exists(const char *resource,
> +				const char *feature);
> +bool resctrl_cache_feature_exists(const char *resource,
> +				  const char *feature);
>  bool test_resource_feature_check(const struct resctrl_test *test);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 70333440ff2f..8546421f0940 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -697,20 +697,16 @@ char *fgrep(FILE *inf, const char *str)
>  }
>  
>  /*
> - * validate_resctrl_feature_request - Check if requested feature is valid.
> - * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
> - * @feature:	Required monitor feature (in mon_features file). Can only be
> - *		set for L3_MON. Must be NULL for all other resources.
> + * resctrl_resource_exists - Check if a resource is supported.
> + * @resource:	Resctrl resource (e.g., MB, L3, L2, L3_MON, etc.)
>   *
> - * Return: True if the resource/feature is supported, else false. False is
> + * Return: True if the resource is supported, else false. False is
>   *         also returned if resctrl FS is not mounted.
>   */
> -bool validate_resctrl_feature_request(const char *resource, const char *feature)
> +bool resctrl_resource_exists(const char *resource)
>  {
>  	char res_path[PATH_MAX];
>  	struct stat statbuf;
> -	char *res;
> -	FILE *inf;
>  	int ret;
>  
>  	if (!resource)
> @@ -725,6 +721,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>  	if (stat(res_path, &statbuf))
>  		return false;
>  
> +	return true;
> +}
> +
> +/*
> + * resctrl_mon_feature_exists - Check if requested feature is valid.
> + * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)

If this is intended for the monitoring resource and L3_MON (per below) is the
only valid resource then @resource cannot be all of the examples shown. Why is
the @resource argument needed?

> + * @feature:	Required monitor feature (in mon_features file). Can only be
> + *		set for L3_MON. Must be NULL for all other resources.

Which other resources?

> + *
> + * Return: True if the resource/feature is supported, else false. False is
> + *         also returned if resctrl FS is not mounted.
> + */
> +bool resctrl_mon_feature_exists(const char *resource,
> +				const char *feature)
> +{
> +	char res_path[PATH_MAX];
> +	char *res;
> +	FILE *inf;
> +
>  	if (!feature)
>  		return true;

Doesn't this mean that resctrl_mon_feature_exists(NULL, NULL) will return true? 

>  
> @@ -740,9 +755,35 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>  	return !!res;
>  }
>  
> +/*
> + * resctrl_cache_feature_exists - Check if a file that indicates a
> + * cache related feature support is present.

Seems like this is not really specific to a cache ... it can
check for any info file related to any resource.


> + * @resource:	Required cache resource (L3 or L2)
> + * @feature:	Required cache feature.

This seems to assume some usage of this utility. What if it
is, for example, resource_info_file_exists() or resource_info_file_readable()?

> + *
> + * Return: True if the feature is supported, else false.
> + */
> +bool resctrl_cache_feature_exists(const char *resource,
> +				  const char *feature)
> +{
> +	char res_path[PATH_MAX];
> +	struct stat statbuf;
> +
> +	if (!feature)
> +		return true;

resctrl_cache_feature_exists(NULL, NULL) will return true, no?


> +
> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH, resource,
> +		 feature);
> +
> +	if (stat(res_path, &statbuf))
> +		return false;

I think it will be more robust to look at statbuf to learn if the file type
is correct and the file is actually readable.

> +
> +	return true;
> +}
> +
>  bool test_resource_feature_check(const struct resctrl_test *test)
>  {
> -	return validate_resctrl_feature_request(test->resource, NULL);
> +	return resctrl_resource_exists(test->resource);
>  }
>  
>  int filter_dmesg(void)

Reinette

