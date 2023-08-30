Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F378D175
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjH3AyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjH3Axq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 20:53:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B99CCA;
        Tue, 29 Aug 2023 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693356814; x=1724892814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cg7U413HjFGDfWkfhyBEicBzZW5/jysmTmnR8p/hFiI=;
  b=B0+stw3tveY3sKUrlYmxn3cEQTzydXpbfDxY9R33lBuxTJeIohY6VXEb
   hdSweoOUP2mu+B4WMJQBqn+O0kEojXRq3PA8BHLgqlR3aigEIRJVcbL4h
   fYOUFQKNU2h1kl2+Q4SdKmN5HQXQj1TYeeBQRUxeohbhkQTa5QSHCgaRo
   w7slyY/1s6wAP0xj+pjeDjHH1S/o/XEejQA4zue7j+KscOzR9irg8FWvE
   xwx/i0+kD2WffLD1yKmv0zwpw9hHYgsmrEp0+tZtMd/4PFXjZOQdd4ECc
   3DaWj8TRAvYA/gR1QFRt+mVsRdPq5OhPC1Jf2aVl9IwxqyMReendbMf3c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374422338"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="374422338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 17:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773924309"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="773924309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 17:53:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 17:53:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 17:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAf2nD7yIYY4ZIKuLK4TvU3iPKrJVTy8oN856MbzA1oebG/sp/DEqslQL1kOMwKs4etgAzz8mAvuc4Nw0Pm/ynAKGvKr400G72mHHM2/2QcregG8NWnUT7iKlwO6+0JJI7P6uF3FNa/iMS2IjyHNn/2zNXvCwW096sN9tNjHKEQ+d4aqIoj73a4/VWsYTV/RNuR/+DSL0A1z4fk6XUsUzFKC2f1firrg1Z4ehod3a1FF8gZXu13/bxOBv3HXijTQiKL4lTLvU7objVsbMOi+3C10Ty8sl0+eBbtcq80rPCXfkP7tJ71wlswrGlKP02uAQie0N8u0YRCYgCOQyhu6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/fb7bZE0CBh7hEz0fmemsQQFgqjpb0lt9YpUf2naQo=;
 b=LwVG+ie3DZJG08nKQ5n7gOeeCvUvWWNc9OupMccgbVEhlLgsky9B2YPQF6iTiZn2biVbmOP/DAL8WCg7JThZA6m84E4jU6JY65b8IqUQ5PsZt9uZLzNeh8mUBScWpSzUGruneeut816BS76XXRkQc62dDhdWcnZJ3Bb6LzRdgCJ6qrbPchsVWp5ur90mSZLZ/d8KS7dYzTkBc673n5CYhEnsTvUtshVMgzwXnJMKVVHOqarbYHSa9f5+KwZAf5dIioDbQlNmEFyS1RQ+a/LFxLHfIkZshyjiYM09/7TKu5dGoKe46UiXYScJsTAUGjvUDbJiok0jOcLb1jqawtjC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 00:53:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 00:53:29 +0000
