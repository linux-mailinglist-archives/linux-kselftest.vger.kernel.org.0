Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A923F7B3850
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjI2REc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2REc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 13:04:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5001A7;
        Fri, 29 Sep 2023 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696007068; x=1727543068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qUZF9S20oqTb2JrpdnAd1i7kxKEc1kH9cNTS8MD+t8U=;
  b=YECchNuLPK/FFz/eeQsfTjU7PfHr/RwY/N1Xv6wTsXvE0uMzm5k++iO6
   dngfI7btWl5Fpz6jPWWIDPhcJBqDIsq/k3q1h6//Jgl90D8sun7ficxyo
   vvF3a85Qyjz+qDiumG2MciPdyFK3bIEZ1A85mWnlAHKWHYAmrkr7DYb70
   GCg4x3XiCejtZ8UBelf3+HPA2StCsPjMrHhuHyPvEeLif7a1i5Dsvmj0+
   ArKNvfvyi/Ws0ewFwCewRsPEeOpAuX4XbFb4pGnudo5okWjVvxtWd6JGq
   x+3hJy2enh2WLLiLUV9wPgVW0eWJ+xN3O7LgcasbL4kacoXlscXPhNda7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379615969"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379615969"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753443593"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="753443593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:04:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:04:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:04:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:04:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS6qnAfYgZITNcYvfCJRCI1G6M9MfH5C+4krvPayYMWyUucOSW6fBlb32RtZMDxaNQGrhJAH8cJk34Xtve+gZjmrWaA2Ew2tvi3Ab4d9tjU0T8ul/DmShKxL1bhte/1n1Bbs4zyZIwJQjFnTER8y+QYIEvm93ESN+2Xr7yKrwaSSNVBiugzYT8hBVk3WM89A4W/y+MGxgU1P0l+QI3cc8c7Tlvzm+/cqwWYq0r/x7/if3hHoDfTx8iquvIHgxt2y2uli/CmUqnM5AeRUHc16L6pSslS74zQLsEHJ7IjyvfVVuHIxhYpCZ6ZeOkkhxM0nYgYYwKb14rmCzr5LksYziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuT1TQqId53tZ639PHrEux4GpL6HwOMXgMCCiCMiYQg=;
 b=TJlIiU154aKnze532Wqr7GKQ+c29PoSxHgZbUr8qP/MERnEVmf+30Z4IcFYT8CFehMKAOj5gDhmBKgoKL7wegm3ghzIKgEpLw822zyFDJ33mu0jOmwRtnhTetPIz+gO/kkozS1hmxQZL6Wt7iFtfUHjk3XX3ytmH0wI93Y4PpvncBtzjqV47cAesok5CK3IEkZpjse1VDP5qFUHBZBZ9agyxkkZnOqRM2R3CINDij/TTP/dAID+gBFn+PB1z+5M+r6NuzJHQzNPMTjNtPtuXKLuj55qwwNHkA97yRYw5WF+/nV08pUNVkxUdQnoo7I+KWtxhWVTuUl+D2yk4rYENAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8044.namprd11.prod.outlook.com (2603:10b6:806:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 17:04:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 17:04:24 +0000
Message-ID: <b4fe7970-06ce-43eb-a972-eb7cad26ff34@intel.com>
Date:   Fri, 29 Sep 2023 10:04:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Fix schemata write error check
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1695975327.git.maciej.wieczor-retman@intel.com>
 <f1f8f4132d6e6cdb1438186cb40c5d78b94acd5f.1695975327.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f1f8f4132d6e6cdb1438186cb40c5d78b94acd5f.1695975327.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f997fe-b686-44ab-0ef4-08dbc10e21c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHPzk6FyGVLPKv77ionZUAGDk5WHVjYuEx/yYftHhUxgRSVTKhl5Y0p+JFaT9jrT29nMXLozuPgwSKBfGmhcSxZ4TRFSqCoSWqIFUOPzoqv8RF8qFF2RfKM9QacB7a1SYZ2RlZTuwL024jsPWpXdAVM9oiR/hgxUk1cD9priTmy95dfhFFN90XOoMy+HP5bnedjBsS/GG59owH2YTqDY9bDn5NowcqEp8BSh2ip9stH1jn99p8/G00XnrUYngpBhpWxgXwLUVt7AXpf1nBvsv/upfdK4st/MaoqHlIxysqZ+XfU6OJgsJvEl3CJG1rK5Ed0763xIZejfvlpWhpelu7t2JDyWgnmKDPE0JMie4qZCPGJd/y3uCnANHVNug8qHXkbbx5rEtGfOUIxzNAoNcuCcwsRzAjLlLJ8DBDVP0IeQy9SmUHEQxotXhaPbzatHQ2Q6jBM99Ht4jwCXKT8kKJsbCpKCCV3e35D76ksa/mY73C7xO+NThZ2nrDIl0YbAvNrWDf2BmSM5v9YxRL+EO7yk8rv+sEEP/2q5dFnkS2hw7xiWJLitou3Q8AkyBd0RpykcyhTjmYP2gATyk5lMrBH2I/e84AdqgssJ2fKYHu5+apOIYQ78YgyvxEubRslYT9LkR4ysJpwfVjcuBzEouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66476007)(66556008)(66946007)(4326008)(8936002)(8676002)(41300700001)(26005)(36756003)(2616005)(83380400001)(6486002)(478600001)(53546011)(6506007)(6666004)(31696002)(6512007)(86362001)(38100700002)(82960400001)(110136005)(2906002)(31686004)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVjQWEvRzB3QUp0ZUpkY3ZzcVBtbnZnSm9kbkpoUHJMZk0zOWtyNGxibXZs?=
 =?utf-8?B?MHVENHpZbktUeGthcVk0RlVZaTFpYzlnMTg4ZnpJbk5aQzdRQUJpMzZ2TVR0?=
 =?utf-8?B?YnlTdUJhWGZXQmhoajV1Tm9aWWp6aEN5T09oZTNLM21adGE5SWsxV1AwTE9K?=
 =?utf-8?B?ZTdtVEUySjNZTHJCSFpmbzVKdkFuOHQyZXhjMGhmdlliaGZKQW9wSTY2NEpv?=
 =?utf-8?B?Q29qY3RhMGxZN3IxRm9BU2pnbUEvUmZObzVlQWN1WUhRWFROc09RVXQ2aGRn?=
 =?utf-8?B?Q0ZVUzhMZnV2SXJydklGdU9yaW5CcDB3RXZucmEyNHVySEJ0V2NuOGI3YUxE?=
 =?utf-8?B?VFMwVEJoL2NKTWN1WjBjeWRDZmFYL0VlTFlEZzl6bEV3NUhIb1FCZ0FGbnpC?=
 =?utf-8?B?OW1vUEx2elBJeFJhd01kM3QxYXdiTkcxNUptdFZVb29pd1ZzYWtaMzlKUHMz?=
 =?utf-8?B?aHdHVjFWNGpUUExubnowais1NWpWUUtGZVdKYitIc3lUZ1k2RFYrUFRBc3Zw?=
 =?utf-8?B?Y3BqWkpKc0NLTWE5b1M3UnNHbHhUeHYyNlhnYVp1SmdpZ1FQdWhKRlhPUWlD?=
 =?utf-8?B?K05FTnhud2JnNGVKWVlUWDdFRTduZkRyM2FSM0RmRGpzS2oyNXNvMnBUKzEw?=
 =?utf-8?B?UEE1d09IeGFKSURjUVF2NUg0Q3BiZjNkWDl4YjJtdzFNSmpaYkZtUGNkWVNu?=
 =?utf-8?B?aWkwWTZyK2VsY3o2M3VvUzBCVXFvcWcrM200VUxVUmNEWldPZEpCQXNzNjd6?=
 =?utf-8?B?TGdHdXZaL3VYd29rdDhib1V4cVFTZDBEbkhZWG1qOFlJckhjWVY3MVUxcDB0?=
 =?utf-8?B?UnJsSExJaUs2Yk40YktDUWd4cFV2QnBPd1poVC9NQ09iT3RYcjRENDEwY1pW?=
 =?utf-8?B?UVpZOS8vWUE1VTNybWlVUVBtTFRyckhYNWNqY3dFZ0VTY3dUMXZnRXdhZ2RK?=
 =?utf-8?B?VVBKRkNPVUljODF0dllBN1RBN0x4NlIvdkZWdzJIenZiUVNSZ0RLVDZ3RFk4?=
 =?utf-8?B?Q0ZRMnRoRG1QTWN1ZnU0SXBEZUkxWjFGUzFCV1Z0ODc0azhxazRqQ3J5WFM1?=
 =?utf-8?B?ZFdWcVV4R25jWDg1T0ZGdEpZZFd0Rlo1RVlOQ0drdlp5eEF1UUlnd3FnZW1O?=
 =?utf-8?B?Qi8vN2Y0YVhSSG9KQ2tZRnFTTXQ5dVBFbGFMZ3VKd3hVemFLRWpObkgzZU8y?=
 =?utf-8?B?cDQ0OXVqVFVsV29iUkZBUzgycnZRa20xUlpRMGdqeEoweG03RURWQjNkY0pL?=
 =?utf-8?B?ZS9rZzlqVmdYTmtTSzVXeG5vbVAwdFR1TEsrVk1jZW1TVTNRUm1SamR2Zndt?=
 =?utf-8?B?U09HWUx5VjdTLzFFS1hDWFFOY3YvZEVaZXZCNkJSa1U2TDJuU1dMdEVwMlVR?=
 =?utf-8?B?d2FNR0xIczBXd1dOQzhrejY3bzNkMnpiWEtBWVRHNytqRmRBNy9oNkhhaFox?=
 =?utf-8?B?SllxZHhHb1dmSE5maHl5MGxVM0dBYXVlTHM1Z2tScEdQeDlZYzd2Y1FMVkhQ?=
 =?utf-8?B?RmRqd1dRYkkza292L3dUUjhwbmh0UTYxS09pM0hGZU9DbmtLY096VVBOM1hq?=
 =?utf-8?B?NURILzRQMHNpNkcvTjYxWm4xVm5JZ1VCVm9md0xQbXlBbXdycFpwSnBLT1RF?=
 =?utf-8?B?ZXk1TmFWUXFYWUJyQzhsaHBzU1JrUmU0ODFDOEhGeUtoL1FKWGNxSk55VnJi?=
 =?utf-8?B?Z2N6S0dXN09nMkRHRlkvOUtrYnphMnhsTGNJc1A4c3ZYWVYxNk44OWs4QVdZ?=
 =?utf-8?B?akYwQUNSVCtRWmg1KzNkTXFJUlZwYjdCeDk1VjhOUnI1ZG5ma0ZGZ2VQU0dt?=
 =?utf-8?B?WDBtTXJzWUpQZzFBT2NQWWtmRUdDUERlWTVNeVVaOW1qZ05IS1Z0T1QwdFF0?=
 =?utf-8?B?ciszZjlHNDE4MDVwWHU5MXdtY1VEMnpmOVFjVzZlYnVMU1JxK0dnNVMrQ2Jq?=
 =?utf-8?B?TkZYdEc0aHBYYVE0ZzNMbXc4RnNlMWxiRFBxNDRacFhuNzJmSzNLZDNYWWJN?=
 =?utf-8?B?OEo1b1JBTnI1djVsRzhvQXArSWN3MUtvQ2lyUVl5ZkpFSWl4cTIxY3NzUzk4?=
 =?utf-8?B?WmdvcDB6eWhxSFZrU0ZhOWpVSzZaeUNvTWhmZmt6eEtpM1BqaVlRb3BwTVJ0?=
 =?utf-8?B?QXZ4alBuNERjQnJCanFlNi9EYzFLTnoybE52UitPMk9pOFdUTUo5bjRpWWNv?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f997fe-b686-44ab-0ef4-08dbc10e21c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:04:24.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mSuibBNo07w49UqeYWtaTkjNYahAE5g8/CPPZrtdEG8W4A+DeNtKQ83IKPcth76TtlM1bD5CAVnLwbmRh/N6F4BTtQ0YPQQfNKBp5XMeUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 9/29/2023 1:21 AM, Maciej Wieczor-Retman wrote:
