Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5A423494
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJEXrq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 19:47:46 -0400
Received: from mail-bn8nam11hn2202.outbound.protection.outlook.com ([52.100.171.202]:63616
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237016AbhJEXrn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 19:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIDwIA5vSNiFklwCngSqdTPE0hZKhUwbwx1yiZP/ZNwOuAZF3ZfXFB3gW2oJ22IFruH/zmj27531MI0Ao4LGRhfR8TR9eOMNgy+KrICSyEey3y25uAppaN88Az+vTFOXkKssfJ8f0wWxlhco6v1F0+Fbhh7CtWltJBtDrIYDt51xkl7ru+NE5m19GuXbL0KKqRyDJEk9urNwa7xIgRyqxuiX74Y+C0dM1eSWVbPl8jqYr2sSq9i1bxOIcSW4B2VDWZ9gp63wkMzp6UGXKDKoQ+sHyk51/TdhjVJ1G+676u8cYKeXQK/opUOPRbBK7Mqzpvx4HS0U4xzTIR/lzCAR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNc1Vp8B73BXYEpwY4yuFcoRId/o+0rdFZiZXHm3R1w=;
 b=MpSYlrYUr/itcFYl1oNtwn1sv/0tBNiIws0If3e+dtB9TL3/3l73tD2RD2apPAxZKaiq4pQo5cH6316iAtgBJm9M95dngeWH3ybroLFDA7Z/MwYnRdT1Puh+g5H1ee5LnoFVrFtFLqwSDM5w1dVMpiojyU5fAy3J0QZmn64Yqja7u0GMUKEvNN4g1FeO728BFG4se7H6Iae00qcvOWjod7PPp3g2qKpXakquri8LZkFCw9bifSWqdLpYEzP8Y4+reuRE7jQc1sKRi7O5QCVUYkLLRgEqPx9RoF2xY7CM4HryPb4xzw1u9Cv1ncIuDNqpO2k1eRV9ISpSxpYffLJWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNc1Vp8B73BXYEpwY4yuFcoRId/o+0rdFZiZXHm3R1w=;
 b=4uYDSVo5q0sLgdTnX2MkEG9Rr9s4htZu1BBlQebgkLybSxjLX0k8LgQVrDAdduNhjMuQ7qYpachJC7frARrvNBwICd9udAHbVtz14ulzvRfZfdx6hRbgiUTuh0OuWskWhSpnitl+vVPm0AvmJsqhClmiLu3VOKfKCYzdF1EzyV4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 23:45:50 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::59b0:c983:56:ec27%5]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 23:45:49 +0000
