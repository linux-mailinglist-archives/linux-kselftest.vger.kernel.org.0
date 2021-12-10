Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF81470643
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhLJQwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:52:36 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:11440
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240511AbhLJQwb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:52:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMO0F8awZsJ+thSBhfY1bDtLgYjZrbCHhII2KMZZ43TthcBag9ojQIWl/GLrYSFfMl92dl60E8NcM1PWcOWGG6CjROTRunLKpJJ7sNmfygOHmRcpp1Lt1hYhOdfOADLm2mxIQgZ8Dt5tQeXhBrkbuC9plzwX+34BgE9fZVQIa6TpRo15O6Fqr5naLwXMalnwME4FmJhhX3i5bfQBi5HxKKR4OjzR9ymOAjsAnGSlXcuDrKoTAtEI9gkgy1cm1b9eTO0YF0/xRV6ai5D2UYD+m2Jx9HWfZCnmFX++Sb0LdfptuC/fv+ZtdiHSI+3zNnvB02lDv9pgwb6u9SBuR/q2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/12okhrmrB4xuQZH192RDbXC9BoT/Vvu/pMTiY+30Y=;
 b=QZrtbnyxR26x7vVx24at5jQxc2qRzXMR/yIcGtUBqG+qQLASwbpfNAIc4Uw8Vqc26bnsWOgQ3cA5IOAPAPUqIT3Doaft4aG8sLy0sT4yTXb0K33PKTLoO9X5VGktFWYXAXZsbDlOw8pq6VOojjTtlzbI2d1BiyQb8XRU9IKsxeHHbj77QaI0ugNegvuMyMUN88Qd0ppv1We7NFFCIMZPKkZ1nsIffActAQ/+Doz+nhESsIV2+P1oBxSAT3C6oCNp/pTgjf6w6gEFNZMhFA4zrLhvN+iVLlj41jDRXMMZrOyQ+WpG64H3gLVYesSRoXyyZwKzm64FhCGrsNP/6EA2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/12okhrmrB4xuQZH192RDbXC9BoT/Vvu/pMTiY+30Y=;
 b=GB4lBojFgrvFCU4umO5yvq5PmEIsELcf3WVmtaR2zWqbMa/0zu5v3/vaHha8qMjpx+tKYMUR4faNlQI2GB213WYQPbfMktlmGiwjsTk4nrMGt09t/nkJ0iXdQ1t1B2m/DNSRqpQL39HivaIrs1kYqptECDtFeuC2+fwzV27uBMg=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 DM5PR12MB1626.namprd12.prod.outlook.com (2603:10b6:4:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 16:48:53 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::be) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 16:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:48:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:48:52 -0600
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
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH RFC 03/10] kvm: selftests: introduce ucall_ops for test/arch-specific ucall implementations
Date:   Fri, 10 Dec 2021 10:46:13 -0600
Message-ID: <20211210164620.11636-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210164620.11636-1-michael.roth@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d97c4d-9f90-4a7e-3916-08d9bbfcf308
X-MS-TrafficTypeDiagnostic: DM5PR12MB1626:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1626029E5CE7FB41321066D695719@DM5PR12MB1626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/9kUOMpO0HEO5aE0Pvzp19pLHnOnsS1Z6mY5SEPWQVCBWkIo8LYcV7MlVI0Rvhfipm9TVeQjOX77bNfQwGn6JOEKSXvNIi4EADFKvXNrwFco0dil0ier5z6YUi3sWYXDhdwkt8AavsdfKnBdJqqii3v+Cq8L/Ue0a1sq+yCdC6N/xBiCZNiSz7u4O8Vwo5j3doEUvPaUMh2S8J6oeK0ulic29CJtTpygWSx3DuvQn+p7xPmy+Qz8EcZSpEbEufvf2vCYTkIlNfc9S7H9iZOD7m4ZehPAT3QMhmYgCSF8OuzdHji72fHkgJ6wqnU53K/lkYeBstJrQj2zyfy5RfTgVtu8tP09cXEizjGRNeWqlljTs0iWfPgiafYT51H1XIHVJLUU7yyy6snEy0rS624M/ziOGRUJ42mriEokGSj5qZW9GDP+wk6r1ZGcjAivAJXO5vTadiYBAvDqyX1LzlRFckaPvx6qXQg5knv9NQTbdv7KjgycejzysawdwlccToEm9LzCGWrjAZI/PcpS+I4WEwzbaoLFepgal0OZp3IBg1MGB0C8g+3Xttq7hM86ogZDR+ldnVJ3WP+Hm9BlQzqlXYIVvOw/Vr3STWMSLBfJgMXuVMRs4NCILwAD3bUXnWCtRJEetgSlOQjmNI/ytf+lvIRajNbVmllVTx8w27B1zXc7NPnfviuoylBB7W9Kl9pGgSRXwAJcH5Sig2tV8hFuYfkLN4OEVPk2rHJ4WfL7W/v8afJ2zayN/d8eNjM9La1GbM0ELAiKBnadFk8Op1s06Sfbonxkskbd/XFxbrPIZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7416002)(5660300002)(70206006)(426003)(6916009)(6666004)(26005)(83380400001)(4326008)(47076005)(336012)(86362001)(8936002)(81166007)(44832011)(2616005)(16526019)(36860700001)(356005)(82310400004)(54906003)(36756003)(508600001)(70586007)(316002)(40460700001)(8676002)(1076003)(2906002)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:48:53.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d97c4d-9f90-4a7e-3916-08d9bbfcf308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1626
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support SEV, x86 tests will need an alternative to using PIO
instructions to handle ucall-related functionality since ucall structs
are currently allocated on the guest stack, which will generally be
encrypted memory that can't be accessed by tests through the normal
mechanisms (along with some other complications which will requires
some new ucall interfaces as well).

