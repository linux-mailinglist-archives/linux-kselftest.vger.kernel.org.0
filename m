Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6C79C6C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjILGSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjILGSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:18:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF88E78;
        Mon, 11 Sep 2023 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694499477; x=1726035477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PnV2Q1NMq/14IqkmajYkGVpaNK0ykYYjLpGES1HoQRs=;
  b=DOr7Iu6IyljgCg3Lhu2Wgf32zZePGZpxsBNpuMbRMq6cjbmym5guZVQW
   aW+gPLN55v5WIeEkeevkjB73tZJT7usoYjYizeAjvXBTNyDa+mvApA3Xf
   KUi48mmW0NbRuC4TNYdK1CjAFNq4uAbzy9bYDfp2lPgX0/XRT8YTcIjnP
   6qobKzcPOnr1Lckmx2BvoEqf5aWhv3Xep5dE5mm9U36Z2GPvtquQNTYNv
   UIPyuIEgpg4Tzo6ldl+VUXXp8xO93iAYBdBgGusGog9c7YDStoxhTtn1F
   ul9eJd6bn/8POE9+L07ZRVPgLAmvcnUTF5PgnuyFRo/rHHKmH2lIkL17r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442298686"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="442298686"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867250494"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="867250494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:17:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:17:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:17:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8jacsqFy0hhfxEsCYtOin7b12tEaZGYlgOqTsrC2D3sEqHsq4TRsnPn5oSuj+urXcAH5+mwdz8DfSi2wt0+WEW8gmnV2/eiBBpBRy5uWzcQd8CQ232Z9J0F/0PKmauYgZvCHn+Y0wWSJHasw8jcoKsJZLR8Fz7k+NMSItlK7XIS8ViSgTAjw1JibLOBG0XHxK1nv+mlFC+HCblMw5gc/PATtiuwEzha9kJ8j0fI8U3DtEZ0bOku40VZPcd+6lMMs1UvGFCcZWBzSC7zYVGNc3IeAFBmy4wGF0e5X1bd7cK/yLJ1mU3wspvPZFfFE8HkuUueI2dNAuZvqDZtuQUlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otIqKsytV685mkM7q1QhVKAKA+XE4nx1pg7gNyZ1Ryo=;
 b=ik1OU0IGMD+S6jZQ/6+7BrCoVs5Uu3NozD/83ZuoLxLEoeo6Q9rZavSGiMS7lwej8rVzE2SpCzEswWql07TTg2hPj8rHXfJ9GsCJePEFgUqDz9FXAiLrBxuSLEVVQEc3O+dt3bhfdsLk6O4qqWmcyjpRy4rgsXgN6x+uoayqw9PAmh1lsRR9WnFwXk16Hi9lFhNH7lwidoOVrQYTsldu3N48+iDPXPFT7t5iQuP+J8WIruAuQOe+utlhWyPROOo7jzYRicQ9gJ9vcRNBlBnD76HZrdrv5vP0buubE7CRQS/J9bEYrrz2Im1cv4ngCGTdBz9P3k+kydHhp55DW7Js6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA0PR11MB4638.namprd11.prod.outlook.com (2603:10b6:806:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:17:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:17:50 +0000
Date:   Tue, 12 Sep 2023 14:17:38 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [selftests]  58e2847ad2:
 kernel-selftests.openat2.resolve_test.fail
Message-ID: <202309121342.97e2f008-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA0PR11MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: da423da8-00f9-47bb-6428-08dbb357fd77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I50ybrl722fElz6BhAHrumj2g6OUPZlPVMHd98a71ICxOkb4gedmD3um9lQHsPLb1teQPnJYJHWo0Ns85FNs8m5nfCRI6xhGE6Qj0gSXsvAZ0NmVg4TG8Sbbu/pEHvNByq7Q4blnLa0Avhy7s6blkulwmdmcDfsyjsK3bca5TQccRunecTVY+kx9RHXTq7D9BJDN58Ve/zfh6bMhKHebysSgHS5AQlWMnghdxTBjDBZ6fssPZSycvs/NaoQuZUeyOoSwczXgiHWDyzkmOEGTb6gtLkQuipXEq9kwyFs7/bwtTF2RE2Zh02Mg3ZaIV1M7AOelnP9dopwNJVV/WXRzd+uNzx+rGXLRKjutAiiyK52Ul2SqKax6ZUPj7bChI/p84No+avY7CF9kwaXkRDJ1DWOQncdX8WU08qN6ZX7WNB2lNfPnCKI3c5kXxxqLLcByeUJEVr+tzZ1YSP2V6J1TniKe+q1kQxoWQ1QJSu28UNxh6/GW2s0VrOLsDkyyiCMQwN5yhXasxe/gAD5HeYiQfhINxfBTzKMuz1L3m4nioCv998H4d2AlQ1QvrRjRLUpp97apUOc/S4RemTyYMJyBgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(66946007)(41300700001)(316002)(8676002)(8936002)(54906003)(4326008)(6916009)(66476007)(66556008)(6512007)(966005)(478600001)(36756003)(38100700002)(6486002)(2616005)(7416002)(6666004)(6506007)(26005)(2906002)(107886003)(1076003)(83380400001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6ieQXyUFVCy0yFFZpntaY6sscZvBbYYg5VoyYZ145kyQlS2cUUZPdAdSXLt?=
 =?us-ascii?Q?COM9joo+QssvXzacFX7d7qU9ARGynUuCgkQEjVCPqm1tOMf0yLBdBeto18iP?=
 =?us-ascii?Q?5M2naIN3d4Z0vTGETcXnN1P+j7f35DtLMRe28n3sFMrfa4/61qlkfepoSV/w?=
 =?us-ascii?Q?xoiU5Dt2ovVjkGNQcLBJLxfWJO1Y2176vwSL/xuLqN7csbVi6h0wHP3AyhW1?=
 =?us-ascii?Q?b1YoXpDLdfl0xbx261xjJrMnopfZhPILPZwxXeV6voY8YISJ2jLbD1Ss7x0I?=
 =?us-ascii?Q?1XJmi4FSLNd24v7TqXfa+KAkenUPGUiaqvvoYSfKnP1W6ytyzKrXXJOAttl6?=
 =?us-ascii?Q?MSiTOgOyuFDrWDpB8njNSaIfPIqwAgxBF4zVm2F3hkme9ltRRA4DMmJmstsU?=
 =?us-ascii?Q?J6DZZPcSuH+2qbwX4x+Hba1N4JYhdSse1yUohuxhBbqHjQthK7d2+QfLo6K/?=
 =?us-ascii?Q?rLmBq4Q/PfQLe4Th6/t/WT8ZFoLCG4k65XJhAnkKpRSZkn/kDD9Buzs8S+zD?=
 =?us-ascii?Q?/pltmXNinXUsM55pa7VMdxbani6x4ul/Ou63QDywjfuY7aME1gJ6NT3Pb40H?=
 =?us-ascii?Q?KWukFGdMAljIli5acimq3oo8fFG5EzdD/XnmMKRpeodLBdn5JpyYE+J/YHAk?=
 =?us-ascii?Q?tF1wzb5hQ1gbjIaaDFGRTxaiYXhMNi6LkeWEERDGkqwWGl/bHDZ5PMGDk78a?=
 =?us-ascii?Q?uLxwUjv1OO+YkRFXwvGQQNX1g5x66iqNZN+rYU2YKlv5gR1WetKgncIqvV/H?=
 =?us-ascii?Q?10a0ekBdDg3UFCZqYRLgv0jLHwaugD3QPUUg0xVEivbu9zkn60+GKG9Xk0rU?=
 =?us-ascii?Q?mvslsm3EklH2zU9hUhq8mFo1uQ8jPzOJK5jjyuTVeKdhpVXj1bfiztC4KZXe?=
 =?us-ascii?Q?ng6ox0JZ98Nb9i2Q9DGA92gbzp5Xq1ru5MnEDRauEH7kL2U0dozvT/ZG9rX+?=
 =?us-ascii?Q?A75oIAeTxnu6NFdA/38+5UR9eMjWUyh/v7b9+EOL7qe77kpYiErc0pwYZUwb?=
 =?us-ascii?Q?Qb1H0kXlUP3ZTKVAT9/tvN3iWGBZ8BMc8Tmf9n6tAgTzdE7VUAmW1xlhDR14?=
 =?us-ascii?Q?s3KrROFaaJJURXkuDsPof9eEieQE9V+FP0PZNc2LM3iY88U7LbaC+dTo77do?=
 =?us-ascii?Q?qJjd0WQ9RhuyY04bfCKAIxnnRf/dboF4F9VmS2QeSOOWEk0Z4RwDX3NzVUR/?=
 =?us-ascii?Q?oRKAEYqXTvRkGhcSr5fCq+OkXXpfdQB7D5X2/raAMgP/ojioaAyd5aA68zWn?=
 =?us-ascii?Q?F1vMJMWL8f55fMa81G4OumKKATyqXXBxQqNODLCDeGThTzRFwYSXhScsk0FV?=
 =?us-ascii?Q?HtjAgyXz3Ie+TXlhr1xYaQc0/K+pnYOgd4oFtj7/KkDjd64EG/TA6j5TrMEA?=
 =?us-ascii?Q?Y55dwT/r9qyhJDLfgNohj4IskuQ2L/myRN+oWsTb55Di7onG7QJGXF6VxnzF?=
 =?us-ascii?Q?zaGNov4uJmp1aH/GK+DCQ60ozRe2X5WC3Qr1hDMzjX8K/sOTsyDWLd7sUK4g?=
 =?us-ascii?Q?k3+mgJfj+Mnq8YMoH2cltnt4+V/oXpsMkY1fdhvzjSzhSUZpI7zYNvFYDyIr?=
 =?us-ascii?Q?MLntRoYOqLwWjGFeLVgsK272APdJXXoCv5yz+j5GToydhaJaqg1PizGmXbDC?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da423da8-00f9-47bb-6428-08dbb357fd77
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:17:50.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0cpcpGmMDMTCYHwm37bzP+XdTuZLFqXWY5niNNnMs9AxJ0/NDbnGStcY59BncbRzNV5VlUXO9YTZp1Ejug+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4638
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Hello,

kernel test robot noticed "kernel-selftests.openat2.resolve_test.fail" on:

commit: 58e2847ad2e6322a25dedf8b4549ff924baf8395 ("selftests: line buffer test program's stdout")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


[test failed on linus/master 0bb80ecc33a8fb5a682236443c1e740d5c917d1d]
[test failed on linux-next/master 7bc675554773f09d88101bf1ccfc8537dc7c0be9]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-02



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309121342.97e2f008-oliver.sang@intel.com


besides kernel-selftests.openat2.resolve_test, we also observed

ea09800bf17561a0 58e2847ad2e6322a25dedf8b454
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kernel-selftests.openat2.openat2_test.fail
           :6          100%           6:6     kernel-selftests.openat2.resolve_test.fail

which pass on parent commit.

however, there are other tests such like below "perf_events: sigtrap_threads"
are not impacted by this commit.

we want to consult with you if there is some special config need to do after
this commit? Thanks a lot!



TAP version 13
1..3
# timeout set to 300
# selftests: openat2: openat2_test
# ==4052==ASan runtime does not come first in initial library list; you should either link runtime to your application or manually preload it with LD_PRELOAD.
not ok 1 selftests: openat2: openat2_test # exit=1
# timeout set to 300
# selftests: openat2: resolve_test
# ==4070==ASan runtime does not come first in initial library list; you should either link runtime to your application or manually preload it with LD_PRELOAD.
not ok 2 selftests: openat2: resolve_test # exit=1

...

TAP version 13
1..2
# timeout set to 120
# selftests: perf_events: sigtrap_threads
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           sigtrap_threads.remain_disabled ...
# #            OK  sigtrap_threads.remain_disabled
# ok 1 sigtrap_threads.remain_disabled

...


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309121342.97e2f008-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

