Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17B7DF940
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKBR5p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjKBR5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:57:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8623134;
        Thu,  2 Nov 2023 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947858; x=1730483858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D18QASxgavWJUkqeEG1ZkgGiV8xduulxsyNWzi9gMf4=;
  b=n7xNCaUX8RwZ5cU6B0x3p4H2Kgky5G7t6UCrL+E3/Ttg+JdEr/0kQLH0
   WFhAZbOiOJucX1X9C//SUbrwKmriTcbhGw81uO9vVgvYMdugvNkq6s8Rx
   M28A+8npKNYI1Duy56Z9GGQtIEAcNMI3skEOOppWe1lbVI1mfdaxB8cFq
   8DV3PstZiq1X/pZIP6yP24jjw+/a77YWTzZmkd/P1WHbMVd9s+MHxOHK/
   AAyBMVrdnfvezOhfLtg3hGVvsGSJdYwOyxgUNK6mcYAsAKCpQrGxImmLr
   t0aN4BwklOmeJmXw849hq8tJhn2cqg4RRMDt22zsE/sxUjJxsNWDkW8Nm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="475021748"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="475021748"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092798006"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092798006"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:57:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:57:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:57:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR1en6gvE1QC5wEu2P2pTYH4gyaJNqFzTbJFbfK7me9rdCk2SEXr9rKqes+xUx8Bz0WUWUBiE2I+5qU2GA8MmwKY+Uch18Y8dQgDQYL1nk0Tbs9c5lNxTvMZszu6SEiuIKmTO4yoJ1IVu6WazQgjH3Ar4mry/Heu5i2qcLH7x+QIRMX8NiCpLqadqAY/k4WwHW0MnZgo5gCsvkUUkBH+ral+/4sZo/Sl0Xsk5baA5tEdRsDwHbIVPWQYhIuCSfAdI5LvV6G4z9fI26QijYWZhChh/WcWwDryhc+ZQ95WJT/xLW/IyNDbilKFZBvxNvwZ6I1KBi/PxHepY/2xsd+p3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb/MJk4WON2SU77gc1dv+suZMFrI/sk91UI+cU2CwHs=;
 b=L42bFvq4izvPqT8jNvICWHOpqJsbMwCcL+nkl7cJaTXNmPBRzPVJEiKNrVgxYR8T4tGkwHG5SAvA7hHZE5ygu824lOemJ70QJVRz3qKFTZfQERMZbVU8ejeHbLsViX9cm9LKDhKatLBvAWAZOEmAZ42wOGdtXYQl8K8m84nhsP4AJiVfnf0EVWhcCuGp/pxIjyvb2mDWytZfRL5NGmZ2v7GJ9DX4Q1rSUHQSbjy4XqZwBzGcgGxgKHO9RM6y5ud6rp+pdb4MhIlcnghgaMc73SNj9AHvcBkp+Xw3QlJv/tRasbFq1a6sDTDXwBJm4ts6QqmJq+PWQELlbqe/Sc4VOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:57:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:57:15 +0000