Message-ID: <bafde7cd-01ae-56ff-c1f5-53be610c2b10@intel.com>
Date:   Tue, 29 Aug 2023 17:53:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 5/7] selftests/resctrl: Make benchmark command const
 and build it with pointers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
 <20230823131556.27617-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230823131556.27617-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWH0EPF00056D03.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:d) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: ff94765a-5caa-46e6-1dbc-08dba8f386d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3quYQp8SB/NGToy4JYJP6IEil1d9XxgmVKzsygro3kkvpBequ+phK+42rX5JY0VQ3tT0Ong7+kUVPjImR3nQSFIarCDlhOdqQPe+JEURoHr0dvURd9NAUr4ldynMkvtIqCryYxWfEas2O3el2uo+lyTbOAV4dCjXfjmojDryqacV04fKWlyv+3BrELStNSz3iKhjkc7fDX6+naIXemI6JaeF/30K1B4ee5ag1QS+ewI/sVeWg7ra0Ck1Xan26UrnYdy59kiXOJuH1BojbsQBKfo0B7mCus75b0JZ4JZw/t2CHQ2ES+Z8bW5Fp1Nyfd8VjNjpo/hwcj3zszrCcIBzHVRXmqBgyneqsISsfy7M9GLDPHAAXQu/4lg7BqW8Xxu0F7oZOlEOKnxHpxJyIdn87vb2HCPcfh1qZNk3IRKAykDfWoxAY1WO1/1pAfscUnv2ePXygLWpL2A6QNdaFrTkVQHWB0QQeGtkOc/MkCsyNc/XHS5rqguveiquZG3elmvfHA1MiVBoMtbTGUumfzXTH/Jkvu0pciYB1K1QcabKFCQQJVLJ3hTO6O0roVtjw5gZM+HaWWdlazU8cV/aQUT+LvoXYR/nCHCRnV3PKtr/Smi5WM7DsT/Qs7GluqOKoe9EtXqPA26XEIDxtu4FwdAz/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6486002)(6512007)(86362001)(82960400001)(6666004)(38100700002)(6506007)(110136005)(53546011)(31696002)(478600001)(83380400001)(66574015)(26005)(66946007)(36756003)(4326008)(8676002)(8936002)(5660300002)(44832011)(6636002)(316002)(66556008)(54906003)(66476007)(41300700001)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9QNjN3WFRlRXJwUmhnL29JeTF4TTRuUFpRVTMxNGJxQ2s2YVdKNm03d0tL?=
 =?utf-8?B?K05hREFLN0dQVURUR0VYSVdIOEQ1clZzY0k5ODNNMXNZOWR4a0RxTlhhM2M4?=
 =?utf-8?B?MjNMQ0d1aGJVWU5yWHFnYjg0ZEo3bmM2RWprTktjNXJ6Wk9WNGdUVHlLWFEw?=
 =?utf-8?B?bVFsMGF3VjZMY1loeUNqUGl0MUJtNWVocGdyZlBvbnFQbGJHaW9hZHAxc3Ny?=
 =?utf-8?B?Q3JLMUFuN0labkEwSDdrM2NKNFE5R25peWowaExxWEdoL0plMTNFRkZnaCtJ?=
 =?utf-8?B?Z3FLYzVqMjN4UzJmbU5yZG5uSDRmVnVldEJyNkJHS3BlYWhIYlFqS3Y1ODhk?=
 =?utf-8?B?cWpuemFSWFdVU29sNU9sekY2L2E0cFdya3cwaFYxc3I4V2lvcUthUU91ajdh?=
 =?utf-8?B?RzY2SHlZdzBWME5VemJNMWpUTlllY3lseHgvcXI2aUtKR1BTWmxZUG5TcWRG?=
 =?utf-8?B?TkRqZC9CUHBaQ09DRThUOWRTaERRR1Y5eXliU2tmUWtJTnVUV2thLzJDbmo1?=
 =?utf-8?B?VkZOMVNRZHVNQ2N0MXVteStScXp4WjFydEVYc3A1S09DOEFZZ3UzNEhKODZi?=
 =?utf-8?B?OSszM0xldFVCcjVEanpYNWtDNXVKdUZ1U0NDS1FpYVVMTjFLNUxINWdSTk11?=
 =?utf-8?B?WkMyR2NUV1hlWEZtWjNoQ1Q2elVxZHkrOVF5U2t4d3BxSjNtekhSa21pTFRu?=
 =?utf-8?B?SUpjR1hLd2JoeFVveG9IUkQ1ekhRY1R6TVlGNWxIODVHVHd2aFVuNUc4OWVj?=
 =?utf-8?B?NC9YR1VXdDMxTWxhR3BSdEhHMWcyeHFuRmtKVEFqNGVnZFNqQ2NaK0E5ekp6?=
 =?utf-8?B?OUh5OXhpU3cyUVNnSUk3TmswU1ExdkhUb2p5N3Zsc0E2VFlMbmdIY0hsbU1N?=
 =?utf-8?B?aGlwdFhSRnlOSy9rQ3AzNjg1Q1BuZUE0emlwNDZTVVJqTEVrL28zaGFmb3Ur?=
 =?utf-8?B?Mjh0RXpkNm1DOGlOSnduMENrR0Zma0lvUFJiMXNjdS9aL0t4akYrZnpEczZj?=
 =?utf-8?B?bFhpM0VkU2xUN1RabkNQKzZNa1lpQTliM1hLTTNCdEE4VndyRTMvbDRveHNX?=
 =?utf-8?B?WDA2bEIvekNTWjAvbVlNU24zN1BIYU45M05nc1VtcVhubnhHSlcycVIzNVBY?=
 =?utf-8?B?a3NJSU5lQVFSZmtyQitoRnFUNHpLamRzY3ZjUlp0NG5oUDFnS2UrMkFUUlI5?=
 =?utf-8?B?aTBsbjRINXcyalpOQjBWM3BIU3JISTlxYlU4RjEvVExHRmxuOFJ6ZUJ6R250?=
 =?utf-8?B?a3g1L0FjaDhpNklYemZNTTNjZXZuZWhPY1NQT0NjUzY4ZndzOVVEV3l5Z3hz?=
 =?utf-8?B?Tjd6R2VLWnc4WlZWcDdPZmpmWDQrMzFHZHppMFpiY0luVU5WUDdHNG5BOUt6?=
 =?utf-8?B?Y29ZZzl0b2REOGJWazd6eHBpdlFLUm1xdFIyZkMxb2FoSlZNM1czOUIxclBM?=
 =?utf-8?B?NGJBWVAyNkFJVnBtYTRRWm5wTVByZkVKQTBEdDNVZnFPTHNBZ1pzYVNtQXda?=
 =?utf-8?B?VDBPVkJ6aHZ1T1I1YW5WTjdnVk55RUlMcFcwZGVtdlhjNEJMOXVUU0xUTk1a?=
 =?utf-8?B?a2NxbHNZTDBnbW9YR3N6MjBnNndpYnByRXdxaVdMcjhGQkpJcnNnYnZCc1hF?=
 =?utf-8?B?TXlNTUdRUHdVaWpJNjNNODN1VTIxa2VaZWR5TGw5ZWU2V3NtZGpncG5Uc2pD?=
 =?utf-8?B?T0lEZWFUeEgxNXVoWng0aDdWNGs5WUcydG95dDJ1VXRNdkh3bzVWcGhxS3gx?=
 =?utf-8?B?TXQvL0x1T1lKYm5LVjBzL0FFT1FHNXBtUVF4Wmt1N0JOVlBxM2JoTVpGVm9D?=
 =?utf-8?B?WnBWSHBLTWxQcHhZUGJiUXh4RnNuUXI3RkR0L245THZpc29RQXNJM3UrZnZS?=
 =?utf-8?B?YTVuUVJWTFR3TWJ0YjVWZVpib0s3S0ZMRmY5QXF5TmhBRmYxbXNkaWtzdDA0?=
 =?utf-8?B?ZDRBaHh6alVwOUtTQ2IxbmVxRW1GbFV1NFZSSEJ0ano0bytSYlhTbUIzcUh5?=
 =?utf-8?B?UURaNUZ3SGdMb2h4Q3F4dXBaa01rVHkyY0dJQkloY0ErNWFXL3dsUXpYTFlP?=
 =?utf-8?B?c08rbDBJU2Y3bG91VDZjRm93aUhLTTh1aVVRZ042eXFTeVQxTXhNOFhaZlUy?=
 =?utf-8?B?NEIrNTdWdVNjYlNCWGFmY25waWVOc2lQUXFEcGNTQWY3Mlk0MG9rMk04c3kw?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff94765a-5caa-46e6-1dbc-08dba8f386d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 00:53:29.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41IneAL5uOoQ5dgIOSN4DjSKnuFgC+73zvdCvTHp1RDPS72oBwkAv+goj5R5S1VvtCFbtgmv5FjX/0EL/AEnmSxM5VsDo6xBbOvN1d12cLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 8/23/2023 6:15 AM, Ilpo Järvinen wrote:
