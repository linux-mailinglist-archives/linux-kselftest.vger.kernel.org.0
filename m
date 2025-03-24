Return-Path: <linux-kselftest+bounces-29641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD8A6DABD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66A016BEDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAF25F7A0;
	Mon, 24 Mar 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GXpWa04C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1718200CB;
	Mon, 24 Mar 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821402; cv=fail; b=IV82hSmRm54zV/a0apjVkK4DLq2zsCzehegyFMMhQCEl1j2sCMYnOwRHoD/uh1zRY9rRuu02t7wzPbGqLhQIQnDXKmYhpyH4t/bFjS5g+FJm3QQZ0DoCd4RGs79fS9MdI3CGBcMaRt/SgJei6V+C7JsBX32zlJjLS3+Hm5J/B8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821402; c=relaxed/simple;
	bh=PIC92M46MlQOjw5mMZ4/P5vECj7rVr+bL/ug8bUAZzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSfeGIQ4U8RPlUTRVaszVgqlILBEeiHZLYeN/FOJSfeLGoeNZS5fHuTq2TasAaFEjK2yGJK3Xim7p5HWSKCzgkAQp674u7DWla6Yy2/8eLcw+0UxhyeOM4lGPjvb6oKNHbve/SuBju4+gAC/Xouh8AJkw+N+RXgthUUjMWS6YDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GXpWa04C; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbO8Q4a1dff8R2ZPMuHnUlpIkuWvFz8hY6yydmf+bg+auvOa6lQBYZVcIBEsjtXa9GfOfpFStX+1dw4MF4e+1MsQyiMjO2g1afH9WN1CJIxMF6Y3C144zTrJkdiYwUmEwq6CMQSBT2d7tJEPgXvOS+fmbwsKZkSCPZGGrSOIylf1dxub73Y9KjxvOBWt6RsYtZbYk6vBewgbuslLIET/m0zw5K2/0GF/ql2MPDVI5xbDsN9XiU3DDp3gSkIbUOGeemHhIORSYN9TVlEfhIQgumqMqnoZnoAFNoxJM3FDG0O21Rwmq++Dq8wTLsPS907KguI8vvpFVD828bcu8JmPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2zDMJ6JCIneIgXzaLY/KFLNFSs6O3p0d01D/JiY8gY=;
 b=ISNt64Um2+4bcyfx9y8IuUlYqbw5DSIpJ15fGSIlpHkWEbprgGuhRPbDbp4phiuZaFBnyZFsqnVwowxaWyr0DlMjCS3syz+6LXFc+G+BHuId2JUR37H7zYGaN7JcScjU9TgrUjjyhckej1KYh1yE5r+bbThW0URaLNYkwIKypFNWLPhCq5dAE0FHbJ7GopqwR3wV4O0ruTxqIs2ORj0O+985lBNR3GZRn8B9uUeKKuZSw8NkMNqeENgRzub+XE1pORl+79aeZuk/GqcEN6r6Bv3o1rZDzpp38drZKnNKhgKwbwIwM4gLYpGSHXtiHo/aXndDdoVFyEueuF1KD/qVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2zDMJ6JCIneIgXzaLY/KFLNFSs6O3p0d01D/JiY8gY=;
 b=GXpWa04C7QBij5n2DC+f4UTxwIwNuusG/tJW5SggO/sgsaiVWuA6WvxX3AyCFNiFY3Rrrf2ql7Yixu1Rky9SbOCS5bdWHj2dKkasmgx/D/d7E6iSGmPJ69EJI6irLD9k93y8q8mtkq2YDH5yXArNUprsp0OVRS+VZJt8FHHOo7Y=
Received: from BYAPR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:74::43)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:03:15 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::d6) by BYAPR05CA0066.outlook.office365.com
 (2603:10b6:a03:74::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:03:15 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 08:03:12 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <nikunj@amd.com>,
	<thomas.lendacky@amd.com>, <manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v4 5/5] KVM: selftests: Add bus lock exit test
