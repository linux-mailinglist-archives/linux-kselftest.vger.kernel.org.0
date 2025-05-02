Return-Path: <linux-kselftest+bounces-32148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CFAA69FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 07:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1A1BA55A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF11A2389;
	Fri,  2 May 2025 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ND/9kl0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321C15DBB3;
	Fri,  2 May 2025 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162274; cv=fail; b=fmc4LNMyU70bAsSz7sNBmN5THEN5wvY9nttcHydH/laeKMQ7LstBzFBLTuyLBYKrVGRDuXxU6n1oKm2hFLYVtxpOT6/qtTMd/9+ZPBfYc1mejsNVV0jd+T8cScAdfcFeOv2r3SHJps8tEfDSzzrr6dqX66kwEfrs5U0vLSwUwUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162274; c=relaxed/simple;
	bh=gjggo3NkCWuUz0cOz45wrYK0CGAlxp92vIZwdT4DLMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4mHJY9/+YTcD5RDs1FIgzRlHjpBQ3blDm6M6dHsSPQkK5+UmZs0lCQMtGEInM7o0zezywfRUWyYVRAu6zzDYBeJt0n7sBXmKX+RfTFCwIEh9IXBfqPTjPYHqWzQHlaTYv19niy3npvs61GCmy1MtcQCFdV5TEns9Y2wTbP5OsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ND/9kl0w; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZEgAdlUovaFljzRtbYouZH4h/0fAWET1EDTCA6aKUxb+qTLiM+OM1pb+TuVI5/FOGHNXqsRLCbLTOWQ5n0FVQyNvspYB4tG9bu06O401omRK/MLVdr/uBBkZvXj3ALh1OMtQgiseUKR8hKCgQVq3rmcRtSaymUJaZH7NRXtZtTZyIdX0vBPYqHHRNdItsu5vVBiEj6j8K57MihROb9rH9NSFwgTWVxbZK5F8o+8i6IK1NRcg57/D4J3s6qSnKcXCMC9Be4ePe5z2K8PnwUP2V8qmQWFFdzlJxdFOk8qhV8aAWjdpW3aY5WSthrilqH+W1wSyQ1KhK/vz/EhIKnCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkGlW2bhsmg03J9dWTNgmMep9hUmKyD2f+AfK7+W/RQ=;
 b=vefqXHkWTi5Srb/Z7sapdrAsv8lA8pfStgIN2LoHRYVC0r8HXx7y5e6XvwQBJbEccGZf4PnZbbCQu9j+Q1nteS2jL42f0UEdZTOWcEc+/dCOUqN+nJ0mCtLNSYP+Nia7W7Gb4CNTUBPWWhRkqjum6VEXb1/IU44dNYf29iwTpTbqm4yIFOrvfplbfOFVQI4QmM+2igQ64QVaY9YM1maGab6DaLO4Q+KjjvF5vIYH4FxetSmQxgaZJ/sFiD2Tn4Yxn5SlmlDOFmWteTo7MvPVpcReiH5K107whCx4DFxs7qGvLirea46k4LE8ABMN0m/1ulUs7l0ZZzfi3Vo7ZpBQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkGlW2bhsmg03J9dWTNgmMep9hUmKyD2f+AfK7+W/RQ=;
 b=ND/9kl0w9tQCDcg7d19/VSSNHAnhaoRpB1NxrDExpPmcuGct56hWtb3RaR76yPyxa+MSoKvhcIN7D9pyXZoXVV2l7yqq4onmidTcpLV1QtqLb8IWDRkCX0wcPWstG1l2UV81Ljtl2tNiGu8x/KvDHFWr/npt5qUAgEhVbsBusKM=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 2 May
 2025 05:04:27 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::3d) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 05:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 05:04:27 +0000