...
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index bcd0d2060f81..32d23e665697 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -6,6 +6,7 @@
>  #include <math.h>
>  #include <errno.h>
>  #include <sched.h>
> +#include <stdint.h>

What does this header provide?

>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <string.h>
> @@ -38,6 +39,8 @@
>  
>  #define END_OF_TESTS	1
>  
> +#define BENCHMARK_ARGS		64
> +
>  #define DEFAULT_SPAN		(250 * MB)
>  
>  #define PARENT_EXIT(err_msg)			\
> @@ -97,11 +100,11 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  		    int group_fd, unsigned long flags);
>  int run_fill_buf(size_t span, int memflush, int op, bool once);
> -int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
> -int mbm_bw_change(int cpu_no, char **benchmark_cmd);
> +int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
> +int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
>  void tests_cleanup(void);
>  void mbm_test_cleanup(void);
> -int mba_schemata_change(int cpu_no, char **benchmark_cmd);
> +int mba_schemata_change(int cpu_no, const char *const *benchmark_cmd);

Could you please use consistent spacing ("char * const" vs "char *const")?

>  void mba_test_cleanup(void);
>  int get_cbm_mask(char *cache_type, char *cbm_mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
> @@ -111,7 +114,7 @@ void signal_handler_unregister(void);
>  int cat_val(struct resctrl_val_param *param, size_t span);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
> -int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
> +int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
>  unsigned int count_bits(unsigned long n);
>  void cmt_test_cleanup(void);
>  int get_core_sibling(int cpu_no);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index d4ce8592466c..84a37bf67306 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -10,9 +10,6 @@
>   */
>  #include "resctrl.h"
>  
> -#define BENCHMARK_ARGS		64
> -#define BENCHMARK_ARG_SIZE	64
> -
>  static int detect_vendor(void)
>  {
>  	FILE *inf = fopen("/proc/cpuinfo", "r");
> @@ -70,7 +67,7 @@ void tests_cleanup(void)
>  	cat_test_cleanup();
>  }
>  
> -static void run_mbm_test(char **benchmark_cmd, int cpu_no)
> +static void run_mbm_test(const char **benchmark_cmd, int cpu_no)
>  {
>  	int res;
>  
> @@ -96,7 +93,7 @@ static void run_mbm_test(char **benchmark_cmd, int cpu_no)
>  	umount_resctrlfs();
>  }
>  
> -static void run_mba_test(char **benchmark_cmd, int cpu_no)
> +static void run_mba_test(const char **benchmark_cmd, int cpu_no)
>  {
>  	int res;
>  
> @@ -120,7 +117,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no)
>  	umount_resctrlfs();
>  }
>  
> -static void run_cmt_test(char **benchmark_cmd, int cpu_no)
> +static void run_cmt_test(const char **benchmark_cmd, int cpu_no)
>  {
>  	int res;
>  

Could you please elaborate why the above functions have
"const char **" instead of "const char * const *"?

> @@ -173,11 +170,13 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  int main(int argc, char **argv)
>  {
>  	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
> -	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
>  	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
> -	char *benchmark_cmd[BENCHMARK_ARGS];
> +	const char *benchmark_cmd[BENCHMARK_ARGS];
>  	int ben_ind, ben_count, tests = 0;
> +	char *span_str = NULL;
>  	bool cat_test = true;
> +	char *skip_reason;
> +	int ret;
>  
>  	for (i = 0; i < argc; i++) {
>  		if (strcmp(argv[i], "-b") == 0) {
> @@ -257,31 +256,31 @@ int main(int argc, char **argv)
>  			ksft_exit_fail_msg("Too long benchmark command.\n");
>  
>  		/* Extract benchmark command from command line. */
> -		for (i = ben_ind; i < argc; i++) {
> -			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
> -			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)
> -				ksft_exit_fail_msg("Too long benchmark command argument.\n");
> -			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
> -		}
> +		for (i = 0; i < argc - ben_ind; i++)
> +			benchmark_cmd[i] = argv[i + ben_ind];
>  		benchmark_cmd[ben_count] = NULL;
>  	} else {
>  		/* If no benchmark is given by "-b" argument, use fill_buf. */
> -		for (i = 0; i < 5; i++)
> -			benchmark_cmd[i] = benchmark_cmd_area[i];
> -
> -		strcpy(benchmark_cmd[0], "fill_buf");
> -		sprintf(benchmark_cmd[1], "%u", DEFAULT_SPAN);
> -		strcpy(benchmark_cmd[2], "1");
> -		strcpy(benchmark_cmd[3], "0");
> -		strcpy(benchmark_cmd[4], "false");
> +		benchmark_cmd[0] = "fill_buf";
> +		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
> +		if (ret < 0)
> +			ksft_exit_fail_msg("Out of memory!\n");
> +		benchmark_cmd[1] = span_str;
> +		benchmark_cmd[2] = "1";
> +		benchmark_cmd[3] = "0";
> +		benchmark_cmd[4] = "false";
>  		benchmark_cmd[5] = NULL;
>  	}
>  
> -	if (!check_resctrlfs_support())
> -		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
> +	if (!check_resctrlfs_support()) {
> +		skip_reason = "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n";
> +		goto free_span;
> +	}
>  
> -	if (umount_resctrlfs())
> -		return ksft_exit_skip("resctrl FS unmount failed.\n");
> +	if (umount_resctrlfs()) {
> +		skip_reason = "resctrl FS unmount failed.\n";
> +		goto free_span;
> +	}
>  
>  	filter_dmesg();
>  
> @@ -299,5 +298,10 @@ int main(int argc, char **argv)
>  	if (cat_test)
>  		run_cat_test(cpu_no, no_of_bits);
>  
> +	free(span_str);
>  	ksft_finished();
> +
> +free_span:
> +	free(span_str);
> +	return ksft_exit_skip(skip_reason);
>  }

This is a tricky one. If I understand correctly this goto target makes
some assumptions about the state (no test plan created yet) and exit
reason (it has to be skipped). A temporary variable is also thrown into
the mix. Can this not be simplified by moving the snippet where
benchmark_cmd[] is initialized to fill_buf to be just before the tests are run?
Perhaps right before ksft_set_plan()? This may be an easier move to consider
when the changes in patch 7 are taken into account.

Reinette
