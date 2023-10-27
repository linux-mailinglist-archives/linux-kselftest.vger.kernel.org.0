Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB27D8E95
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0GUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 02:20:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F881B1;
        Thu, 26 Oct 2023 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698387645; x=1729923645;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Hnt5kfDhHzU9pquVTMnm3ATc0CrxAE42dnMgECEkPos=;
  b=jwKaO55xmI1zVDK4zrSRupSPVN0wdt8hHIbqb2KhLwY7VEhboffLhR8a
   SIYEMNEhV64/F5/omxTEhiEq0+nRvq0zw7pG9cNr9aSPsnjPEnvR4rOLe
   QnK5YLBOa2OtdaDkWGkOQ3wDa1EmGC+smlE39wYH0eihDrWQg97wf0kaL
   Hw38KCVpiqUf3eOjybNuoq79m+0VZmYSaFmIyoyilS20kI5udk6e5hJfh
   cc/jz5HpIX74U/7TWoXZ5VO+jTY3BlH7J3vYtmH/x1gMwA0WcVKfpE34j
   KMoUIebrrOkXFbZrmHrIQ6oPdhVUKKtcMFH208/IHMlTjNcKuvd4xzZm6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="386604634"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="386604634"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 23:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709330035"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="709330035"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 23:20:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:20:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:20:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 23:20:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 23:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSYuq4R9/xfTKpLjZgrmoz/t590IztJO8/yCsOE9dCdX2oOhtGcs88n/TiCrkG+VvfeRusjGs7MEUpZr+w1cO8IBuXL/Zf9uhrUoGgE0V1uLBc3oNmmF/cG/Axs/3mT4LgCwr2pDEaLa4hRA+7/XOOXaGXQsuIpcffximbVB5Pd2dd4zyl5m7x8KMBum2ZJd7lJkbBNOZq0ZnQbFFAdxtkoo7sxHXjXgT8hFO+XeFDkFTvkc8pVC4anyoaQi/dwdzdxxJau/ljfyrCNLMyZU5Ieiy78/VIZB3psgtuuNAEBlv+Qg24sgQZ3ekd0gtxhG1wlNzWfrZ8oxRDC+AwHgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wHUrY5RsbJv2jktKpGFamblQZKrYTadihTMsbpFUbE=;
 b=E1z7z9UsRp3HoMyripM5u7gojllYDg6QhcQwVag3aEJPtWg1BUgTVOSZmo5phk6KeKxmuEHtpi8rDDLj83svd4kbRpjbqmU7NucOiphK6KJXdELuEz3xKlShrNQ7KdKcLIME/QW9937/m+Kx/hBy+qZ8w2It+m0pieithJ6Av+k5BBkQ4y7v2DAxtVlZ9LNkIWtpbkfU5nZFLpms6NeM7eJaxrvy+8ajMMQn3knfAlbogR3DH+3nMelSRvJFvw8FEPLCvTMYzhRbDg8yQLxDMdE8ZWmgE4m24Z45fq4Eu9wRG/dDZ4mGJ42ixmv7uXcxVRvEfMLIr9H7DaJdm8Rw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 06:20:35 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 06:20:35 +0000
Date:   Fri, 27 Oct 2023 14:20:26 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Xabier Marquiegui <reibax@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Vinicius Costa Gomes" <vinicius.gomes@intel.com>,
        <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [ptp]  403376ddb4:  stress-ng.clock.ops_per_sec
 -12.7% regression