Received: from brahmaputra.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 00:04:24 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v5 5/5] KVM: selftests: Add bus lock exit test
Date: Fri, 2 May 2025 05:03:46 +0000
Message-ID: <20250502050346.14274-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502050346.14274-1-manali.shukla@amd.com>
References: <20250502050346.14274-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cb2dcf-a3f6-4792-6f95-08dd8936d033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y9p6yJM2o47DpDluAHTP9FSMmrChlfhOZL/2BgquS6tusx1XF4mbC+4zhxL6?=
 =?us-ascii?Q?55UT0Cekb5LLGuvwhVfYkJmt3/fPlBLttaj6ZE7eeegs3Iif6EHd952Kux4V?=
 =?us-ascii?Q?RaaXautM/iuvTqm4xr5lKoZ7B4Tj2/ulOCJj5t/7exOTC/6Bu4JRt+N9LEbC?=
 =?us-ascii?Q?E/5rnEH3EDzzGFA31QhCtK/slvbCkKXrpFgvuBxYK7Oldw7r725MvZDRK3HM?=
 =?us-ascii?Q?Vj/MYlbMcocFrYkKe5e2Yvc551mRlMGTX9Krhrz0TyUFCsETa7s8hW9qHAuo?=
 =?us-ascii?Q?wlEuOtHq5eWjNwtzSRxw9WlUKna7Z6X0zT07t0eVxl2BiAxu8CIFbKzut8S1?=
 =?us-ascii?Q?0pxnIytvfLjaQXUnELSgTcRYwcCLPRI8Q/RreSY5ChWBohicLB7HbjFf0/qT?=
 =?us-ascii?Q?4TuA6qvhp7TQRk1sExx1kkRLJJKMSF+NSo6HGX3CCluJEw1KCroidTufJOUr?=
 =?us-ascii?Q?1phMgqAW6g6NxQaYiyWlkE4wW3OX7Wk7AfhjErH5UBO6/kb/8mN+i11hhyr8?=
 =?us-ascii?Q?7n3EpwmQSuhtqT+XuI9GTikSfJaw/3VJ4H0xHX0RGBoV/XoaV5SYjX5gtabG?=
 =?us-ascii?Q?Ygji3ggQvknu8hUVx9Wz7L4zEYJ5y5y///w0vxR4l8vRmLu0SXil7iq0cevt?=
 =?us-ascii?Q?E1v/WAjHD6rb9K3xM57y0QCZ9rlrVwem5tCeA8JmEUZArlZqjQdm/OgpCtdf?=
 =?us-ascii?Q?tBOOCpwmxerO+UdespzBKsGmMfdZ407U3c5KE0dAlLCc7Vac6zT4ktPZvMTW?=
 =?us-ascii?Q?woPMzarioNQHNsLPQRfT5VnwXwoZM2YRVRG8UyoUJyTDryPBUiHjEPy/YJOt?=
 =?us-ascii?Q?FROGNupSd/9sl1sNF5YK//t+E4wivzU2G0k642A5PMQMzD9h+TPgxy8YWCq0?=
 =?us-ascii?Q?YKF8ou3vtnJ19RER/9QuS0FhGKwhrbFBlJJWWnFuN3t7hHqSO6T3pKAtjDoG?=
 =?us-ascii?Q?b+XiogT7k2obEoNjnGtiPN4DB+XD4PpMObuAS6cNnK6FzI/vgVYaBNwFYm5j?=
 =?us-ascii?Q?d0axnE3Xwbf+zDfaNzOS2n060OwrYEbwf7+gt7PFvB8V7v02pAaUgaXNGBTG?=
 =?us-ascii?Q?NoU6iWbyGovY8AAQ1kdk7mdnieLWQ9myUUizJnTh7z6ewvtXy134Yeez5oKC?=
 =?us-ascii?Q?G8xcWDhhu5SiOExBMfvMDisUbLAoYqbNrEhBtd76Zl4dagUFy2w7jal6ScHS?=
 =?us-ascii?Q?ZtZBArR++P6HPIsC0eZZdizzB67jgzKXePoX1geS25Ha4CR3KM9KCUSQhHQC?=
 =?us-ascii?Q?5/YALwvBqMYuv5W54gau8A3qTlal6M2IX6j8Aw17GP3vUth3vHI90mQoZpuQ?=
 =?us-ascii?Q?Qd1ZttPU9wWtlXBo1O/P2GII+b5bUYPtQHo2szJ31S83kEnaI0IW4rM2I577?=
 =?us-ascii?Q?V3y1C08UqFE54CZODSaQrtKmaUVEHUkEtsLc8lEvTzGPAAPZUWx89yrFYSJ9?=
 =?us-ascii?Q?aAkMj2xOrvBNBtK9c+3qLjK0DUptunwcZL7WZZYgKwLZdH0/7fnP7zU1eeyy?=
 =?us-ascii?Q?PJZcns6TcpcY1VA79TUmmWMWj+5xEkdmnNY9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 05:04:27.0308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cb2dcf-a3f6-4792-6f95-08dd8936d033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458

