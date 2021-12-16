Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055F1477A44
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhLPRP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:15:58 -0500
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:14052
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233283AbhLPRP5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:15:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbA6Enz/HIzp7BWRZTeKJJhxeNBZEAtFlbCcl+HfqwY/S4/SzSq5G9r026S0xBlcyr2jzKZXWmf8OVbn9CbP78lrU/W9CxVN9xA/lvuKgiXnao5PypR24pGf1ZzJ1GXKLzC7ovPh7fBhtDLK1SZcwzjnXOnNo/aVh56iKrK20KhPujkzn24wZSYQhLO2/NMnMgrg9R3A4U9BMzlU6Pxv28OPtsIr9QYlkVut7MJHR1PfIxmg++nAKuvjklpXDjaiSLKA6glZnW75uVegBWMaIwagkt5fuPR+SKeFQvGTVTPXDJT2nwf43SqGR8xsNYTTGjnct8nLqHklqum0F31A6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVMTkYEAox+dDIbBbUL9XGo8YCMwRLxKN+fL96RQ+P0=;
 b=O0pv1wfOTe+ENmMC8VpZRXeimjjtp2zn0W964+sy6Ei0MSaDpQRpwgKMeVVVt92uYEfxVUYqEvkKbipeZkJuc5AQ80Wsvfz4fLGa5MOUTsYB6Q0OVdWn9Sg5jfKzQvMquwc66zX4P+6QDoTsu2+ZVPA3rKfWQA2G4oloBNT7XSINoKcBsBaew0oridTqisLwVr7HLxs9G/wdVeUe31J9WdzUfSg5xkZvyKDBwQbYNYJ4ADcsLqWv9vnoG6Q2NEZFAIdDVdis/fdXfEo+7WAxjHYa3KoFpmZQ2S2L4Ofd2ZSDGQvrKtCAUA4VJGxoPYsx6xjTuKvy62KE31ZXG+jTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVMTkYEAox+dDIbBbUL9XGo8YCMwRLxKN+fL96RQ+P0=;
 b=E2VgXbj1NAFz48uwS/SsBRy45pL2cARft6aDgjuJy8sPgeKQXO7BFxbd000dDjDJuKngPR7iR2elk/z4b7lKpdkMrzEScpkTJ84fy8d20tvPalzv4sRHP83MLrZUtWk1x6Inp96BaxBzK9ljDi7kVOt4q1R1riubJEyrv4kdRlM=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 17:15:55 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::4f) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Thu, 16 Dec 2021 17:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:15:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:15:54 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 12/13] KVM: selftests: add library for handling SEV-ES-related exits
Date:   Thu, 16 Dec 2021 11:13:57 -0600
Message-ID: <20211216171358.61140-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216171358.61140-1-michael.roth@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f8176a-387b-4740-8866-08d9c0b7b84d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5383:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5383024668EC9BFD4609378895779@BN9PR12MB5383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dclHwDGxTZVeNx52NQ+OV+M4onP1hyLsRPV19r6ctPd1newv4NwVGe3Z+KgL5J+HS5rQ9Y12z/kB2mN8W7oQ6/stOXvCYXXAPGOY/sfWxGZ+fUf844ep3ayrFeZcMcAS1DhYfpC1MyhIgmmXDHlSXvBCRo/Q/4mJ6PpAn42IgkVrdFxssO0XIidG3oVpYCWIqJnJP9n9wLdpqfHhqpt9/E5/0b3n3ACMpCpEO2ZvQw+EH0l+CytcPKjVkAyrTUYn8FGomwWaRAs6z0flTomvUJTnLt2ruNdMAiPA34qDN+Km7zELpV6ruXTQ/HnOxSw5LvEw1XjIBBIMbOZ0NI5wYUmhrnj6hpQt/jzFzEmhKNHjX5W3T8baoW4FWyX6lNo1IP9jZYOYAmGL3dYIx+TtOLM9cvattnwsM07CBEcSIB216L1PLTQJJY6ob1m7LQL8LBE5q49kZIBlwc3XQuBgEP6+VRT1UGByzE0uOQt0sVAadmrgYXmv5hbCkvoHdGHxLaeMqrf3nSilrxkA780t5rOs5CFt00Spr7hXdG0DUzidPWb12F1nm4izryxX4IPghmgjorgoca3HtoEhwhzRXKaYDMzj2CximmxhIKRaUs4FosOwJpzEMnqu+g7Y/dFIiI2foH1GRubArQ6/B4Lcx8nIb9mX650bXsZSGRQ2EYphSQgDLGlzU2GP04YPRALynx/9CHFRWs+ybRA8Af2xXtaGpryICctzaXJLkWYE/jXzO9yrhSWuwvXBfjp/aib2aNkIMxHnti+et3Dx9tEo1ov7wokoBRGbrhIcswVEmG0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(26005)(81166007)(356005)(83380400001)(44832011)(426003)(86362001)(70586007)(4326008)(82310400004)(2616005)(336012)(40460700001)(70206006)(508600001)(186003)(36860700001)(7416002)(6916009)(47076005)(36756003)(1076003)(30864003)(316002)(8676002)(8936002)(2906002)(54906003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:15:55.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8176a-387b-4740-8866-08d9c0b7b84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add (or copy from kernel) routines related to handling #VC exceptions
(only for cpuid currently) or issuing vmgexits. These will be used
mostly by guest code.

Some of this copied code, like DEFINE_GHCB_ACCESSORS, generate
GCC/clang warnings due to -Waddress-of-packed-member, so compile with
-Wno-address-of-packed-member like the kernel does.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../kvm/include/x86_64/sev_exitlib.h          |  14 +
 .../selftests/kvm/include/x86_64/svm.h        |  35 +++
 .../selftests/kvm/include/x86_64/svm_util.h   |   1 +
 .../selftests/kvm/lib/x86_64/sev_exitlib.c    | 249 ++++++++++++++++++
 5 files changed, 301 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 6f250e190fde..56f845523a03 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -40,7 +40,7 @@ SEV_PATH=/dev/sev
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c lib/ucall_common.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
-LIBKVM_x86_64 += lib/x86_64/sev.c
+LIBKVM_x86_64 += lib/x86_64/sev.c lib/x86_64/sev_exitlib.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
@@ -142,7 +142,7 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(UNAME_M) -I.. \
-	-DSEV_DEV_PATH=\"$(SEV_PATH)\"
+	-DSEV_DEV_PATH=\"$(SEV_PATH)\" -Wno-address-of-packed-member
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
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
index 587fbe408b99..29f586775c86 100644
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