Message-ID: <8051f3ef-1126-41fb-b6cc-f48441936dd7@intel.com>
Date:   Thu, 2 Nov 2023 10:57:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cd6839-87fd-4c55-a8b4-08dbdbcd259e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeiiLkLba5RFQPBcRrOgkdMcT3EvpwCQSaQCNS5cM0t3K2pdfJ+ww69P5JAO6azuLwfwHE7ckdz2wy7Fx9LzaMRoryc8Y0iDzLy9+KE0dj4kyqT/15LCJpTdvz33YCRDXwyBVvjIpFm2I13+ylu+zcvQQ9cX+ZITbbJxGnyn3tMczKOjHlhQ8HJtCXyzEEytqIvlPmIHkbAzsD0bJJLrTz4qG4OJjGoqv8A11qdsUR6W9zx2bV2rc6U2swuY43iRXBZv4efhkYi3h9Tg2u0uevyF/e33rDbVwDnxu2oI+bbYtrOk2H6mR+L9T+UE6mliKJRuk3Vaz3CfcLNs3rWiTJXWTFqmJfb1KwmRnCzAEC83goWee7ugSX94WGsxrrGZu1GC1/uQVGWUZS2JWTn685v8gUxtQ6g3/QTQjtrHBn54zPnE4AxfNMP7bbJVc8YfWzgBfhjOnXTEbjeYP8vxkE03kItqm/RXnN7I62Z6PH2Wab57Krcol/fFUTSTHt9QzIoyvdGfD241AhYdtmiGajwjNmPu0xXgpK6LQYYm8vlc1ruTuc5CSCehgicj2P1Qvh/d+nuviIrFh5QlZKQOZYmijENvtlS7DhyDjpuUB0w/+EimuqR7XbRXV/NK1Pefs4cV81ucBEyyRdVbMkQGUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6512007)(2616005)(6666004)(478600001)(6506007)(53546011)(66946007)(66574015)(5660300002)(41300700001)(6486002)(316002)(110136005)(66556008)(6636002)(8676002)(83380400001)(8936002)(26005)(44832011)(2906002)(66476007)(4326008)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXp3TjRTdTRkbzdNWTdDQnBMRHhkZHFXd3MxS3FwWm0wSUV0U2lqWHlOWFZO?=
 =?utf-8?B?dnoyQXl0V0lhZGg5ZlVGZTJqNjhnNlBYOEF4UllYSThxMnV5dnR5ME54Qm9m?=
 =?utf-8?B?d1YvYTlpOHJoaHdEVjJLRHNrZWpGYzRLeTNZUWFiOHBscEVRUDVYUkhiNWEy?=
 =?utf-8?B?azNPd2hURE44QVZWYWtidi9VL2JEL0k2NFU0N0JvRE0vZUFyNkJ6TU1Wc0lU?=
 =?utf-8?B?NXo5QzhyL05DOVlWYTZKQlpsM0V1akh1bzlEa3dLbFc2citEVVEydmFRemhK?=
 =?utf-8?B?REJZZGFiNUtia0tIa3d3ZzJBbUpsRkY0Z2k2dUs3TjR6Um11ZUlhTU9sMENh?=
 =?utf-8?B?L3RHbWZDVlJaRm5jOVRFV3N0Ykw2aE10dUI1bUorSURVRWhTMWZ6REJ5Y3Q3?=
 =?utf-8?B?OEcvb3dHRm8yN09iako0bVE4Y0diUzRKQjJZcHJwNjRnNEVSMnAwMzFKNkxX?=
 =?utf-8?B?WTlZS2kzYytRM1R0MmI1TTN2czhJN2J0K2dkTWpQZFZ1UkF1Z2VlY0JkdG91?=
 =?utf-8?B?YS9pbElSSEZnK0NDbGsrWCtzWXdPcjF1dUtiemxpd3JGYkJ5R3ZSbTN0MWt3?=
 =?utf-8?B?Q2xTSjcvcTRUemVneG55a3VKaW5pdVRrdXNDZ1hKMmt6T243VlliTUJ0S0VV?=
 =?utf-8?B?VEZnTlJmOGVyZ21RSkhqSHpCQXBteHJCWjlNYSsxdk53VHZMWCtSU25ERHlj?=
 =?utf-8?B?byticU5CNWYxMHJ0Ti8zTVlFc3N0c3FpRG5ScnFyYkp4b3FmeDdzZzVXM2Vh?=
 =?utf-8?B?MHc0cHN0c1Y1RG5PQTU2ZlFDOGVHaXcraEhMcFllZEpqenNoZXhoTkhUV3FY?=
 =?utf-8?B?bTYrNWp3N0lDSGpGUy9VSlFzbmE4YUN1SHE4L3paZ0xUbyt5dVJUcUdnUGQw?=
 =?utf-8?B?OFdYSDRLam1IVERlN1EraGpNSERCNUc1cTdMQ2lyV1Q0bGhGM2hlSG5vck9U?=
 =?utf-8?B?UkluaXQ3RnZBQjRYS0tsOGNIb2p1NkZoR2c0N2pHR0RZMG9xWmxoNTdiSGVT?=
 =?utf-8?B?WGJseWZKZzFBemtoTUhrYzdhTXJ2NnY3MVZpU2k2Sm1WaHBVdmdtTkcraFgr?=
 =?utf-8?B?enc4K0NnckY1Y29uMkxDeno4SVRpS1oyY0ptZ2xJaWYzeWlBS2E5cjlVcFJI?=
 =?utf-8?B?VVduVXJKaWtTVFk2YVMyVjBjNTE4QmZGbWpUcUd5cTUzVTlhQkFteTd1SGFB?=
 =?utf-8?B?RWg3VHlKa0tndmR6Y3NEaHNGR3IrVWIzbk1Xcm84cnpXUThheE5IMWRmdC9s?=
 =?utf-8?B?cEFKZ3Z2bmNKQzVUMHQ1bEhCK3dnQnFJNm1CVzBBWDhPVTFGajVKN1h0MXZm?=
 =?utf-8?B?aWhzazBVUVdyc3lJd2NRUklWTVhhMXl1NU9QRHRhVWRsUzdBOEVXSnFWaEE3?=
 =?utf-8?B?cFJaa3g3ckRzRk80RkZpVSsvTXZrTFFrL0l1ZlZLeVlsbnVjTDJZQWVCWGsv?=
 =?utf-8?B?NzBhZE45eVdjMmRSR1FDVE1HYjFWS1BvaVAyMnFJeFgwWFo1bGJhQ1RnSWFO?=
 =?utf-8?B?MWg2VHJDV0xlZ01HWGxiaS95d0VkZm9NZ0RUYkNLOVBRV1dCLzZ0QWJhTzZw?=
 =?utf-8?B?SUFQLzJPZUFObFVJVEhDWTRDWXpHZVMyS3M4N1dXdDF3L2RjMWlHUFNuQnJD?=
 =?utf-8?B?R2NJNkNHNmtvemJjTENGY1NmQzBjeUdTUHE3b3VUT3FPSHQ1WWhGSEZNaUsw?=
 =?utf-8?B?MTdPQ0tYREZVRzRBU1BaU0JSN0pUMzlwNXhoTTRRNko3c1RYTVdBcjVOb0Zy?=
 =?utf-8?B?SGNyQjViN2VQMS9XQlk3dG53MElsZ01keHBxRVBWWDZjZTNaSmppcXU2T3Bn?=
 =?utf-8?B?N0NneEJGaGtDdDBFWTFiekxHU0o3T0ZTWDdKTE1OckFSaGkrWEIwUGg0ck04?=
 =?utf-8?B?RXdPUUpPTHRtRUtuUzJ2bmhRWHZPMEZuRlloSDZaS2FsQlcwYkJ4UExHbGVo?=
 =?utf-8?B?dlNjcFpTRUxubHZIVlRtdkx2YWVza0VIcCt5RE8wZ3F4YkhWZ29LL1pQTE5q?=
 =?utf-8?B?cHBLcGkrbGFmeXhjZmxocnRYSEtZLzY5UHp5MkJLQVVGeUdjMnVjWEZlYVZY?=
 =?utf-8?B?MGxjWG5ZL0hleEZMQmNFcDV1VllRR3FXUnlFcFN2TWl6TlhRd2tLWGZjNWEx?=
 =?utf-8?B?K3lKUEJGWkhaMk1IQnZEVENwSVVscTBONXN2c2ZOQ2JUN09JMlB3d0NvUmtx?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cd6839-87fd-4c55-a8b4-08dbdbcd259e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:57:15.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woPlHkUo65fc40/LIAXrdAMlJnjs7itA81Ohlq7SCBcY4hjlLuCMubeN3GTDcpvMA8+JCOUaClkBfRqmPov2DN453rUeuLs+aSMz2fu0WZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:
