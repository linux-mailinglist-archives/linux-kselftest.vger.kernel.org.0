Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEC47064E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 17:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbhLJQxE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 11:53:04 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:55264
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240602AbhLJQxD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 11:53:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3HgOkNgov8C1PVqHuhbgScCdJsuI/9/nXc8bjhzJGwb/7ARuJgsP99bqpT9kUfGVj/Z2ulinWUGVILhEI6QCK5Anld5AOwgzNKWJKAlXY9ZXcaGXlD7zX3TzWkTdjVIJDZJN9FN8DdA4I4Lt1b/Gjlwp/QfrMnJNWushdYKMSx/++Oedao08OWlyeUaS5vRkbfJ5I7qS8vPhfohq1XVHRiC4U/mTP91WNtruYuf0KKCxtOuq/CSKL6WGVIVGTkxVKNkl+8LkfAqNiF49KiPIBBT3Y9FXoI6BZX4lTUx6vhNLkgGY3dczxgRtKf5aOKKRO8aD144oly8IRQ0qxB5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSmM4s+hqJTlbhoYmw6xwaMc+NBXHAQkNw3bSCMrj1Y=;
 b=JWoD61SIrHAdjH5N3GG3+GQipxm9Wj49qgPJiO+4I0Be9rjsKaCW+i6Bqy3DPrdWJBPzyTKZlAToVRjvu0m2SYU9DvsLwlWcCVCFz7/cBnDqM4WpGt/QZg7CoEjqUknTLxGDLrq3ZtXeMOr4loX+oWtW9tv3t1zFgag42KswUqD4g/i7FzIWNPzOqImYdGAvTEk5lGheLDKA8yGleGSV3UqVgPo1GdL5cs5Wt6PkY5m6269Sc4DKQPdGjPjA4xg19yPan6CanBaW1RbuKeI4rlkf6GGbLe+71H9P8Tav691yeaLYdlniSm2Hhu66++DvT8Mdui9vu+1yAdXdhoEseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSmM4s+hqJTlbhoYmw6xwaMc+NBXHAQkNw3bSCMrj1Y=;
 b=rpHf1+j0JHP+w39UmPOl8uWvECEE4boiUpw48bHiWr7NFdDgJuAueiWcfz+CSPlDQu9mcbervS30tp/ulIIGlFiBtheyd71gfvFJlaFcCVkWETfh8P5Asme2WjmOL8YWCy12W3UrbbqiEMoj3eGItLEMLEyLzQhrqvCrtEgqLOk=