From: Nikunj A Dadhania <nikunj@amd.com>

Add a test case to verify the Bus Lock exit feature

The main thing that the selftest verifies is that when a Buslock is
generated in the guest context, the KVM_EXIT_X86_BUS_LOCK is triggered
for SVM or VMX when the KVM capability KVM_CAP_X86_BUS_LOCK_EXIT is
enabled.

This test case also verifies the Bus Lock exit in nested scenario.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Co-developed-by: Manali Shukla <manali.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/kvm_buslock_test.c      | 135 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/kvm_buslock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f62b0a5aba35..fa65b82c1f53 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -78,6 +78,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
+TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 += x86/nested_emulation_test
 TEST_GEN_PROGS_x86 += x86/nested_exceptions_test
diff --git a/tools/testing/selftests/kvm/x86/kvm_buslock_test.c b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
new file mode 100644
index 000000000000..9c081525ac2a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/kvm_buslock_test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
+
+#define NR_ITERATIONS 100
+#define L2_GUEST_STACK_SIZE 64
+
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
+
+struct buslock_test {
+	unsigned char pad[PAGE_SIZE - 2];
+	atomic_long_t val;
+} __packed;
+
+struct buslock_test test __aligned(PAGE_SIZE);
+
+static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
+{
+	asm volatile(LOCK_PREFIX "addl %1,%0"
+		     : "+m" (v->counter)
+		     : "ir" (i) : "memory");
+}
+
+static void buslock_add(void)
+{
+	/*
+	 * Increment a page unaligned variable atomically.
+	 * This should generate a bus lock exit.
+	 */
+	for (int i = 0; i < NR_ITERATIONS; i++)
+		buslock_atomic_add(2, &test.val);
+}
+
+#pragma GCC diagnostic pop
+
+static void l2_guest_code(void)
+{
+	buslock_add();
+	GUEST_DONE();
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
+	GUEST_DONE();
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
+	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+
+	prepare_vmcs(vmx, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	GUEST_ASSERT(!vmwrite(GUEST_RIP, (u64)l2_guest_code));
+	GUEST_ASSERT(!vmlaunch());
+
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_DONE();
+}
+
+static void guest_code(void *test_data)
+{
+	buslock_add();
+
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	vm_vaddr_t nested_test_data_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_BUS_LOCK_EXIT));
+
+	vm = vm_create(1);
+	vm_enable_cap(vm, KVM_CAP_X86_BUS_LOCK_EXIT, KVM_BUS_LOCK_DETECTION_EXIT);
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	if (kvm_cpu_has(X86_FEATURE_SVM))
+		vcpu_alloc_svm(vm, &nested_test_data_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_test_data_gva);
+
+	vcpu_args_set(vcpu, 1, nested_test_data_gva);
+
+	run = vcpu->run;
+
+	for (;;) {
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_IO) {
+			switch (get_ucall(vcpu, &uc)) {
+			case UCALL_ABORT:
+				REPORT_GUEST_ASSERT(uc);
+				/* NOT REACHED */
+			case UCALL_SYNC:
+				continue;
+			case UCALL_DONE:
+				goto done;
+			default:
+				TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+			}
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