> CAT selftests only cover L3 but some newer CPUs come also with L2 CAT
> support.

No need to use "new" language. L2 CAT has been available for a long time
... since Apollo Lake. Which systems actually support it is a different
topic. This is an architectural feature that has been available for a
long time. Whether a system supports it will be detected and the test
run based on that. 

> 
> Add L2 CAT selftest. As measuring L2 misses is not easily available
> with perf, use L3 accesses as a proxy for L2 CAT working or not.

I understand the exact measurement is not available but I do notice some
L2 related symbolic counters when I run "perf list". l2_rqsts.all_demand_miss
looks promising.

L3 cannot be relied on for those systems, like Apollo lake, that do
not have an L3.

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c    | 68 +++++++++++++++++--
>  tools/testing/selftests/resctrl/resctrl.h     |  1 +
>  .../testing/selftests/resctrl/resctrl_tests.c |  1 +
>  3 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 48a96acd9e31..a9c72022bb5a 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -131,8 +131,47 @@ void cat_test_cleanup(void)
>  	remove(RESULT_FILE_NAME);
>  }
>  
> +/*
> + * L2 CAT test measures L2 misses indirectly using L3 accesses as a proxy
> + * because perf cannot directly provide the number of L2 misses (there are
> + * only platform specific ways to get the number of L2 misses).
> + *
> + * This function sets up L3 CAT to reduce noise from other processes during
> + * L2 CAT test.

This motivation is not clear to me. Does the same isolation used during L3 CAT
testing not work? I expected it to follow the same idea with the L2 cache split
in two, the test using one part and the rest of the system using the other.
Is that not enough isolation?

Reinette