Received: from DM5PR21CA0006.namprd21.prod.outlook.com (2603:10b6:3:ac::16) by
 MWHPR12MB1277.namprd12.prod.outlook.com (2603:10b6:300:f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 10 Dec 2021 16:49:22 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::29) by DM5PR21CA0006.outlook.office365.com
 (2603:10b6:3:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.8 via Frontend
 Transport; Fri, 10 Dec 2021 16:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 16:49:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 10:49:13 -0600
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
Subject: [PATCH RFC 04/10] kvm: arm64: selftests: use ucall_ops to define default ucall implementation
Date:   Fri, 10 Dec 2021 10:46:14 -0600
Message-ID: <20211210164620.11636-5-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5ce928b-2e96-4ca1-8d77-08d9bbfd045b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1277:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1277BBFECD3DF3EE8B18F7FA95719@MWHPR12MB1277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpZw4FezY8Pj0kOl2dow7P1rgRmDU62Gb9dZswx6yfcCRgIlteAInvooU5zRulzucxnqtImgvRN8nLRO5tTzLyM/nRYUAgd+rZXQHCcKKqQuRp5iRTAA2Cj5jfj+DdUedA6CZ6oKFMg32BJwjtU74vnkBIX5fv6gv4oNNcWzskv2AosY+2Pae3IumtGo3u7cTSJD821qFYMGxlTWoQo3hQaYW85LqaI1ZU4AWs+P1LIp1q6CGAc+FT1Ci6YTTv49g1UR1RgFTuzxrYZ4yiaCNrDpKe2TI8USz5Vd924LUhCnP/aZE5yMUf8QJvLX7cTgdcvpErSwRjYRWcoVmghaq577yNECJ374asMWl63eBxWsdzaaAHgga3P3Hp0LbAA2TtUfSNYoAZQzvcplpOrNRygJ8F4us9FgYW4PY8tvs0NIHwfgJGYtJK10ri7DhqGBR96p/yeI95RK2ynCvVgy/PGR8VUNHHRRAp1XAP1THiNpt5W2ZTemBuJK3TUNVanBHukaGdOnLJ8uyguM1iWT7lQ1U41pGjrido0x8l5KFVcRftwCTATzNL4gTYMx760X5/AQedbLViNU1m5+tEraLf1+x3aG5qRAklIQfFaTstm75eVXwglzjbSGNGx77tggld5nr+RlYvfIgbsisUyYz+VG6wPyBzK3uew0Z7+dsnQct1FoQoSMyrIATxlgKouelcKcOElivlcL0VcO/2GRMzj/RHBPK/r3hYd13Fqx+usM5BljfMWXRnq/dqYCJxurvqGr9uC9GgKphBnORQrjZUH40F7vbpOwFulWA5EuKy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(70586007)(316002)(70206006)(83380400001)(7416002)(40460700001)(82310400004)(8936002)(356005)(508600001)(81166007)(26005)(8676002)(86362001)(6916009)(36860700001)(47076005)(426003)(336012)(4326008)(44832011)(2616005)(5660300002)(16526019)(186003)(54906003)(1076003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:49:22.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ce928b-2e96-4ca1-8d77-08d9bbfd045b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As with x86, switch the default ucall implementation to using the new
ucall_ops infrastructure. With this change ucall_init/ucall_uninit are
no longer arch-specific and can now be dropped in favor of the ones in
ucall_common.c.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../selftests/kvm/include/aarch64/ucall.h     | 18 ++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 43 +++++++++----------
 4 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/ucall.h

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 05bff4039890..2d4299961d0e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,7 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S lib/ucall_common.c
-LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
+LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c lib/ucall_common.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
diff --git a/tools/testing/selftests/kvm/include/aarch64/ucall.h b/tools/testing/selftests/kvm/include/aarch64/ucall.h
new file mode 100644
index 000000000000..d3189d0a4d68
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/ucall.h
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
+extern const struct ucall_ops ucall_ops_mmio;
+
+extern const struct ucall_ops ucall_ops_default;
+
+#endif /* SELFTEST_KVM_UCALL_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2701bf98c0db..16ec8c53cd81 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -14,7 +14,7 @@
  * new header. Once all archs implement the new header the #include for
  * ucall_common.h can be dropped.
  */
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined (__aarch64__)
 #include "ucall.h"
 #else
 #include "ucall_common.h"
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index e0b0164e9af8..ab052ab5d5de 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -1,11 +1,14 @@
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
 #include "../kvm_util_internal.h"
+#include "ucall.h"
 
 static vm_vaddr_t *ucall_exit_mmio_addr;
 
@@ -22,7 +25,7 @@ static bool ucall_mmio_init(struct kvm_vm *vm, vm_paddr_t gpa)
 	return true;
 }
 
-void ucall_init(struct kvm_vm *vm, void *arg)
+static void ucall_ops_mmio_init(struct kvm_vm *vm, void *arg)
 {
 	vm_paddr_t gpa, start, end, step, offset;
 	unsigned int bits;
@@ -65,38 +68,22 @@ void ucall_init(struct kvm_vm *vm, void *arg)
 	TEST_FAIL("Can't find a ucall mmio address");
 }
 
-void ucall_uninit(struct kvm_vm *vm)
+static void ucall_ops_mmio_uninit(struct kvm_vm *vm)
 {
 	ucall_exit_mmio_addr = 0;
 	sync_global_to_guest(vm, ucall_exit_mmio_addr);
 }
 
-void ucall(uint64_t cmd, int nargs, ...)
+static void ucall_ops_mmio_send_cmd(struct ucall *uc)
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
-	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
+	*ucall_exit_mmio_addr = (vm_vaddr_t)uc;
 }
 
-uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+static uint64_t ucall_ops_mmio_recv_cmd(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 {
 	struct kvm_run *run = vcpu_state(vm, vcpu_id);
 	struct ucall ucall = {};
 
-	if (uc)
-		memset(uc, 0, sizeof(*uc));
-
 	if (run->exit_reason == KVM_EXIT_MMIO &&
 	    run->mmio.phys_addr == (uint64_t)ucall_exit_mmio_addr) {
 		vm_vaddr_t gva;
@@ -113,3 +100,13 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 
 	return ucall.cmd;
 }
+
+const struct ucall_ops ucall_ops_mmio = {
+	.name = "MMIO",
+	.init = ucall_ops_mmio_init,
+	.uninit = ucall_ops_mmio_uninit,
+	.send_cmd = ucall_ops_mmio_send_cmd,
+	.recv_cmd = ucall_ops_mmio_recv_cmd,
+};
+
+const struct ucall_ops ucall_ops_default = ucall_ops_mmio;
-- 
2.25.1