To prepare for this, introduce a ucall_ops struct and supporting
interfaces that can be used to define multiple ucall implementations
that can be selected on a per-test basis, and re-work the existing
PIO-based ucall implementation to make use of these changes. Subsequent
patches will do the same for other archs as well, and then extend this
ops interface to address complications when dealing with
encrypted/private guest memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../testing/selftests/kvm/include/kvm_util.h  | 10 ++
 .../selftests/kvm/include/ucall_common.h      | 17 +++-
 .../selftests/kvm/include/x86_64/ucall.h      | 18 ++++
 .../testing/selftests/kvm/lib/ucall_common.c  | 95 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 46 ++++-----
 6 files changed, 157 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index c4e34717826a..05bff4039890 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -34,7 +34,7 @@ ifeq ($(ARCH),s390)
 endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
-LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
+LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S lib/ucall_common.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index c9286811a4cb..2701bf98c0db 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -8,6 +8,16 @@
 #define SELFTEST_KVM_UTIL_H
 
 #include "kvm_util_base.h"
+/*
+ * TODO: ucall.h contains arch-specific declarations along with
+ * ucall_common.h. For now only a subset of archs provide the
+ * new header. Once all archs implement the new header the #include for
+ * ucall_common.h can be dropped.
+ */
+#ifdef __x86_64__
+#include "ucall.h"
+#else
 #include "ucall_common.h"
+#endif
 
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 9eecc9d40b79..fcd32607dcff 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -1,8 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * tools/testing/selftests/kvm/include/kvm_util.h
+ * Common interfaces related to ucall support.
+ *
+ * A ucall is a hypercall to userspace.
  *
  * Copyright (C) 2018, Google LLC.
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2021, Advanced Micro Devices, Inc.
  */
 #ifndef SELFTEST_KVM_UCALL_COMMON_H
 #define SELFTEST_KVM_UCALL_COMMON_H
@@ -14,6 +18,7 @@ enum {
 	UCALL_ABORT,
 	UCALL_DONE,
 	UCALL_UNHANDLED,
+	UCALL_NOT_IMPLEMENTED,
 };
 
 #define UCALL_MAX_ARGS 6
@@ -23,8 +28,18 @@ struct ucall {
 	uint64_t args[UCALL_MAX_ARGS];
 };
 