Message-ID: <202310271441.b9fb0896-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b5a981-65fa-4100-5778-08dbd6b4d42f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4oqoSjJ28ro/CDu7x3TJvevfeKwBaWnhRuwH21BG1AQQ5rV5vyvQ/eCf3ecdPF7OI1DznN/dll5B4Yvvhs1Mhfvq0TyEgltbBgUkwHI13enqKAYeZ9Y513s2yTjA5NtgxHXLqmMoify5b8wNK7a1RHfFeaCTWoIC8w9OQiyTfA2H/oxpAOzQeL1uwAqc87wlkw7+SKH9eqtJyC2P1Y02NcdXBotLVf/h74KKAcJsI/ztjoWOTIATkTwA18iuHWRQAiKgpbvPNcnDKCU0rHiBvBGnkiWLdKEk2kJ1e0a73m5Jq23l0slTpqe++AOiFit2VFSRC20+US1Tp66m+dcOo/87SHgaxLNLgnfmlcp66/urvR2iti0SA0rq/f6dxcazanLI+mDV0x6NDGx43Se5E8281x/7RCEJDI3vTGROOPGDNjszK7kUr6shgZoFGfCmFzjYXLtQ/c2JUPQXdK2dvB+twhhYnYzAVE5OL4mBROe45xqL5vvfcJa87Vhv3cg77dNfgvFq7bNZMmCy1NuCPHHEXwHUWM07ZLOUvxkUNeCC4EM0C75B0MlbUvtJH7tKR9++Gr9eKM5Xa1Wv0WD9TqPAFBdYUalDCDkEQEhY6OZbsksuHgUZmgjQiUUrF6oFeSNQ3/phWGr+rA4YpJdxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230373577357003)(230473577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(2906002)(30864003)(38100700002)(54906003)(6512007)(66556008)(316002)(6916009)(82960400001)(1076003)(6506007)(107886003)(2616005)(478600001)(6666004)(6486002)(66946007)(83380400001)(966005)(86362001)(36756003)(5660300002)(8676002)(4326008)(66476007)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xcazHa9pDBQm/x1NYC521VHQlZ5pMC4xehHAPpIP1BtoAs20pQOOkmgOar?=
 =?iso-8859-1?Q?13xSBp94+wj53owXHlNhqFvMehl0lyOOeCdZmmXnHi/53UtOA/MhgnkwjL?=
 =?iso-8859-1?Q?FiQibMvAo3ad4FvZFGfGykIJsgn9qlFd14PxXrVCeMsw/Fhqaz2QslQzNM?=
 =?iso-8859-1?Q?CP9REf+eL4l41cL3iSuNpG/kORQ9NxUhezJeQlZ2H+IM9yOvvGDPDC4ia6?=
 =?iso-8859-1?Q?Sja6+7wv/OLbwioVjN5zQf2nLrX8iEfizSvCw/cS8K7plNfHXHUdETBSxV?=
 =?iso-8859-1?Q?h+Y04Ubqbqxmlsl9ISh/9LdGPOpZwI+9qkqTlIebMza9CzKPdsSgs5DOaW?=
 =?iso-8859-1?Q?7sH/u2sc/Hj0LVSPjLQyeqmZZfkDi5LHclQxDVGmR/4uRlE1nlJ88+o3QM?=
 =?iso-8859-1?Q?nS9Ki+8gitufv8m75Va31E6KqEwZ56077EE6Xhgx8UJwCxpyYi4oY3vbCx?=
 =?iso-8859-1?Q?Yw1MKCG3Ej9TFD0zSeTtpFklXOfn1ken0l2ayUEJVWq0xV2xnGkolfqxPz?=
 =?iso-8859-1?Q?A4zFdJxhIar3AJFRhTLisIk8pfrLhW3DGUFE37lu6auwmsQzZZabvIhZo+?=
 =?iso-8859-1?Q?sqsR0cFjs7VNTNKxi3qP9BHGo0/X6XivNK/t1KRybXvNZKYDwGhrqOr11n?=
 =?iso-8859-1?Q?O3lLYxYKVPboUx1FhYJetkOXxTpVT37O2avnAnQ/J2bQyiZdyDJ1LGPg4B?=
 =?iso-8859-1?Q?ht3uertRD2ewrbLEgdpzNhh/T8YK6DjEkDRed0SKLiKMNB8DtV4FZqL7+h?=
 =?iso-8859-1?Q?LaaCl9pueCEHfoxuS2QSN9E6MUqol1QiKn86c8+pgW1I6y8YxPtjV9qNgf?=
 =?iso-8859-1?Q?w65eeKqlu4t7/gMgq0QAyFD1IczI24QFEicLFxScEk2YBS3JyiWjUyVFrc?=
 =?iso-8859-1?Q?WestVeNXjIJulDnKICbhcRhahZ+zua9I0cDaJsLe1ssCNZ5PgbEnCDE2Nn?=
 =?iso-8859-1?Q?kib+51Dik0csy0vGDwZGTYSIbBZRW4CJr6WWHjFFuBShNGwV/L2ncEDoDR?=
 =?iso-8859-1?Q?59OEoxV7indC1NmkIneJ5G8tZ+B/B+WmijSp16wT9WtZKTIFAXCGsf9Vmw?=
 =?iso-8859-1?Q?hiSrr3ihOJ/211ENRiIJnUTzphOeSDbhI4u80zksnzq7JS9d0q4yA3DcvM?=
 =?iso-8859-1?Q?rcka1KktDtNaXJH7X3nqj4hBB9XGbx+wldIjjz33afHg/do9p0YY9GKYvb?=
 =?iso-8859-1?Q?y2oukFAhCWnpj+Sk1dNp3mprIJC/SA5tuWrXsAus/pHKvLCQC+h1Ot9uap?=
 =?iso-8859-1?Q?qmbseeWkq0XKyiAbh6PZkhSlzAFgAveKJ19gBTrgidzKbJiINzr3F6CJZ1?=
 =?iso-8859-1?Q?Lfd4CPJJT+BkEwaCiuKS+7nUxlVtRwb1aFygCdNHetGOgnzMZFgl2bLMPE?=
 =?iso-8859-1?Q?ReNIwU9jIARXg6AGJ4ZssCsdySLv5bzjfdqBxrsyP6sfLlcZQkWIP0K9xD?=
 =?iso-8859-1?Q?JgYgNUI5vHS9GlZwYGUZJjBGkzTTHQ8bT+vFhywqQUb3f2V9SinK669vrm?=
 =?iso-8859-1?Q?9eGSFLk/xINv9m/bMabmIIieK0ZT5C7jD1qBJycmKtJLd0Sw9y4+mIqnyg?=
 =?iso-8859-1?Q?onXZcRESkbaYkHKERkvti+h3+ly8JE+m5Cm+KLb161WOLjhFHOML/BRPwz?=
 =?iso-8859-1?Q?i3oCwyPqNi2GtTVYXOybDtOG68L7kdiq5BQ48BfjfARrkwjnSEZi7QJg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b5a981-65fa-4100-5778-08dbd6b4d42f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:20:34.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8T2YlKeCYCdBgTusXJTaSy2n3ddB9IrCmOFJYGIWGpLd0cZNhRae7RSYfJp+IxSy83x/VMuFlyWQAu1vUyYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Hello,

kernel test robot noticed a -12.7% regression of stress-ng.clock.ops_per_sec on:


commit: 403376ddb4221be9db5326ae334773807df71ffe ("ptp: add debugfs interface to see applied channel masks")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	disk: 1HDD
	testtime: 60s
	class: interrupt
	test: clock
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310271441.b9fb0896-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231027/202310271441.b9fb0896-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1HDD/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/clock/stress-ng/60s

commit: 
  c5a445b1e9 ("ptp: support event queue reader channel masks")
  403376ddb4 ("ptp: add debugfs interface to see applied channel masks")

c5a445b1e9347b14 403376ddb4221be9db5326ae334 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.50            +8.3%       2.71        iostat.cpu.system
      0.05 ±  3%      +0.0        0.06        mpstat.cpu.all.soft%
      1.84            +0.2        2.04        mpstat.cpu.all.sys%
    200469           -10.7%     178950        vmstat.system.cs
    135153            -7.8%     124597        vmstat.system.in
   2804514           -12.7%    2448917        stress-ng.clock.ops
     46741           -12.7%      40815        stress-ng.clock.ops_per_sec
     78.00            +2.6%      80.00        stress-ng.time.percent_of_cpu_this_job_got
   5606454           -12.7%    4896355        stress-ng.time.voluntary_context_switches
     18583 ±  5%     +31.1%      24360 ±  9%  turbostat.C1
      2.90 ±  2%      +0.1        3.03        turbostat.C1E%
   5353747           -13.0%    4655189        turbostat.POLL
      0.28            -0.0        0.24        turbostat.POLL%
     10.11            +1.4%      10.25        turbostat.RAMWatt
     88825            -6.6%      82944        proc-vmstat.nr_active_anon
     11367            +4.6%      11892        proc-vmstat.nr_mapped
     96532            -6.6%      90119        proc-vmstat.nr_shmem
     19819            +4.1%      20633        proc-vmstat.nr_slab_reclaimable
     88825            -6.6%      82944        proc-vmstat.nr_zone_active_anon
    420661           +27.6%     536903 ± 35%  proc-vmstat.numa_hit
    420556           +27.4%     535725 ± 36%  proc-vmstat.numa_local
    133275            -6.9%     124053        proc-vmstat.pgactivate
    488366 ±  2%     +60.4%     783374        proc-vmstat.pgalloc_normal
    227687            +3.2%     234860        proc-vmstat.pgfault
    323139 ±  3%     +94.6%     628694        proc-vmstat.pgfree
      0.00 ±141%    +325.0%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±217%    +455.3%       0.04 ± 68%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpumask_var_node.clock_was_set
      0.10 ± 14%     +66.8%       0.16 ± 15%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
      0.00 ±141%    +325.0%       0.01 ± 26%  perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.91 ± 21%     -53.8%       0.42 ± 55%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.27           +18.7%       1.51        perf-sched.total_wait_and_delay.average.ms
      1.27           +18.7%       1.51        perf-sched.total_wait_time.average.ms
     18.82 ± 20%     +59.4%      29.99 ± 27%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1278 ±  2%     +16.3%       1487 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    220.33 ±  5%     +14.1%     251.33 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 13%     +63.7%       0.33 ± 14%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
     18.82 ± 20%     +59.4%      29.99 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ±208%    +433.3%       0.05 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.alloc_cpumask_var_node.clock_was_set
      0.10 ± 12%     +60.7%       0.16 ± 13%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
      0.13           +35.1%       0.17 ±  2%  perf-stat.i.MPKI
 9.417e+08            +4.1%    9.8e+08        perf-stat.i.branch-instructions
      4.24 ±  2%      +0.6        4.81 ±  2%  perf-stat.i.cache-miss-rate%
   1107890           +23.8%    1371103 ±  2%  perf-stat.i.cache-misses
  18969540           +28.6%   24388966        perf-stat.i.cache-references
    210406           -11.1%     187069        perf-stat.i.context-switches
      1.15            -3.5%       1.11        perf-stat.i.cpi
    185.83 ±  2%      +7.7%     200.19 ±  4%  perf-stat.i.cpu-migrations
     56299 ±  6%     -64.8%      19830 ±  6%  perf-stat.i.cycles-between-cache-misses
 1.249e+09            +2.7%  1.283e+09        perf-stat.i.dTLB-loads
      0.00 ±  6%      +0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
      7425 ±  5%     +12.8%       8373 ±  4%  perf-stat.i.dTLB-store-misses
 7.573e+08            +2.3%  7.746e+08        perf-stat.i.dTLB-stores
   6674913 ±  2%      -5.5%    6305796        perf-stat.i.iTLB-load-misses
  5.03e+09            +3.1%  5.184e+09        perf-stat.i.instructions
      1159            +5.5%       1222 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.89            +3.0%       0.92        perf-stat.i.ipc
    536.86           +28.0%     687.18        perf-stat.i.metric.K/sec
     81.89            +3.0%      84.38        perf-stat.i.metric.M/sec
      2127            +5.2%       2239 ±  2%  perf-stat.i.minor-faults
    106399 ±  2%     +36.0%     144713 ±  3%  perf-stat.i.node-loads
    106511 ±  5%     +71.6%     182771 ±  3%  perf-stat.i.node-stores
      2127            +5.2%       2239 ±  2%  perf-stat.i.page-faults
      0.22           +20.1%       0.26 ±  2%  perf-stat.overall.MPKI
      1.09            -2.6%       1.06        perf-stat.overall.cpi
      4955           -18.8%       4021 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  5%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
    753.96            +9.1%     822.64 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.92            +2.7%       0.94        perf-stat.overall.ipc
  9.27e+08            +4.1%  9.648e+08        perf-stat.ps.branch-instructions
   1090868           +23.8%    1350235 ±  2%  perf-stat.ps.cache-misses
  18670301           +28.6%   24005580        perf-stat.ps.cache-references
    207054           -11.1%     184104        perf-stat.ps.context-switches
    182.86 ±  2%      +7.7%     197.01 ±  4%  perf-stat.ps.cpu-migrations
 1.229e+09            +2.7%  1.263e+09        perf-stat.ps.dTLB-loads
      7309 ±  5%     +12.8%       8244 ±  4%  perf-stat.ps.dTLB-store-misses
 7.454e+08            +2.3%  7.624e+08        perf-stat.ps.dTLB-stores
   6568626 ±  2%      -5.5%    6205894        perf-stat.ps.iTLB-load-misses
 4.951e+09            +3.1%  5.103e+09        perf-stat.ps.instructions
      2094            +5.2%       2204 ±  2%  perf-stat.ps.minor-faults
    104758 ±  2%     +36.0%     142499 ±  3%  perf-stat.ps.node-loads
    104880 ±  5%     +71.6%     179969 ±  3%  perf-stat.ps.node-stores
      2094            +5.2%       2204 ±  2%  perf-stat.ps.page-faults
 3.124e+11            +3.9%  3.245e+11        perf-stat.total.instructions
      9.42 ±  5%      -2.2        7.20 ±  8%  perf-profile.calltrace.cycles-pp.clock_gettime
      9.26 ±  5%      -2.2        7.08 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_gettime
      9.24 ±  5%      -2.2        7.07 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
      8.84 ±  5%      -2.2        6.67 ±  9%  perf-profile.calltrace.cycles-pp.e1000e_read_systim.e1000e_phc_gettimex.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64
      9.20 ±  5%      -2.2        7.04 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
      8.96 ±  5%      -2.2        6.81 ±  8%  perf-profile.calltrace.cycles-pp.e1000e_phc_gettimex.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.12 ±  5%      -2.1        6.98 ±  8%  perf-profile.calltrace.cycles-pp.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
     10.96 ±  2%      -2.0        8.98 ±  8%  perf-profile.calltrace.cycles-pp.syscall
     10.98 ±  3%      -1.7        9.28 ±  9%  perf-profile.calltrace.cycles-pp.clock_adjtime
     10.09 ±  3%      -1.5        8.55 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_adjtime
      9.94 ±  3%      -1.5        8.42 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_adjtime
      9.68 ±  3%      -1.5        8.20 ± 10%  perf-profile.calltrace.cycles-pp.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_adjtime
      8.53 ±  4%      -1.3        7.22 ±  9%  perf-profile.calltrace.cycles-pp.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_adjtime
      6.44 ±  5%      -1.2        5.20 ± 10%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.22 ±  4%      -1.1        5.12 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      5.59 ±  3%      -1.0        4.59 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      6.42 ±  3%      -0.9        5.51 ± 10%  perf-profile.calltrace.cycles-pp.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.86 ±  3%      -0.9        5.00 ±  9%  perf-profile.calltrace.cycles-pp.clock_was_set.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64
      3.34 ±  5%      -0.7        2.68 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.99 ±  9%      -0.6        2.34 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      2.47 ± 13%      -0.5        1.94 ± 15%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      3.31 ±  3%      -0.5        2.83 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.clock_was_set.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtime
      2.78 ±  3%      -0.4        2.42 ± 10%  perf-profile.calltrace.cycles-pp.timer_create
      2.37 ±  3%      -0.3        2.07 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_create
      2.33 ±  3%      -0.3        2.03 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
      1.64 ±  3%      -0.3        1.36 ± 10%  perf-profile.calltrace.cycles-pp.add_device_randomness.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.43 ±  3%      -0.3        1.16 ± 11%  perf-profile.calltrace.cycles-pp.blake2s_compress.blake2s_update.add_device_randomness.do_adjtimex.__do_sys_clock_adjtime
      1.52 ±  3%      -0.3        1.26 ± 11%  perf-profile.calltrace.cycles-pp.blake2s_update.add_device_randomness.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64
      1.23 ±  8%      -0.2        0.99 ± 12%  perf-profile.calltrace.cycles-pp.posix_cpu_clock_get.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.02 ±  5%      -0.1        0.88 ± 12%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get_update_offsets_now.clock_was_set.timekeeping_inject_offset.do_adjtimex
      0.74 ±  4%      -0.1        0.61 ± 13%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.47 ± 45%      +0.4        0.90 ± 17%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.7        0.69 ± 10%  perf-profile.calltrace.cycles-pp.lookup_one_len.start_creating.__debugfs_create_file.ptp_open.posix_clock_open
      0.00            +0.7        0.72 ± 12%  perf-profile.calltrace.cycles-pp.dput.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release
      0.00            +0.7        0.75 ± 14%  perf-profile.calltrace.cycles-pp.lookup_one_len.start_creating.debugfs_create_dir.ptp_open.posix_clock_open
      0.00            +0.8        0.75 ± 12%  perf-profile.calltrace.cycles-pp.start_creating.__debugfs_create_file.ptp_open.posix_clock_open.chrdev_open
      0.00            +0.9        0.86 ± 15%  perf-profile.calltrace.cycles-pp.start_creating.debugfs_create_dir.ptp_open.posix_clock_open.chrdev_open
      0.00            +0.9        0.91 ± 14%  perf-profile.calltrace.cycles-pp.mnt_get_count.mntput_no_expire.simple_recursive_removal.debugfs_remove.ptp_release
      0.00            +1.0        1.05 ± 13%  perf-profile.calltrace.cycles-pp.mntput_no_expire.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release
      0.00            +1.3        1.26 ± 12%  perf-profile.calltrace.cycles-pp.__debugfs_create_file.ptp_open.posix_clock_open.chrdev_open.do_dentry_open
      0.00            +1.5        1.47 ± 13%  perf-profile.calltrace.cycles-pp.debugfs_create_dir.ptp_open.posix_clock_open.chrdev_open.do_dentry_open
      0.00            +2.4        2.42 ± 11%  perf-profile.calltrace.cycles-pp.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release.__fput
      0.00            +3.0        2.95 ± 11%  perf-profile.calltrace.cycles-pp.debugfs_remove.ptp_release.posix_clock_release.__fput.__x64_sys_close
      1.74 ±  5%      +3.0        4.71 ±  8%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      2.90 ±  6%      +3.0        5.87 ±  9%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      1.35 ±  6%      +3.0        4.33 ±  8%  perf-profile.calltrace.cycles-pp.posix_clock_open.chrdev_open.do_dentry_open.do_open.path_openat
      1.42 ±  6%      +3.0        4.41 ±  8%  perf-profile.calltrace.cycles-pp.chrdev_open.do_dentry_open.do_open.path_openat.do_filp_open
      2.02 ±  5%      +3.0        5.01 ±  8%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.95 ±  6%      +3.0        5.95 ±  9%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.51 ±  6%      +3.0        6.51 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.54 ±  6%      +3.0        6.55 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.18 ±  6%      +3.0        4.21 ±  8%  perf-profile.calltrace.cycles-pp.ptp_open.posix_clock_open.chrdev_open.do_dentry_open.do_open
      3.57 ±  6%      +3.0        6.61 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.75 ±  6%      +3.1        6.82 ± 10%  perf-profile.calltrace.cycles-pp.open64
      3.58 ±  6%      +3.1        6.66 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.93 ± 11%      +3.2        4.16 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.90 ± 11%      +3.2        4.13 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.87 ± 11%      +3.2        4.10 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.06 ±  8%      +3.2        4.30 ± 11%  perf-profile.calltrace.cycles-pp.__close
      0.51 ± 45%      +3.4        3.91 ± 12%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +3.6        3.59 ± 11%  perf-profile.calltrace.cycles-pp.ptp_release.posix_clock_release.__fput.__x64_sys_close.do_syscall_64
      0.00            +3.7        3.68 ± 11%  perf-profile.calltrace.cycles-pp.posix_clock_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.58 ±  4%      -2.8        9.74 ±  9%  perf-profile.children.cycles-pp.__x64_sys_clock_gettime
      9.42 ±  5%      -2.2        7.20 ±  8%  perf-profile.children.cycles-pp.clock_gettime
      8.84 ±  5%      -2.2        6.67 ±  9%  perf-profile.children.cycles-pp.e1000e_read_systim
      8.97 ±  5%      -2.2        6.81 ±  8%  perf-profile.children.cycles-pp.e1000e_phc_gettimex
      9.12 ±  5%      -2.1        6.98 ±  8%  perf-profile.children.cycles-pp.pc_clock_gettime
     10.92 ±  3%      -1.8        9.07 ±  8%  perf-profile.children.cycles-pp.syscall
     11.24 ±  3%      -1.7        9.51 ± 10%  perf-profile.children.cycles-pp.clock_adjtime
      9.69 ±  3%      -1.5        8.21 ± 10%  perf-profile.children.cycles-pp.__do_sys_clock_adjtime
      7.19 ±  4%      -1.4        5.80 ± 10%  perf-profile.children.cycles-pp.poll_idle
      8.53 ±  4%      -1.3        7.22 ±  9%  perf-profile.children.cycles-pp.do_adjtimex
      6.42 ±  3%      -0.9        5.51 ± 10%  perf-profile.children.cycles-pp.timekeeping_inject_offset
      5.93 ±  3%      -0.9        5.06 ±  9%  perf-profile.children.cycles-pp.clock_was_set
      4.47 ±  3%      -0.5        3.98 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.37 ±  3%      -0.4        1.95 ±  9%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.88 ±  2%      -0.4        2.50 ± 10%  perf-profile.children.cycles-pp.timer_create
      2.08 ±  3%      -0.3        1.74 ±  9%  perf-profile.children.cycles-pp.read_tsc
      1.65 ±  3%      -0.3        1.37 ± 11%  perf-profile.children.cycles-pp.add_device_randomness
      1.43 ±  3%      -0.3        1.16 ± 11%  perf-profile.children.cycles-pp.blake2s_compress
      1.53 ±  3%      -0.3        1.26 ± 11%  perf-profile.children.cycles-pp.blake2s_update
      1.74 ±  5%      -0.3        1.48 ±  8%  perf-profile.children.cycles-pp.hrtimer_wakeup
      1.24 ±  8%      -0.2        1.00 ± 12%  perf-profile.children.cycles-pp.posix_cpu_clock_get
      1.70 ±  5%      -0.2        1.46 ±  8%  perf-profile.children.cycles-pp.try_to_wake_up
      1.81 ±  6%      -0.2        1.59 ± 11%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      1.14 ±  3%      -0.2        0.96 ± 10%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.91 ±  3%      -0.2        0.73 ± 13%  perf-profile.children.cycles-pp.rep_movs_alternative
      1.20 ±  6%      -0.2        1.02 ±  9%  perf-profile.children.cycles-pp.lapic_next_deadline
      1.04 ±  4%      -0.2        0.87 ± 13%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.00 ±  4%      -0.1        0.86 ± 10%  perf-profile.children.cycles-pp.activate_task
      0.96 ±  5%      -0.1        0.83 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.46 ±  7%      -0.1        0.33 ± 15%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.54 ±  8%      -0.1        0.42 ± 16%  perf-profile.children.cycles-pp.clockevents_program_min_delta
      1.04 ±  4%      -0.1        0.94 ±  6%  perf-profile.children.cycles-pp.memset_orig
      0.52 ±  8%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.22 ± 17%      -0.1        0.14 ± 34%  perf-profile.children.cycles-pp.posix_get_monotonic_timespec
      0.22 ± 20%      -0.1        0.14 ± 20%  perf-profile.children.cycles-pp.ktime_get_real_ts64
      0.11 ± 20%      -0.1        0.05 ± 51%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.22 ±  9%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.posix_get_boottime_timespec
      0.12 ±  7%      -0.0        0.08 ± 27%  perf-profile.children.cycles-pp.update_curr_fair
      0.06 ± 46%      +0.0        0.10 ± 25%  perf-profile.children.cycles-pp.memcpy_orig
      0.01 ±223%      +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.default_pointer
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__srcu_read_unlock
      0.00            +0.1        0.08 ± 32%  perf-profile.children.cycles-pp.iput
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.lookup_one_common
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.inode_init_once
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.__d_lookup
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.setup_object
      0.14 ± 20%      +0.1        0.24 ± 13%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.shrink_dcache_parent
      0.02 ±142%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.00            +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.d_lookup
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.lookup_dcache
      0.00            +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.shuffle_freelist
      0.00            +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.d_instantiate
      0.00            +0.1        0.12 ± 24%  perf-profile.children.cycles-pp.down_write
      0.10 ± 36%      +0.1        0.23 ± 29%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.allocate_slab
      0.00            +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.00            +0.1        0.14 ± 34%  perf-profile.children.cycles-pp.d_walk
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.number
      0.00            +0.2        0.16 ± 16%  perf-profile.children.cycles-pp.__destroy_inode
      0.00            +0.2        0.16 ± 16%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.10 ± 26%      +0.2        0.26 ± 18%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.2        0.17 ± 17%  perf-profile.children.cycles-pp.destroy_inode
      0.00            +0.2        0.18 ± 13%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.27 ± 20%      +0.2        0.44 ± 12%  perf-profile.children.cycles-pp.__call_rcu_common
      0.34 ± 14%      +0.2        0.52 ± 15%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.2        0.19 ±  8%  perf-profile.children.cycles-pp.inode_init_always
      0.00            +0.2        0.22 ± 15%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.40 ± 12%      +0.3        0.66 ± 18%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.3        0.26 ± 22%  perf-profile.children.cycles-pp.d_invalidate
      0.00            +0.3        0.28 ± 10%  perf-profile.children.cycles-pp.__d_add
      0.00            +0.3        0.30 ± 11%  perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.3        0.32 ± 15%  perf-profile.children.cycles-pp.evict
      0.55 ±  9%      +0.4        0.90 ± 17%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.14 ± 24%      +0.4        0.50 ± 15%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.4        0.37 ± 11%  perf-profile.children.cycles-pp.sprintf
      0.00            +0.4        0.37 ± 11%  perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.4        0.43 ± 15%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.00            +0.6        0.58 ± 12%  perf-profile.children.cycles-pp.__d_alloc
      1.69 ±  7%      +0.6        2.30 ± 14%  perf-profile.children.cycles-pp.__do_softirq
      1.15 ±  4%      +0.6        1.80 ± 17%  perf-profile.children.cycles-pp.rcu_do_batch
      1.26 ±  4%      +0.6        1.91 ± 15%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.7        0.70 ± 14%  perf-profile.children.cycles-pp.alloc_inode
      0.00            +0.8        0.76 ± 10%  perf-profile.children.cycles-pp.d_alloc
      0.00            +0.8        0.84 ± 11%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.59 ±  6%      +0.9        1.46 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.9        0.91 ± 11%  perf-profile.children.cycles-pp.new_inode
      0.00            +1.0        1.01 ± 15%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +1.0        1.05 ± 11%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +1.1        1.10 ± 11%  perf-profile.children.cycles-pp.dentry_kill
      0.00            +1.2        1.16 ± 11%  perf-profile.children.cycles-pp.__lookup_slow
      0.10 ± 30%      +1.2        1.31 ± 10%  perf-profile.children.cycles-pp.dput
      0.00            +1.3        1.26 ± 12%  perf-profile.children.cycles-pp.__debugfs_create_file
      0.00            +1.4        1.44 ± 13%  perf-profile.children.cycles-pp.mnt_get_count
      0.00            +1.4        1.44 ± 11%  perf-profile.children.cycles-pp.lookup_one_len
      0.00            +1.5        1.47 ± 13%  perf-profile.children.cycles-pp.debugfs_create_dir
      0.01 ±223%      +1.6        1.60 ± 13%  perf-profile.children.cycles-pp.mntput_no_expire
      0.00            +1.6        1.61 ± 11%  perf-profile.children.cycles-pp.start_creating
      0.00            +2.4        2.43 ± 12%  perf-profile.children.cycles-pp.simple_recursive_removal
      0.00            +3.0        2.96 ± 11%  perf-profile.children.cycles-pp.debugfs_remove
      1.75 ±  5%      +3.0        4.71 ±  8%  perf-profile.children.cycles-pp.do_dentry_open
      1.35 ±  6%      +3.0        4.33 ±  8%  perf-profile.children.cycles-pp.posix_clock_open
      2.93 ±  5%      +3.0        5.91 ±  9%  perf-profile.children.cycles-pp.path_openat
      1.42 ±  6%      +3.0        4.41 ±  8%  perf-profile.children.cycles-pp.chrdev_open
      2.03 ±  5%      +3.0        5.02 ±  8%  perf-profile.children.cycles-pp.do_open
      2.97 ±  6%      +3.0        5.98 ±  9%  perf-profile.children.cycles-pp.do_filp_open
      3.54 ±  6%      +3.0        6.56 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
      3.57 ±  6%      +3.0        6.59 ±  9%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.18 ±  6%      +3.0        4.22 ±  8%  perf-profile.children.cycles-pp.ptp_open
      3.79 ±  6%      +3.1        6.84 ± 10%  perf-profile.children.cycles-pp.open64
      0.87 ± 11%      +3.2        4.10 ± 12%  perf-profile.children.cycles-pp.__x64_sys_close
      1.09 ±  9%      +3.2        4.34 ± 11%  perf-profile.children.cycles-pp.__close
      0.59 ± 11%      +3.3        3.92 ± 12%  perf-profile.children.cycles-pp.__fput
      0.31 ± 19%      +3.4        3.68 ± 11%  perf-profile.children.cycles-pp.posix_clock_release
      0.18 ± 15%      +3.4        3.59 ± 11%  perf-profile.children.cycles-pp.ptp_release
      8.84 ±  5%      -2.2        6.67 ±  9%  perf-profile.self.cycles-pp.e1000e_read_systim
      3.55 ±  7%      -0.8        2.72 ± 14%  perf-profile.self.cycles-pp.poll_idle
      4.42 ±  3%      -0.5        3.92 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.32 ±  4%      -0.4        1.90 ±  9%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.01 ±  3%      -0.3        1.70 ±  8%  perf-profile.self.cycles-pp.read_tsc
      1.78 ±  5%      -0.3        1.50 ±  9%  perf-profile.self.cycles-pp.syscall
      1.43 ±  3%      -0.3        1.16 ± 11%  perf-profile.self.cycles-pp.blake2s_compress
      1.08 ±  5%      -0.2        0.88 ± 15%  perf-profile.self.cycles-pp._copy_to_user
      1.20 ±  6%      -0.2        1.02 ±  9%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.56 ±  4%      -0.1        0.44 ± 17%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.42 ±  8%      -0.1        0.30 ± 16%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.52 ±  8%      -0.1        0.42 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38 ± 10%      -0.1        0.30 ± 19%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.44 ±  9%      -0.1        0.36 ±  9%  perf-profile.self.cycles-pp.__schedule
      0.28 ± 14%      -0.1        0.20 ± 10%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.09 ± 29%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.do_adjtimex
      0.21 ± 13%      -0.0        0.16 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.12 ±  8%      -0.0        0.08 ± 22%  perf-profile.self.cycles-pp.update_curr_fair
      0.13 ± 20%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.apparmor_capable
      0.06 ± 50%      +0.0        0.10 ± 16%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.02 ±144%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.do_filp_open
      0.17 ± 16%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.put_timespec64
      0.02 ±141%      +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.___slab_alloc
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.__srcu_read_unlock
      0.02 ±141%      +0.1        0.09 ± 24%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.44 ±  9%      +0.1        0.52 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.inode_init_once
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.00            +0.1        0.09 ± 25%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.__d_lookup
      0.00            +0.1        0.09 ± 26%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.slab_pre_alloc_hook
      0.01 ±223%      +0.1        0.11 ± 51%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.00            +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.inode_init_always
      0.00            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.number
      0.26 ± 19%      +0.2        0.44 ± 18%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.11 ± 29%      +0.3        0.39 ± 18%  perf-profile.self.cycles-pp._find_next_bit
      0.58 ±  7%      +0.8        1.42 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +1.1        1.14 ± 14%  perf-profile.self.cycles-pp.mnt_get_count




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