...

> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 3a8111362d26..342a3dbcdbb6 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -8,6 +8,7 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <fcntl.h>
>  #include <limits.h>
>  
>  #include "resctrl.h"
> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], schema[1024], reason[128];
> +	int resource_id, fd, schema_len = 0, ret = 0;
>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -520,27 +520,37 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "MB:", resource_id, '=', schemata);
> +	if (schema_len < 1) {

I find that this complicates the code since this is not the typical snprintf()
error checking (0 is a valid snprintf() return). I think it will make the code
easier to understand if it sticks to snprintf() error checking and initialize
schema_len to match. What I mean with this is something like this:

	int schema_len = -1;

	if (...)
		schema_len = snprintf(...);

	if (schema_len < 0 || schema_len >= sizeof(schema))
		/* error handling */

> +		snprintf(reason, sizeof(reason),
> +			 "snprintf() failed with return value : %d", schema_len);
> +		ret = -1;
> +		goto out;
> +	}
>  
> -	fp = fopen(controlgroup, "w");
> -	if (!fp) {
> -		sprintf(reason, "Failed to open control group");
> +	fd = open(controlgroup, O_WRONLY);
> +	if (fd < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "open() failed : %s", strerror(errno));
>  		ret = -1;
>  
>  		goto out;
>  	}
> -
> -	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> -		fclose(fp);
> +	if (write(fd, schema, schema_len) < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "write() failed : %s", strerror(errno));
> +		close(fd);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	close(fd);
> +	schema[schema_len - 1] = 0;
>  
>  out:
>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",

Also please note that _if_ there is an early exit then uninitialized schema
will be printed. Maybe this also needs a schema[1024] = {} ?

Reinette