+struct ucall_ops {
+	const char *name;
+	void (*init)(struct kvm_vm *vm, void *arg);
+	void (*uninit)(struct kvm_vm *vm);
+	void (*send_cmd)(struct ucall *uc);
+	uint64_t (*recv_cmd)(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
+};
+
 void ucall_init(struct kvm_vm *vm, void *arg);
 void ucall_uninit(struct kvm_vm *vm);
+void ucall_init_ops(struct kvm_vm *vm, void *arg, const struct ucall_ops *ops);
+void ucall_uninit_ops(struct kvm_vm *vm);
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 
diff --git a/tools/testing/selftests/kvm/include/x86_64/ucall.h b/tools/testing/selftests/kvm/include/x86_64/ucall.h
new file mode 100644
index 000000000000..8366bdc9c04e
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/ucall.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Arch-specific ucall implementations.
+ *
+ * A ucall is a "hypercall to userspace".
+ *
+ * Copyright (C) 2021 Advanced Micro Devices
+ */
+#ifndef SELFTEST_KVM_UCALL_H
+#define SELFTEST_KVM_UCALL_H
+
+#include "ucall_common.h"
+
+extern const struct ucall_ops ucall_ops_pio;
+
+extern const struct ucall_ops ucall_ops_default;
+
+#endif /* SELFTEST_KVM_UCALL_H */
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
new file mode 100644
index 000000000000..db0129edcbc1
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common interfaces related to ucall support. A ucall is a hypercall to
+ * userspace.
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2021, Advanced Micro Devices, Inc.
+ */
+#include "kvm_util_base.h"
+#include "ucall_common.h"
+
+extern const struct ucall_ops ucall_ops_default;
+
+/* Some archs rely on a default that is available even without ucall_init(). */
+#if defined(__x86_64__) || defined(__s390x__)
+static const struct ucall_ops *ucall_ops = &ucall_ops_default;
+#else
+static const struct ucall_ops *ucall_ops;
+#endif
+
+void ucall_init_ops(struct kvm_vm *vm, void *arg, const struct ucall_ops *ops)
+{
+	TEST_ASSERT(ops, "ucall ops must be specified");
+	ucall_ops = ops;
+	sync_global_to_guest(vm, ucall_ops);
+
+	if (ucall_ops->init)
+		ucall_ops->init(vm, arg);
+}
+
+void ucall_init(struct kvm_vm *vm, void *arg)
+{
+	ucall_init_ops(vm, arg, &ucall_ops_default);
+}
+
+void ucall_uninit_ops(struct kvm_vm *vm)
+{
+	if (ucall_ops && ucall_ops->uninit)
+		ucall_ops->uninit(vm);
+
+	ucall_ops = NULL;
+	sync_global_to_guest(vm, ucall_ops);
+}
+
+void ucall_uninit(struct kvm_vm *vm)
+{
+	ucall_uninit_ops(vm);
+}
+
+static void ucall_process_args(struct ucall *uc, uint64_t cmd, int nargs, va_list va_args)
+{
+	int i;
+
+	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+	uc->cmd = cmd;
+
+	for (i = 0; i < nargs; ++i)
+		uc->args[i] = va_arg(va_args, uint64_t);
+}
+
+/*
+ * Allocate/populate a ucall buffer from the guest's stack and then generate an
+ * exit to host userspace. ucall_ops->send_cmd should have some way of
+ * communicating the address of the ucall buffer to the host.
+ */
+void ucall(uint64_t cmd, int nargs, ...)
+{
+	struct ucall uc;
+	va_list va;
+
+	if (!ucall_ops->send_cmd)
+		return;
+
+	va_start(va, nargs);
+	ucall_process_args(&uc, cmd, nargs, va);
+	va_end(va);
+
+	ucall_ops->send_cmd(&uc);
+}
+
+/*
+ * Parse the ucall buffer allocated by the guest via ucall() to determine what
+ * ucall message/command was sent by the guest. If 'uc' is provided, copy the
+ * contents of the guest's ucall buffer into it.
+ */
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+{
+	if (!ucall_ops->recv_cmd)
+		return UCALL_NOT_IMPLEMENTED;
+
+	if (uc)
+		memset(uc, 0, sizeof(*uc));
+
+	return ucall_ops->recv_cmd(vm, vcpu_id, uc);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index a3489973e290..f5d9aba0d803 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -1,48 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * ucall support. A ucall is a "hypercall to userspace".
+ * Arch-specific ucall implementations.
+ *
+ * A ucall is a "hypercall to userspace".
  *
  * Copyright (C) 2018, Red Hat, Inc.
  */
-#include "kvm_util.h"
+#include "kvm_util_base.h"
+#include "ucall.h"
 
 #define UCALL_PIO_PORT ((uint16_t)0x1000)
 
-void ucall_init(struct kvm_vm *vm, void *arg)
-{
-}
-
-void ucall_uninit(struct kvm_vm *vm)
-{
-}
-
-void ucall(uint64_t cmd, int nargs, ...)
+static void ucall_ops_pio_send_cmd(struct ucall *uc)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
-	va_list va;
-	int i;
-
-	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
-
-	va_start(va, nargs);
-	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
-	va_end(va);
-
 	asm volatile("in %[port], %%al"
-		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax", "memory");
+		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+static uint64_t ucall_ops_pio_recv_cmd(struct kvm_vm *vm, uint32_t vcpu_id,
+				       struct ucall *uc)
 {
 	struct kvm_run *run = vcpu_state(vm, vcpu_id);
 	struct ucall ucall = {};
 
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
-
 	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
 		struct kvm_regs regs;
 
@@ -57,3 +37,11 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 
 	return ucall.cmd;
 }
+
+const struct ucall_ops ucall_ops_pio = {
+	.name = "PIO",
+	.send_cmd = ucall_ops_pio_send_cmd,
+	.recv_cmd = ucall_ops_pio_recv_cmd,
+};
+
+const struct ucall_ops ucall_ops_default = ucall_ops_pio;
-- 
2.25.1