From:   Michael Roth <michael.roth@amd.com>
To:     linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [RFC 11/16] KVM: selftests: add library for handling SEV-ES-related exits
Date:   Tue,  5 Oct 2021 18:44:54 -0500
Message-Id: <20211005234459.430873-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005234459.430873-1-michael.roth@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
Received: from localhost (165.204.77.1) by SA9PR13CA0037.namprd13.prod.outlook.com (2603:10b6:806:22::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Tue, 5 Oct 2021 23:45:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56ebb1f1-037a-45e1-58d1-08d9885a4297
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39253CDA07A6BFD638ED1B2195AF9@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YvCl55RbV/Kfnb8OxevMoKNNAxiY/vXWKsxzmbw3pV6GXastp0JFRIMVnsMA?=
 =?us-ascii?Q?39kn2PilqQH5sd+Ye/+H2IrLUuyUj6lV3BI6xN9xhBi3GvuVD0c3E3wU4VZw?=
 =?us-ascii?Q?tZrqit7eBBK9u+rzsyZiT6Ouk481fTVN5+9Yk4TTjvOXJPcteFtj/zHaBO7v?=
 =?us-ascii?Q?n0XeP1xXPuXhK1H7IHaDG42LQ28tRpg1Yif8LaQGHQMEUw7om3mEolnJp8rT?=
 =?us-ascii?Q?PsEqV/z8QbgmhsSNPp60mAsY0r7+0Te5Paj1HiNMCXblNo8fQfWONitD5k1z?=
 =?us-ascii?Q?k6M7Vhev3g19LOL9mtvXsig93ocmE21cjRnyw7jSSSGkZu0NncaXI5eOWTPw?=
 =?us-ascii?Q?fviT4g+1+ZlYiti/CEVG8GjZ/oK20+fYj5zIfb1wJHaZtBrrHqXttUX5YfKU?=
 =?us-ascii?Q?YKu1hWTUQ9uJ9W2OCg1+aq2gqJFCE/Jj7UBL24HNFmuk14107bu3/ujnIGm+?=
 =?us-ascii?Q?OxGmjIpWFw8UTNsdZPks/G1f1okfGvKMnKfJoSihBQ3DXEFYm9Q1xXjfmfDO?=
 =?us-ascii?Q?KUYaAPPV9iiHJ7r1ADLE6FajSOOByzGOdgVgRNPUIVFlJDmNurqYNAsU8P97?=
 =?us-ascii?Q?MMI1BeNxIxdzv8CMasNePSwJpbAyC3I7PiocW36ghhsaqHOA+ia0DpXAaFgv?=
 =?us-ascii?Q?r/s1pMTfIQkJ/mYnGgz2Of8q+EpEJIra5sze7lU4MfVKClppVFupeCs+8B57?=
 =?us-ascii?Q?fddQRzv+c9eA630A/SnDUJ2vZlAoWI0tpsH/mAtL1bz0jVtktcbbBb3XsOx/?=
 =?us-ascii?Q?0v7vl1I9KsS4c3NTp88pxqDGz/pJ78q64UEriGHoClztWZ0kPNjfMRNLaENr?=
 =?us-ascii?Q?2zElrdP502NK8VsUXmeRrlTRg03FrYDv43QQ7QpsIwD9UHoYr0vymkkQUZ8g?=
 =?us-ascii?Q?HJdkITLAYrLZPhbtYwbM3A9HKC29tx5hB+Db4D7XpFp6xeE3D6kZpJdinfr/?=
 =?us-ascii?Q?vz0bHobwvf9czHhZlVXno2IhjpWHLY8URFqBwBoHjVep0+l1ZA2Xs6s1lICD?=
 =?us-ascii?Q?bIhtkixTYSrUjesKpHmu7SqeHxPKPukXBGbuFAtXIhx649E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(8936002)(5660300002)(6486002)(30864003)(6666004)(6916009)(316002)(8676002)(44832011)(26005)(54906003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(38100700002)(52116002)(956004)(508600001)(36756003)(7416002)(86362001)(2616005)(4326008)(1076003)(6496006)(186003)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJvp/6040UrjR4qIyXmxC3NWmriPIz4vPNDhWWFcNGsNqDspGb46pfj05k6o?=
 =?us-ascii?Q?WcOpdi5gcG/v2c063e7JWTHD6J+2cON0Nd/TFinMZIO9rFBF7WadGIbZC33q?=
 =?us-ascii?Q?dplaLbsJIrhBw2UWI7SXxDw2+W4AoaQiFLXPMB23/u1ruQZTvzn7z1qlnC49?=
 =?us-ascii?Q?ckurtwOTwyQTELRN7ePSXWI2o7eOx5dspYlMPthoZkaIhShvo8SlRR190MHe?=
 =?us-ascii?Q?AJO7um6Ap81GeXjscQeJKNG1wW5WO8nXYkbxGW0yDIx2xwiw6kG7LZNO5q4T?=
 =?us-ascii?Q?9bEC4xto3S+QO9BkNi1+c3FlW+HqttYD/lXLe5bGJrsTV5ROs5KI6afvdMIF?=
 =?us-ascii?Q?fmS5KJLIrZ/6ETP9d0j/qTrS9ojMxP0k8twu39BfGnDKyW/Tb4oeL+SzlPeh?=
 =?us-ascii?Q?4Nniiqa22H/ywcZWka+ls0QCqYeYoy4o1x6Vj/LWB7CN9gJOOTlVQCvJ537H?=
 =?us-ascii?Q?mc4prvE8wrPfo11eydTchTA06U6wsysJX0aWqgA5WHD+jPryZ2/Xvquw7sUn?=
 =?us-ascii?Q?XSldkYJBj1d26JirnWQv+Z3pMz1Ha5ziw9rAmdja/S23Vy0zIyLRjt3sapRw?=
 =?us-ascii?Q?W5rX2THM4KqXe6VIR63AJHh9ZPcoNX2YRhq1BM2RFcYmgdCLkbOl9btOp4pD?=
 =?us-ascii?Q?QqgALF9taxmV60sYqmEH+QEg+6FyEKLIf2vaBsy+HF+QgcUO5altRrQDWt53?=
 =?us-ascii?Q?QyhkRAI7XZvzb6nSmGWjjPR/oaioPk/NmcAuf8303mR2wO/CdvvNg1i0VaIg?=
 =?us-ascii?Q?NftttByvAE+bewSg8MDKGPwNUGgVJrY7Mr5zopkAk0XkX+mTWIvXIULtVEC4?=
 =?us-ascii?Q?hSuVNjITy5cxYVDQwUmS3raVXOYnAjDm8Ed0KDejHhasacTHHblBt0nBQsYZ?=
 =?us-ascii?Q?xKYzeNF1VPceLyyOS2s6lSgF2+kY27GFtkw8lRNkRpE3itvrTJf83KxN5PX8?=
 =?us-ascii?Q?j5z8N9mnR1sgdxsErEk4/8UH5inc4hbjplyCdEiC6Z++LRPA5j1fUq+Chs8/?=
 =?us-ascii?Q?mIYgwZRqBSU/XfJmeaYneWvKwxbMG2A+TqVUkoXuS/57gE6CLBNRU1KTBQ28?=
 =?us-ascii?Q?4lGxnsQWcQDsrJ2ysNPhMR4e1PTN2O1Ysay7Aa1rcVPICkN8BswziWIUDsk7?=
 =?us-ascii?Q?F/UVqT32igiaAvibrn33MNSrivJYqpRER+y3zfSHmK9hIDi4pD9p9MowVVZ4?=
 =?us-ascii?Q?3fPzJBn/fZvrOcNydq19qYuIvTGmXGL6MdWssn3zgnelkMwhKIXl8eTPEdG6?=
 =?us-ascii?Q?I7H6T4B2ElQ0q+5ET8zEcv2se/01FmQH1VmXfJ5Uu1hc36AxZXGrpMv2eDut?=
 =?us-ascii?Q?vyZ3vzhUbuBN2vLz0PJKqFLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ebb1f1-037a-45e1-58d1-08d9885a4297
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 23:45:49.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPFm0xjBAxTt8nxAlPMNJuS+s/hvKPB7CkaFZzKbNBqTxMGXnKHr4J1BUwiJcisuSODxEFs4hmGMfyrc2xyHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add (or copy from kernel) routines related to handling #VC exceptions
(only for cpuid currently) or issuing vmgexits. These will be used
mostly by guest code.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   2 +-
 .../kvm/include/x86_64/sev_exitlib.h          |  14 +
 .../selftests/kvm/include/x86_64/svm.h        |  35 +++
 .../selftests/kvm/include/x86_64/svm_util.h   |   1 +
 .../selftests/kvm/lib/x86_64/sev_exitlib.c    | 249 ++++++++++++++++++
 5 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index aa8901bdbd22..7b3261cc60a3 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,7 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
-LIBKVM_x86_64 += lib/x86_64/sev.c
+LIBKVM_x86_64 += lib/x86_64/sev.c lib/x86_64/sev_exitlib.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h b/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
new file mode 100644
index 000000000000..4b67b4004dfa
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * VC/vmgexit/GHCB-related helpers for SEV-ES/SEV-SNP guests.
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+
+#ifndef SELFTEST_KVM_SEV_EXITLIB_H
+#define SELFTEST_KVM_SEV_EXITLIB_H
+
+int sev_es_handle_vc(void *ghcb, u64 ghcb_gpa, struct ex_regs *regs);
+void sev_es_terminate(int reason);
+
+#endif /* SELFTEST_KVM_SEV_EXITLIB_H */
diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index f4ea2355dbc2..d633caea4b7d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -204,6 +204,41 @@ struct __attribute__ ((__packed__)) vmcb_save_area {
 	u64 br_to;
 	u64 last_excp_from;
 	u64 last_excp_to;
+
+	/*
+	 * The following part of the save area is valid only for
+	 * SEV-ES guests when referenced through the GHCB or for
+	 * saving to the host save area.
+	 */
+	u8 reserved_7[80];
+	u32 pkru;
+	u8 reserved_7a[20];
+	u64 reserved_8;		/* rax already available at 0x01f8 */
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u64 reserved_9;		/* rsp already available at 0x01d8 */
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u8 reserved_10[16];
+	u64 sw_exit_code;
+	u64 sw_exit_info_1;
+	u64 sw_exit_info_2;
+	u64 sw_scratch;
+	u64 sev_features;
+	u8 reserved_11[48];
+	u64 xcr0;
+	u8 valid_bitmap[16];
+	u64 x87_state_gpa;
 };
 
 struct __attribute__ ((__packed__)) vmcb {
diff --git a/tools/testing/selftests/kvm/include/x86_64/svm_util.h b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
index b7531c83b8ae..4319bb6f4691 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm_util.h
@@ -16,6 +16,7 @@
 #define CPUID_SVM_BIT		2
 #define CPUID_SVM		BIT_ULL(CPUID_SVM_BIT)
 
+#define SVM_EXIT_CPUID		0x072
 #define SVM_EXIT_VMMCALL	0x081
 
 struct svm_test_data {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
new file mode 100644
index 000000000000..b3f7b0297e5b
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * GHCB/#VC/instruction helpers for use with SEV-ES/SEV-SNP guests.
+ *
+ * Partially copied from arch/x86/kernel/sev*.c
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+
+#include <linux/bitops.h>
+#include <kvm_util.h>			/* needed by kvm_util_internal.h */
+#include "../kvm_util_internal.h"	/* needed by processor.h */
+#include "processor.h"			/* for struct ex_regs */
+#include "svm_util.h"			/* for additional SVM_EXIT_* definitions */
+#include "svm.h"			/* for VMCB/VMSA layout */
+#include "sev_exitlib.h"
+
+#define PAGE_SHIFT 12
+
+#define MSR_SEV_ES_GHCB 0xc0010130
+
+#define VMGEXIT() { asm volatile("rep; vmmcall\n\r"); }
+
+#define GHCB_PROTOCOL_MAX	1
+#define GHCB_DEFAULT_USAGE	0
+
+/* Guest-requested termination codes */
+#define GHCB_TERMINATE 0x100UL
+#define GHCB_TERMINATE_REASON(reason_set, reason_val)	\
+	(((((u64)reason_set) &  0x7) << 12) |			\
+	 ((((u64)reason_val) & 0xff) << 16))
+
+#define GHCB_TERMINATE_REASON_UNSPEC 0
+
+/* GHCB MSR protocol for CPUID */
+#define GHCB_CPUID_REQ_EAX 0
+#define GHCB_CPUID_REQ_EBX 1
+#define GHCB_CPUID_REQ_ECX 2
+#define GHCB_CPUID_REQ_EDX 3
+#define GHCB_CPUID_REQ_CODE 0x4UL
+#define GHCB_CPUID_REQ(fn, reg) \
+	(GHCB_CPUID_REQ_CODE | (((uint64_t)reg & 3) << 30) | (((uint64_t)fn) << 32))
+#define GHCB_CPUID_RESP_CODE 0x5UL
+#define GHCB_CPUID_RESP(resp) ((resp) & 0xfff)
+
+/* GHCB MSR protocol for GHCB registration */
+#define GHCB_REG_GPA_REQ_CODE 0x12UL
+#define GHCB_REG_GPA_REQ(gfn) \
+	(((unsigned long)((gfn) & GENMASK_ULL(51, 0)) << 12) | GHCB_REG_GPA_REQ_CODE)
+#define GHCB_REG_GPA_RESP_CODE 0x13UL
+#define GHCB_REG_GPA_RESP(resp) ((resp) & GENMASK_ULL(11, 0))
+#define GHCB_REG_GPA_RESP_VAL(resp) ((resp) >> 12)
+
+/* GHCB format/accessors */
+
+struct ghcb {
+	struct vmcb_save_area save;
+	u8 reserved_save[2048 - sizeof(struct vmcb_save_area)];
+	u8 shared_buffer[2032];
+	u8 reserved_1[10];
+	u16 protocol_version;
+	u32 ghcb_usage;
+};
+
+#define GHCB_BITMAP_IDX(field)							\
+	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
+
+#define DEFINE_GHCB_ACCESSORS(field)						\
+	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
+	{									\
+		return test_bit(GHCB_BITMAP_IDX(field),				\
+				(unsigned long *)&ghcb->save.valid_bitmap);	\
+	}									\
+										\
+	static inline u64 ghcb_get_##field(struct ghcb *ghcb)			\
+	{									\
+		return ghcb->save.field;					\
+	}									\
+										\
+	static inline u64 ghcb_get_##field##_if_valid(struct ghcb *ghcb)	\
+	{									\
+		return ghcb_##field##_is_valid(ghcb) ? ghcb->save.field : 0;	\
+	}									\
+										\
+	static inline void ghcb_set_##field(struct ghcb *ghcb, u64 value)	\
+	{									\
+		__set_bit(GHCB_BITMAP_IDX(field),				\
+			  (unsigned long *)&ghcb->save.valid_bitmap);		\
+		ghcb->save.field = value;					\
+	}
+
+DEFINE_GHCB_ACCESSORS(cpl)
+DEFINE_GHCB_ACCESSORS(rip)
+DEFINE_GHCB_ACCESSORS(rsp)
+DEFINE_GHCB_ACCESSORS(rax)
+DEFINE_GHCB_ACCESSORS(rcx)
+DEFINE_GHCB_ACCESSORS(rdx)
+DEFINE_GHCB_ACCESSORS(rbx)
+DEFINE_GHCB_ACCESSORS(rbp)
+DEFINE_GHCB_ACCESSORS(rsi)
+DEFINE_GHCB_ACCESSORS(rdi)
+DEFINE_GHCB_ACCESSORS(r8)
+DEFINE_GHCB_ACCESSORS(r9)
+DEFINE_GHCB_ACCESSORS(r10)
+DEFINE_GHCB_ACCESSORS(r11)
+DEFINE_GHCB_ACCESSORS(r12)
+DEFINE_GHCB_ACCESSORS(r13)
+DEFINE_GHCB_ACCESSORS(r14)
+DEFINE_GHCB_ACCESSORS(r15)
+DEFINE_GHCB_ACCESSORS(sw_exit_code)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
+DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
+DEFINE_GHCB_ACCESSORS(sw_scratch)
+DEFINE_GHCB_ACCESSORS(xcr0)
+
+static uint64_t sev_es_rdmsr_ghcb(void)
+{
+	uint64_t lo, hi;
+
+	asm volatile("rdmsr"
+		     : "=a" (lo), "=d" (hi)
+		     : "c" (MSR_SEV_ES_GHCB));
+
+	return ((hi << 32) | lo);
+}
+
+static void sev_es_wrmsr_ghcb(uint64_t val)
+{
+	uint64_t lo, hi;
+
+	lo = val & 0xFFFFFFFF;
+	hi = val >> 32;
+
+	asm volatile("wrmsr"
+		     :: "c" (MSR_SEV_ES_GHCB), "a" (lo), "d" (hi)
+		     : "memory");
+}
+
+void sev_es_terminate(int reason)
+{
+	uint64_t val = GHCB_TERMINATE;
+
+	val |= GHCB_TERMINATE_REASON(2, reason);
+
+	sev_es_wrmsr_ghcb(val);
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt" : : : "memory");
+}
+
+static int sev_es_ghcb_hv_call(struct ghcb *ghcb, u64 ghcb_gpa, u64 exit_code)
+{
+	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->ghcb_usage = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wrmsr_ghcb(ghcb_gpa);
+
+	VMGEXIT();
+
+	/* Only #VC exceptions are currently handled. */
+	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1)
+		sev_es_terminate(GHCB_TERMINATE_REASON_UNSPEC);
+
+	return 0;
+}
+
+static int handle_vc_cpuid(struct ghcb *ghcb, u64 ghcb_gpa, struct ex_regs *regs)
+{
+	int ret;
+
+	ghcb_set_rax(ghcb, regs->rax);
+	ghcb_set_rcx(ghcb, regs->rcx);
+
+	/* ignore additional XSAVE states for now */
+	ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ghcb_gpa, SVM_EXIT_CPUID);
+	if (ret)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return 1;
+
+	regs->rax = ghcb->save.rax;
+	regs->rbx = ghcb->save.rbx;
+	regs->rcx = ghcb->save.rcx;
+	regs->rdx = ghcb->save.rdx;
+
+	regs->rip += 2;
+
+	return 0;
+}
+
+static int handle_msr_vc_cpuid(struct ex_regs *regs)
+{
+	uint32_t fn = regs->rax & 0xFFFFFFFF;
+	uint64_t resp;
+
+	sev_es_wrmsr_ghcb(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
+	VMGEXIT();
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_CPUID_RESP(resp) != GHCB_CPUID_RESP_CODE)
+		return 1;
+	regs->rax = resp >> 32;
+
+	sev_es_wrmsr_ghcb(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
+	VMGEXIT();
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_CPUID_RESP(resp) != GHCB_CPUID_RESP_CODE)
+		return 1;
+	regs->rbx = resp >> 32;
+
+	sev_es_wrmsr_ghcb(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
+	VMGEXIT();
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_CPUID_RESP(resp) != GHCB_CPUID_RESP_CODE)
+		return 1;
+	regs->rcx = resp >> 32;
+
+	sev_es_wrmsr_ghcb(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
+	VMGEXIT();
+	resp = sev_es_rdmsr_ghcb();
+	if (GHCB_CPUID_RESP(resp) != GHCB_CPUID_RESP_CODE)
+		return 1;
+	regs->rdx = resp >> 32;
+
+	regs->rip += 2;
+
+	return 0;
+}
+
+int sev_es_handle_vc(void *ghcb, u64 ghcb_gpa, struct ex_regs *regs)
+{
+	if (regs->error_code != SVM_EXIT_CPUID)
+		return 1;
+
+	if (!ghcb)
+		return handle_msr_vc_cpuid(regs);
+
+	return handle_vc_cpuid(ghcb, ghcb_gpa, regs);
+}
-- 
2.25.1