Date: Mon, 24 Mar 2025 13:02:48 +0000
Message-ID: <20250324130248.126036-6-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324130248.126036-1-manali.shukla@amd.com>
References: <20250324130248.126036-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: c4eafd24-a3f5-4dbb-81ed-08dd6ad43d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0dkgISNnyKoMCr7VWaQCNjBkMngTCH/YcCVAxT+Sud1EYi4ISbpS6kRX4fJ?=
 =?us-ascii?Q?CmCXsUHgnmfFQ9Gri3Rpn5IyhQsRa+V0gm43YUEoQ7fFNK0eKHFoQwOsJJ6F?=
 =?us-ascii?Q?2ojeTV/VyjNk9rSBkVad5GVoq3F5ROQwxATt/OM2VSYEOqa8jrVWruRqVJh3?=
 =?us-ascii?Q?dGMWciPhSLASaXZVeJ/AAbApbb7avaZVVQADagIQm6/kb2YuF1zrBEYqITpC?=
 =?us-ascii?Q?FZ2aUbZGpPsfqZUQ06LUAq+Oo1nYm/x5K+EtSCQXX2XfkiRWkuQz+RoEuFoe?=
 =?us-ascii?Q?rqidOu+kxUa+Sv2S7kawtx4ddGQ9KrLrY7KmKEbTM4T3y8rakWIAQUDl05wz?=
 =?us-ascii?Q?Mqm+SzwDtYaluBplVDkZlpQ6uoqICPOXJumrOGY6SOqD5ueJlvi2qT/Xjf+V?=
 =?us-ascii?Q?l4RPzeU0d4Q2DhUjNqCvezBNKd0mqJhSPOWdPgh2nZS1B7WujYFBYjqHDpyq?=
 =?us-ascii?Q?mZy5yNb7v8oKwER3TsVXVZjPmDvw2ed8buu+lo+L4EErg5iMdl8sywQlJ/M3?=
 =?us-ascii?Q?AkOm9L0Rp5A+eLFP+wCys/CIvOudGdaxujAH0QkVYG5ZGEGMK1cVwbO4F/0h?=
 =?us-ascii?Q?w4OwrL2w0hS8uUYc02YbjYwQwzaqK1gDHWOgC6FB/MzryTse9dEawrvONlr9?=
 =?us-ascii?Q?ZI1Y39OI+UBEnkD57sPsNxpYdBMorxON84yOYxNaU/2J4FyDafF1XHbzA353?=
 =?us-ascii?Q?jv8ynW8fAu1rTib1rzh3eC+nQ9L7XJDRQqW8K8DAIjoNl322UR8bz1WHB/WN?=
 =?us-ascii?Q?2HcLkjb/bMEthu8mghte7y3GXIJ+eVYf5fTRX7AEZ47VS5gvh/7PPISeNAI3?=
 =?us-ascii?Q?426FURDY85R8LWtxaJtuDbSlD/NHzbVYWQDoEsHl7zmN77ZAZg0gM1m2oIQ2?=
 =?us-ascii?Q?lWoXd+a+irrMjg42H+TgvIDdstmhfvkplH8i8/YK2OgsgJ4ivielpmmG0dAk?=
 =?us-ascii?Q?8Jr/T5BaugJlmhfpgHZYCMQYRvgumt3yDFAdAClWnTURxEGoE56fDq/YV3e+?=
 =?us-ascii?Q?uESl4yBMrJIunGEFlK7LgDLsooJgEufRR6LmsB2x8SCW8RMyZ8j9vGQgRq32?=
 =?us-ascii?Q?UQOFqo9slSoaA8ZGigvFez+yfZrri0VHQ+xoiQdM7/fuQqXkdJA1VpFd5qjo?=
 =?us-ascii?Q?M3ucNigBJPigvHXwZIxV7gas0Z0OG0Q+0vpT5wrBdOL3Nz1jOY8wlmwH7DT8?=
 =?us-ascii?Q?gGLd5pjs7T0ZLe8x/wJJbqTUTWuQDsyUVzz3QK3zklbBRo3FBCB6P9qmd8Ik?=
 =?us-ascii?Q?x9atVhA6zhAeShPrFGPD+nWC7Fv1DfT1v7qIgcKkjKkozYjVdTCLeSOSDosn?=
 =?us-ascii?Q?qOvbT1b18STSv3MxzTN9bmxpm6i+PxLTN3imEfZD9ZXacvqDOQ7i97FAPDVJ?=
 =?us-ascii?Q?O92uN9psj+Tz1YSqKf3lUA7SjwWQXrOxmQIGIOZVqN2mBp33UlvjXHsHtM09?=
 =?us-ascii?Q?HAuiuJ7TopAphCGSJz9gw3lOtPLqzZtDJNY0tY76kQRBYlCrOsTzkNRAY49d?=
 =?us-ascii?Q?ysBM+2fKDguBcIY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:03:15.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4eafd24-a3f5-4dbb-81ed-08dd6ad43d53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

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
index f773f8f99249..17c77f947ae8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -68,6 +68,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
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


